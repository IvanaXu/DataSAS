/* Create a CSV representation of SASHELP.CARS in the file specified on  */
/* the filename statement.  The file name should be fully qualified and  */
/* end with .csv                                                         */

filename outcsv "<location on file system to put the CSV file>";

proc export data=sashelp.cars
            outfile=outcsv
            dbms=csv replace;
run;

filename outcsv;
