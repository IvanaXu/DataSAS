#### 1、SAS宏
```SAS
%MACRO printTable(table);

PROC PRINT DATA=&TABLE;RUN;

%MEND;

%printTable(SASHELP.CARS);
```
```
观测	Make	Model	Type	Origin	DriveTrain	MSRP	Invoice	EngineSize	Cylinders	Horsepower	MPG_City	MPG_Highway	Weight	Wheelbase	Length
1	Acura	MDX	SUV	Asia	All	$36,945	$33,337	3.5	6	265	17	23	4451	106	189
2	Acura	RSX Type S 2dr	Sedan	Asia	Front	$23,820	$21,761	2.0	4
...
```

#### 2、SAS宏Char函数
```SAS
  /*----------------------------------------------*/
  /*       Macro Char Functions                   */
  /*----------------------------------------------*/


  /*------------------------------*/
  /*       %EVAL FUNCTION         */
  /*------------------------------*/

  %let num1=%eval(32767+7233);
  %put &num1 should be 40000;


  /*------------------------------*/
  /*       %INDEX FUNCTION        */
  /*------------------------------*/

  %let a=a very long value;
  %let b=%index(&a,v);
  %put v appears at position &b..;         /* at 3 */

  /*------------------------------*/
  /*       %LENGTH FUNCTION       */
  /*------------------------------*/

  %macro aproc;
     proc print; run;
  %mend aproc;

  %put %length(&a) should be 17;

  %put %length(%aproc) should be 16;

  /*------------------------------*/
  /*       %SCAN FUNCTION         */
  /*------------------------------*/

	%LET P=CATS AND DOGS;
	%LET Q=%SCAN(&P,3,%str( ));
	%put &q SHOULD BE DOGS;


  /*-------------------------------*/
  /*      %substr function         */
  /*-------------------------------*/

   %LET FIRST=THIS BOOK;
   %LET SECOND=%SUBSTR(&FIRST,6,4);
   %put &second SHOULD BE BOOK;


  /*-------------------------------*/
  /*      %UPCASE function         */
  /*-------------------------------*/

  %let string=%upcase(a string to upcase);
  %put &string should be A STRING TO UPCASE;
```
```
1    %studio_hide_wrapper;
77   
78   /*----------------------------------------------*/
79     /*       Macro Char Functions                   */
80     /*----------------------------------------------*/
81   
82   
83     /*------------------------------*/
84     /*       %EVAL FUNCTION         */
85     /*------------------------------*/
86   
87     %let num1=%eval(32767+7233);
88     %put &num1 should be 40000;
40000 should be 40000
89   
90   
91     /*------------------------------*/
92     /*       %INDEX FUNCTION        */
93     /*------------------------------*/
94   
95     %let a=a very long value;
96     %let b=%index(&a,v);
97     %put v appears at position &b..;         /* at 3 */
v appears at position 3.
98   
99     /*------------------------------*/
100    /*       %LENGTH FUNCTION       */
101    /*------------------------------*/
102  
103    %macro aproc;
104       proc print; run;
105    %mend aproc;
106  
107    %put %length(&a) should be 17;
17 should be 17
108  
109    %put %length(%aproc) should be 16;
16 should be 16
110  
111    /*------------------------------*/
112    /*       %SCAN FUNCTION         */
113    /*------------------------------*/
114  
115  %LET P=CATS AND DOGS;
116  %LET Q=%SCAN(&P,3,%str( ));
117  %put &q SHOULD BE DOGS;
DOGS SHOULD BE DOGS
118  
119  
120    /*-------------------------------*/
121    /*      %substr function         */
122    /*-------------------------------*/
123  
124     %LET FIRST=THIS BOOK;
125     %LET SECOND=%SUBSTR(&FIRST,6,4);
126     %put &second SHOULD BE BOOK;
BOOK SHOULD BE BOOK
127  
128  
129    /*-------------------------------*/
130    /*      %UPCASE function         */
131    /*-------------------------------*/
132  
133    %let string=%upcase(a string to upcase);
134    %put &string should be A STRING TO UPCASE;
A STRING TO UPCASE should be A STRING TO UPCASE
135  
136  %studio_hide_wrapper;
144  
145  
```

