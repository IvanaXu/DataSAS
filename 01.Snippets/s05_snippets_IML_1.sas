/* Numerical integration by using SAS/IML software.
   Example taken from
   R. Wicklin, "How to numerically integrate a function in SAS",
   The DO Loop blog, published May 6, 2011.
   URL: http://blogs.sas.com/content/iml/2011/05/06/how-to-numerically-integrate-a-function-in-sas/

You can use SAS/IML software to numerically integrate a function.
1. Write a SAS/IML module that evaluates the integrand.
2. Call the QUAD subroutine to integrate the function on the interval [a,b].
*/
proc iml;

start SimpleFunc(x);
   return( cos(x) );
finish;

/* integrate function on [0, pi/2] */
pi = constant("PI");
a = 0;
b = pi / 2;
call quad(Integral1, "SimpleFunc", a||b);

/* compare with exact answer */
Answer1 = sin(b) - sin(a);
diff = Answer1 - Integral1;
print Integral1 Answer1 diff;

/*********************/
/* a harder integral */
/*********************/
start TrigFunc(x);
   return( 5 - 2*tan(x)/cos(x) );
finish;

/* integrate function on [pi/6, pi/4] */
a = pi / 6;
b = pi / 4;
call quad(Integral2, "TrigFunc", a||b);

/* compare with exact answer */
Answer2 = 5*pi/12 - 2*sqrt(2) + 4/sqrt(3);
diff = Answer2 - Integral2;
print Integral2 Answer2 diff;

/* optional: plot the function on [a,b] */
x = do(a,b,0.01);
title "f(x) = 5 - 2 tan(x)/cos(x)";
call Series(x, TrigFunc(x)) other="band x=x upper=y lower=0";
title;

quit;
