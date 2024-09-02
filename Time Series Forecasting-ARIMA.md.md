# Time Series Forecasting Using ARIMA Models

This project demonstrates time series forecasting using ARIMA models on economic data, specifically the U.S. unemployment rate and the exchange rate between the U.S. dollar and Japanese yen. The code utilizes the `forecast` package in R to build, evaluate, and visualize forecasts.

## Dataset

The dataset used in this project is assumed to be named `UR&JPY.csv`, which contains two primary columns:
- `UNRATE`: U.S. Unemployment Rate
- `DEXJPUS`: Exchange Rate between U.S. Dollar and Japanese Yen

The dataset is expected to cover the period starting from 1971, with a monthly frequency.

## Files

- **`Assignment3corrected.R`**: The R script containing all the code for data loading, model fitting, forecasting, and visualization.
- **`UR&JPY.csv`**: The dataset file containing the economic indicators used for time series analysis (this file should be provided separately).

## Requirements

- R version 3.5.0 or higher
- R packages:
  - `forecast`: For time series forecasting and ARIMA model fitting
  - `ggplot2`: For data visualization (if not included, consider adding)

Install the required packages using the following commands:
```r
install.packages("forecast")
install.packages("ggplot2")
