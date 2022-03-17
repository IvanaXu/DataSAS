/* Import a csv file from the location specified on the filename statement */
/* The SAS data set created is named by substituting a name for work.mycsv */

filename csv "<location on file system of the CSV file>";

/* Import the CSV file  */
proc import datafile=csv out=work.mycsv dbms=csv;
   getnames=yes;
   run;

/* Print the first 10 observations **/
proc print data=work.mycsv(obs=10);
   run;

filename csv;
