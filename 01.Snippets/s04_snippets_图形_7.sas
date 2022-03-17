/*--Scatter Plot Matrix--*/

title 'Vehicle Profile';
proc sgscatter data=sashelp.cars(where=(type in ('Sedan' 'Sports')));
  label mpg_city='City';
  label mpg_highway='Highway';
  matrix mpg_city mpg_highway horsepower weight /
     transparency=0.8 markerattrs=graphdata3(symbol=circlefilled);
  run;
