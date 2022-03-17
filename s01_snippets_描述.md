#### 1、SAS宏
```SAS
ODS HTML5(ID=WEB);
ODS PDF(ID=WEB);
ODS RTF(ID=WEB);

PROC PRINT DATA=SASHELP.CARS; RUN;
ODS _ALL_ CLOSE;
```
```
1    %studio_hide_wrapper;
77   
78   ODS HTML5(ID=WEB);
79   ODS PDF(ID=WEB);
NOTE: 正在将 ODS PDF(WEB) 输出写入 DISK 目标
      “/viya/tmp/b12d2128-6178-4cd5-9322-98741b72191e/SAS_work5A6B000000B3_sas-launcher-f93b9477-75ad-4ca4-9282-37911634d818-rpsmx
      /sasprt.pdf”，打印机为“PDF”。
80   ODS RTF(ID=WEB);
NOTE: 正在写入 RTF Body（主体）文件: sasrtf.rtf
81   
82   PROC PRINT DATA=SASHELP.CARS; RUN;
NOTE: 从以下数据集读取了 428 个观测: SASHELP.CARS.
NOTE: PROCEDURE PRINT 已打印第 21-30 页。
NOTE: “PROCEDURE PRINT”所用时间（总处理时间）:
      实际时间          1.99 秒
      CPU 时间          2.00 秒

83   ODS _ALL_ CLOSE;
NOTE: ODS PDF(WEB) 打印了 22 页，
      位置:
      /viya/tmp/b12d2128-6178-4cd5-9322-98741b72191e/SAS_work5A6B000000B3_sas-launcher-f93b9477-75ad-4ca4-9282-37911634d818-rpsmx/sa
      sprt.pdf。
84   
85   
86   
87   %studio_hide_wrapper;
95   
96   
...
```

#### 2、SAS宏Char函数
```SAS
PROC SQL;

	CREATE TABLE WORK.QUERY

	AS

	SELECT * FROM SASHELP.CARS;

RUN;
QUIT;

PROC PRINT DATA=WORK.QUERY; RUN;
```
```
1    %studio_hide_wrapper;
77   
78   
79   
80   PROC SQL;
81   
82   CREATE TABLE WORK.QUERY
83   
84   AS
85   
86   SELECT * FROM SASHELP.CARS;
NOTE: 表 WORK.QUERY 创建完成，有 428 行，15 列。
87   
88   RUN;
NOTE: PROC SQL 语句被立即执行；RUN 语句无效。
89   QUIT;
NOTE: “PROCEDURE SQL”所用时间（总处理时间）:
      实际时间          0.00 秒
      CPU 时间          0.00 秒

90   
91   PROC PRINT DATA=WORK.QUERY; RUN;
NOTE: 从以下数据集读取了 428 个观测: WORK.QUERY.
NOTE: PROCEDURE PRINT 已打印第 31-40 页。
NOTE: “PROCEDURE PRINT”所用时间（总处理时间）:
      实际时间          1.04 秒
      CPU 时间          1.06 秒

92   
93   
94   
95   
96   %studio_hide_wrapper;
104  
105   
```
