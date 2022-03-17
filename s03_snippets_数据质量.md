#### 1、标准化数据
```SAS
/******************************************************************************/
/* The snippet illustrates the use of DQSTANDARDIZE function to standardize   */
/* the casing, spacing, and format of an input character value and return an  */
/* updated character value.                                                   */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create input data set */
data addresses;
input id $3. address $31.;
cards;
1   4D 664TH ST
2   820 MAIN
3   307 SOUTH BRKS
4   511 SOUTHWEST HWY W
5   1631 WESTSPRING ST
6   274 NORTH 500 EAST APARTMENT 1
7   3138 CLINTUN AVE
8   13434 2ND NE
9   9598 HIGHWAY 2 BOX 2037
10  BOX 2914 UNIT 7900
;
run;

/* Run the dqStandardize function to create output data set.          */
/* The required arguments specified are character-value (address)     */
/* and standardization-definition ('Address'). The optional argument  */
/* locale is not specified. The default locale is used.               */
data addresses_out  (drop=id);
   set addresses;
   length stdAddress $ 31.;

   stdAddress=dqStandardize(address,'Address');
run;

title 'Standardized Version of the Addresses';
proc print data=addresses_out;
run;
```
```
Standardized Version of the Addresses
观测	address	stdAddress
1	4D 664TH ST	4D 664th St
2	820 MAIN	820 Main
3	307 SOUTH BRKS	307 South Brks
4	511 SOUTHWEST HWY W	511 Southwest Hwy W
5	1631 WESTSPRING ST	1631 Westspring St
6	274 NORTH 500 EAST APARTMENT 1	274 N 500 E, Apt 1
7	3138 CLINTUN AVE	3138 Clintun Ave
8	13434 2ND NE	13434 2nd NE
9	9598 HIGHWAY 2 BOX 2037	9598 Hwy 2, PO Box 2037
10	BOX 2914 UNIT 7900	PO Box 2914 Unit 7900
```

