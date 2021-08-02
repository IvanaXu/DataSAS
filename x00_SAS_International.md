### SAS International Format

------

(1)DATE

(2)CHAR

```SAS
/* --------------------------------------------------------------------------------------------- */
/* Before */
%MACRO RCYC1(ST=, ED=,);
    DATA _NULL_;
        CALL SYMPUT("DEV", INTCK("MONTH", INPUT("&ST.01", YYMMDD8.), INPUT("&ED.01", YYMMDD8.)));
    RUN;
    %PUT &DEV.;

    %DO I = 0 %TO &DEV.;
        DATA _NULL_;
            CALL SYMPUT("NMON", PUT(INTNX("MONTH", INPUT("&ST.01", YYMMDD8.), &I.), YYMMN6.));
        RUN;
        %PUT &I. &NMON.;

        DATA CARS_&NMON.;
        SET SASHELP.CARS(OBS=10);
        RUN;
    %END;
%MEND RCYC1;
%RCYC1(ST=201801, ED=201802);
/* --------------------------------------------------------------------------------------------- */

/*
34   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
34 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
35   
38   %MACRO RCYC1(ST=, ED=,);
39       DATA _NULL_;
40           CALL SYMPUT("DEV", INTCK("MONTH", INPUT("&ST.01", YYMMDD8.), INPUT("&ED.01", YYMMDD8.)));
41       RUN;
42       %PUT &DEV.;
43   
44       %DO I = 0 %TO &DEV.;
45           DATA _NULL_;
46               CALL SYMPUT("NMON", PUT(INTNX("MONTH", INPUT("&ST.01", YYMMDD8.), &I.), YYMMN6.));
47           RUN;
48           %PUT &I. &NMON.;
49   
50           DATA CARS_&NMON.;
51           SET SASHELP.CARS(OBS=10);
52           RUN;
53       %END;
54   %MEND RCYC1;
55   %RCYC1(ST=201801, ED=201802);
NOTE: Numeric values have been converted to character values at the places given by: (Line):(Column).
      55:42   
NOTE: DATA statement used (Total process time):
      real time           0.01 seconds
      cpu time            0.00 seconds
      
1
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
0 201801
NOTE: There were 10 observations read from the data set SASHELP.CARS.
NOTE: The data set WORK.CARS_201801 has 10 observations and 15 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
      
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
1 201802
NOTE: There were 10 observations read from the data set SASHELP.CARS.
NOTE: The data set WORK.CARS_201802 has 10 observations and 15 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
57   
58   ods html5 (id=saspy_internal) close;ods listing;
59   
*/
```

```SAS
%LET C1 = "DEV";
%LET C2 = "MONTH";
%LET C3 = "NMON";

%MACRO RCYC2(ST=, ED=,);
    %LET MST = "&ST.01";
    %LET MED = "&ED.01";

    DATA _NULL_;
        CALL SYMPUT(&C1., INTCK(&C2., INPUT(&MST., YYMMDD8.), INPUT(&MED., YYMMDD8.)));
    RUN;
    %PUT &DEV.;	

    %DO I = 0 %TO &DEV.;
        DATA _NULL_;
            CALL SYMPUT(&C3., PUT(INTNX(&C2., INPUT(&MST., YYMMDD8.), &I.), YYMMN6.));
        RUN;
        %PUT &I. &NMON.;

        DATA CARS_&NMON.;
        SET SASHELP.CARS(OBS=10);
        RUN;
    %END;
%MEND RCYC2;
%RCYC2(ST=201801, ED=201802);

/*
61   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
61 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
62   
63   %LET C1 = "DEV";
64   %LET C2 = "MONTH";
65   %LET C3 = "NMON";
66   
67   %MACRO RCYC2(ST=, ED=,);
68       %LET MST = "&ST.01";
69       %LET MED = "&ED.01";
70   
71       DATA _NULL_;
72           CALL SYMPUT(&C1., INTCK(&C2., INPUT(&MST., YYMMDD8.), INPUT(&MED., YYMMDD8.)));
73       RUN;
74       %PUT &DEV.;	
75   
76       %DO I = 0 %TO &DEV.;
77           DATA _NULL_;
78               CALL SYMPUT(&C3., PUT(INTNX(&C2., INPUT(&MST., YYMMDD8.), &I.), YYMMN6.));
79           RUN;
80           %PUT &I. &NMON.;
81   
82           DATA CARS_&NMON.;
83           SET SASHELP.CARS(OBS=10);
84           RUN;
85       %END;
86   %MEND RCYC2;
87   %RCYC2(ST=201801, ED=201802);
NOTE: Numeric values have been converted to character values at the places given by: (Line):(Column).
      87:41   
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
1
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
0 201801
NOTE: There were 10 observations read from the data set SASHELP.CARS.
NOTE: The data set WORK.CARS_201801 has 10 observations and 15 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
      
1 201802
NOTE: There were 10 observations read from the data set SASHELP.CARS.
NOTE: The data set WORK.CARS_201802 has 10 observations and 15 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
88   
89   ods html5 (id=saspy_internal) close;ods listing;

90   
*/
```

