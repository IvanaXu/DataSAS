/*--Fit Plot--*/

title 'Mileage by Horsepower for USA';
proc sgplot data=sashelp.cars(where=(origin='USA'));
  reg x=horsepower y=mpg_city / degree=2 clm='CL Mean';
  keylegend / location=inside position=topright across=1;
  xaxis grid;
  yaxis grid;
  run;
