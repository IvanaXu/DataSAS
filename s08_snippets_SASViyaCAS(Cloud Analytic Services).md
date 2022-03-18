#### 1、创建CAS连接
```SAS
/*****************************************************************************/
/*  Set the options necessary for creating a connection to a CAS server.     */
/*  Once the options are set, the cas command connects the default session   */
/*  to the specified CAS server and CAS port, for example the default value  */
/*  is 5570.                                                                 */
/*****************************************************************************/

options cashost="<cas server name>" casport=<port number>;
cas;
```

#### 2、从CAS逻辑库中删除表或文件
```SAS
/*****************************************************************************/
/*  Delete a table or file from a caslib data source ("sourceCaslib").  The  */
/*  quiet option suppresses error messages.  Specify casdata="fileName" to   */
/*  remove SASHDAT files from HDFS data source for HDFS-type caslibs.        */
/*****************************************************************************/

proc casutil;
   deletesource casdata="tableName" incaslib="sourceCaslib" quiet;
run;

/*****************************************************************************/
/*  Remove an in-memory table ("tableName") from "sourceCaslib". The quiet   */
/*  option suppresses error messages and avoids setting SYSERR when the      */
/*  specified table is not found.                                            */
/*****************************************************************************/

proc casutil;
   droptable casdata="tableName" incaslib="sourceCaslib" quiet;
run;
```

#### 3、断开CAS会话
```SAS
/*****************************************************************************/
/*  Disconnect from a session named mySession.  Before disconnecting, set an */
/*  appropriate value for the timeout parameter.  You can reconnect to the   */
/*  session before the timeout expires.  Otherwise the session is terminated */
/*****************************************************************************/

cas mySession sessopts=(timeout=1800);    /* 30 minute timeout */
cas mySession disconnect;
```

#### 4、将表保存至CAS逻辑库
```SAS
/* Creates a permanent copy of an in-memory table ("table-name") from "sourceCaslib".      */
/* The in-memory table is saved to the data source that is associated with the target      */
/* caslib ("targetCaslib") using the specified name ("file-name").                         */
/*                                                                                         */
/* To find out the caslib associated with an CAS engine libref, right click on the libref  */
/* from "Libraries" and select "Properties". Then look for the entry named "Server Session */
/* CASLIB".                                                                                */
proc casutil;
    save casdata="table-name" incaslib="sourceCaslib" outcaslib="targetCaslib"
	     casout="file-name";
quit;
```

#### 5、将数据加载至CAS逻辑库
```SAS
/*****************************************************************************/
/*  Load file from a client location ("pathToClientFile") into the specified */
/*  caslib ("myCaslib") and save it as "tableNameForLoadedFile".             */
/*****************************************************************************/

proc casutil;
	load file="pathToClientFile"
	outcaslib="myCaslib" casout="tableNameForLoadedFile";
run;

/*****************************************************************************/
/*  Load SAS data set from a Base engine library (library.tableName) into    */
/*  the specified caslib ("myCaslib") and save as "targetTableName".         */
/*****************************************************************************/

proc casutil;
	load data=library.tablename outcaslib="myCaslib"
	casout="targetTableName";
run;

/*****************************************************************************/
/*  Load a table ("sourceTableName") from the specified caslib               */
/*  ("sourceCaslib") to the target Caslib ("targetCaslib") and save it as    */
/*  "targetTableName".                                                       */
/*****************************************************************************/

proc casutil;
	load casdata="sourceTableName" incaslib="sourceCaslib"
	outcaslib="targetCaslib" casout="targetTableName";
run;
```

#### 6、列出CAS会话选项
```SAS
/*****************************************************************************/
/*  List session options for the specified CAS session (mySession).          */
/*****************************************************************************/

cas mySession listsessopts;
```

#### 7、删除CAS逻辑库
```SAS
/*****************************************************************************/
/*  Delete the specified caslib (caslibName).  The SESSREF parameter is      */
/*  optional.  If SESSREF is not specified, the current session is used.     */
/*****************************************************************************/

caslib caslibName drop sessref=mySession;
```

#### 8、为CAS逻辑库生成SAS逻辑库引用名
```SAS
/*****************************************************************************/
/*  Create a default CAS session and create SAS librefs for existing caslibs */
/*  so that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/

cas;
caslib _all_ assign;
```

#### 9、为SAS客户端列出CAS会话
```SAS
/*****************************************************************************/
/*  List all the CAS sessions (and their session properties) created or      */
/*  reconnected to by the SAS Client.                                        */
/*****************************************************************************/

cas _all_ list;
```

#### A、为路径新建CAS逻辑库
```SAS
/*****************************************************************************/
/*  Create a CAS library (myCaslib) for the specified path ("/filePath/")    */
/*  and session (mySession).  If "sessref=" is omitted, the caslib is        */
/*  created and activated for the current session.  Setting subdirs extends  */
/*  the scope of myCaslib to subdirectories of "/filePath".                  */
/*****************************************************************************/

caslib myCaslib datasource=(srctype="path") path="/filePath/" sessref=mySession subdirs;
libname myCaslib cas;
```

#### B、为用户ID列出CAS会话
```SAS
/*****************************************************************************/
/*  List all of the CAS sessions known to the CAS server for the userID      */
/*  associated with "mySession".                                             */
/*****************************************************************************/

cas mySession listsessions;
```

#### C、新建CAS会话
```SAS
/*****************************************************************************/
/*  Start a session named mySession using the existing CAS server connection */
/*  while allowing override of caslib, timeout (in seconds), and locale     */
/*  defaults.                                                                */
/*****************************************************************************/

cas mySession sessopts=(caslib=casuser timeout=1800 locale="en_US");
```

#### D、终止CAS会话
```SAS
/*****************************************************************************/
/*  Terminate the specified CAS session (mySession). No reconnect is possible*/
/*****************************************************************************/

cas mySession terminate;
```

#### E、重新连接CAS会话
```SAS
/*****************************************************************************/
/*  Reconnect to a session named "mySession".                                */
/*****************************************************************************/

cas mySession reconnect;
```
