#### SAS宏

------

##### 第一部分:简单回顾

```
DATA ACCT_C03;
SET ACCT(WHERE=(MONTH_NBR = "352")); ...
RUN;
DATA EVENT_C03;
SET EVENT(WHERE=(MONTH_NBR = "352")); ...
RUN;
DATA ACCT_M201902;
SET ACCT;
WHERE START_DT<="28FEB2019"D AND END_DT>"28FEB2019"D;
...
RUN;
DATA ACCT_M201903;
SET ACCT;
WHERE START_DT<="31MAR2019"D AND END_DT>"31MAR2019"D; ...
RUN;
```

##### 第二部分 SAS宏

(1)宏概述

• 宏实现完成重复任务减少必要代码量，对代码的模块化封装，使程序易读、便于修改、移植、方便重复使用;

• 宏包含两部分:宏命令和宏变量;

• 宏命令通常加"%"作为前缀，宏变量通常加"&"作为前缀;

(2)宏变量

用%LET创建一个宏变量，基本形式:

%LET VARNAME = VALUE;

&VARNAME.

• 宏变量有局部宏变量和全局宏变量;

• 如果在宏的内部定义则为局部宏变量，只能在内部使用;

• 如果在开放代码中定义则为全局宏变量;

(3)宏变量声明方法

• %LET语句

• DATA步中使用CALL SYMPUT

• PROC SQL中使用SELECT INTO:

(4)宏结构

宏可以使一段代码在一个或多个程序中被反复使用，而不需要重复的 去编写相同或相似的代码；

宏的基本形式:

```
%MACRO MACRO_NAME;
    MACRO_CODE; 
%MEND MACRO_NAME;

%MACRO_NAME；
```

宏语句中，可以在宏名称后的括号内列出宏参数的名字 基本形式为:

```
%MACRO MACRO_NAME(PARA_1=,PARA_2,...,PARA_N=);
    MACRO_CODE; 
%MEND MACRO_NAME;

%MACRO_NAME(PARA_1=,PARA_2,...,PARA_N=);
```

(5)宏语句

• 宏的条件语句

基本形式为:

```
%IF condition %THEN action; 
%ELSE %IF condition %THEN action; 
%ELSE action;
```

• 宏的控制语句

基本形式为:

```
%DO ... %TO ...; action; %END;
%DO %WHILE(condition); action; %END; 
%DO %UNTIL(condition); action; %END;
```

(6)内置函数

• %SYSFUNC

调用所有SAS的内置函数；

```
%IF %SYSFUNC(MOD(&I., 2)) = 1 
%THEN action;
```

• %EVAL

对表达式进行数值计算；

```
%LET S = 0;
%LET S = %EVAL(&S. + &I.);
```

------

MORE CODE

```SAS
OPTIONS COMPRESS = YES;
```

```SAS
DATA CARS;
KEEP MAKE MODEL MSRP;
SET SASHELP.CARS;
RUN;
/*
41   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
41 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
42   
43   DATA CARS;
44   KEEP MAKE MODEL MSRP;
45   SET SASHELP.CARS;
46   RUN;
NOTE: There were 428 observations read from the data set SASHELP.CARS.
NOTE: The data set WORK.CARS has 428 observations and 3 variables.
NOTE: Compressing data set WORK.CARS increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
47   
48   ods html5 (id=saspy_internal) close;ods listing;
49   
*/
```

```SAS
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
/*
51   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
51 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
52   
53   DATA DVAR01;
54   SET CARS;
55   WHERE MAKE = "BMW";
56   RUN;
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR01 has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR01 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
57   
58   DATA DVAR02;
59   SET CARS;
60   WHERE MAKE = "BMW";
61   RUN;
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR02 has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR02 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
62   
63   DATA DVAR03;
64   SET CARS;
65   WHERE MAKE = "BMW";
66   RUN;
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR03 has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR03 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
67   
68   ods html5 (id=saspy_internal) close;ods listing;
69   
*/
```

