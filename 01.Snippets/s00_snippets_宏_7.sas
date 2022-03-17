  /*----------------------------------------------*/
  /*       Macro Quoting                          */
  /*----------------------------------------------*/


  %macro m;
    %put this is macro m;
  %mend m;

  %let p=%str(proc print; run;);
  %put p = &p;

  /* results should be:  p = proc print; run; */


  %let m=%nrstr(look at macro %m and var &m);
  %put m = &m;

  /* results should be: m = look at macro %m and var &m */


 data test;
    store="Tom's place";
    call symput('s',store);
run;

%macro test;
   %if %bquote(&s) ne %then %put *** valid ***;
   %else %put *** null value ***;
%mend test;
%test;

 /* results should be:  *** valid *** */


 %let bqtvar=%str(macro%'s here!);
     %put bqtvar = &bqtvar;

  /* results should be: bqtvar = macro's here! */


 %let nbqtvar=%nrstr(macro%'s and &procs);
 %put nbqtvar = &nbqtvar;

  /*---------------------------
   results should be:
      nbqtvar = macro's and &procs
   ---------------------------*/


  %put superqed variable = %superq(nbqtvar);

  /* results should be:  superqed variable = macro's and &procs */


  %let qsc=%qscan(&nbqtvar,1);
  %put qsc = &qsc;

  /* results should be: qsc = macro's  */


  %let qsu=%qsubstr(&nbqtvar,1,7);
  %put qsu = &qsu;

  /* results should be: qsu = macro's */


  %let qsp=%qupcase(&nbqtvar);
  %put qsp = &qsp;

  /* results should be:  qsp = MACRO'S AND &PROCS */


  %let mvar=%nrstr(%m);
  %put mvar = %unquote(&mvar);

  /*---------------------------
    results should be:
this is macro m
mvar =
   ---------------------------*/