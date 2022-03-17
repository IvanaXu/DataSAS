/* Simulate one-way ANOVA data */

data onewayanovadata;
   call streaminit(112358);
   drop n;
   do n = 1 to 100;
      treatment = rand( 'TABLE', .2, .4, .4);
      if treatment = 1 then response = rand( 'NORMAL', 10, 0.8 );
      else
      if treatment = 2 then response = rand( 'NORMAL', 11, 0.8 );
      else
      if treatment = 3 then response = rand( 'NORMAL', 15, 0.8 );
      output;
   end;
run;

proc print;
run;
