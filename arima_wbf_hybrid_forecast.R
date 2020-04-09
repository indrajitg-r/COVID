# Load packages

library(forecast)
library(caret)
library(WaveletArima)

#### Code assumes that the time-series data set for a country is loaded as a variable y ####
#### Build an ARIMA model

mymodel=auto.arima(y)

#### 10-step ahead forecast from the fitted ARIMA model
fit=forecast(mymodel,h=10)

#### Assign residuals to a variable
res=fit$residuals

#### Fit a WBF model to the residuals obtained from the previous step 
#### Simultaneously 10-ste-ahead forecast using the fitted WBF model
WaveletForecast<-WaveletFittingarma(res,Waveletlevels=floor(log(length(res))),boundary='periodic',FastFlag=TRUE,MaxARParam=5,MaxMAParam=5,NForecast=10)


#### Add the fitted ARIMA outouts to the fitted WBF model outputs
hybrid_fit=WaveletForecast$FinalPrediction+mymodel$fitted

#### Compute accuracy of the hybrid model
RMSE(hybrid_fit, y)
MAE(hybrid_fit, y)

#### Final 10-day-ahead forecast
final_forecast=fit$mean+WaveletForecast$Finalforecast