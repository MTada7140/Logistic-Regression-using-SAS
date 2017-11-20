# 2.Pre-analysis tasks

## 2-1. Seeing the shape of original series
### Before you apply the time series model to your data, it is extremely important to know the 'shape' of your data. Without knowing this, you will make the mistake of applying wrong model(s) to your data. To do this, the easiest way is to make graph of the data. In SAS, you can submit following code to do this.
![Code of Sgplot](/images/ProcStepSgPlot1.jpg)
### Submitting this code, the graph below is shown on the results window. There seems to be up trend and cyclic changing patterns are there in this data. 
![Result of Sgplot](/images/Graph1.jpg)
### To see these 'basic patterns' clearer, I would like to make 'year-on-year' oveorlayed graphs from this dataset. To do this, the first thing I must do is to cut down data into 'single' year. So I write data step shown below.
![Code for transformation](/images/DataStep3.jpg)
### Submitting this code, I got the dataset shown below. With this, data of each year is stored as a column. So I got 13 columns for years covered by this series altogether.
![Transformed Data set](/images/Result3.jpg)
### To make a graph from this data, I submitted code below.
![Code of Sgplot](/images/ProcStepSgPlot2.jpg)
### And I got this graph.
![Result of Sgplot](/images/Graph2.jpg)
### Seeing this graph, you can recognise the up trend of the whole series and seasonal pattern(have peek in December - January) more clearly.

 




