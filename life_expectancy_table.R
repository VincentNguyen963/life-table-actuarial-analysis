# ============================================================
# Life Table & Actuarial Analysis
# Author: Vincent Nguyen
# Data: Statistics Canada, Table 13-10-0837-01 (2024)
# Description: Constructs a life table from real Canadian
#              mortality data and calculates actuarial
#              present values
# ============================================================

library(tidyverse)
library(ggplot2)

# ============================================================
# SECTION 1: LOAD REAL CANADIAN MORTALITY DATA
# Source: Statistics Canada, 2024
# ============================================================

raw <- read.csv("Life_expectancy.csv", skip = 13, header = FALSE)

raw <- raw[1:111, ]
colnames(raw) <- c("age_label", "dx")
raw$age <- 0:110
raw$dx <- as.numeric(gsub(",", "", raw$dx))
raw <- raw[raw$age <= 109, ]

# ============================================================
# SECTION 2: BUILD THE LIFE TABLE
# ============================================================

n <- nrow(raw)
age <- raw$age
dx <- raw$dx

lx <- numeric(n)
lx[1] <- 100000
for (i in 2:n) {
  lx[i] <- lx[i - 1] - dx[i - 1]
}

qx <- dx / lx
px <- 1 - qx

life_table <- data.frame(age, lx, dx, qx, px)

cat("=== Life Table (First 20 rows) ===\n")
print(head(life_table, 20))

# ============================================================
# SECTION 3: LIFE EXPECTANCY
# ============================================================

Lx <- numeric(n)
for (i in 1:(n - 1)) {
  Lx[i] <- (lx[i] + lx[i + 1]) / 2
}
Lx[n] <- lx[n] / 2

Tx <- numeric(n)
for (i in 1:n) {
  Tx[i] <- sum(Lx[i:n])
}

ex <- Tx / lx

life_table$Lx <- Lx
life_table$Tx <- Tx
life_table$ex <- ex

cat("\n=== Life Expectancy ===\n")
cat("Life expectancy at birth (age 0):", round(ex[1], 2), "years\n")
cat("Life expectancy at age 25:", round(ex[26], 2), "years\n")
cat("Life expectancy at age 65:", round(ex[66], 2), "years\n")

# ============================================================
# SECTION 4: SURVIVAL CURVE PLOT
# ============================================================

ggplot(life_table, aes(x = age, y = lx / 1000)) +
  geom_line(color = "#2C3E90", linewidth = 1.2) +
  geom_area(fill = "#2C3E90", alpha = 0.1) +
  labs(
    title = "Survival Curve (lx) — Statistics Canada 2024",
    subtitle = "Starting cohort of 100,000 lives, Canada (Both Sexes)",
    x = "Age",
    y = "Survivors (thousands)",
    caption = "Source: Statistics Canada, Table 13-10-0837-01"
  ) +
  scale_x_continuous(breaks = seq(0, 110, 10)) +
  scale_y_continuous(breaks = seq(0, 100, 10)) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "gray40"),
    panel.grid.minor = element_blank()
  )