#### 3、SAS宏Do语句
```SAS
 /*----------------------------------------------*/
 /*       %DO  statement                         */
 /*----------------------------------------------*/

 %macro shownote(length);
    %if &length = LONG %then %do;
       %put NOTE: This is a longer note.;
       %put NOTE: It is shown if the macro parameter is set to the value LONG.;
       %put NOTE: The default note is much shorter.;
    %end;
    %else %put NOTE: This is a short note;
%mend shownote;

%shownote(LONG)

  /* results should be:

 NOTE: This is a longer note.
 NOTE: It is shown if the macro parameter is set to the value LONG.
 NOTE: The default note is much shorter.

 */
```
```
1    %studio_hide_wrapper;
77   
78    /*----------------------------------------------*/
79    /*       %DO  statement                         */
80    /*----------------------------------------------*/
81   
82    %macro shownote(length);
83       %if &length = LONG %then %do;
84          %put NOTE: This is a longer note.;
85          %put NOTE: It is shown if the macro parameter is set to the value LONG.;
86          %put NOTE: The default note is much shorter.;
87       %end;
88       %else %put NOTE: This is a short note;
89   %mend shownote;
90   
91   %shownote(LONG)
NOTE: This is a longer note.
NOTE: It is shown if the macro parameter is set to the value LONG.
NOTE: The default note is much shorter.
92   
93     /* results should be:
94   
95    NOTE: This is a longer note.
96    NOTE: It is shown if the macro parameter is set to the value LONG.
97    NOTE: The default note is much shorter.
98   
99    */
100  
101  %studio_hide_wrapper;
109  
110  
```

#### 4、SAS宏If语句
```SAS
  /*----------------------------------------------*/
  /*       %IF  statement                         */
  /*----------------------------------------------*/

  %macro testif;
      %local x y z;
      %let x=10;
      %let y=5;
      %let z=0;
      %if &x > &y %then %put test 1 successful;
      %else %put test 1 failed;
      %if &x < &y %then %put test 2 failed;
      %else %put test 2 successful;
      %if &x %then %put test 3 successful;
      %else %put test 3 failed;
      %if &z %then %put test 4 failed;
      %else %put test 4 successful;
   %mend testif;

   %testif

  /* results should be:
test 1 successful
test 2 successful
test 3 successful
test 4 successful
*/
```
```
1    %studio_hide_wrapper;
77   
78    /*----------------------------------------------*/
79     /*       %IF  statement                         */
80     /*----------------------------------------------*/
81   
82     %macro testif;
83         %local x y z;
84         %let x=10;
85         %let y=5;
86         %let z=0;
87         %if &x > &y %then %put test 1 successful;
88         %else %put test 1 failed;
89         %if &x < &y %then %put test 2 failed;
90         %else %put test 2 successful;
91         %if &x %then %put test 3 successful;
92         %else %put test 3 failed;
93         %if &z %then %put test 4 failed;
94         %else %put test 4 successful;
95      %mend testif;
96   
97      %testif
test 1 successful
test 2 successful
test 3 successful
test 4 successful
98   
99     /* results should be:
100  test 1 successful
101  test 2 successful
102  test 3 successful
103  test 4 successful
104  */
105  
106  %studio_hide_wrapper;
114  
115  
```

