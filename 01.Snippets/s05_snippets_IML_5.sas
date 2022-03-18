/* Use maximum likelihood estimation to estimate parameters for
   normal density estimate. Example taken from
   R. Wicklin, "Maximum likelihood estimation in SAS/IML",
   The DO Loop blog, published Oct 12, 2011.
   URL: http://blogs.sas.com/content/iml/2011/10/12/maximum-likelihood-estimation-in-sasiml/

You can use SAS/IML software to fit a parametric density to data.
1. Write a SAS/IML module that computes the log-likelihood function.
2. Specify constraints for the parameters.
3. Call a nonlinear optimization routines to maximize the log-likelihood.
*/
%let DSName = Sashelp.Iris;
%let VarName = SepalWidth;

proc iml;
/* write the log-likelihood function for Normal dist */
start LogLik(param) global (x);
   mu = param[1];
   sigma2 = param[2]##2;
   n = countn(x);         /* count nonmissing values */
   f = -n/2*log(sigma2) - 1/2/sigma2*ssq(x-mu);
   return ( f );
finish;

/* read data */
use &DSName;
read all var {&VarName} into x;
close &DSName;
/* Specify initial guess for parameters that is close to
   p = mean(x) || std(x); */
p = {35 5.5};

/*     mu-sigma constraint matrix */
con = { .   0,  /* lower bounds: -infty < mu; 0 < sigma     */
        .   .}; /* upper bounds:  mu < infty; sigma < infty */
opt = {1,       /* find maximum of function                 */
       0};      /* print iteration history? 0=no; 1=yes     */
call nlpnra(rc, MLE, "LogLik", p, opt, con);
print MLE[c={"mu" "sigma"}]; /* maximum likelihood estimates */

/* Optional: plot histogram with density overlay.
   The SUBMIT and ENDSUBMIT statements enable you to call
   SAS procedures from within a SAS/IML program.  You can
   pass parameters to the procedure. See
   R. Wicklin, "Passing values from PROC IML into SAS procedures",
   The DO Loop blog, published Jun 3, 2013.
   http://blogs.sas.com/content/iml/2013/06/03/passing-values-into-procedures/
*/
submit mu=(MLE[1]) sigma=(MLE[2]);
   proc sgplot data=&DSName;
   histogram &VarName;
   density &VarName / type=normal(mu=&mu sigma=&sigma);
   run;
endsubmit;

quit;
