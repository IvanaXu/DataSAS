/********************************************************************************/
/* The snippet provides examples for applying data profiling to a data set      */
/* using DATAMETRICS procedure with/without multiidentity optional argument     */
/* specified on Identities statement.                                           */
/*                                                                              */
/* The steps are:                                                               */
/* (1) Set QKB Locale and Prepare Data                                          */
/* (2) Apply data profiling to input data set                                   */
/*     a) Calculate one identity for identification analysis                    */
/*     b) Calculate more than one identity for identification analysis          */
/********************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create the input data set */
data nameSet ;
  input id 1-2 names $ 5-22;
cards;
1   Joan Raggio
2   Alexander Healy
3   Jody Hazlett
4   Brandon Visconti
5   Becky Loui
6   Martha Brockmeier
7   Shirley Espino
8   V Kipp
9   Stacy Stockli
10  Brittany Delman
11  Lauren Tellez
12  Megan Hampu
13  John Deere
14  Mary Kay
15  Krispy Kreme
;
run;

/* Run the dataMetrics procedure to profile a data set without multiidentity    */
/* specified. The required arguments specified for proc dataMetrics are data    */
/* (nameSet) and out (names_multi_false). The optional arguments specified for  */
/* the proc metaMetrics are median and threads (2). The optional specified      */
/* argument specified for the identities statement is def ("field_content").    */
proc dataMetrics data=nameSet out=names_multi_false median threads=2;
    identities def="Field Content";
run;

/* Run the dataMetrics procedure to profile a data set with multiidentity.      */
/* The optional arguments specified for proc dataMetrics are data (nameSet)     */
/* and out (names_multi_false). The optional arguments specified for proc       */
/* dataMetrics are median and  threads (2). The optional arguments specified    */
/* for the identities statement are def ("field_content") and multi.            */
proc datametrics data=nameSet out=names_multi_true median threads=2;
    identities def="Field Content" multi;
run;
