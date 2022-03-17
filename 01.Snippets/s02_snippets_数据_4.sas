/* Simulate linear regression data */
data regdata;
   call streaminit(112358);
   keep x1-x3 y;
   b0 = 4; b1 = 0.8; b2 = 1.2; b3 = 2.4;
   do i=1 to 100;
      x1 = rand( 'NORMAL',5,0.5 );
      x2 = rand( 'NORMAL',8,0.3 );
      x3 = rand( 'NORMAL',6,0.1 );
      epsilon = rand( 'NORMAL',0,0.8 );
      y = b0 + b1*x1 + b2*x2 + b3*x3 + epsilon;
      output;
   end;
run;
proc print;
run;
