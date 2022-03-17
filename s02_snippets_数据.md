#### 1、导入CSV文件
```SAS
/* Import a csv file from the location specified on the filename statement */
/* The SAS data set created is named by substituting a name for work.mycsv */

filename csv "<location on file system of the CSV file>";

/* Import the CSV file  */
proc import datafile=csv out=work.mycsv dbms=csv;
   getnames=yes;
   run;

/* Print the first 10 observations **/
proc print data=work.mycsv(obs=10);
   run;

filename csv;
```
```
```

#### 2、导入XLSX文件
```SAS
/* Import a xlsx file from the location specified on the filename statement */
/* The SAS data set created is named by substituting a name for work.myxlsx */

filename xlsx "<location on file system of the XLSX file>" ;

/* Import the XLSX file  */
proc import datafile=xlsx out=work.myxlsx dbms=xlsx;
   getnames=yes;
   run;

/* Print the first 10 observations **/
proc print data=work.myxlsx(obs=10);
   run;

filename xlsx;
```
```
```

#### 3、模拟单因子ANOVA数据
```SAS
/* Simulate one-way ANOVA data */

data onewayanovadata;
   call streaminit(112358);
   drop n;
   do n = 1 to 100;
      treatment = rand( 'TABLE', .2, .4, .4);
      if treatment = 1 then response = rand( 'NORMAL', 10, 0.8 );
      else
      if treatment = 2 then response = rand( 'NORMAL', 11, 0.8 );
      else
      if treatment = 3 then response = rand( 'NORMAL', 15, 0.8 );  
      output;
   end;
run;

proc print;
run;
```
```
观测	treatment	response
1	3	13.9753
2	2	10.6638
3	2	10.8742
4	2	12.3737
5	3	14.5647
```

#### 4、模拟线性回归数据
```SAS
/* Simulate linear regression data */
data regdata;
   call streaminit(112358);
   keep x1-x3 y;
   b0 = 4; b1 = 0.8; b2 = 1.2; b3 = 2.4;
   do i=1 to 100;
      x1 = rand( 'NORMAL',5,0.5 );
      x2 = rand( 'NORMAL',8,0.3 );
      x3 = rand( 'NORMAL',6,0.1 );
      epsilon = rand( 'NORMAL',0,0.8 );
      y = b0 + b1*x1 + b2*x2 + b3*x3 + epsilon;
      output;
   end;
run;
proc print;
run;
```
```
观测	x1	x2	x3	y
1	5.05760	8.11757	5.94148	31.5596
2	4.12473	7.54537	5.75828	29.7828
3	5.85728	7.94817	5.96265	32.0026
4	5.27572	8.50847	5.79159	30.3810
5	4.91180	8.10329	5.85520	30.9365
```

#### 5、生成CSV文件
```SAS
/* Create a CSV representation of SASHELP.CARS in the file specified on  */
/* the filename statement.  The file name should be fully qualified and  */
/* end with .csv                                                         */

filename outcsv "<location on file system to put the CSV file>";

proc export data=sashelp.cars
            outfile=outcsv
            dbms=csv replace;
run;

filename outcsv;
```
```
```

#### 6、生成PPT文件
```SAS
/* Create powerpoint output from proc sgplot and put the results in */
/* file specified on the filename statement.  The file name should  */
/* be fully qualified and end with .ppt                             */

ods graphics on / border=off;
filename _dataout "<location on file system to put the PPT file>";

ods powerpoint file=_dataout;
title 'PROC SGRENDER';
footnote 'ODS Destination for PowerPoint';

title 'Horsepower by Type and Origin';
proc sgplot data=sashelp.cars;
  dot type / response=horsepower limits=both stat=mean
      markerattrs=(symbol=circlefilled size=9);
  xaxis grid;
  yaxis display=(nolabel) offsetmin=0.1;
  keylegend / location=inside position=topright across=1;
  run;

ods powerpoint close;
```
```
```

#### 7、生成XML文件
```SAS
/* Create an XML representation of SASHELP.CARS in the directory specified       */
/* on the the filename statement.  The directory name should be fully qualified  */

filename xmlout "<location on file system to put the XML file>" encoding="utf-8";
libname xmlout xmlv2;

data xmlout.cars;
set sashelp.cars;
run;

libname xmlout;
```
```
```