```SAS
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

%PUT &VAR1.;
/*
71   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
71 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
72   
73   %LET VAR1 = BMW;
74   
75   DATA DVAR01;
76   SET CARS;
77   WHERE MAKE = "&VAR1.";
78   RUN;
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR01 has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR01 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
79   
80   DATA DVAR02;
81   SET CARS;
82   WHERE MAKE = "&VAR1.";
83   RUN;
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR02 has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR02 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
84   
85   DATA DVAR03;
86   SET CARS;
87   WHERE MAKE = "&VAR1.";
88   RUN;
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR03 has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR03 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
91   
92   %PUT &VAR1.;
BMW
93   
94   ods html5 (id=saspy_internal) close;ods listing;
95   
*/
```

```SAS
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
/*
97   ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
97 ! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
98   
100  %LET VAR1 = Acura;
101  %PUT &VAR1.;
Acura
102  
103  DATA DVAR1;
104  SET CARS;
105  WHERE MAKE = "&VAR1.";
106  RUN;
NOTE: There were 7 observations read from the data set WORK.CARS.
      WHERE MAKE='Acura';
NOTE: The data set WORK.DVAR1 has 7 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR1 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
107  
108  
110  DATA _NULL_;
111      CALL SYMPUT("VAR2", "Acura");
112  RUN;
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
113  %PUT &VAR2.;
Acura
114  
115  DATA DVAR2;
116  SET CARS;
117  WHERE MAKE = "&VAR2.";
118  RUN;
NOTE: There were 7 observations read from the data set WORK.CARS.
      WHERE MAKE='Acura';
NOTE: The data set WORK.DVAR2 has 7 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR2 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
119  
120  
122  PROC SQL NOPRINT;
123  SELECT
124      MAKE INTO: VAR3
125  FROM CARS;
126  QUIT;
NOTE: PROCEDURE SQL used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
      
127  %PUT &VAR3.;
Acura
128  
129  PROC SQL NOPRINT;
130  SELECT
131      MAX(MAKE) INTO :VAR3
132  FROM CARS;
133  QUIT;
NOTE: PROCEDURE SQL used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
134  %PUT &VAR3.;
Volvo
135  
136  PROC SQL NOPRINT;
137  SELECT
138      MAX(MAKE),MIN(MSRP) INTO :VAR3, :VAR4
139  FROM CARS;
140  QUIT;
NOTE: PROCEDURE SQL used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
141  %PUT &VAR3. &VAR4.;
Volvo            10280
142  
143  DATA DVAR3;
144  SET CARS;
145  WHERE MAKE = "&VAR3.";
146  RUN;
NOTE: There were 12 observations read from the data set WORK.CARS.
      WHERE MAKE='Volvo        ';
NOTE: The data set WORK.DVAR3 has 12 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR3 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
147  
148  ods html5 (id=saspy_internal) close;ods listing;
149  
*/
```

```SAS
%MACRO T1;
    DATA A;
    A = 1;
    RUN;
%MEND T1;
%T1;
/*
151  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
151! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
152  
153  %MACRO T1;
154      DATA A;
155      A = 1;
156      RUN;
157  %MEND T1;
158  %T1;
NOTE: Compression was disabled for data set WORK.A because compression overhead would increase the size of the data set.
NOTE: The data set WORK.A has 1 observations and 1 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
159  
160  ods html5 (id=saspy_internal) close;ods listing;
161 
*/
```

```SAS
%MACRO T2(V=,);
    %PUT &V.;

    DATA DVAR_&V.;
    SET CARS;
    WHERE MAKE = "&V.";
    RUN;
%MEND T2;

%T2(V=BMW);
%T2(V=Acura);
/*
163  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
163! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
164  
165  %MACRO T2(V=,);
166      %PUT &V.;
167  
168      DATA DVAR_&V.;
169      SET CARS;
170      WHERE MAKE = "&V.";
171      RUN;
172  %MEND T2;
173  
174  %T2(V=BMW);
BMW
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR_BMW has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR_BMW increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
175  %T2(V=Acura);
Acura
NOTE: There were 7 observations read from the data set WORK.CARS.
      WHERE MAKE='Acura';
NOTE: The data set WORK.DVAR_ACURA has 7 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR_ACURA increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
176  
177  ods html5 (id=saspy_internal) close;ods listing;
178  
*/
```

