# 1.Analysis of "Low Birth Weight"

## 1-1.Introduction: "What is logistic regression?"
###   As the simple regression or 'linear' regression deals with the estimation of models like 
 
![LinearModel](/images/linearModel.jpg)
### And try to find a set of parameters (a, b) in order to figure out a model which explains the data as correctly as possible. In this case, this model gives you a single line and it is easy to use the result of estimation. But this is applicable for the models with 'continuous' variables as the target of estimation.
![Result window](/images/linearModel2.jpg)
### If you have problems like *'Will this customer buy product A?'* or *'Will this patient be cured?'*, you can not apply linear regression because the target variables only have two values ie. '1' for success and '0' for failure. 
![Log window](/images/binaryModel.jpg)
### In this case, logistic regression is quite effective. Ligistic regression enables you to estimate the model you need in this kind of model and still the result is easy to read. That means logistic regression gives you the 'acctionable' outcomes to you 
## 1-2.Getting the data
### In this article, I'd like to use a 'real' data published on the web site. I found a monthly data of passengers from this site(http://new.censusatschool.org.nz/resource/time-series-data-sets-2013/).
### The data is organised in the form of csv file and look like this.
### As you can see, there are three columns contained and 154 records in total in this file to cover from January of 2000 to October of 2012. I am  going to read and create SAS data set for this file on the next section.
## 1-3.Reading the raw data from csv file
### To read the raw data from csv file we saw on the previous section, the first program I write and submitted is listed below.
### There are five program steps in this program. The first line specifies the name of output dataset with second line showing input file specification. Please note that there are two options added to 'infile' statement. One is 'dsd' which is used to read comma seperated file and another is 'firstobs' which is used to skip reading the first line which contains only the column headding. Submitting this one, I got the result below.
### Seeing the result, three columns are read from input file, but there is one thing which is not good for further analysis. Because the date column(in this case named 'yymm') contains character 'M' between year and month. In SAS, this is not recognised as 'date' type information. In order to remove this problem, several codes must be added.
### Looking at this code, you will find three lines are added in order to make up date type column of SAS(line 5 to 7). The first two lines added for extracting numbers of year and month from originad 'Date' column and the third line is aded to form date type column using 'mdy' function. Submitting this program, the final data set is created as shown below.
### From the next chapter, I will show you the steps of time series analysis using this dateset. 

  