#### 2、猜测语言/地区
```SAS
/*****************************************************************************/
/* The snippet illustrates the use of the DQLOCALEQUESS function to apply    */
/* the input character value to the locale-guess definition that are listed  */
/* in the DQLOCALE= system option or session option. The function returns    */
/* the name of a locale.                                                     */
/*****************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();/*****************************************************************************/
/* The snippet illustrates the use of the DQLOCALEQUESS function to apply    */
/* the input character value to the locale-guess definition that are listed  */
/* in the DQLOCALE= system option or session option. The function returns    */
/* the name of a locale.                                                     */
/*****************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create input data set */
data phone_guess;
   length phone $ 30 actual $ 5;
   input phone $char30.;
cards;
(212) 987-7654
713-940-6100
+1 414 242 8202
1(303)5466306
(001) 719-260-5533
612.736.4436
+1 800 328 2407
;
run;

/* Run the dqLocaleGuess function to Return the name of a locale as the value */
/* of guess variable. The required arguments are character-value (phone) and  */
/* locale-guess-definition ('Phone').                                         */
data guessLocale;
   set work.phone_guess;
   length guess $ 10;

   locale=dqLocaleGuess(phone, 'Phone');

   put phone=   locale=;
run;

/* Create input data set */
data phone_guess;
   length phone $ 30 actual $ 5;
   input phone $char30.;
cards;
(212) 987-7654
713-940-6100
+1 414 242 8202
1(303)5466306
(001) 719-260-5533
612.736.4436
+1 800 328 2407
;
run;

/* Run the dqLocaleGuess function to Return the name of a locale as the value */
/* of guess variable. The required arguments are character-value (phone) and  */
/* locale-guess-definition ('Phone').                                         */
data guessLocale;
   set work.phone_guess;
   length guess $ 10;

   locale=dqLocaleGuess(phone, 'Phone');

   put phone=   locale=;
run;
```
```
1    %studio_hide_wrapper;
77   
78   /*****************************************************************************/
79   /* The snippet illustrates the use of the DQLOCALEQUESS function to apply    */
80   /* the input character value to the locale-guess definition that are listed  */
81   /* in the DQLOCALE= system option or session option. The function returns    */
82   /* the name of a locale.                                                     */
83   /*****************************************************************************/
84   
85   /**************************************************************************/
86   /* Set system options values and load locale(s) into memory               */
87   /**************************************************************************/
88   %dqload();/*****************************************************************************/
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
89   /* The snippet illustrates the use of the DQLOCALEQUESS function to apply    */
90   /* the input character value to the locale-guess definition that are listed  */
91   /* in the DQLOCALE= system option or session option. The function returns    */
92   /* the name of a locale.                                                     */
93   /*****************************************************************************/
94   
95   /**************************************************************************/
96   /* Set system options values and load locale(s) into memory               */
97   /**************************************************************************/
98   %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
99   
100  /* Create input data set */
101  data phone_guess;
102     length phone $ 30 actual $ 5;
103     input phone $char30.;
104  cards;
NOTE: 变量 actual 未初始化。
NOTE: 数据集 WORK.PHONE_GUESS 有 7 个观测和 2 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.00 秒

112  ;
113  run;
114  
115  /* Run the dqLocaleGuess function to Return the name of a locale as the value */
116  /* of guess variable. The required arguments are character-value (phone) and  */
117  /* locale-guess-definition ('Phone').                                         */
118  data guessLocale;
119     set work.phone_guess;
120     length guess $ 10;
121  
122     locale=dqLocaleGuess(phone, 'Phone');
123  
124     put phone=   locale=;
125  run;
NOTE: 变量 guess 未初始化。
phone=(212) 987-7654 locale=ENUSA
phone=713-940-6100 locale=ENUSA
phone=+1 414 242 8202 locale=ENUSA
phone=1(303)5466306 locale=ENUSA
phone=(001) 719-260-5533 locale=ENUSA
phone=612.736.4436 locale=ENUSA
phone=+1 800 328 2407 locale=ENUSA
NOTE: 从以下数据集读取了 7 个观测: WORK.PHONE_GUESS.
NOTE: 数据集 WORK.GUESSLOCALE 有 7 个观测和 4 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.77 秒
      CPU 时间          0.77 秒

126  
127  /* Create input data set */
128  data phone_guess;
129     length phone $ 30 actual $ 5;
130     input phone $char30.;
131  cards;
NOTE: 变量 actual 未初始化。
NOTE: 数据集 WORK.PHONE_GUESS 有 7 个观测和 2 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.00 秒

139  ;
140  run;
141  
142  /* Run the dqLocaleGuess function to Return the name of a locale as the value */
143  /* of guess variable. The required arguments are character-value (phone) and  */
144  /* locale-guess-definition ('Phone').                                         */
145  data guessLocale;
146     set work.phone_guess;
147     length guess $ 10;
148  
149     locale=dqLocaleGuess(phone, 'Phone');
150  
151     put phone=   locale=;
152  run;
NOTE: 变量 guess 未初始化。
phone=(212) 987-7654 locale=ENUSA
phone=713-940-6100 locale=ENUSA
phone=+1 414 242 8202 locale=ENUSA
phone=1(303)5466306 locale=ENUSA
phone=(001) 719-260-5533 locale=ENUSA
phone=612.736.4436 locale=ENUSA
phone=+1 800 328 2407 locale=ENUSA
NOTE: 从以下数据集读取了 7 个观测: WORK.PHONE_GUESS.
NOTE: 数据集 WORK.GUESSLOCALE 有 7 个观测和 4 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.02 秒

153  
154  %studio_hide_wrapper;
162  
163  
```

#### 3、观测数据
```SAS
/**************************************************************************/
/* The snippet illustrates the use of the DQCASE function to transform a  */
/* character constant, according to the specified case definition, and    */
/* return a character value with standardized capitalization.             */
/**************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/***************************************************************************/
/* Run the DQCASE function to apply the 'proper (organization)' definition */
/* to transform organization names to Proper case                          */
/***************************************************************************/
data _null_;
length org_name result $ 25;

org_name='aaa motor service';
result = dqCase(org_name, 'proper (organization)');

/* send results to log */
put 'Data has been transformed from ' org_name 'to ' result /;
run;
```
```
1    %studio_hide_wrapper;
77   
78   /**************************************************************************/
79   /* The snippet illustrates the use of the DQCASE function to transform a  */
80   /* character constant, according to the specified case definition, and    */
81   /* return a character value with standardized capitalization.             */
82   /**************************************************************************/
83   
84   /**************************************************************************/
85   /* Set system options values and load locale(s) into memory               */
86   /**************************************************************************/
87   %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
88   
89   /***************************************************************************/
90   /* Run the DQCASE function to apply the 'proper (organization)' definition */
91   /* to transform organization names to Proper case                          */
92   /***************************************************************************/
93   data _null_;
94   length org_name result $ 25;
95   
96   org_name='aaa motor service';
97   result = dqCase(org_name, 'proper (organization)');
98   
99   /* send results to log */
100  put 'Data has been transformed from ' org_name 'to ' result /;
101  run;
Data has been transformed from aaa motor service to AAA Motor Service
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.22 秒
      CPU 时间          0.23 秒

102  
103  %studio_hide_wrapper;
111  
112  
```

