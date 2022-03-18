/************************************************************************/
/* This example illustrates fitting and comparing several Machine       */
/* Learning algorithms for predicting the binary target in the          */
/* HMEQ data set. The steps include:                                    */
/*                                                                      */
/* (1) PREPARE AND EXPLORE                                              */
/*     a) Check data is loaded into CAS                                 */
/*                                                                      */
/* (2) PERFORM SUPERVISED LEARNING                                      */
/*     a) Fit a model using a Random Forest                             */
/*     b) Fit a model using Gradient Boosting                           */
/*     c) Fit a model using a Neural Network                            */
/*     d) Fit a model using a Support Vector Machine                    */
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
/* RANDOM FOREST predictive model                                       */
/************************************************************************/
proc forest data=&partitioned_data ntrees=50 intervalbins=20 minleafsize=5
            outmodel=mycaslib.forest_model;
  input &interval_inputs. / level = interval;
  input &class_inputs. / level = nominal;
  target &target / level=nominal;
  partition rolevar=_partind_(train='1' validate='0');
run;


/************************************************************************/
/* Score the data using the generated RF model                          */
/************************************************************************/
proc forest data=&partitioned_data inmodel=mycaslib.forest_model noprint;
  output out=mycaslib._scored_RF copyvars=(_ALL_);
run;


/************************************************************************/
/* GRADIENT BOOSTING MACHINES predictive model                          */
/************************************************************************/
proc gradboost data=&partitioned_data ntrees=10 intervalbins=20 maxdepth=5
               outmodel=mycaslib.gb_model;
  input &interval_inputs. / level = interval;
  input &class_inputs. / level = nominal;
  target &target / level=nominal;
  partition rolevar=_partind_(train='1' validate='0');
run;


/************************************************************************/
/* Score the data using the generated GBM model                         */
/************************************************************************/
proc gradboost  data=&partitioned_data inmodel=mycaslib.gb_model noprint;
  output out=mycaslib._scored_GB copyvars=(_ALL_);
run;


/************************************************************************/
/* NEURAL NETWORK predictive model                                      */
/************************************************************************/
proc nnet data=&partitioned_data;
  target &target / level=nom;
  input &interval_inputs. / level=int;
  input &class_inputs. / level=nom;
  hidden 2;
  train outmodel=mycaslib.nnet_model;
  partition rolevar=_partind_(train='1' validate='0');
  ods exclude OptIterHistory;
run;


/************************************************************************/
/* Score the data using the generated NN model                          */
/************************************************************************/
proc nnet data=&partitioned_data inmodel=mycaslib.nnet_model noprint;
  output out=mycaslib._scored_NN copyvars=(_ALL_);
run;


/************************************************************************/
/* SUPPORT VECTOR MACHINE predictive model                              */
/************************************************************************/
proc svmachine data=&partitioned_data(where=(_partind_=1));
  kernel polynom / deg=2;
  target &target;
  input &interval_inputs. / level=interval;
  input &class_inputs. / level=nominal;
  id bad _partind_;
  savestate rstore=mycaslib.svm_astore_model;
  ods exclude IterHistory;
run;


/************************************************************************/
/* Score data using ASTORE code generated for the SVM model             */
/************************************************************************/
proc astore;
  score data=&partitioned_data out=mycaslib._scored_SVM
        rstore=mycaslib.svm_astore_model;
run;


/************************************************************************/
/* Assess                                                               */
/************************************************************************/
%macro assess_model(prefix=, var_evt=, var_nevt=);
proc assess data=mycaslib._scored_&prefix.(where=(_partind_=0));
    input &var_evt.;
    target &target / level=nominal event='1';
    fitstat pvar=&var_nevt. / pevent='0';

    ods output
      fitstat=&prefix._fitstat
      rocinfo=&prefix._rocinfo
      liftinfo=&prefix._liftinfo;
run;
%mend assess_model;

ods exclude all;
%assess_model(prefix=RF, var_evt=p_&target.1, var_nevt=p_&target.0);
%assess_model(prefix=SVM, var_evt=p_&target.1, var_nevt=p_&target.0);
%assess_model(prefix=GB, var_evt=p_&target.1, var_nevt=p_&target.0);
%assess_model(prefix=NN, var_evt=p_&target.1, var_nevt=p_&target.0);
ods exclude none;


/************************************************************************/
/* ROC and Lift Charts using validation data                            */
/************************************************************************/
ods graphics on;

data all_rocinfo;
  set SVM_rocinfo(in=s)
      GB_rocinfo(in=g)
      NN_rocinfo(in=n)
      RF_rocinfo(in=f);

  length model $ 16;
  select;
    when (s) model='SVM';
    when (f) model='Forest';
    when (g) model='GradientBoosting';
    when (n) model='NeuralNetwork';
  end;
run;

data all_liftinfo;
  set SVM_liftinfo(in=s)
      GB_liftinfo(in=g)
      NN_liftinfo(in=n)
      RF_liftinfo(in=f);

  length model $ 16;
  select;
    when (s) model='SVM';
    when (f) model='Forest';
    when (g) model='GradientBoosting';
    when (n) model='NeuralNetwork';
  end;
run;

/* Print AUC (Area Under the ROC Curve) */
title "AUC (using validation data) ";
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
