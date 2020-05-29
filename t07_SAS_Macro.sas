

/* */
OPTIONS COMPRESS = YES;

DATA CARS;
KEEP MAKE MODEL MSRP;
SET SASHELP.CARS;
RUN;


/* */
DATA DVAR01;
SET CARS;
WHERE MAKE = "BMW";
RUN;

DATA DVAR02;
SET CARS;
WHERE MAKE = "BMW";
RUN;

DATA DVAR03;
SET CARS;
WHERE MAKE = "BMW";
RUN;


/* */
%LET VAR1 = BMW;

DATA DVAR01;
SET CARS;
WHERE MAKE = "&VAR1.";
RUN;

DATA DVAR02;
SET CARS;
WHERE MAKE = "&VAR1.";
RUN;

DATA DVAR03;
SET CARS;
WHERE MAKE = "&VAR1.";
RUN;

/* ... */

%PUT &VAR1.;


/* */
/* 1 */
%LET VAR1 = Acura;
%PUT &VAR1.;

DATA DVAR1;
SET CARS;
WHERE MAKE = "&VAR1.";
RUN;


/* 2 */
DATA _NULL_;
    CALL SYMPUT("VAR2", "Acura");
RUN;
%PUT &VAR2.;

DATA DVAR2;
SET CARS;
WHERE MAKE = "&VAR2.";
RUN;


/* 3 */
PROC SQL NOPRINT;
SELECT
    MAKE INTO: VAR3
FROM CARS;
QUIT;
%PUT &VAR3.;

PROC SQL NOPRINT;
SELECT
    MAX(MAKE) INTO :VAR3
FROM CARS;
QUIT;
%PUT &VAR3.;

PROC SQL NOPRINT;
SELECT
    MAX(MAKE),MIN(MSRP) INTO :VAR3, :VAR4
FROM CARS;
QUIT;
%PUT &VAR3. &VAR4.;

DATA DVAR3;
SET CARS;
WHERE MAKE = "&VAR3.";
RUN;


/* */
%MACRO T1;
    DATA A;
    A = 1;
    RUN;
%MEND T1;
%T1;


/* */
%MACRO T2(V=,);
    %PUT &V.;

    DATA DVAR_&V.;
    SET CARS;
    WHERE MAKE = "&V.";
    RUN;
%MEND T2;

%T2(V=BMW);
%T2(V=Acura);


/* */
%MACRO T2(V=,);
    %PUT &V.;

    DATA DVAR_&V.;
    SET CARS;
    WHERE MAKE = "&V.";
    RUN;
%MEND T2;

%PUT &V.;
%T2(V=BMW);
%PUT &V.;


/* */
%LET M = BMW;

%MACRO T3(V=,);
    %PUT &V.;

    %IF &V.= &M. %THEN %DO;
        DATA DVAR_&V.;
        SET CARS;
        WHERE MAKE = "&V.";
        RUN;
        /* ... */
    %END;
    %ELSE %DO;
        DATA DVAR_&V.;
        SET CARS;
        WHERE MAKE = "&V." AND MSRP > 50000;
        RUN;
        /* ... */
    %END;

%MEND T3;

%T3(V=BMW);
%T3(V=Acura);


/* */
DATA A;
DO I = 1 TO 10;
    T = I + 2;
    OUTPUT;
END;
RUN;

PROC PRINT DATA = A;
RUN;


/* */
DATA ACCT;
INPUT SEX $ MONTH;
CARDS;
X0001 0
X0001 1
X0001 2
X0001 3
X0001 4
X0002 0
X0002 1
X0003 9
X0004 2
X0005 9
;
RUN;

%MACRO T4(V=,);
    %PUT &V.;

    %DO I = 0 %TO &V.;
        DATA A_&I.;
        SET ACCT;
        WHERE MONTH = &I.;
        RUN;
    %END;
%MEND T4;

%T4(V=10);


/* */
%MACRO T5(V=, N=10000);
    %PUT &V.;

    DATA MSRP;
    SET CARS;
    IMSRP = ROUNDZ(MSRP, &N.);
    %DO I = 0 %TO &V.;
        IF MSRP > &I.*&N. THEN A&I. = 1;ELSE A&I. = 0;
    %END;
    DROP MAKE MODEL;
    RUN;

    PROC PRINT DATA = MSRP(OBS=&V.);
    RUN;
%MEND T5;

%T5(V=6);


/* */
%LET S = 1;
%LET I = 10;
%PUT &S. &I.;


%LET S = &S. + &I.;
%PUT &S. &I.;


%LET S = 1;
%LET I = 10;
%LET S = %EVAL(&S. + &I.);
%PUT &S. &I.;