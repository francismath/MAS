/* Step 1: Set up the libname for the Excel file */
/*LIBNAME mylib XLSX PATH="C:/Users/enmao/OneDrive - Carleton University/job/BSC/data/Cycle times per recipe and location.xlsx"

/* Example code to import data from Oracle database */
/* libname mylib oracle user=myuser password=mypassword path='//hostname:port/service_name';
data mydata;
   set mylib.oracletable;
run; */

/* Import data from Excel file odaws02-usw2-2*/
/* folders/myfolders/AutoParts/Cycle times per recipe and location.xlsx */

proc import datafile="/home/u63488182/AutoParts/Long-term unemployment rate.csv"
   out=mydata
   dbms=csv
   replace;
   range="Long-term unemployment rate$A1:Z10000"; /* Sheet1$A1 by default*/
run;


/*SET mylib.'+40$';*/
/*delete the first 7 columns*/
data mydata_updated;
	set mydata;
	drop A B C D E F G;
run;

/* Step 2: View the contents of the Excel file */
libname mylib '/home/u63488182/AutoParts/';
proc contents data=mylib._all_;
run;

/* Step 3: Read the data from the Excel file */
data mydata;
   set mylib.Long-term unemployment rate; /* Replace 'sheet1' with the actual sheet name in your Excel file */
run;

/* Step 4: Check the imported data */
proc print data=mydata;
run;

/* Step 5: compute means*/
proc means data=mydata;
  var _numeric_; /* This includes all numeric variables in the dataset */
run;

proc means data=mydata;
  var Value; /* This includes all numeric variables in the dataset */
run;

/* Step 6: compute frequency */
proc freq data=mydata;
	table TIME;
run;

/* Step 5: histogram of numerical variable*/
proc univariate data=mydata;
	var Value;
	histogram / normal;
run;

/* Step 5: bar chart of a categorical variable*/
proc sgplot data=mydata;
	vbar LOCATION;
run;

/* Step 5: box plot of a numerical variable*/
proc sgplot data=mydata;
	vbox Value;
run;

/* Step 5: scatter plot of a pair of numerical variable*/
proc sgplot data=mydata;
	scatter x=time y=Value;
run;

/* Step 5: correlations of a pair of numerical variable*/
proc corr data=mydata outp=correlations;
	var time Value;
run;

/* Step 5: scatter plot of a pair of numerical variable*/
proc sgplot data=correlations;
	heatmap x=time y=Value / colorresponse=corr;
run;

/* Step 5: Close the libname */
libname mylib clear;
