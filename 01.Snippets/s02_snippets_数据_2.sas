/* Import a xlsx file from the location specified on the filename statement */
/* The SAS data set created is named by substituting a name for work.myxlsx */

filename xlsx "<location on file system of the XLSX file>" ;

/* Import the XLSX file  */
proc import datafile=xlsx out=work.myxlsx dbms=xlsx;
   getnames=yes;
   run;

/* Print the first 10 observations **/
proc print data=work.myxlsx(obs=10);
   run;

filename xlsx;
