

/* */
/*
ODBC LIBNAME Statement Examples
In this example, USER=, PASSWORD=, and DATASRC= are connection options.
*/
libname mydblib odbc user=myusr1 password=mypwd1 datasrc=mydatasource;

/*
In this next example, the libref MYLIB uses the ODBC engine to connect to an Oracle database. The connection options are USER=, PASSWORD=, and DATASRC=.
*/
libname mydblib odbc datasrc=mydatasourcemydatasource user=myusr1 password=mypwd1;

proc print data=mydblib.customers;
   where state='CA';
run;

/*
In the next example, the libref MYDBLIB uses the ODBC engine to connect to a Microsoft SQL Server database. The connection option is NOPROMPT=.
*/
libname mydblib odbc noprompt="uid=myusr1;pwd=mypwd1;dsn=sqlservr;" stringdates=yes;

proc print data=mydblib.customers;
   where state='CA';
run;


/* */
/* SAS */
LIBNAME TA ODBC USER=system PASSWORD=oracle DSN=odata;

/* Log
1    LIBNAME TA ODBC USER=system PASSWORD=XXXXXX DSN=odata;
NOTE: 已成功分配逻辑库引用名“TA”，如下所示:
       引擎:        ODBC
       物理名: odata
*/


/* */
/* SAS */
LIBNAME TA ODBC USER=root PASSWORD=123456 DATASRC=mdata;

/* Log
1    LIBNAME TA ODBC USER=root PASSWORD=XXXXXX DATASRC=mdata;
NOTE: 已成功分配逻辑库引用名“TA”，如下所示:
       引擎:        ODBC
       物理名: mdata
*/


/* */
/* SAS */
LIBNAME TA ODBC USER=db2inst1 PASSWORD="db2inst1-pwd" DATASRC=sample;

/* Log
1    LIBNAME TA ODBC USER=db2inst1 PASSWORD=XXXXXXXXXXXXXX DATASRC=sample;
NOTE: 已成功分配逻辑库引用名“TA”，如下所示:
       引擎:        ODBC
       物理名: sample
*/
