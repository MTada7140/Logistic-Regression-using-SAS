
libname RData 'd:\RData';

proc freq data=RData.birthwt;
tables race ht ptl smoke ui ftv;

data RData.birthwt;
infile 'd:\RData\birthwt.csv'
 dsd firstobs=2;
input id low age lwt race smoke ptl ht ui ftv bwt;
run;


data temp;
    set RData.birthwt;
    if smoke = 0 then nsmoke = 'Not';
                 else nsmoke = 'Exp';
    if ftv   = 0 then nftv   = 'Not';
                 else nftv   = 'Exp';
    if ptl   = 0 then nptl   = 'Not';
                 else nptl   = 'Exp';
    drop smoke ftv ptl; 
run;
data temp;
    set temp;
    smoke = nsmoke;
    ftv   = nftv;
    ptl   = nptl;
    drop nsmoke nftv nptl; 
run;

 
title 'Stepwise Regression on Low weight birth Data';
proc logistic data=temp covout;
   class ftv ptl race smoke;
   model low(event='1') = lwt smoke ptl ht race ftv  
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

