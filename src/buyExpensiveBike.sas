libname adworks 'd:\AdWorks';

data adworks.Customer(drop=SpanishOccupation FrenchOccupation SpanishEducation FrenchEducation
                           AddressLine1 AddressLine2 Phone MiddleName NameStyle Title
                           CommuteDistance Suffix eMail custAltKey);
length custAltKey $17. FirstName MiddleName LastName eMail $20.
       englishEducation SpanishEducation FrenchEducation $20. 
       EnglishOccupation SpanishOccupation FrenchOccupation $30.
       phone CommuteDistance $10. Suffix $10.
       AddressLine1 AddressLine2 $120.;   
infile 'd:\AdWorks\AdWorksData\DimCustomer.csv'
      dsd dlm='|' obs=max;
informat BirthDate DateFirstPurchase yymmdd10.;
input CustomerKey GeographyKey CustAltKey Title $ FirstName MiddleName LastName NameStyle
      BirthDate MaritalStatus $ Suffix Gender $ eMail YearlyIncome TotalChildren
      NumberChildAtHome englishEducation SpanishEducation FrenchEducation
      EnglishOccupation SpanishOccupation FrenchOccupation HouseOwnerFlag NumberCarsOwned
      AddressLine1 AddressLine2 Phone DateFirstPurchase CommuteDistance;

select (CommuteDistance);
	when('0-1 Miles' )        commute  = 800;
	when('1-2 Miles' )        commute  = 2000;
	when('2-5 Miles' )        commute  = 6400;
	when('5-10 Miles')        commute  = 12800;
	when('10+ Miles' )        commute  = 20000;
end;

format BirthDate DateFirstPurchase date9.
run;

data adworks.Sales(drop=ProductKey OrderDateKey DueDateKey ShipDateKey PromotionKey CurrencyKey SalesTerritoryKey 
                        SalesOrderNumber SalesOrderLineNumber RevisionNumber
                        ExtendedAmount UnitPriceDiscountPct DiscountAmount ProductStandardCost
                        TotalProductCost TaxAmt Freight CarrierTrackingNumber CustomerPONumber
                        OrderDate DueDate ShipDate);
length SalesOrderNumber $17. CarrierTrackingNumber CustomerPONumber $20.
       OrderDate DueDate ShipDate $20.; 
infile 'd:\AdWorks\AdWorksData\FactInternetSales.csv'
      dsd dlm='|' obs=max;

input ProductKey OrderDateKey DueDateKey ShipDateKey 
      CustomerKey PromotionKey CurrencyKey SalesTerritoryKey 
      SalesOrderNumber SalesOrderLineNumber RevisionNumber
      OrderQuantity UnitPrice ExtendedAmount UnitPriceDiscountPct
      DiscountAmount ProductStandardCost TotalProductCost
      SalesAmount TaxAmt Freight CarrierTrackingNumber CustomerPONumber
      OrderDate DueDate ShipDate;
run;

proc sort data=adworks.Sales;
by CustomerKey;
run;

data sumWork(drop=salesAmount quantity unitPrice);
set adworks.sales;
by CustomerKey;
if first.CustomerKey then totalAmount =0;
totalAmount+SalesAmount;
if last.CustomerKey  then output;
run;

data adworks.customerSales;
merge adworks.Customer sumWork;
by CustomerKey;
run;


data adworks.customerSales;
set adworks.customerSales;
drop buyExpensiveBike;
run; 

data selectSales(drop=ProductKey OrderDateKey DueDateKey ShipDateKey PromotionKey CurrencyKey SalesTerritoryKey 
                        SalesOrderNumber SalesOrderLineNumber RevisionNumber
                        ExtendedAmount UnitPriceDiscountPct DiscountAmount ProductStandardCost
                        TotalProductCost TaxAmt Freight CarrierTrackingNumber CustomerPONumber
                        UnitPrice OrderQuantity SalesAmount OrderDate DueDate ShipDate);
length SalesOrderNumber $17. CarrierTrackingNumber CustomerPONumber $20.
       OrderDate DueDate ShipDate $20.; 
infile 'd:\AdWorks\AdWorksData\FactInternetSales.csv'
      dsd dlm='|' obs=max;

input ProductKey OrderDateKey DueDateKey ShipDateKey 
      CustomerKey PromotionKey CurrencyKey SalesTerritoryKey 
      SalesOrderNumber SalesOrderLineNumber RevisionNumber
      OrderQuantity UnitPrice ExtendedAmount UnitPriceDiscountPct
      DiscountAmount ProductStandardCost TotalProductCost
      SalesAmount TaxAmt Freight CarrierTrackingNumber CustomerPONumber
      OrderDate DueDate ShipDate;
if    ProductKey not in (310,311,312,313,314,315,316,317,318,320) then delete;
run;

proc sort data=work.selectsales nodup;
by customerkey;

data adworks.customerSales;
merge adworks.customerSales(in=ina) 
      selectsales(in=inb);
by CustomerKey;
buyExpensiveBike = 0;
if ina and inb then buyExpensiveBike = 1;
run;



title 'Stepwise Regression on Bike purchase Data';
proc logistic data=adworks.customerSales outest=betas covout;
   class HouseOwnerFlag Gender MaritalStatus EnglishOccupation; 
   model buyExpensiveBike(event='1')=YearlyIncome HouseOwnerFlag 
         TotalChildren NumberChildAtHome NumberCarsOwned commute 
         Gender MaritalStatus EnglishOccupation
                / selection=stepwise
                  slentry=0.3
                  slstay=0.35
                  details
                  lackfit;
   output out=pred p=phat lower=lcl upper=ucl
          predprob=(individual crossvalidate);
run;

proc print data=pred;
   title2 'Predicted Probabilities and 95% Confidence Limits';
run;
