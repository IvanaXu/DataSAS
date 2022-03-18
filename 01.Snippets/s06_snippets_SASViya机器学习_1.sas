/****************************************************************************/
/* This is the first in a series of examples provided to demonstrate the    */
/* use of SAS Viya Data Mining and Machine Learning procedures to compose   */
/* a program that follows a standard machine learning process of            */
/* - loading data,                                                          */
/* - preparing the data,                                                    */
/* - building models, and                                                   */
/* - assessing and comparing those models                                   */
/*                                                                          */
/* The programs are written to execute in the CAS in-memory distributed     */
/* computing engine in the SAS Viya environment.                            */
/*                                                                          */
/* This first example showcases how to load local data into CAS             */
/****************************************************************************/

/* Define a CAS engine libref for CAS in-memory data tables */
libname mycaslib cas caslib=casuser;

/****************************************************************************/
/* Load data into CAS                                                       */
/*                                                                          */
/* The data set used for this workflow is from a financial services company */
/* that offers a home equity line of credit. The company has extended       */
/* several thousand lines of credit in the past, and many of these accepted */
/* applicants have defaulted on their loans. Using demographic and          */
/* financial variables, the company wants to build a model to predict       */
/* whether an applicant will default.                                       */
/*                                                                          */
/* The target variable "BAD" indicates whether an applicant defaulted       */
/* on the home equity line of credit.                                       */
/*                                                                          */
/* For execution in the CAS engine, data must be loaded from the local      */
/* data set to a CAS table. This code first checks to see if the specified  */
/* CAS table exists and then loads data from local data sets in 2           */
/* different ways.  After executing this code, you will notice a new        */
/* "MYCASLIB" library reference under "Libraries" in the navigation panel   */
/* on the left side (note the special icon indicating it is a caslib).      */
/*                                                                          */
/****************************************************************************/
%if not %sysfunc(exist(mycaslib.hmeq)) %then %do;

  /* You can load data using a "load" statement in PROC CASUTIL */
  proc casutil;
    load data=sampsio.hmeq casout="hmeq" outcaslib=casuser;
  run;

%end;

%if not %sysfunc(exist(mycaslib.hmeq)) %then %do;

  /* You can also load data using a data step */
  data mycaslib.hmeq;
    set sampsio.hmeq;
  run;

%end;
