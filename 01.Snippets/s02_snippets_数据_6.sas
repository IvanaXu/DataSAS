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