#### 4、计算匹配代码
```SAS
/**************************************************************************/
/* The snippet illustrates the use of the DQMATCH function to generate a  */
/* match code from a character value. The matchcodes reflect the relative */
/* similarity of data values. Matchcodes are created based on a specified */
/* match definition in a specified locale. The matchcodes are written to  */
/* an output SAS data set. Values that generate the same matchcodes are   */
/* candidates for transformation or standardization.                      */
/**************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();


/* Create input data set */
data cust_db;
   length customer $ 22;
   length address $ 31;
   input customer $22. address $31.;
cards;
Bob Beckett           392 S. Main St. PO Box 2270
Robert E. Beckett     392 S. Main St. PO Box 2270
Rob Beckett           392 S. Main St. PO Box 2270
Paul Becker           392 N. Main St. PO Box 7720
Bobby Becket          392 S. Main St. PO Box 2270
Mr. Robert J. Beckeit P. O. Box 2270 392 S. Main St.
Mr. Robert E Beckett  392 South Main Street #2270
Mr. Raul Becker       392 North Main St.
;
run;

/* Run the dqMatch function to return match codes. The required arguments    */
/* are character-value (address)and match-definition ('Address').            */
/* The optional arguments specified are sensitivity (50 or 85) and locale    */
/* ('ENUSA'). If the sensitivity value is not specified, the default value   */
/* is 85. Valid values range from 50 to 95. If the locale value is not       */
/* specified, the default locale value is used.                              */
data matchcode_out;
  set cust_db;
  mc_50=dqMatch(address,'Address', 50,'ENUSA');
  mc_85=dqMatch(address,'Address', 85,'ENUSA');
run;

title 'Output Data from Matching with Sensitivity of 50 and 85';
proc print data=matchcode_out;
run;
```
```
1    %studio_hide_wrapper;
77   
78   /**************************************************************************/
79   /* The snippet illustrates the use of the DQMATCH function to generate a  */
80   /* match code from a character value. The matchcodes reflect the relative */
81   /* similarity of data values. Matchcodes are created based on a specified */
82   /* match definition in a specified locale. The matchcodes are written to  */
83   /* an output SAS data set. Values that generate the same matchcodes are   */
84   /* candidates for transformation or standardization.                      */
85   /**************************************************************************/
86   
87   /**************************************************************************/
88   /* Set system options values and load locale(s) into memory               */
89   /**************************************************************************/
90   %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
91   
92   
93   /* Create input data set */
94   data cust_db;
95      length customer $ 22;
96      length address $ 31;
97      input customer $22. address $31.;
98   cards;
NOTE: 数据集 WORK.CUST_DB 有 8 个观测和 2 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.01 秒

107  ;
108  run;
109  
110  /* Run the dqMatch function to return match codes. The required arguments    */
111  /* are character-value (address)and match-definition ('Address').            */
112  /* The optional arguments specified are sensitivity (50 or 85) and locale    */
113  /* ('ENUSA'). If the sensitivity value is not specified, the default value   */
114  /* is 85. Valid values range from 50 to 95. If the locale value is not       */
115  /* specified, the default locale value is used.                              */
116  data matchcode_out;
117    set cust_db;
118    mc_50=dqMatch(address,'Address', 50,'ENUSA');
119    mc_85=dqMatch(address,'Address', 85,'ENUSA');
120  run;
NOTE: 从以下数据集读取了 8 个观测: WORK.CUST_DB.
NOTE: 数据集 WORK.MATCHCODE_OUT 有 8 个观测和 4 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.86 秒
      CPU 时间          0.86 秒

121  
122  title 'Output Data from Matching with Sensitivity of 50 and 85';
123  proc print data=matchcode_out;
124  run;
NOTE: 从以下数据集读取了 8 个观测: WORK.MATCHCODE_OUT.
NOTE: PROCEDURE PRINT 已打印第 2 页。
NOTE: “PROCEDURE PRINT”所用时间（总处理时间）:
      实际时间          0.02 秒
      CPU 时间          0.01 秒

125  
126  %studio_hide_wrapper;
134  
135  
```