#### 5、SAS宏变量
```SAS
  /*----------------------------------------------*/
  /*      Macro Variables                        */
  /*----------------------------------------------*/

/* User Defined Global Variables */
%let city=Dallas;
%let date=25APR2014;
%let amount=343;

/* User Defined Local Variables */
%macro lvars;
   %local name day;
   %let name=Ed Norton;
   %let day=Friday;
   %put _local_;
%mend;

/* When we run this we will see the Local Variables in %lvar */
%lvars

/* This show all global user and automatic macro variables */
%put _all_;
```
```
1    %studio_hide_wrapper;
77   
78   /*----------------------------------------------*/
79     /*      Macro Variables                        */
80     /*----------------------------------------------*/
81   
82   /* User Defined Global Variables */
83   %let city=Dallas;
84   %let date=25APR2014;
85   %let amount=343;
86   
87   /* User Defined Local Variables */
88   %macro lvars;
89      %local name day;
90      %let name=Ed Norton;
91      %let day=Friday;
92      %put _local_;
93   %mend;
94   
95   /* When we run this we will see the Local Variables in %lvar */
96   %lvars
LVARS DAY Friday
LVARS NAME Ed Norton
97   
98   /* This show all global user and automatic macro variables */
99   %put _all_;
GLOBAL A a very long value
GLOBAL AMOUNT 343
GLOBAL B 3
GLOBAL CITY Dallas
GLOBAL CLIENTMACHINE sasstudioapp5f9dc9d488mqght
GLOBAL DATE 25APR2014
GLOBAL FIRST THIS BOOK
GLOBAL GRAPHINIT goptions reset=all gsfname=_gsfname;
GLOBAL GRAPHTERM goptions noaccessible;
GLOBAL NUM1 40000
GLOBAL P CATS AND DOGS
GLOBAL Q DOGS
GLOBAL REQUESTEDLOCALE zh-CN
GLOBAL SASWORKLOCATION
"/viya/tmp/b12d2128-6178-4cd5-9322-98741b72191e/SAS_work5A6B000000B3_sas-launcher-f93b9477-75ad-4ca4-9282-37911634d818-rpsmx/"
GLOBAL SECOND BOOK
GLOBAL STRING A STRING TO UPCASE
GLOBAL SYSCASINIT 0
GLOBAL SYSUSERNAME 14******07@qq.com                                                                                                

GLOBAL SYS_COMPUTE_DATA /compute_data
GLOBAL SYS_COMPUTE_JOB_ID 134F9AD3-19E4-454F-885C-5A6B7194E37F
GLOBAL SYS_COMPUTE_SESSION_ID b12d2128-6178-4cd5-9322-98741b72191e-ses0000
GLOBAL SYS_COMPUTE_SESSION_OWNER 14******07@qq.com
GLOBAL TWORKLOC
"/viya/tmp/b12d2128-6178-4cd5-9322-98741b72191e/SAS_work5A6B000000B3_sas-launcher-f93b9477-75ad-4ca4-9282-37911634d818-rpsmx"
GLOBAL VALIDLOCALE zh_CN
GLOBAL _BASEURL https:pdcesx19004.mytrials.sas.comSASStudio
GLOBAL _CASHOSTCONT_ controller.sas-cas-server-default.sse.svc.cluster.local
GLOBAL _CASHOST_ controller.sas-cas-server-default.sse.svc.cluster.local
GLOBAL _CASPORT_ 5570
GLOBAL _CLIENTAPP SAS Studio
GLOBAL _CLIENTAPPABBREV Studio
GLOBAL _CLIENTAPPVERSION 2020.1.3
GLOBAL _CLIENTMACHINE sasstudioapp5f9dc9d488mqght
GLOBAL _CLIENTMODE viya
GLOBAL _CLIENTUSERID 14******07@qq.com
GLOBAL _CLIENTUSERNAME 14******07@qq.com
GLOBAL _CLIENTVERSION 6.163.19
GLOBAL _EXECENV SASStudio
GLOBAL _GITVERSION         0.27
GLOBAL _MACRO_FOUND 0
GLOBAL _ORIGSYNTAXCHECK SYNTAXCHECK
GLOBAL _SASHOSTNAME saslauncherf93b947775ad4ca4928237911634d818rpsmx
GLOBAL _SASPROGRAMFILE
GLOBAL _SASPROGRAMFILEHOST saslauncherf93b947775ad4ca4928237911634d818rpsmx
GLOBAL _SASSERVERNAME saslauncherf93b947775ad4ca4928237911634d818rpsmx
GLOBAL _SASWORKINGDIR
/viya/tmp/b12d2128-6178-4cd5-9322-98741b72191e/SAS_work5A6B000000B3_sas-launcher-f93b9477-75ad-4ca4-9282-37911634d818-rpsmx
GLOBAL _SASWSTEMP_
viyatmpb12d212861784cd5932298741b72191eSAS_work5A6B000000B3_saslauncherf93b947775ad4ca4928237911634d818rpsmx
GLOBAL _SASWS_
viyatmpb12d212861784cd5932298741b72191eSAS_work5A6B000000B3_saslauncherf93b947775ad4ca4928237911634d818rpsmx
GLOBAL _STUDIONOTES
GLOBAL _STUDIOSOURCE
GLOBAL _STUDIOSTIMER
GLOBAL _USERHOME /home/14******07@qq.com
AUTOMATIC AFDSID 0
AUTOMATIC AFDSNAME
AUTOMATIC AFLIB
AUTOMATIC AFSTR1
AUTOMATIC AFSTR2
AUTOMATIC FSPBDV
AUTOMATIC SYSADDRBITS 64
AUTOMATIC SYSBUFFR
AUTOMATIC SYSCC 0
AUTOMATIC SYSCHARWIDTH 1
AUTOMATIC SYSCMD
AUTOMATIC SYSDATASTEPPHASE
AUTOMATIC SYSDATE 17MAR22
AUTOMATIC SYSDATE9 17MAR2022
AUTOMATIC SYSDAY Thursday
AUTOMATIC SYSDEVIC
AUTOMATIC SYSDMG 0
AUTOMATIC SYSDSN WORK    PRODUCTS                                                           
AUTOMATIC SYSENCODING utf-8
AUTOMATIC SYSENDIAN LITTLE
AUTOMATIC SYSENV BACK
AUTOMATIC SYSERR 0
AUTOMATIC SYSERRORTEXT
AUTOMATIC SYSFILRC 1
AUTOMATIC SYSHOSTINFOLONG Linux LIN X64 3.10.0-1160.6.1.el7.x86_64 #1 SMP Tue Nov 17 13:59:11 UTC 2020 x86_64 Red Hat Enterprise
Linux release 8.3 (Ootpa)
AUTOMATIC SYSHOSTNAME sas-launcher-f93b9477-75ad-4ca4-9282-37911634d818-rpsmx
AUTOMATIC SYSINCLUDEFILEDEVICE
AUTOMATIC SYSINCLUDEFILEDIR
AUTOMATIC SYSINCLUDEFILEFILEREF
AUTOMATIC SYSINCLUDEFILENAME
AUTOMATIC SYSINDEX 43
AUTOMATIC SYSINFO 0
AUTOMATIC SYSJOBID 179
AUTOMATIC SYSLAST WORK.PRODUCTS
AUTOMATIC SYSLCKRC 0
AUTOMATIC SYSLIBRC 0
AUTOMATIC SYSLOGAPPLNAME
AUTOMATIC SYSMACRONAME
AUTOMATIC SYSMAXLONG 9007199254740992
AUTOMATIC SYSMENV S
AUTOMATIC SYSMSG
AUTOMATIC SYSNCPU 4                   
AUTOMATIC SYSNOBS 428
AUTOMATIC SYSODSESCAPECHAR 03
AUTOMATIC SYSODSGRAPHICS 1
AUTOMATIC SYSODSPATH  WORK.TEMPLAT(UPDATE) SASUSER.TEMPLAT(READ) SASHELP.TMPLMST(READ)
AUTOMATIC SYSPARM
AUTOMATIC SYSPRINTTOLOG
AUTOMATIC SYSPRINTTOLIST
AUTOMATIC SYSPROCESSID 41DD40B28FA761BF4018000000000000
AUTOMATIC SYSPROCESSMODE SAS Compute Server
AUTOMATIC SYSPROCESSNAME Compute Server
AUTOMATIC SYSPROCNAME
AUTOMATIC SYSRC 0
AUTOMATIC SYSSCP LIN X64
AUTOMATIC SYSSCPL Linux
AUTOMATIC SYSSITE 70180938
AUTOMATIC SYSSIZEOFLONG 8
AUTOMATIC SYSSIZEOFPTR 8
AUTOMATIC SYSSIZEOFUNICODE 4
AUTOMATIC SYSSTARTID
AUTOMATIC SYSSTARTNAME
AUTOMATIC SYSTCPIPHOSTNAME sas-launcher-f93b9477-75ad-4ca4-9282-37911634d818-rpsmx
AUTOMATIC SYSTIME 06:18
AUTOMATIC SYSTIMEZONE GMT+08:00
AUTOMATIC SYSTIMEZONEIDENT ETC/GMT-8
AUTOMATIC SYSTIMEZONEOFFSET 28800
AUTOMATIC SYSUSERID 14******07@qq.com
AUTOMATIC SYSVER V.04.00
AUTOMATIC SYSVIYARELEASE 20210406.1617742339209
AUTOMATIC SYSVIYAVERSION Stable 2020.1.3
AUTOMATIC SYSVLONG V.04.00M0P021421
AUTOMATIC SYSVLONG4 V.04.00M0P02142021
AUTOMATIC SYSWARNINGTEXT
100  
101  %studio_hide_wrapper;
109  
110  
```

