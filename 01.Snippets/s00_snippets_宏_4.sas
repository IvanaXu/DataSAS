 /*----------------------------------------------*/
  /*       %IF  statement                         */
  /*----------------------------------------------*/

  %macro testif;
      %local x y z;
      %let x=10;
      %let y=5;
      %let z=0;
      %if &x > &y %then %put test 1 successful;
      %else %put test 1 failed;
      %if &x < &y %then %put test 2 failed;
      %else %put test 2 successful;
      %if &x %then %put test 3 successful;
      %else %put test 3 failed;
      %if &z %then %put test 4 failed;
      %else %put test 4 successful;
   %mend testif;

   %testif

  /* results should be:
test 1 successful
test 2 successful
test 3 successful
test 4 successful
*/