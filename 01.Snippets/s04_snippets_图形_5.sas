/*--Box Panel--*/

title 'Cholesterol by Weight and Sex';
proc sgpanel data=sashelp.heart(where=(weight_status ne 'Underweight'));
  panelby weight_status / novarname;
  vbox cholesterol / category=sex;
  rowaxis grid;
  run;
