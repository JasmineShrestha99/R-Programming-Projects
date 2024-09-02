# Load the necessary library for time series forecasting
library(forecast)

# Read the dataset from a CSV file named "UR&JPY.csv" and store it in the variable data_set
data_set <- read.csv("UR&JPY.csv", header=TRUE)

# Create a time series object for the U.S. unemployment rate (UNRATE) starting in 1971 with monthly frequency
ur <- ts(data_set$UNRATE, start=1971, frequency=12)

# Create a time series object for the log of the USD/JPY exchange rate (DEXJPUS) starting in 1971 with monthly frequency
er <- ts(log(data_set$DEXJPUS), start=1971, frequency=12)

# Fit an ARIMA model to the unemployment rate time series using the AIC criterion to select the best model
ARpq_result_ur_aic <- auto.arima(ur, max.p=12, max.q=12, max.d=0, ic="aic")

# Display the summary of the ARIMA model selected using AIC
summary(ARpq_result_ur_aic)

# Fit an ARIMA model to the unemployment rate time series using the AICC criterion
ARpq_result_ur_aicc <- auto.arima(ur, max.p=6, max.q=6, max.d=0, ic="aicc")

# Display the summary of the ARIMA model selected using AICC
summary(ARpq_result_ur_aicc)

# Fit an ARIMA model to the unemployment rate time series using the BIC criterion
ARpq_result_ur_bic <- auto.arima(ur, max.p=6, max.q=6, max.d=0, ic="bic")

# Display the summary of the ARIMA model selected using BIC
summary(ARpq_result_ur_bic)

# Forecast the next 12 months of the unemployment rate using the ARIMA model selected by AIC
ARpq_forecast <- forecast(ARpq_result_ur_aic, h=12)

# Create a copy of the unemployment rate data and introduce missing values (NA) in a specific range
ur_ <- data_set$UNRATE
ur_[638:651] <- NA

# Create a new time series object with the modified unemployment rate data
ur2_ <- ts(ur_, start=1971, frequency=12)

# Subset the modified time series data starting from the 500th observation
ur2_subset <- subset(ur2_, start=500)

# Plot the subset of the modified unemployment rate data with the ARIMA forecast overlayed
autoplot(ur2_subset, xlab="Time", ylab="Percent", main="U.S. Unemployment Rate: Forecasts for the Next 12 Months") + autolayer(ARpq_forecast)

# Estimate the exchange rate time series up to the 625th observation
er_est <- er[1:625]

# Fit an ARIMA model to the exchange rate time series using the AIC criterion
ARpq_result_er_aic <- auto.arima(er_est, max.p=12, max.q=12, max.d=0, ic="aic")

# Forecast the next 12 months of the exchange rate using the ARIMA model selected by AIC
ARpq_forecast_aic <- forecast(ARpq_result_er_aic, h=12)

# Display the forecasted exchange rate values
ARpq_forecast_aic

# Display the summary of the ARIMA forecast for the exchange rate
summary(ARpq_forecast_aic)

# Generate a random walk forecast for the exchange rate without drift
rwf_no_drift <- rwf(er_est, h=12, drift=FALSE)

# Display the random walk forecast without drift
rwf_no_drift

# Generate a random walk forecast for the exchange rate with drift
er_est <- er[1:625] 
rwf_drift <- rwf(er_est, h=12, drift=TRUE)

# Display the random walk forecast with drift
rwf_drift

# Create a matrix named Table2 to store actual and forecasted values for comparison
Table2 <- matrix(0, 12, 6)

# Store the actual exchange rate values in the first column of the matrix
Table2[,1] <- er[626:637]

# Store the ARIMA forecasted values in the second column of the matrix
Table2[,2] <- ARpq_forecast_aic$mean

# Store the random walk forecasted values without drift in the fifth column of the matrix
Table2[,5] <- rwf_no_drift$mean

# Store the random walk forecasted values with drift in the sixth column of the matrix
Table2[,6] <- rwf_drift$mean
