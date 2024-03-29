
/*  */
OPTIONS COMPRESS = YES;

DATA CARS;
SET SASHELP.CARS;
RUN;


/*  */
/* PROC SORT */
PROC SORT DATA = SASHELP.CARS;
BY MSRP;
RUN;


/*  */
PROC SORT DATA = SASHELP.CARS OUT = CARS_MSRP;
BY DESCENDING MSRP;
RUN;

PROC SORT DATA = SASHELP.CARS OUT = CARS_MAKE;
BY MAKE;
RUN;


/*  */
DATA CARS_DUP;
KEEP TYPE ORIGIN DRIVETRAIN;
SET SASHELP.CARS;
RUN;

PROC PRINT DATA = CARS_DUP(OBS=20);
RUN;


/*  */
PROC SORT DATA = CARS_DUP(OBS=20) OUT = CARS_NDK NODUPKEY;
BY TYPE ORIGIN;
RUN;

PROC PRINT DATA = CARS_NDK;
RUN;


/*  */
PROC SORT DATA = CARS_DUP(OBS=20) OUT = CARS_NQK NOUNIQUEKEY;
BY TYPE ORIGIN;
RUN;

PROC PRINT DATA = CARS_NQK;
RUN;


/*  */
PROC SORT DATA = CARS_DUP(OBS=20) OUT = CARS_ND NODUP;
BY TYPE ORIGIN;
RUN;

PROC PRINT DATA = CARS_ND;
RUN;


/*  */
/* PROC FREQ */
PROC FREQ DATA = CARS NOPRINT;
TABLE DRIVETRAIN / OUT = CARS_FREQ;
RUN;

PROC PRINT DATA = CARS_FREQ;
RUN;


/*  */
PROC FREQ DATA = CARS;
TABLE DRIVETRAIN * ORIGIN/NOCOL NOROW NOPERCENT MISSING;
RUN;


/*  */
PROC FREQ DATA = CARS;
TABLE ORIGIN * DRIVETRAIN/NOCOL NOROW NOPERCENT MISSING;
RUN;


/*  */
PROC FREQ DATA = CARS;
TABLE DRIVETRAIN * ORIGIN;
WHERE TYPE = "SUV";
RUN;

PROC FREQ DATA = CARS(OBS=20);
TABLE TYPE * DRIVETRAIN * ORIGIN;
RUN;

PROC FREQ DATA = CARS;
TABLE (TYPE DRIVETRAIN) * ORIGIN;
RUN;


/*  */
/* PROC UNIVARIATE */
PROC UNIVARIATE DATA = CARS;
VAR MSRP;
RUN;


/*  */
PROC UNIVARIATE DATA = CARS;
VAR MAKE;
RUN;


/*  */
PROC UNIVARIATE DATA = CARS(OBS=100);
VAR MSRP;
CLASS MAKE;
RUN;


/*  */
/* PROC TRANSPOSE */
DATA CARS_MAMS;
KEEP MAKE TYPE MSRP;
SET SASHELP.CARS;
RUN;

PROC SORT DATA = CARS_MAMS OUT = CARS_MAMSD NODUPKEY;
BY MAKE TYPE;
RUN;

PROC PRINT DATA = CARS_MAMSD;
RUN;


/*  */
PROC TRANSPOSE DATA = CARS_MAMSD;
VAR MSRP;
BY MAKE;
RUN;


/*  */
PROC TRANSPOSE DATA = CARS_MAMSD OUT = CARS_M PREFIX = ID_;
VAR MSRP;
BY MAKE;
ID TYPE;
RUN;

PROC PRINT DATA = CARS_M;
RUN;


/*  */
/* PROC SURVEYSELECT */
PROC SURVEYSELECT 
    DATA = CARS_MAMS METHOD = SRS N = 3 
    OUT = CARS_SRS_N3;
RUN;

PROC PRINT DATA = CARS_SRS_N3;
RUN;


/*  */
PROC SURVEYSELECT 
    DATA = CARS_MAMS METHOD = SRS SAMPRATE = 0.01 
    OUT = CARS_SRS_P1;
RUN;

PROC PRINT DATA = CARS_SRS_P1;
RUN;


/*  */
PROC SURVEYSELECT 
    DATA = CARS_MAMS METHOD = SRS SAMPRATE = 0.01 
    OUT = CARS_SRS_N1;
STRATA MAKE;
RUN;

PROC PRINT DATA = CARS_SRS_N1;
RUN;