#### 6、SAS宏参数
```SAS
  /*----------------------------------------------*/
  /*       Macro Parameters                       */
  /*----------------------------------------------*/


/* Positional Paramaters */

%macro pospar(var1,var2,var3,var4,var5);
      %put &var1 &var2 &var3 &var4 &var5;
  %mend pospar;

  %pospar();

  /* results should be: *blank*  */


  %pospar(str1,str2,str3,str4,str5)


  /*  results should be: str1 str2 str3 str4 str5  */

  %pospar(str1)

  /* results should be: str1  */


/* Keyword Parameters  */

  %macro keypar(var1=str1,var2=str2,var3=);
  %put &var1 &var2 &var3;
  %mend keypar;

  %keypar();

  /* results should be: str1 str2  */


  %keypar();

  /* results should be: str1 str2  */

  %keypar(var1=abc,var2=def,var3=ghi)

  /* results should be: abc def ghi */


```
```
1    %studio_hide_wrapper;
77   
78   /*----------------------------------------------*/
79     /*       Macro Parameters                       */
80     /*----------------------------------------------*/
81   
82   
83   /* Positional Paramaters */
84   
85   %macro pospar(var1,var2,var3,var4,var5);
86         %put &var1 &var2 &var3 &var4 &var5;
87     %mend pospar;
88   
89     %pospar();
90   
91     /* results should be: *blank*  */
92   
93   
94     %pospar(str1,str2,str3,str4,str5)
str1 str2 str3 str4 str5
95   
96   
97     /*  results should be: str1 str2 str3 str4 str5  */
98   
99     %pospar(str1)
str1
100  
101    /* results should be: str1  */
102  
103  
104  /* Keyword Parameters  */
105  
106    %macro keypar(var1=str1,var2=str2,var3=);
107    %put &var1 &var2 &var3;
108    %mend keypar;
109  
110    %keypar();
str1 str2
111  
112    /* results should be: str1 str2  */
113  
114  
115    %keypar();
str1 str2
116  
117    /* results should be: str1 str2  */
118  
119    %keypar(var1=abc,var2=def,var3=ghi)
abc def ghi
120  
121    /* results should be: abc def ghi */
122  
123  
124  
125  %studio_hide_wrapper;
133  
134  
```

