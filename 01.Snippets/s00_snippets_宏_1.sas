%MACRO printTable(table);

PROC PRINT DATA=&TABLE;RUN;

%MEND;

%printTable(SASHELP.CARS);