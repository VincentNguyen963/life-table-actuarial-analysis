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