#### 5、解析数据
```SAS
/*****************************************************************************/
/* The snippet shows how to use the DQPARSE function to return  a delimited  */
/* string of parse token values and the QPARSETOKENGET function to return a  */
/* parse token value from a delimited string of parse token values.          */
/*****************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

data parseName;
   length familyName $ 50;
   length name $ 100;
   length parsedValue $100;

   name='Mrs. Sallie Mae Pravlik';

   /* Run the DQPARSE function to parse the name. The required arguments     */
   /* specified are character-value (name) and parse-definition ('Name').    */
   /* The optional argument specifeied is locale ('ENUSA').                  */
   parsedValue=dqParse(name, 'Name', 'ENUSA');
   put parsedvalue=;

   /* Run the DQPARSETOKENGET function to parse a delimited string of parse  */
   /* token value that has been generated by the parse-definition.           */
   /* The required arguments are delimited-string (parsedValue), token       */
   /* ('Family Name') and parse-definition ('Name'). The optional argument   */
   /* specified is locale ('ENUSA').                                         */
   familyName=dqParseTokenGet(parsedvalue, 'Family Name', 'Name', 'ENUSA');
   put familyname=;
run;
```
```
1    %studio_hide_wrapper;
77   
78   /*****************************************************************************/
79   /* The snippet shows how to use the DQPARSE function to return  a delimited  */
80   /* string of parse token values and the QPARSETOKENGET function to return a  */
81   /* parse token value from a delimited string of parse token values.          */
82   /*****************************************************************************/
83   
84   /**************************************************************************/
85   /* Set system options values and load locale(s) into memory               */
86   /**************************************************************************/
87   %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
88   
89   data parseName;
90      length familyName $ 50;
91      length name $ 100;
92      length parsedValue $100;
93   
94      name='Mrs. Sallie Mae Pravlik';
95   
96      /* Run the DQPARSE function to parse the name. The required arguments     */
97      /* specified are character-value (name) and parse-definition ('Name').    */
98      /* The optional argument specifeied is locale ('ENUSA').                  */
99      parsedValue=dqParse(name, 'Name', 'ENUSA');
100     put parsedvalue=;
101  
102     /* Run the DQPARSETOKENGET function to parse a delimited string of parse  */
103     /* token value that has been generated by the parse-definition.           */
104     /* The required arguments are delimited-string (parsedValue), token       */
105     /* ('Family Name') and parse-definition ('Name'). The optional argument   */
106     /* specified is locale ('ENUSA').                                         */
107     familyName=dqParseTokenGet(parsedvalue, 'Family Name', 'Name', 'ENUSA');
108     put familyname=;
109  run;
parsedValue=Mrs./=/Sallie/=/Mae/=/Pravlik/=//=/
familyName=Pravlik
NOTE: 数据集 WORK.PARSENAME 有 1 个观测和 3 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          1.12 秒
      CPU 时间          1.05 秒

110  
111  %studio_hide_wrapper;
119  
120  
```

