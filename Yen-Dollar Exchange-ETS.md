# Yen-Dollar Exchange Rate Forecasting using ETS Model

This project involves forecasting the Yen-Dollar exchange rate (`DEXJPUS`) using the ETS (Error, Trend, Seasonal components) model. The script is designed to load the relevant data, estimate the ETS model, generate forecasts, and visualize the results.

## Dataset

The dataset used in this project is named `UR&JPY.csv`, which contains the following columns:
- `UNRATE`: U.S. Unemployment Rate
- `DEXJPUS`: Exchange Rate between the Japanese Yen and U.S. Dollar

The dataset spans from January 1971 to January 2024, with monthly observations.

## Files

- **`Assignment 4 Example.R`**: The R script containing all the code for data loading, model estimation, forecasting, and visualization.
- **`UR&JPY.csv`**: The dataset file containing the economic indicators used for time series analysis (to be provided separately).

## Requirements

- R version 3.5.0 or higher
- R packages:
  - `forecast`: For time series forecasting and ETS model fitting

You can install the required package using the following command:
```r
install.packages("forecast")