```SAS
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
/*
180  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
180! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
181  
182  %MACRO T2(V=,);
183      %PUT &V.;
184  
185      DATA DVAR_&V.;
186      SET CARS;
187      WHERE MAKE = "&V.";
188      RUN;
189  %MEND T2;
190  
WARNING: Apparent symbolic reference V not resolved.
191  %PUT &V.;
&V.
192  %T2(V=BMW);
BMW
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR_BMW has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR_BMW increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
WARNING: Apparent symbolic reference V not resolved.
193  %PUT &V.;
&V.
194  
195  ods html5 (id=saspy_internal) close;ods listing;
196  
*/
```

```SAS
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
/*
198  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
198! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
199  
200  %LET M = BMW;
201  
202  %MACRO T3(V=,);
203      %PUT &V.;
204  
205      %IF &V.= &M. %THEN %DO;
206          DATA DVAR_&V.;
207          SET CARS;
208          WHERE MAKE = "&V.";
209          RUN;
211      %END;
212      %ELSE %DO;
213          DATA DVAR_&V.;
214          SET CARS;
215          WHERE MAKE = "&V." AND MSRP > 50000;
216          RUN;
218      %END;
219  
220  %MEND T3;
221  
222  %T3(V=BMW);
BMW
NOTE: There were 20 observations read from the data set WORK.CARS.
      WHERE MAKE='BMW';
NOTE: The data set WORK.DVAR_BMW has 20 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR_BMW increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
223  %T3(V=Acura);
Acura
NOTE: There were 1 observations read from the data set WORK.CARS.
      WHERE (MAKE='Acura') and (MSRP>50000);
NOTE: The data set WORK.DVAR_ACURA has 1 observations and 3 variables.
NOTE: Compressing data set WORK.DVAR_ACURA increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
224  
225  ods html5 (id=saspy_internal) close;ods listing;
226  
*/
```

```SAS
DATA A;
DO I = 1 TO 10;
    T = I + 2;
    OUTPUT;
END;
RUN;

PROC PRINT DATA = A;
RUN;
```

**The SAS System**

|  Obs |    I |    T |
| ---: | ---: | ---: |
|    1 |    1 |    3 |
|    2 |    2 |    4 |
|    3 |    3 |    5 |
|    4 |    4 |    6 |
|    5 |    5 |    7 |
|    6 |    6 |    8 |
|    7 |    7 |    9 |
|    8 |    8 |   10 |
|    9 |    9 |   11 |
|   10 |   10 |   12 |