#### 7、SAS宏引用
```SAS
  /*----------------------------------------------*/
  /*       Macro Quoting                          */
  /*----------------------------------------------*/


  %macro m;
    %put this is macro m;
  %mend m;

  %let p=%str(proc print; run;);
  %put p = &p;

  /* results should be:  p = proc print; run; */


  %let m=%nrstr(look at macro %m and var &m);
  %put m = &m;

  /* results should be: m = look at macro %m and var &m */


 data test;
    store="Tom's place";
    call symput('s',store);
run;

%macro test;
   %if %bquote(&s) ne %then %put *** valid ***;
   %else %put *** null value ***;
%mend test;
%test;

 /* results should be:  *** valid *** */


 %let bqtvar=%str(macro%'s here!);
     %put bqtvar = &bqtvar;

  /* results should be: bqtvar = macro's here! */


 %let nbqtvar=%nrstr(macro%'s and &procs);
 %put nbqtvar = &nbqtvar;

  /*---------------------------
   results should be:
      nbqtvar = macro's and &procs
   ---------------------------*/


  %put superqed variable = %superq(nbqtvar);

  /* results should be:  superqed variable = macro's and &procs */


  %let qsc=%qscan(&nbqtvar,1);
  %put qsc = &qsc;

  /* results should be: qsc = macro's  */


  %let qsu=%qsubstr(&nbqtvar,1,7);
  %put qsu = &qsu;

  /* results should be: qsu = macro's */


  %let qsp=%qupcase(&nbqtvar);
  %put qsp = &qsp;

  /* results should be:  qsp = MACRO'S AND &PROCS */


  %let mvar=%nrstr(%m);
  %put mvar = %unquote(&mvar);

  /*---------------------------
    results should be:
this is macro m
mvar =
   ---------------------------*/
```
```
1    %studio_hide_wrapper;
77   
78     /*----------------------------------------------*/
79     /*       Macro Quoting                          */
80     /*----------------------------------------------*/
81   
82   
83     %macro m;
84       %put this is macro m;
85     %mend m;
86   
87     %let p=%str(proc print; run;);
88     %put p = &p;
p = proc print; run;
89   
90     /* results should be:  p = proc print; run; */
91   
92   
93     %let m=%nrstr(look at macro %m and var &m);
94     %put m = &m;
m = look at macro %m and var &m
95   
96     /* results should be: m = look at macro %m and var &m */
97   
98   
99    data test;
100      store="Tom's place";
101      call symput('s',store);
102  run;
NOTE: 数据集 WORK.TEST 有 1 个观测和 1 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.00 秒

103  
104  %macro test;
105     %if %bquote(&s) ne %then %put *** valid ***;
106     %else %put *** null value ***;
107  %mend test;
108  %test;
*** valid ***
109  
110   /* results should be:  *** valid *** */
111  
112  
113   %let bqtvar=%str(macro%'s here!);
114       %put bqtvar = &bqtvar;
bqtvar = macro's here!
115  
116    /* results should be: bqtvar = macro's here! */
117  
118  
119   %let nbqtvar=%nrstr(macro%'s and &procs);
120   %put nbqtvar = &nbqtvar;
nbqtvar = macro's and &procs
121  
122    /*---------------------------
123     results should be:
124        nbqtvar = macro's and &procs
125     ---------------------------*/
126  
127  
128    %put superqed variable = %superq(nbqtvar);
superqed variable = macro's and &procs
129  
130    /* results should be:  superqed variable = macro's and &procs */
131  
132  
133    %let qsc=%qscan(&nbqtvar,1);
134    %put qsc = &qsc;
qsc = macro's
135  
136    /* results should be: qsc = macro's  */
137  
138  
139    %let qsu=%qsubstr(&nbqtvar,1,7);
140    %put qsu = &qsu;
qsu = macro's
141  
142    /* results should be: qsu = macro's */
143  
144  
145    %let qsp=%qupcase(&nbqtvar);
146    %put qsp = &qsp;
qsp = MACRO'S AND &PROCS
147  
148    /* results should be:  qsp = MACRO'S AND &PROCS */
149  
150  
151    %let mvar=%nrstr(%m);
152    %put mvar = %unquote(&mvar);
this is macro m
mvar =
153  
154    /*---------------------------
155      results should be:
156  this is macro m
157  mvar =
158     ---------------------------*/
159  
160  %studio_hide_wrapper;
168  
169  
```
