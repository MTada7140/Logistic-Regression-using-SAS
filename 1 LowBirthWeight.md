# 1.Analysis of "Low Birth Weight"

## 1-1.Introduction: "What is logistic regression?"
###   As the simple regression or linear regression deals with the estimation of models like following:
 
![LinearModel](/images/linearModel.jpg)
### And try to find a set of parameters (a, b) in order to figure out a model which explains the data as correctly as possible. In this case, this model gives you a single line and it is easy to use the result of estimation in your field. But this is applicable for the models with variables with 'continuous' values as the target of estimation.
![Result window](/images/linearModel2.jpg)
### If you have problems like *'Will this customer buy product A?'* or *'Will this patient be cured?'*, you can not apply linear regression because the target variables only have two values ie. '1' for success and '0' for failure. 
![Log window](/images/binaryModel.jpg)
### In this case, logistic regression is quite effective. Logistic regression enables you to estimate the models you need in this kind of event and still the results provided are easy to read. That means logistic regression gives you the 'acctionable' estimations of models to you. In fact, logistic regression is a one of the most favourable analytical method in the field of marketing and medicine. 
## 1-2.Getting the data
### In this article, I would like to use a data in the R library called "Risk Factors Associated with Low Infant Birth Weight". This contains 189 rows of data which collected at Baystate Medical Center in 1986. It can be downloaded from "https://github.com/vincentarelbundock/Rdatasets/tree/master/csv/MASS".
## 1-3.Reading the raw data from csv file
### The downloaded file looks like this. 
![rawdata](/images/rawdata.jpg)
### To read this raw data in csv format, we can use "dsd" option of SAS data step. And all the data items contain only numeric values, so reading the data is quite simple as follows. 
![reading Birtwt](/images/SASprogramReadData1.jpg)
### In the above program list, I included 'libname' statement on the top to create 'permanent' data library followed by 'data step'. In the data step, I use infile statement with 'dsd' option. With this, we don't have to worry about double quotation marks surrounding 'ID' item in the rawdata. Also, we must specify 'firstobs' option in order to skip the first row which contains field names. 
## 1-4.Inspection of input file  
### After reading raw data, we must do some preparation works before doing analysis. The first thing we must do is the inspection of dataset. Because, to apply logistic regression, all the explanatory variables either 1) have continuous values or 2) are categorical variables with only two values(ex. male or female, pass or fail etc.) otherwise, we must include 'class' option in our model.
### So, we must know which data item have which values. In this case, 'Freq' procedure is quite effective and useful.
![freq procedure](/images/SASprocfreq.jpg)
### In the program list above, I used 'tables' option. With this, we can see the values of each variables as separate tables.
![result of freq procedure](/images/SASprocfreq2.jpg)
### As show in the tables above, we now see the range of the variables in our dataset. The variables named 'race' has three values, 'ptl' has four and 'ftv' has seven values. Before we headding to building our model, let's see the meaning of variables from the explanatory document.
> **race** mother's race (1 = white, 2 = black, 3 = other).
> **ptl**  number of previous premature labours.
> **ftv**  number of physician visits during the first trimester.
### Seeing from the explanation above, the variable 'race' can be used as it is, but for 'ptl' and 'ftv', we must change the values of these ones in order to show only two states, ie. 'yes' and 'no'.
### I wrote the following data step code to do this;

### 