```SAS
SADATA ACCT;
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
/*
278  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
278! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
279  
280  DATA ACCT;
281  INPUT SEX $ MONTH;
282  CARDS;
NOTE: Compression was disabled for data set WORK.ACCT because compression overhead would increase the size of the data set.
NOTE: The data set WORK.ACCT has 10 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
293  ;
294  RUN;
295  
296  %MACRO T4(V=,);
297      %PUT &V.;
298  
299      %DO I = 0 %TO &V.;
300          DATA A_&I.;
301          SET ACCT;
302          WHERE MONTH = &I.;
303          RUN;
304      %END;
305  %MEND T4;
306  
307  %T4(V=10);
10
NOTE: Compression was disabled for data set WORK.A_0 because compression overhead would increase the size of the data set.
NOTE: There were 2 observations read from the data set WORK.ACCT.
      WHERE MONTH=0;
NOTE: The data set WORK.A_0 has 2 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_1 because compression overhead would increase the size of the data set.
NOTE: There were 2 observations read from the data set WORK.ACCT.
      WHERE MONTH=1;
NOTE: The data set WORK.A_1 has 2 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_2 because compression overhead would increase the size of the data set.
NOTE: There were 2 observations read from the data set WORK.ACCT.
      WHERE MONTH=2;
NOTE: The data set WORK.A_2 has 2 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.01 seconds
      
NOTE: Compression was disabled for data set WORK.A_3 because compression overhead would increase the size of the data set.
NOTE: There were 1 observations read from the data set WORK.ACCT.
      WHERE MONTH=3;
NOTE: The data set WORK.A_3 has 1 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_4 because compression overhead would increase the size of the data set.
NOTE: There were 1 observations read from the data set WORK.ACCT.
      WHERE MONTH=4;
NOTE: The data set WORK.A_4 has 1 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_5 because compression overhead would increase the size of the data set.
NOTE: There were 0 observations read from the data set WORK.ACCT.
      WHERE MONTH=5;
NOTE: The data set WORK.A_5 has 0 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_6 because compression overhead would increase the size of the data set.
NOTE: There were 0 observations read from the data set WORK.ACCT.
      WHERE MONTH=6;
NOTE: The data set WORK.A_6 has 0 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_7 because compression overhead would increase the size of the data set.
NOTE: There were 0 observations read from the data set WORK.ACCT.
      WHERE MONTH=7;
NOTE: The data set WORK.A_7 has 0 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_8 because compression overhead would increase the size of the data set.
NOTE: There were 0 observations read from the data set WORK.ACCT.
      WHERE MONTH=8;
NOTE: The data set WORK.A_8 has 0 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_9 because compression overhead would increase the size of the data set.
NOTE: There were 2 observations read from the data set WORK.ACCT.
      WHERE MONTH=9;
NOTE: The data set WORK.A_9 has 2 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
NOTE: Compression was disabled for data set WORK.A_10 because compression overhead would increase the size of the data set.
NOTE: There were 0 observations read from the data set WORK.ACCT.
      WHERE MONTH=10;
NOTE: The data set WORK.A_10 has 0 observations and 2 variables.
NOTE: DATA statement used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
308  
309  ods html5 (id=saspy_internal) close;ods listing;
310  
*/
```

```SAS
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
```

**The SAS System**

|  Obs |    MSRP | IMSRP |   A0 |   A1 |   A2 |   A3 |   A4 |   A5 |   A6 |
| ---: | ------: | ----: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
|    1 | $36,945 | 40000 |    1 |    1 |    1 |    1 |    0 |    0 |    0 |
|    2 | $23,820 | 20000 |    1 |    1 |    1 |    0 |    0 |    0 |    0 |
|    3 | $26,990 | 30000 |    1 |    1 |    1 |    0 |    0 |    0 |    0 |
|    4 | $33,195 | 30000 |    1 |    1 |    1 |    1 |    0 |    0 |    0 |
|    5 | $43,755 | 40000 |    1 |    1 |    1 |    1 |    1 |    0 |    0 |
|    6 | $46,100 | 50000 |    1 |    1 |    1 |    1 |    1 |    0 |    0 |

```SAS
S%LET S = 1;
%LET I = 10;
%PUT &S. &I.;


%LET S = &S. + &I.;
%PUT &S. &I.;


%LET S = 1;
%LET I = 10;
%LET S = %EVAL(&S. + &I.);
%PUT &S. &I.;
/*
487  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
487! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
488  
489  %LET S = 1;
490  %LET I = 10;
491  %PUT &S. &I.;
1 10
492  
493  
494  %LET S = &S. + &I.;
495  %PUT &S. &I.;
1 + 10 10
496  
497  
498  %LET S = 1;
499  %LET I = 10;
500  %LET S = %EVAL(&S. + &I.);
501  %PUT &S. &I.;
11 10
502  
503  ods html5 (id=saspy_internal) close;ods listing;
504 
*/
```

