/*----------------------------------------------*/
  /*      Macro Variables                        */
  /*----------------------------------------------*/

/* User Defined Global Variables */
%let city=Dallas;
%let date=25APR2014;
%let amount=343;

/* User Defined Local Variables */
%macro lvars;
   %local name day;
   %let name=Ed Norton;
   %let day=Friday;
   %put _local_;
%mend;

/* When we run this we will see the Local Variables in %lvar */
%lvars

/* This show all global user and automatic macro variables */
%put _all_;