#### 6、聚类-实体解析PROC DQMATCH
```SAS
/******************************************************************************/
/* The snippet provides examples for running the DQMATCH procedure to         */
/* generate match codes and create cluster numbers with multiple criteria     */
/* statement. PROC DQMATCH creates matchcodes as a basis for standardization  */
/* or transformation. The matchcodes reflect the relative similarity of data  */
/* values. Matchcodes are created based on a specified match definition in a  */
/* specified locale. The matchcodes are written to an output SAS data set.    */
/* Values that generate the same matchcodes are candidates for transformation */
/* or standardization.                                                        */
/*                                                                            */
/* The steps are:                                                             */
/* (1) Set QKB Locale and Prepare Data                                        */
/*     a) Set up QKB locale                                                   */
/*     b) Create an input data set                                            */
/* (2) Run DQMATCH Procedure                                                  */
/*     a) Criteria statements with default sensitivity level of 85            */
/*     b) Criteria statements with sensitivity level of 50                    */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create input data set */
data cust_db;
   length customer $ 22;
   length address $ 31;
   input customer $22. address $31.;
cards;
Bob Beckett           392 S. Main St. PO Box 2270
Robert E. Beckett     392 S. Main St. PO Box 2270
Rob Beckett           392 S. Main St. PO Box 2270
Paul Becker           392 N. Main St. PO Box 7720
Bobby Becket          392 S. Main St. PO Box 2270
Mr. Robert J. Beckeit P. O. Box 2270 392 S. Main St.
Mr. Robert E Beckett  392 South Main Street #2270
Mr. Raul Becker       392 North Main St.
;
run;

/* Run the dqMatch procedure to generate match codes with default sensitivity */
/* level of 85 and create cluster numbers.                                    */
/* The optional arguments specified for the proc dqMatch are data (cust_db),  */
/* out (matchcode_out1), cluster (clusterid). The optional argument specified */
/* for the two criteria statements are matchdef ('Name' and 'Address'), var   */
/* (customer and address) and matchcode (mc_name and mc_address).             */
proc dqMatch data=cust_db out=matchcode_out1 cluster=clusterid;
  criteria matchdef='Name' var=customer matchcode=mc_name;
  criteria matchdef='Address' var=address matchcode=mc_address;
run;

title 'Output Data from Matching with Default Sensitivity of 85';
proc print data=matchcode_out1;
run;

/* Run the dqMatch procedure to generate match codes with sensitivity level of */
/* 50 and create cluster numbers.                                              */
/* The optional arguments specified for the proc dqMatch are data (cust_db),   */
/* out (matchcode_out1), cluster (clusterid). The optional argument specified  */
/* for the two criteria statements are matchdef ('Name' and 'Address'), var    */
/* (customer and address) and matchcode (mc_name and mc_address).              */
proc dqMatch data=cust_db out=matchcode_out2 cluster=clusterid;
  criteria type='Name' var=customer matchcode=mc_name;
  criteria type='Address' var=address sensitivity=50 matchcode=mc_address;
run;

title 'Output Data from Matching with Sensitivities of 50';
proc print data=matchcode_out2;
run;
```
```
1    %studio_hide_wrapper;
77   
78   /******************************************************************************/
79   /* The snippet provides examples for running the DQMATCH procedure to         */
80   /* generate match codes and create cluster numbers with multiple criteria     */
81   /* statement. PROC DQMATCH creates matchcodes as a basis for standardization  */
82   /* or transformation. The matchcodes reflect the relative similarity of data  */
83   /* values. Matchcodes are created based on a specified match definition in a  */
84   /* specified locale. The matchcodes are written to an output SAS data set.    */
85   /* Values that generate the same matchcodes are candidates for transformation */
86   /* or standardization.                                                        */
87   /*                                                                            */
88   /* The steps are:                                                             */
89   /* (1) Set QKB Locale and Prepare Data                                        */
90   /*     a) Set up QKB locale                                                   */
91   /*     b) Create an input data set                                            */
92   /* (2) Run DQMATCH Procedure                                                  */
93   /*     a) Criteria statements with default sensitivity level of 85            */
94   /*     b) Criteria statements with sensitivity level of 50                    */
95   /******************************************************************************/
96   
97   /**************************************************************************/
98   /* Set system options values and load locale(s) into memory               */
99   /**************************************************************************/
100  %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
101  
102  /* Create input data set */
103  data cust_db;
104     length customer $ 22;
105     length address $ 31;
106     input customer $22. address $31.;
107  cards;
NOTE: 数据集 WORK.CUST_DB 有 8 个观测和 2 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.00 秒

116  ;
117  run;
118  
119  /* Run the dqMatch procedure to generate match codes with default sensitivity */
120  /* level of 85 and create cluster numbers.                                    */
121  /* The optional arguments specified for the proc dqMatch are data (cust_db),  */
122  /* out (matchcode_out1), cluster (clusterid). The optional argument specified */
123  /* for the two criteria statements are matchdef ('Name' and 'Address'), var   */
124  /* (customer and address) and matchcode (mc_name and mc_address).             */
125  proc dqMatch data=cust_db out=matchcode_out1 cluster=clusterid;
126    criteria matchdef='Name' var=customer matchcode=mc_name;
127    criteria matchdef='Address' var=address matchcode=mc_address;
128  run;
NOTE: 数据集 WORK.MATCHCODE_OUT1 有 8 个观测和 5 个变量。
NOTE: “PROCEDURE DQMATCH”所用时间（总处理时间）:
      实际时间          4.25 秒
      CPU 时间          4.20 秒

129  
130  title 'Output Data from Matching with Default Sensitivity of 85';
131  proc print data=matchcode_out1;
132  run;
NOTE: 从以下数据集读取了 8 个观测: WORK.MATCHCODE_OUT1.
NOTE: PROCEDURE PRINT 已打印第 3 页。
NOTE: “PROCEDURE PRINT”所用时间（总处理时间）:
      实际时间          0.03 秒
      CPU 时间          0.03 秒

133  
134  /* Run the dqMatch procedure to generate match codes with sensitivity level of */
135  /* 50 and create cluster numbers.                                              */
136  /* The optional arguments specified for the proc dqMatch are data (cust_db),   */
137  /* out (matchcode_out1), cluster (clusterid). The optional argument specified  */
138  /* for the two criteria statements are matchdef ('Name' and 'Address'), var    */
139  /* (customer and address) and matchcode (mc_name and mc_address).              */
140  proc dqMatch data=cust_db out=matchcode_out2 cluster=clusterid;
141    criteria type='Name' var=customer matchcode=mc_name;
142    criteria type='Address' var=address sensitivity=50 matchcode=mc_address;
143  run;
NOTE: 数据集 WORK.MATCHCODE_OUT2 有 8 个观测和 5 个变量。
NOTE: “PROCEDURE DQMATCH”所用时间（总处理时间）:
      实际时间          0.15 秒
      CPU 时间          0.14 秒

144  
145  title 'Output Data from Matching with Sensitivities of 50';
146  proc print data=matchcode_out2;
147  run;
NOTE: 从以下数据集读取了 8 个观测: WORK.MATCHCODE_OUT2.
NOTE: PROCEDURE PRINT 已打印第 4 页。
NOTE: “PROCEDURE PRINT”所用时间（总处理时间）:
      实际时间          0.02 秒
      CPU 时间          0.02 秒

148  
149  %studio_hide_wrapper;
157  
158  
```

