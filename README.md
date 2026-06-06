# Life Table & Actuarial Analysis

An actuarial analysis project built in R that constructs a life table
from real Canadian mortality data (Statistics Canada, 2024) and calculates
key actuarial present values for whole life insurance pricing.

## Overview

This project applies core actuarial mathematics to model mortality and
pricing for whole life insurance policies using real Canadian data.
It covers concepts from the SOA exam pathway including survival models,
life expectancies, and net premium calculations.

## Features

- **Life Table Construction** — builds a complete life table from age 0
  to 109 using Statistics Canada 2024 mortality data (dx), computing
  lx, qx, and px for each age
- **Life Expectancy** — calculates complete life expectancy (ex) at
  every age using Lx and Tx columns
- **Survival Curve** — visualizes the survival function across all ages
- **Actuarial Present Values** — computes whole life insurance (Ax) and
  life annuity (ax) APVs at 5% interest for ages 25–50
- **Net Premium Analysis** — derives annual net premiums by age and
  plots the premium curve from age 20 to 80

## Key Results (Canada, Both Sexes, 2024)

- Life expectancy at birth: **82.16 years**
- Life expectancy at age 25: **57.92 years**
- Life expectancy at age 65: **21.15 years**
- Annual net premium per $1 of coverage increases with age,
  consistent with increasing mortality risk

## Data Source

Statistics Canada, Table 13-10-0837-01 — Life expectancy and other
elements of the complete life table, single-year estimates, Canada (2024)

## Technologies

- R 4.6.0
- tidyverse
- ggplot2

## Concepts Applied

- Survival models and life tables
- Probability of death (qx) and survival (px)
- Actuarial present value (APV)
- Whole life insurance and annuity pricing
- Net premium calculation (P = Ax / ax)