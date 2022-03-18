/* Find the root of a function of one variable.  Example taken from
   R. Wicklin, "A simple way to find the root of a function of one variable",
   The DO Loop blog, published Feb 4, 2014.
   URL: http://blogs.sas.com/content/iml/2014/02/05/find-the-root-of-a-function/
*/

proc iml;
/* define a function that has one or more zeros */
start Func(x);
   return( exp(-x##2) - x##3 + 5#x +1 );
finish;

/* plot the function to get an idea of how many roots there
   are and approximately where they are located */
x = do(-4, 4, 0.1);
y = Func(x);
call Series(x, y)
grid="x" other="refline 0 / axis=y"; /* reference line */

/* Specify three intervals to search for roots */
intervals = {-4   -1.5,         /* 1st interval [-4, -1.5] */
             -1.5  1  ,         /* 2nd interval [-1.5 1]   */
              1    4  };        /* 3rd interval [1, 4]     */
Roots = froot("Func", intervals);
print Roots;
quit;