#### 7、识别性别
```SAS
/*******************************************************************/
/* The snippet illustrates the use of the DQGENDER function to     */
/* return a gender from the name of an individual.                 */
/*******************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* The required arguments specified for the DQGENDER function are  */
/* character-value (name) and gender-analysis-definition ('Name'). */
/* The optional argument is locale ('ENUSA').                      */
data _null_;
   length name $100;
   length gender $ 20;

   name='Mrs. Sallie Mae Pravlik';

   gender=dqGender(name, 'Name', 'ENUSA');
   put gender=;
run;
```
```
1    %studio_hide_wrapper;
77   
78   /*******************************************************************/
79   /* The snippet illustrates the use of the DQGENDER function to     */
80   /* return a gender from the name of an individual.                 */
81   /*******************************************************************/
82   
83   /**************************************************************************/
84   /* Set system options values and load locale(s) into memory               */
85   /**************************************************************************/
86   %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
87   
88   /* The required arguments specified for the DQGENDER function are  */
89   /* character-value (name) and gender-analysis-definition ('Name'). */
90   /* The optional argument is locale ('ENUSA').                      */
91   data _null_;
92      length name $100;
93      length gender $ 20;
94   
95      name='Mrs. Sallie Mae Pravlik';
96   
97      gender=dqGender(name, 'Name', 'ENUSA');
98      put gender=;
99   run;
gender=F
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          1.15 秒
      CPU 时间          1.17 秒

100  
101  %studio_hide_wrapper;
109  
110  
```

#### 8、提取数据
```SAS
/******************************************************************************/
/* The snippet illustrates the use of DQEXTRACT and DQEXTTOKENGET functions.  */
/* The DQEXTRACT function returns a delimited string of extraction token      */
/* values from an input character value that are detected by the extraction-  */
/* definition. The DQEXTTOKENGET function returns an extraction token value   */
/* from a delimited string of extraction token values.                        */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

data extractAddress;
   length delimstr address_extract $ 400;

   contactinfo='4000 East Sky Harbor Blvd Chesterfield MO 63005 426-758-4180';

   /* Run the dqExtract function. The required arguments specified are          */
   /* character-value (contactinfo) and extract-definition ('Contact Info').    */
   /* The optional argument locale is not specified. The default locale is used.*/
   delimstr = dqExtract(contactinfo, 'Contact Info');
   put delimstr=;

   /* Run the dqExtTokenGet function. The required arguments specified are      */
   /* delimited-string (delimstr) and token ('Address'). The optional argument  */
   /* locale is not specified. The default locale is used.                      */
   address_extract = dqExtTokenGet(delimstr, 'Address', 'Contact Info');
   put address_extract =;

run;
```
```
1    %studio_hide_wrapper;
77   
78   /******************************************************************************/
79   /* The snippet illustrates the use of DQEXTRACT and DQEXTTOKENGET functions.  */
80   /* The DQEXTRACT function returns a delimited string of extraction token      */
81   /* values from an input character value that are detected by the extraction-  */
82   /* definition. The DQEXTTOKENGET function returns an extraction token value   */
83   /* from a delimited string of extraction token values.                        */
84   /******************************************************************************/
85   
86   /**************************************************************************/
87   /* Set system options values and load locale(s) into memory               */
88   /**************************************************************************/
89   %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
90   
91   data extractAddress;
92      length delimstr address_extract $ 400;
93   
94      contactinfo='4000 East Sky Harbor Blvd Chesterfield MO 63005 426-758-4180';
95   
96      /* Run the dqExtract function. The required arguments specified are          */
97      /* character-value (contactinfo) and extract-definition ('Contact Info').    */
98      /* The optional argument locale is not specified. The default locale is used.*/
99      delimstr = dqExtract(contactinfo, 'Contact Info');
100     put delimstr=;
101  
102     /* Run the dqExtTokenGet function. The required arguments specified are      */
103     /* delimited-string (delimstr) and token ('Address'). The optional argument  */
104     /* locale is not specified. The default locale is used.                      */
105     address_extract = dqExtTokenGet(delimstr, 'Address', 'Contact Info');
106     put address_extract =;
107  
108  run;
delimstr=/=//=/4000 East Sky Harbor Blvd Chesterfield MO 63005/=//=/426-758-4180/=/
address_extract=4000 East Sky Harbor Blvd Chesterfield MO 63005
NOTE: 数据集 WORK.EXTRACTADDRESS 有 1 个观测和 3 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          3.70 秒
      CPU 时间          3.63 秒

109  
110  %studio_hide_wrapper;
118  
119  
```

