/************************************************************************/
/* This example showcases fitting and assessing Generalized Linear      */
/* Models using the GENSELECT Procedure                                 */
/* The steps include:                                                   */
/*                                                                      */
/* (1) PREPARE                                                          */
/*     a) Check data is loaded into CAS                                 */
/*                                                                      */
/* (2) Perform Modeling on the Binary Target                            */
/*     a) Assuming binary distribution, using logit link                */
/*     b) Plot ROC curve                                                */
/************************************************************************/

/************************************************************************/
/* Setup and initialize for later use in the program                    */
/************************************************************************/

/* Define a CAS engine libref for CAS in-memory data tables */
libname mycaslib cas caslib=casuser;

/* Specify the data set names */
%let casdata          = mycaslib.hmeq_prepped;
%let partitioned_data = mycaslib.hmeq_part;

/* Specify the data set inputs and target */
%let class_inputs    = reason job;
%let interval_inputs = im_clage clno im_debtinc loan mortdue value im_yoj im_ninq derog im_delinq;
%let target          = bad;

/* Specify a folder path to write the temporary output files */
%let outdir = &_SASWORKINGDIR;

/************************************************************************/
/* Check if HMEQ_PREPPED data created in the Prepare and Explore Data   */
/* snippet exists.  If not, print error message to run the program.     */
/************************************************************************/
%if not %sysfunc(exist(&casdata)) %then %do;
  %put ERROR: The input dataset HMEQ_PREPPED is not loaded into CAS.;
  %put ERROR: Remember to run the Prepare and Explore Data snippet to load necessary data before executing this example.;
%end;


/************************************************************************/
/* Partition the data into training and validation                      */
/************************************************************************/
proc partition data=&casdata partition samppct=70;
  by &target;
  output out=&partitioned_data copyvars=(_ALL_);
run;


/************************************************************************/
/* The binary target model using LOGIT link                             */
/************************************************************************/
/* Assuming binary distribution, using logit link, fit a GLM using the Genselect procedure */
proc genselect data=&partitioned_data;
  class &class_inputs.;
  model &target.(event='1')=&interval_inputs. &class_inputs. / dist=binary link=logit;
  selection method=forward(select=sbc stop=sbc choose=validate);
  partition rolevar=_partind_(train='1' validate='0');
  code file="&outdir./glm_model.sas" pcatall;
run;


/************************************************************************/
/* Score the data using the generated GLM score code                    */
/************************************************************************/
data mycaslib._scored_glm;
  set &partitioned_data;
  %include "&outdir./glm_model.sas";
run;


/************************************************************************/
/* Assess model performance (GLM)                                       */
/************************************************************************/
ods exclude all;
proc assess data=mycaslib._scored_glm(where=(_partind_=0));
  input p_&target.1;
  target &target / level=nominal event='1';
  fitstat pvar=p_&target.0/ pevent='0';
  ods output fitstat  = glm_fitstat
             rocinfo  = glm_rocinfo
             liftinfo = glm_liftinfo;
run;
ods exclude none;


/*************************************************************************/
/*  Create ROC and Lift plots using validation data                      */
/*************************************************************************/
ods graphics on;

/* Print AUC (Area Under the ROC Curve) */
title "AUC (using validation data)";
proc sql;
  select distinct 'GLM', c from glm_rocinfo order by c desc;
quit;

/* Draw ROC charts */
proc sgplot data=glm_rocinfo aspect=1 noautolegend;
  title "ROC Curve (using validation data)";
  xaxis values=(0 to 1 by 0.25) grid offsetmin=.05 offsetmax=.05;
  yaxis values=(0 to 1 by 0.25) grid offsetmin=.05 offsetmax=.05;
  lineparm x=0 y=0 slope=1 / transparency=.7;
  series x=fpr y=sensitivity;
run;

/* Draw lift charts */
proc sgplot data=glm_liftinfo;
  title "Lift Chart (using validation data)";
  yaxis label=' ' grid;
  series x=depth y=lift / markers markerattrs=(symbol=circlefilled);
run;

ods graphics off;
