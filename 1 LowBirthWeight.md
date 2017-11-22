# 1.Analysis of "Low Birth Weight"

## 1-1.Introduction: "What is logistic regression?"

### As the simple regression or linear regression deals with the estimation of models like following:

![LinearModel](/images/linearModel.jpg)

### And try to find a set of parameters (a, b) in order to figure out a model which explains the data as correctly as possible. In this case, this model gives you a single line and it is easy to use the result of estimation in your field. But this is applicable for the models with variables with 'continuous' values as the target of estimation.

![LinearModel2](/images/linearModel2.jpg)

### If you have problems like 'Will this customer buy product A?' or 'Will this patient be cured?', you can not apply linear regression because the target variables only have two values ie. '1' for success and '0' for failure.

![binaryModel](/images/binaryModel.jpg)

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

> name of variable|	explanation
> ------|-------
> race	|mother's race (1 = white, 2 = black, 3 = other)
> ptl	|number of previous premature labours
> ftv	|number of physician visits during the first trimester
### Seeing from the explanation above, the variable 'race' can be used as it is, but for 'ptl' and 'ftv', we must change the values of these ones in order to show only two states, ie. 'yes' and 'no'.

### I wrote the following data step code to do this;

![change values](/images/SASprogramChangeData1.jpg)

### As the result, we have following dataset.

![result dataset](/images/SASprocprint1.jpg)


## 1-5.Analysis

### Now, the time for us to do the ligistic regression analysis. In this case, I would like to use 'stepwise method'. Literally, this method introduce explanatory variables(predictors) one by one with order of statistical significance. It is recommended to use if you don't have subject matter knowledge. But if you are 'expert' of this matter, the knowledge must be prioritised.

### I wrote codes as following;

![logistic regression code](/images/SASproclogistic1.jpg)

### In the code above, class statement is used for telling SAS which variables has categorical values and in the model statement, I specified the model to be estimated in this procedure. Submitting this code, we get the output as following;

![logistic regression result](/images/SASproclogistic21.jpg)

### Above tables showing the outlines of this analysis while the third table shows the handling of categorical values. Autually, SAS adds as many variables as the 'sum' of values of categorical variables. And at the end of 'Step0' output, you can find a table as follows.

![logistic regression result2](/images/SASproclogistic22.jpg)

### This is the quite importatnt table in this output becaus this shows the statistical significance of all the variables included in this model. After step1, SAS introduces the variables one by one with the order on this table. So the first variable to be included in this analysis is 'nptl', which indicates the experience of premature labours. And in the step1, the 'effect' of this variable on having low weight baby as shown below.

![logistic regression result3](/images/SASproclogistic23.jpg)

### You can see the effect of 'nptl' most clearly with checking the table named 'Odds Ratio Estimates' on the right hand side. In the table you can see the value of 4.317. This means experience of prematured labour makes the risk of having low weigh baby over 4 times higher!.

### As I read through the documentation of this datset, I notice that the original purpose of this study was to determine the influence of smoking during pregnancy. So let's check the effect of smoking as well. Actually, the variable smoke was introduce on the step5 and provide the odds ratio table as below;

![logistic regression result4](/images/SASproclogistic24.jpg)

### In the table above, smoke shows odds ratio of 2.402	and it is apparent that smoking habit has bad effect on new born baby.

### As we go down until step five and SAS tells us there are no more variables to enter into this model with statistical significance. So let's see the final result of this stepwise regression as below.

![logistic regression result](/images/SASproclogistic25.jpg)

### Also, since we specified on the code the option of 'out=pred' in the code above, we can see the prediction using this model as below.

![logistic regression result](/images/SASproclogistic26.jpg)

### In the list above, the column 'phat' shows the probability of having low weight baby.
