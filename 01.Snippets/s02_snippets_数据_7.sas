/* Create an XML representation of SASHELP.CARS in the directory specified       */
/* on the the filename statement.  The directory name should be fully qualified  */

filename xmlout "<location on file system to put the XML file>" encoding="utf-8";
libname xmlout xmlv2;

data xmlout.cars;
set sashelp.cars;
run;

libname xmlout;
