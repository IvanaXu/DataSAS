### SAS Encrypt

(1) Data Columns Encrypt;

```SAS
DATA CARS;
SET SASHELP.CARS(OBS=10);
STRING = COLLATE(0, 255);
HIGH4 = REVERSE(STRING);
KEEP MAKE MODEL MSRP STRING HIGH4;
RUN;


DATA CARS1;
SET CARS;
ENCRYPT = TRANSLATE(MODEL, HIGH4, STRING);
DECRYPT = TRANSLATE(ENCRYPT, STRING, HIGH4);
RUN; 


PROC PRINT DATA = CARS1;
VAR MODEL DECRYPT;
RUN;
```

**The SAS System**

|  Obs |                   Model |                 DECRYPT |
| ---: | ----------------------: | ----------------------: |
|    1 |                     MDX |                     MDX |
|    2 |          RSX Type S 2dr |          RSX Type S 2dr |
|    3 |                 TSX 4dr |                 TSX 4dr |
|    4 |                  TL 4dr |                  TL 4dr |
|    5 |              3.5 RL 4dr |              3.5 RL 4dr |
|    6 | 3.5 RL w/Navigation 4dr | 3.5 RL w/Navigation 4dr |
|    7 |  NSX coupe 2dr manual S |  NSX coupe 2dr manual S |
|    8 |             A4 1.8T 4dr |             A4 1.8T 4dr |
|    9 |  A41.8T convertible 2dr |  A41.8T convertible 2dr |
|   10 |              A4 3.0 4dr |              A4 3.0 4dr |

```SAS
PROC PRINT DATA = CARS1;
RUN;
/*
58   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
58 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
59   
60   PROC PRINT DATA = CARS1;
61   RUN;
ERROR: Invalid characters were present in the data.
ERROR: An error occurred while processing text data.
NOTE: The SAS System stopped processing this step because of errors.
NOTE: There were 10 observations read from the data set WORK.CARS1.
NOTE: PROCEDURE PRINT used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
62   
63   ods html5 (id=saspy_internal) close;ods listing;
64  
*/
```

(2) Data Macro Encrypt;

```SAS
/* ENCRYPT */
LIBNAME MPOC "macro/";
OPTION MSTORED SASMSTORE = MPOC;

%MACRO STRA_CAL()/STORE SECURE;
    %PUT 1;
%MEND STRA_CAL;
%STRA_CAL();

/*
66   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
66 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
67   
69   LIBNAME MPOC "macro/";
NOTE: Libref MPOC was successfully assigned as follows: 
      Engine:        V9 
      Physical Name: /folders/myfolders/SASData/macro
70   OPTION MSTORED SASMSTORE = MPOC;
71   
72   %MACRO STRA_CAL()/STORE SECURE;
73       %PUT 1;
74   %MEND STRA_CAL;
75   %STRA_CAL();
1
76   
77   
78   ods html5 (id=saspy_internal) close;ods listing;
79   
*/
```

HOW TO USE:

```SAS
/* DECRYPT */
LIBNAME MPOC "macro/";
OPTION MSTORED SASMSTORE = MPOC;
%STRA_CAL();
```

(3) Data Set Encrypt;

```SAS
DATA S_A(ENCRYPT=YES PW=Q1W2E3R4);
SET SASHELP.CARS;
RUN;
/*
81   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
81 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
82   
83   DATA S_A(ENCRYPT=YES PW=XXXXXXXX);
84   SET SASHELP.CARS;
85   RUN;
NOTE: There were 428 observations read from the data set SASHELP.CARS.
NOTE: The data set WORK.S_A has 428 observations and 15 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
86   
87   ods html5 (id=saspy_internal) close;ods listing;
88   
*/
```

```SAS
/* READ */
PROC PRINT DATA = S_A;
RUN;

/* ALTER */
PROC DELETE DATA = S_A;
RUN;

/*
90   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
90 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
91   
93   PROC PRINT DATA = S_A;
ERROR: Invalid or missing READ password on member WORK.S_A.DATA.
94   RUN;
NOTE: The SAS System stopped processing this step because of errors.
NOTE: PROCEDURE PRINT used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
95   
97   PROC DELETE DATA = S_A;
98   RUN;
ERROR: Invalid or missing ALTER password on member WORK.S_A.DATA.
NOTE: The SAS System stopped processing this step because of errors.
NOTE: PROCEDURE DELETE used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
99   
100  
101  ods html5 (id=saspy_internal) close;ods listing;
102  
*/
```

```SAS
DATA S_B;
SET S_A(PW=Q1W2E3R4);
RUN;

PROC PRINT DATA = S_B(OBS=1);
VAR MAKE;
RUN;

PROC DELETE DATA = S_B;
RUN;
```

**The SAS System**

|  Obs |  Make | Model |    MSRP | STRING | HIGH4 | ENCRYPT | DECRYPT |
| ---: | ----: | ----: | ------: | -----: | ----: | ------: | ------: |
|    1 | Acura |   MDX | $36,945 |        |       |         |         |

|  Obs |  Make |
| ---: | ----: |
|    1 | Acura |