#### 9、应用方案
```SAS
/*****************************************************************************/
/* The snippet provides examples for applying a scheme stored in SAS format  */
/* using the DQSCHEMEAPPLY function, the DQSCHEMEAPPLY CALL routine or the   */
/* DQSCHEME procedure. Schemes allow you to standardize irregular entries    */
/* into data that can be used for reporting.                                 */
/*                                                                           */
/* The steps are:                                                            */
/* (1) Prepare Data                                                          */
/*     a) Create a scheme stored in SAS format                               */
/*     b) Create an input data set                                           */
/* (2) Apply a scheme to an input data set                                   */
/*     a) DQSCHEMEAPPLY Function or                                          */
/*     b) DQSCHEMEAPPLY CALL Routine                                         */
/*     c) DQSCHEME Procedure                                                 */
/*****************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create a scheme stored in SAS format       */
data myscheme;
   input @1 data $char20. @22 standard $char20.;
cards;
fred                 flintstone
barney               rubble
dino                 dinosaur
fred flintstone      grand poobah
;
run;

/* Create the input data set */
data names;
   input @1 origname $char20.;
   newname=origname;
cards;
fred smith
barney baker
fred flintstone
sandra smith baker
;
run;

/* Apply the scheme myscheme to input data set names and return transformed  */
/* value newname using the DQSCHEMEAPPLY function. The required arguments    */
/* specified are char (origname), scheme ('myscheme') and scheme-format      */
/* ('noqkb'). The optional argument specified is mode ('element').           */
data element_function;
   set names;
   newname=dqSchemeApply(origname, 'myscheme', 'noqkb', 'element');
run;

/* Print the element_function data set */
proc print;
   title 'element mode - dqSchemeApply function';
run;

/* Apply the scheme myscheme to transform input value origname using the     */
/* the Call DQSCHEMEAPPLY routine. The required arguments specified are      */
/* char (origname), scheme ('myscheme') and scheme-format ('noqkb').         */
/* The optional argument specified is mmode ('element').                     */
data element_call;
   set names;
   call dqSchemeApply(origname, newname, 'myscheme', 'noqkb', 'element');
run;

/* Print the element_call data set */
proc print;
   title 'element mode - dqSchemeApply Call routine';
run;

/* Apply the scheme myscheme to input data set names using the dqScheme      */
/* procedure. The optional arguments specified for the proc dqScheme are d   */
/* data (names), out (element_proc) and mode (noqkb). The optional arguments */
/* specified for the apply statement are scheme (myscheme), var (newname)    */
/* and mode (element).                                                       */
proc dqscheme data=names out=element_proc noqkb;
   apply scheme=myscheme var=newname mode=element;
run;

/* Print the element_proc data set */
proc print;
   title 'element mode - Proc dqScheme/Apply';
run;
```
```
element mode - dqSchemeApply function
观测	origname	newname
1	fred smith	flintstone smith
2	barney baker	rubble baker
3	fred flintstone	grand poobah
4	sandra smith baker	sandra smith baker

element mode - dqSchemeApply Call routine
观测	origname	newname
1	fred smith	flintstone smith
2	barney baker	rubble baker
3	fred flintstone	grand poobah
4	sandra smith baker	sandra smith baker

element mode - Proc dqScheme/Apply
观测	origname	newname
1	fred smith	flintstone smith
2	barney baker	rubble baker
3	fred flintstone	grand poobah
4	sandra smith baker	sandra smith baker
```

