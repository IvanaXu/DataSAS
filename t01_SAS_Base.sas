

/* */
DATA TMP0;
INPUT SEX $ X1-X3;
CARDS;
F 1 2 3
M 4 5 6
;
RUN;

PROC PRINT DATA = TMP0;
RUN;


/* */
DATA TMP1;
SET TMP0;
WHERE SEX = "F";
RUN;

PROC PRINT DATA = TMP1;
RUN;


/* */
PROC IMPORT DATAFILE = "TEST.CSV"
OUT = TMP2 DBMS = CSV REPLACE;
GETNAMES = NO;
RUN;

PROC PRINT DATA = TMP2;
RUN;


/* */
DATA TMP3;
A = 1;
RUN;

PROC PRINT DATA = TMP3;
RUN;


/* */
PROC EXPORT DATA = TMP3
OUTFILE = "TEST1.CSV" DBMS = CSV
REPLACE;
RUN;


/* */
PROC PRINT DATA = TMP2;
RUN;


/* */
PROC SORT DATA = TMP2;
BY VAR1;
RUN;

PROC PRINT DATA = TMP2;
RUN;


/* */
PROC SORT DATA = TMP2;
BY VAR2 VAR1;
RUN;

PROC PRINT DATA = TMP2;
RUN;


/* */
PROC PRINT DATA = TMP2;
RUN;

PROC FREQ DATA = TMP2;
TABLE VAR1;
RUN;


/* */
PROC PRINT DATA = TMP2;
RUN;

PROC FREQ DATA = TMP2;
TABLE VAR1 * VAR2;
RUN;


/* */
DATA TMP4_1;
CHAR = "123456";
SCHAR = SUBSTR(CHAR,1,3);
RUN;

PROC PRINT DATA = TMP4_1;
RUN;


/* */
DATA TMP4_2;
PI = 3.1415926;
RPI1 = ROUNDZ(PI,.01);
RPI2 = ROUNDZ(PI,1);
RUN;

PROC PRINT DATA = TMP4_2;
RUN;


/* */
DATA TMP4_3;
DT = INTCK("DAY", "01JAN2019"D, "02JAN2019"D);
RUN;

PROC PRINT DATA = TMP4_3;
RUN;


/* */
OPTIONS COMPRESS = YES;


/* */
DATA A;
SET SASHELP.CARS;
RUN;

PROC PRINT DATA = A(OBS = 10 KEEP = MAKE MSRP);
RUN;


/* */
DATA A;
SET SASHELP.CARS;
MSRP1 = MSRP + 1;
RUN;

PROC PRINT DATA = A(OBS = 10 KEEP = MAKE MSRP MSRP1);
RUN;


/* */
DATA A;
KEEP MSRP1;
SET SASHELP.CARS;
MSRP1 = MSRP + 1;
RUN;

PROC PRINT DATA = A(OBS=10);
RUN;


/* */
DATA B1;
FORMAT MSRP2 $20.;
SET A;
IF MSRP1 > 30000 THEN MSRP2 = "DAYU3W";
ELSE MSRP2 = "XIAOYU1000";
RUN;

DATA B2;
FORMAT MSRP2 $20.;
SET A;
IF MSRP1 > 30000 THEN MSRP2 = "DAYU3W";
ELSE IF MSRP1 > 1000 THEN MSRP2 = "DAYU3W<1000";
ELSE IF MSRP1 > 200 THEN MSRP2 = "DAYU3W<200";
ELSE MSRP2 = "XIAOYU1000";
RUN;

PROC PRINT DATA = B1(OBS=10);
RUN;
PROC PRINT DATA = B2(OBS=10);
RUN;


/* */
DATA C;
KEEP MSRP1;
SET SASHELP.CARS;
MSRP1 = MSRP + 1;
IF MSRP1 > 50000;
RUN;

PROC PRINT DATA = C(OBS=10);
RUN;


/* */
DATA D;
KEEP MSRP1;
SET SASHELP.CARS;
MSRP1 = MSRP + 1;
WHERE MSRP1 > 50000;
RUN;

PROC PRINT DATA = D(OBS=10);
RUN;


/* */
DATA E;
KEEP MSRP1 MSRP2;
SET SASHELP.CARS;
MSRP1 = MSRP + 1;
IF MSRP1 > 50000;
IF MSRP1 > 60000 THEN MSRP2 = ">";
ELSE MSRP2 = "<";
RUN;

PROC PRINT DATA = E(OBS=10);
RUN;

/* IF SUBSTR(A,1,1) = "1" */
/* IF SUBSTR(A,1,1) = "1" OR SUBSTR(A,1,1) = "2" */
/* IF SUBSTR(A,1,1) = "1" AND MSRP1 > 60000 */
/* IF SUBSTR(A,1,1) IN ("1", "2") */
/* IF SUBSTR(A,1,1) NOT IN ("1", "2") */



