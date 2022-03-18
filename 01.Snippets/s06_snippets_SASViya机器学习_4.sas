/************************************************************************/
/* This example illustrates fitting and comparing two Machine           */
/* Learning algorithms for predicting the binary target in the          */
/* HMEQ data set. The steps include:                                    */
/*                                                                      */
/* (1) PREPARE AND EXPLORE                                              */
/*     a) Check data is loaded into CAS                                 */
/*                                                                      */
/* (2) PERFORM SUPERVISED LEARNING                                      */
/*     a) Fit model using Logistic Regression                           */
/*     b) Fit a model using a Decision Tree                             */
/*                                                                      */
/* (3) EVALUATE AND IMPLEMENT                                           */
/*     a) Score the data                                                */
/*     b) Assess model performance                                      */
/*     c) Generate ROC and Lift charts                                  */
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
/* LOGISTIC REGRESSION predictive model                                 */
/************************************************************************/
/* ALL data used for training model */
proc logselect data=&partitioned_data;
  class &target &class_inputs.;
  model &target.(event='1')=&class_inputs. &interval_inputs.;
  selection method=backward;
  code file="&outdir./logselect_score.sas" pcatall;
run;


/************************************************************************/
/* Score the data using the generated logistic model score code         */
/************************************************************************/
data mycaslib._scored_logistic;
  set &partitioned_data;
  %include "&outdir./logselect_score.sas";
run;


/************************************************************************/
/* Assess model performance (LOGISTIC REGRESSION)                       */
/************************************************************************/
ods exclude all;
proc assess data=mycaslib._scored_logistic(where=(_partind_=0));
  input p_&target.1;
  target &target / level=nominal event='1';
  fitstat pvar=p_&target.0/ pevent='0';
  ods output fitstat  = logit_fitstat
             rocinfo  = logit_rocinfo
             liftinfo = logit_liftinfo;
run;
ods exclude none;


/************************************************************************/
/* DECISION TREE predictive model                                       */
/************************************************************************/
proc treesplit data=&partitioned_data;
  input &interval_inputs. / level=interval;
  input &class_inputs. / level=nominal;
  target &target / level=nominal;
  partition rolevar=_partind_(train='1' validate='0');
  grow entropy;
  prune c45;
  code file="&outdir./treeselect_score.sas";
run;


/************************************************************************/
/* Score the data using the generated tree model score code             */
/************************************************************************/
data mycaslib._scored_tree;
  set &partitioned_data;
  %include "&outdir./treeselect_score.sas";
run;


/************************************************************************/
/* Assess tree model performance (DECISTION TREE)                       */
/************************************************************************/
ods exclude all;
proc assess data=mycaslib._scored_tree(where=(_partind_=0));
  input p_&target.1;
  target &target / level=nominal event='1';
  fitstat pvar=p_&target.0/ pevent='0';
  ods output fitstat  = tree_fitstat
             rocinfo  = tree_rocinfo
             liftinfo = tree_liftinfo;
run;
ods exclude none;


/*************************************************************************/
/*  Create ROC and Lift plots (both models) using validation data        */
/*************************************************************************/
ods graphics on;

data all_rocinfo;
  set logit_rocinfo(in=l)
      tree_rocinfo(in=t);

  length model $ 16;
  select;
      when (l) model='Logistic';
      when (t) model='Tree';
     end;
run;

data all_liftinfo;
  set logit_liftinfo(in=l)
      tree_liftinfo(in=t);

  length model $ 16;
  select;
      when (l) model='Logistic';
      when (t) model='Tree';
  end;
run;

/* Print AUC (Area Under the ROC Curve) */
title "AUC (using validation data)";
proc sql;
  select distinct model, c from all_rocinfo order by c desc;
quit;

/* Draw ROC charts */
proc sgplot data=all_rocinfo aspect=1;
  title "ROC Curve (using validation data)";
  xaxis values=(0 to 1 by 0.25) grid offsetmin=.05 offsetmax=.05;
  yaxis values=(0 to 1 by 0.25) grid offsetmin=.05 offsetmax=.05;
  lineparm x=0 y=0 slope=1 / transparency=.7;
  series x=fpr y=sensitivity / group=model;
run;

/* Draw lift charts */
proc sgplot data=all_liftinfo;
  title "Lift Chart (using validation data)";
  yaxis label=' ' grid;
  series x=depth y=lift / group=model markers markerattrs=(symbol=circlefilled);
run;

title;
ods graphics off;
