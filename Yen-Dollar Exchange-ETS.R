library(forecast)
  # This program requires calling for the forecast package
  # You need to pre-install the package once, not every time

data_set <- read.csv("UR&JPY.csv",header=TRUE)
  # Upload data set
  # UNRATE U.S. Unemployment Rate
  # DEXJPUS Yen-Dollar Exchange Rate
  # Monthly data from Jan 1971 to Jan 2024

er <- log(ts(data_set$DEXJPUS,start=1971,frequency=12))
  # ts() transfrom data.frame data to time series
  # Start year is 1971
  # Setting frequency to 12 means "monthly"

# Estimation (using full sample of the unemployment rate)

ETS_result_er <- ets(er,model="ANN",damped=FALSE,ic="aic",)
  # ETS()
  # er: the data from Jan 1971 to Jan 2024

# Forecast, ETS Model

ETS_forecast <- forecast(ETS_result_er,h=24)
  # ETS forecast
  # h: forecast horizon
  # h = 24, forecast projected for the 24 months after the estimation period
  # That is, from Feb 2024 to Jan 2026

# Graphing
er_ <- log(data_set$DEXJPUS)
  # I create ur_ to make it distinguishable from ur
  # Personal habit, but if things go wrong, it is easier for me to diagnose
  # where the bug is

er_[638:651] <- NA
  # The original data ends at 637 (sample size)
  # I add 24 rows to ur_ with NA

er2_ <- ts(er_,start=1971,frequency=12)
  # Convert it to time series

er2_subset <- subset(er2_,start=500)
  # subset() select a subset of the series
  # Because I want the graph to highlight the forecast, I do not want the full
  # sample in the diagram which will dominate the diagram
  # start: I pick the subset starting at the 500th observation

autoplot(er2_subset,xlab="Time",ylab="Japanese Yen to US$1.00",main="Yen-Dollar Exchange Rates: Forecasts for the Next 24 Months")+autolayer(ETS_forecast)
  # Autoplot is similar to plot
  # Stack Overflow says I need autolayer, LOL. This is where the forecasts are projected

# Other Output
ETS_result_er
ETS_forecast