#### 8、DS2包
```SAS
/* DS2 Package */

proc ds2;
package my_package / overwrite=yes;
  dcl double k;
  method my_package();
    put 'Constructor';
  end;

  method delete();
    put 'Destructor';
  end;

  method my_meth(double x) returns double;
    return(x * 2);
  end;
endpackage;
run;

data out(overwrite=yes);
  dcl package my_package p();
  dcl double x;

  method init();
    x = p.my_meth(5);
    put x=;

    p.k = 2112;
    x = p.k;
    put x=;
  end;
enddata;
run; quit;
```
```
1    %studio_hide_wrapper;
77   
78   /* DS2 Package */
79   
80   proc ds2;
81   package my_package / overwrite=yes;
82     dcl double k;
83     method my_package();
84       put 'Constructor';
85     end;
86   
87     method delete();
88       put 'Destructor';
89     end;
90   
91     method my_meth(double x) returns double;
92       return(x * 2);
93     end;
94   endpackage;
95   run;
NOTE: 已在数据集 work.my_package 中创建 package my_package。
NOTE: Execution succeeded. No rows affected.
96   
97   data out(overwrite=yes);
98     dcl package my_package p();
99     dcl double x;
100  
101    method init();
102      x = p.my_meth(5);
103      put x=;
104  
105      p.k = 2112;
106      x = p.k;
107      put x=;
108    end;
109  enddata;
110  run;
110!      quit;
Constructor
x=10
x=2112
Destructor
NOTE: Execution succeeded. One row affected.
NOTE: “PROCEDURE DS2”所用时间（总处理时间）:
      实际时间          0.06 秒
      CPU 时间          0.06 秒

111  
112  
113  %studio_hide_wrapper;
121  
122  
```

#### 9、DS2代码
```SAS
/* DS2 Program */

proc ds2;
data out(overwrite=yes);
  dcl double x;
  dcl char(32) c;

  method init();
  end;

  method run();
    put 'Hello World!';
  end;

  method term();
  end;
enddata;
run; quit;
```
```
1    %studio_hide_wrapper;
77   
78   /* DS2 Program */
79   
80   proc ds2;
81   data out(overwrite=yes);
82     dcl double x;
83     dcl char(32) c;
84   
85     method init();
86     end;
87   
88     method run();
89       put 'Hello World!';
90     end;
91   
92     method term();
93     end;
94   enddata;
95   run;
95 !      quit;
Hello World!
NOTE: Execution succeeded. One row affected.
NOTE: “PROCEDURE DS2”所用时间（总处理时间）:
      实际时间          0.03 秒
      CPU 时间          0.04 秒

96   
97   
98   %studio_hide_wrapper;
106  
107  
```

#### A、DS2线程
```SAS
/* DS2 Thread Program Template */

proc ds2;
thread thread_pgm / overwrite=yes;
  dcl double x;
  dcl char(32) c;

  method init();
  end;

  method run();
    x = _threadid_;
    c = put(_threadid_, ROMAN.);
    put 'Thread id as a number and Roman character: ' x c;
  end;

  method term();
  end;
endthread;
run;

data out(overwrite=yes);
  dcl thread thread_pgm t;
  method run();
    set from t threads=4;
  end;
enddata;
run; quit;
```
```
1    %studio_hide_wrapper;
77   
78   
79   /* DS2 Thread Program Template */
80   
81   proc ds2;
82   thread thread_pgm / overwrite=yes;
83     dcl double x;
84     dcl char(32) c;
85   
86     method init();
87     end;
88   
89     method run();
90       x = _threadid_;
91       c = put(_threadid_, ROMAN.);
92       put 'Thread id as a number and Roman character: ' x c;
93     end;
94   
95     method term();
96     end;
97   endthread;
98   run;
NOTE: 已在数据集 work.thread_pgm 中创建 thread thread_pgm。
NOTE: Execution succeeded. No rows affected.
99   
100  data out(overwrite=yes);
101    dcl thread thread_pgm t;
102    method run();
103      set from t threads=4;
104    end;
105  enddata;
106  run;
106!      quit;
Thread id as a number and Roman character:  1 I                               
Thread id as a number and Roman character:  2 II                              
Thread id as a number and Roman character:  4 IV                              
Thread id as a number and Roman character:  3 III                             
NOTE: Execution succeeded. 4 rows affected.
NOTE: “PROCEDURE DS2”所用时间（总处理时间）:
      实际时间          0.05 秒
      CPU 时间          0.06 秒

107  
108  
109  %studio_hide_wrapper;
117  
118  
```
