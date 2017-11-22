# 2.Analysis of "Will He(She) Buy an Expensive Bike?"

## 2-1.Introduction and the data
### Another appropriate field of applying logistic regression is 'marketing'. In tis section, I'd like to show an example of analysis on purchasing probability. The data I am using in this section is sample data provided by Microsoft corporation. It is a set of data regarding a bike manufacturer called 'Adventure Works'. It is quite useful for this kind of analysis because the data contains all data table required for retail/manufacturing analysis including sales, customer, employee, product, manufacturing and so on. This data can be downloaded from "https://msftdbprodsamples.codeplex.com/releases/view/125550" and I chose "Adventure Works 2014 Warehouse Script".
### I set the purpose of analysis using data as estimation of purchasing expensive bike.
 
## 2-2.Reading the raw data from 'csv' file 
### The downloaded file looks like this. 
![rawdata](/images/rawdata2.jpg)
### Although this file has name with extension of '.csv', the delimiter is not comma. So to read this raw data, we must specify "dlm=" option in infile statement as well as "dsd" option. The code I wrote to read customer table is as follows. 
![reading Customer](/images/SASprogramReadData2.jpg)
### In the above program list, I included 'libname' statement on the top to create 'permanent' data library followed by 'data step'. In the data step, I use infile statement with 'dsd' and 'dlm' options. I also put 'length' statement just after data statement because there are no way for SAS to know the length of columns of original table. Without this, SAS determine the length of item with the first row. For example, the first row contains the value 'John' as 'first name' column, the value on the second row 'Margarette' would become 'Marg' with truncation. Following 'informat' statement has been put to convert data type. Actually, SAS holds date as integer data. The number count 0 start on 1st of January,1960. The date before become minus and date after become plus data in SAS. So the default presentation of 01/01/1970 in SAS is "3653". Following format statement has been put in order to avoid output date in this 'numeric' format. 	 
### I also put some codes for converting of column "CommuteDistance". The original value was string denoding commuting distance of certain customer, but I converted the value into numeric I thought it would be easier to read. Submitting this code and we get following dataset as result.
![result Dataset](/images/SASprocprint2.jpg)

## 2-3.Reading of Sales data and merging  
### Before we can do the logistic regression, there is another thing we must do. Since we are going to anlyse future purchase behaviour from past behavioural data, we must read sales data and merge it to customer data. So first of all, let's have alook at the sales data;
![result Dataset](/images/SASprocprint3.jpg)
### Seeing the sales data above, we can recognize the key to customer data(field name is "customerKey"). So the task is compress the rows of saels data by customer key field and then merge with the customer table.
### I wrote the following code to read, sort and compress dataset by customerKey. 
![datastep](/images/SASdatastep1.jpg)
### The last data step for compressing data is a little bit tricky, once if you sort a dataset with the key variable, you can use 'first' and 'last' automatic variables in the datastep. In my case, 'if first.CustomerKey' means the time when SAS read the next CustomerKey and 'if last.CustomerKey' means the time just before the next CustomerKey value. And I put the initialisation of total variable on the former one and output statement on the latter. That make up the typical program of key compression in SAS. Other than 'first' and 'last', SAS has a lot of automatic variables you can use.
### After the compression, next step is merging. It's a lit;le bit easier.
![datastep](/images/SASdatastep2.jpg)
### As you can see above, just set two datasets to merge and specify your merging key. With these steps above we got dataset with customer attributes and sales figures combined. The last step is setting of the target value; ie. bought or didn't buy expensive a bike. It is also done by merging with sales data. But this case sales data must be limited to the sales data of expensive bikes only. After that, data steps required are quite similar to the previous one.
![datastep](/images/SASdatastep3.jpg)

## 2-4.Analysis using logistic regression
### After we finished the preparation of data, we can proceed to the analysis step. The code I wrote is basically same as the one of the previous section.  



 

