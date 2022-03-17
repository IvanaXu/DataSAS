/*--HighLow Plot--*/

title 'Monthly Stock Price for IBM';
proc sgplot data=sashelp.stocks(where=(stock eq 'IBM' and date > '01Jan2003'd));
  highlow x=date high=high low=low / open=open close=close
      lineattrs=(thickness=2) y2axis;
  xaxis display=(nolabel);
  y2axis display=(nolabel) grid;
  run;
