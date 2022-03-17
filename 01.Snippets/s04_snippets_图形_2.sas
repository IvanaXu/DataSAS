/*--VBox Plot--*/

title 'Mileage by Type and Origin';
proc sgplot data=sashelp.cars(where=(type in ('Sedan' 'Sports'))) ;
  vbox mpg_city / category=origin group=type groupdisplay=cluster
    lineattrs=(pattern=solid) whiskerattrs=(pattern=solid);
  xaxis display=(nolabel);
  yaxis grid;
  keylegend / location=inside position=topright across=1;
  run;
