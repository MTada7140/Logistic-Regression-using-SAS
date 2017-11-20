# 3.Applying ARIMA model

### So far, we've done the preparation and pre-analysis tasks for time series analysis. The final step is to applying time series model(this case ARIMA model) to our data set. There are three steps in applying ARIMA model to a certain data. These are called identify, estimate and forecast in SAS. I would show the codes and results of these steps in this order.

## 3-1. Identify
### The goal of this step is to find out what is the most 'fit' model to our series data. The first thing we must do is submit the code below and see the diagnostic statistics.
![Code of identify](/images/ProcStepARIMA1.jpg)
Submitting this code, we get the output below.
![Output of identify1](/images/Result41.jpg)
![Output of identify2](/images/Result42.jpg)
### With seeing the graph on the middle, there clearly seen the bad behaviour of the data. As we see in the previous section, there is upward trend of whole series. To remove this trend component, we must take the first order differencing of the series. To do this, code has bee changed as below.
![Code of identify2](/images/ProcStepARIMA2.jpg)
### This time number one in parentheses follows variable name. With this, we can use the differenced data for our analysis. Below is the result.
![Output of identify1](/images/Result51.jpg)
![Output of identify2](/images/Result52.jpg)
### On seeing the result of this time, we can recognise that the trend graph is 'randomised' and there are no more upward trend. But there still be the influence from seasonal changing patterns. In order to remove this influence, we must introduce the AR(Auto Regression) and MA(Moving Average) models with differenciation. In this stage, SAS can help us quite strongly with testing the several model parameters automatically and recommending us the best fit model for this series. The code we must submit this time is shown below with 'scan' option in the var statement.
![Code of identify3](/images/ProcStepARIMA3.jpg)
### And we get the result of 'scanning' as below and recommendation of p(autoregression parameter)=4 and q(moving average parameter)=5. Hence we get the initial model of ARIMA(4,1,5) as a result.
![Output of identify1](/images/Result61.jpg)
![Output of identify2](/images/Result62.jpg)
## 3-2. Estimate
### As we have got the model parameters, the next thing we must do is the estimation of model formula. To do this, code below is to be submitted.
![Code of identify3](/images/ProcStepARIMA4.jpg)
### With the result of this, the following estimation is done.
![Output of estimate](/images/Result7.jpg)

## 3-3. Forecast
### The final thing is the forecasting.
### The code is shown below.
![Code of forecast](/images/ProcStepARIMA5.jpg)
### And here is the output of forecasting for 12 month foreward.
![Output of estimate](/images/Result8.jpg)



 



