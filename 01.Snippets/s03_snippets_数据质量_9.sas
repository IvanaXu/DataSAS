/*****************************************************************************/
/* The snippet provides examples for applying a scheme stored in SAS format  */
/* using the DQSCHEMEAPPLY function, the DQSCHEMEAPPLY CALL routine or the   */
/* DQSCHEME procedure. Schemes allow you to standardize irregular entries    */
/* into data that can be used for reporting.                                 */
/*                                                                           */
/* The steps are:                                                            */
/* (1) Prepare Data                                                          */
/*     a) Create a scheme stored in SAS format                               */
/*     b) Create an input data set                                           */
/* (2) Apply a scheme to an input data set                                   */
/*     a) DQSCHEMEAPPLY Function or                                          */
/*     b) DQSCHEMEAPPLY CALL Routine                                         */
/*     c) DQSCHEME Procedure                                                 */
/*****************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create a scheme stored in SAS format       */
data myscheme;
   input @1 data $char20. @22 standard $char20.;
cards;
fred                 flintstone
barney               rubble
dino                 dinosaur
fred flintstone      grand poobah
;
run;

/* Create the input data set */
data names;
   input @1 origname $char20.;
   newname=origname;
cards;
fred smith
barney baker
fred flintstone
sandra smith baker
;
run;

/* Apply the scheme myscheme to input data set names and return transformed  */
/* value newname using the DQSCHEMEAPPLY function. The required arguments    */
/* specified are char (origname), scheme ('myscheme') and scheme-format      */
/* ('noqkb'). The optional argument specified is mode ('element').           */
data element_function;
   set names;
   newname=dqSchemeApply(origname, 'myscheme', 'noqkb', 'element');
run;

/* Print the element_function data set */
proc print;
   title 'element mode - dqSchemeApply function';
run;

/* Apply the scheme myscheme to transform input value origname using the     */
/* the Call DQSCHEMEAPPLY routine. The required arguments specified are      */
/* char (origname), scheme ('myscheme') and scheme-format ('noqkb').         */
/* The optional argument specified is mmode ('element').                     */
data element_call;
   set names;
   call dqSchemeApply(origname, newname, 'myscheme', 'noqkb', 'element');
run;

/* Print the element_call data set */
proc print;
   title 'element mode - dqSchemeApply Call routine';
run;

/* Apply the scheme myscheme to input data set names using the dqScheme      */
/* procedure. The optional arguments specified for the proc dqScheme are d   */
/* data (names), out (element_proc) and mode (noqkb). The optional arguments */
/* specified for the apply statement are scheme (myscheme), var (newname)    */
/* and mode (element).                                                       */
proc dqscheme data=names out=element_proc noqkb;
   apply scheme=myscheme var=newname mode=element;
run;

/* Print the element_proc data set */
proc print;
   title 'element mode - Proc dqScheme/Apply';
run;
