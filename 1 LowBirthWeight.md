# 1.Preparations for time series analysis 

## 1-1.Software
###   Surprisingly, since 2016, SAS software can be used free of charge for learning purpose. You can download and install the required software from this URL(https://www.sas.com/en_nz/software/university-edition/download-software.html). The initial panel of "SAS University Edition" looks like this.  
![SAS Studio](/images/SASStudio1.jpg)
### You can submit any program you like from the 'code' window and get output on the 'results' window(in html format).
![Result window](/images/SASStudioOutput.jpg)
### Also, you can have a look at the ordinary SAS log on the 'log' window. 
![Log window](/images/SASStudioLog.jpg)
## 1-2.Getting the data
### In this article, I'd like to use a 'real' data published on the web site. I found a monthly data of passengers from this site(http://new.censusatschool.org.nz/resource/time-series-data-sets-2013/).
### The data is organised in the form of csv file and look like this.
 ![Data 'NZAirPassengers.csv'(partially displayed)](/images/NZAirPassengers.jpg)
### As you can see, there are three columns contained and 154 records in total in this file to cover from January of 2000 to October of 2012. I am going to read and create SAS data set for this file on the next section.
## 1-3.Reading the raw data from csv file
### To read the raw data from csv file we saw on the previous section, the first program I write and submitted is listed below.
 ![The first program](/images/DataStep1.jpg)
### There are five program steps in this program. The first line specifies the name of output dataset with second line showing input file specification. Please note that there are two options added to 'infile' statement. One is 'dsd' which is used to read comma seperated file and another is 'firstobs' which is used to skip reading the first line which contains only the column headding. Submitting this one, I got the result below.
 ![Result of the first program](/images/Result1.jpg)
### Seeing the result, three columns are read from input file, but there is one thing which is not good for further analysis. Because the date column(in this case named 'yymm') contains character 'M' between year and month. In SAS, this is not recognised as 'date' type information. In order to remove this problem, several codes must be added.
 ![The first program](/images/DataStep2.jpg)
### Looking at this code, you will find three lines are added in order to make up date type column of SAS(line 5 to 7). The first two lines added for extracting numbers of year and month from originad 'Date' column and the third line is aded to form date type column using 'mdy' function. Submitting this program, the final data set is created as shown below.
 ![Result of the first program](/images/Result2.jpg)
### From the next chapter, I will show you the steps of time series analysis using this dateset. 

  