#### A、运行数据剖析PROC DATAMETRICS
```SAS
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
```
```
1    %studio_hide_wrapper;
77   
78   /********************************************************************************/
79   /* The snippet provides examples for applying data profiling to a data set      */
80   /* using DATAMETRICS procedure with/without multiidentity optional argument     */
81   /* specified on Identities statement.                                           */
82   /*                                                                              */
83   /* The steps are:                                                               */
84   /* (1) Set QKB Locale and Prepare Data                                          */
85   /* (2) Apply data profiling to input data set                                   */
86   /*     a) Calculate one identity for identification analysis                    */
87   /*     b) Calculate more than one identity for identification analysis          */
88   /********************************************************************************/
89   
90   /**************************************************************************/
91   /* Set system options values and load locale(s) into memory               */
92   /**************************************************************************/
93   %dqload();
NOTE: DQLOAD macro beginning.
NOTE: DQLOAD macro ending.
94   
95   /* Create the input data set */
96   data nameSet ;
97     input id 1-2 names $ 5-22;
98   cards;
NOTE: 数据集 WORK.NAMESET 有 15 个观测和 2 个变量。
NOTE: “DATA 语句”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.00 秒

114  ;
115  run;
116  
117  /* Run the dataMetrics procedure to profile a data set without multiidentity    */
118  /* specified. The required arguments specified for proc dataMetrics are data    */
119  /* (nameSet) and out (names_multi_false). The optional arguments specified for  */
120  /* the proc metaMetrics are median and threads (2). The optional specified      */
121  /* argument specified for the identities statement is def ("field_content").    */
122  proc dataMetrics data=nameSet out=names_multi_false median threads=2;
123      identities def="Field Content";
124  run;
NOTE: 数据集 WORK.NAMES_MULTI_FALSE 有 189 个观测和 5 个变量。
NOTE: “PROCEDURE DATAMETRICS”所用时间（总处理时间）:
      实际时间          4.26 秒
      CPU 时间          4.16 秒

125  
126  /* Run the dataMetrics procedure to profile a data set with multiidentity.      */
127  /* The optional arguments specified for proc dataMetrics are data (nameSet)     */
128  /* and out (names_multi_false). The optional arguments specified for proc       */
129  /* dataMetrics are median and  threads (2). The optional arguments specified    */
130  /* for the identities statement are def ("field_content") and multi.            */
131  proc datametrics data=nameSet out=names_multi_true median threads=2;
132      identities def="Field Content" multi;
133  run;
NOTE: 数据集 WORK.NAMES_MULTI_TRUE 有 190 个观测和 5 个变量。
NOTE: “PROCEDURE DATAMETRICS”所用时间（总处理时间）:
      实际时间          4.18 秒
      CPU 时间          4.21 秒

134  
135  %studio_hide_wrapper;
143  
144
```

#### B、执行识别分析
```SAS
/******************************************************************************/
/* The snippet provides examples for performing identification analysis       */
/* using DQIDENTIFYINFOGET, DQIDENTIFYMULTI and DQIDENTIFYIDGET functions.    */
/* The DQIDENTIFYINFOGET function returns a list of names that are supported  */
/* by a given identification analysisi definition. The DQIDENTIFYMULTI        */
/* function returns all of the identification analysis of a character value.  */
/* The DQIDENTIFYIDGET function retuurns a list of identity names.            */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

data analysis;
    length identities result $ 300;
    length email individ ssn 8;

    /* Run the dqIdentifyInfoGet function. The required argument specified is  */
    /* identification-analysis-definition. The optional argument specified is  */
    /* locale ('ENUSA').                                                       */
    identities = dqIdentifyInfoGet('Field Content','ENUSA');
    put 'The identities for Field Content are: ' identities;


    /* Run the dqIdentifyMulti function. The required arguments are character  */
    /* value ('Samual Adams') and identification-analysis-definition           */
    /* Field Content').                                                        */
    result = dqIdentifyMulti('Samual Adams', 'Field Content');
    put 'The result of the dqIdentifyMulti is: ' result;

    /* Run the dqIdentifyIdGet function to return an individual score for an   */
    /* identity from a delimited string of identification analysis score.      */
    /* The required arguments are delimited-string (result), identity-name     */
    /* ('INDIVIDUAL') for example and identification-analysis-definition       */
    /* (Field Content'). The optional argument locale is not specified. The    */
    /* default locale is used.                                                 */
    put 'The Identification Analysis identified the following identities:';

    email = dqIdentifyIdGet(result, 'E-MAIL', 'Field Content');
    put email=;
    individ = dqIdentifyIdGet(result, 'INDIVIDUAL', 'Field Content');
    put individ=;
    ssn = dqIdentifyIdGet(result, 'SOCIAL SECURITY NUMBER', 'Field Content');
    put ssn=;
 run;
```
```
```
