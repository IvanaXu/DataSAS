/* Simulate data from a multivariate normal distribution
   with a specified mean and covariance. Example taken from
   R. Wicklin (2013) Simulating Data with SAS, SAS Press: Cary, NC,
   pp. 133-135.
*/
proc iml;
/* specify the mean and covariance of the population */
VarNames = 'x1':'x3';
Mean = {1, 2, 3};
Cov = {3 2 1,
       2 4 0,
       1 0 5};

NumSamples = 1000;
call randseed(4321);
X = RandNormal(NumSamples, Mean, Cov);

/* X has 3 columns and 1000 rows.
   Check that the sample mean and covariance are close to
   the population values. */
SampleMean = mean(X);
SampleCov = cov(X);
print SampleMean[c=varNames],
      SampleCov[c=varNames r=varNames];

/* optional: plot the simulated data */
create _Temp from X[c=varNames];
append from X;
close _Temp;
submit;
   proc sgscatter data=_Temp;
      matrix x1-x3 / diagonal=(histogram normal);
   run;
endsubmit;
call delete(_Temp);

quit;
