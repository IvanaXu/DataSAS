/******************************************************************************/
/* The snippet provides examples for running the DQMATCH procedure to         */
/* generate match codes and create cluster numbers with multiple criteria     */
/* statement. PROC DQMATCH creates matchcodes as a basis for standardization  */
/* or transformation. The matchcodes reflect the relative similarity of data  */
/* values. Matchcodes are created based on a specified match definition in a  */
/* specified locale. The matchcodes are written to an output SAS data set.    */
/* Values that generate the same matchcodes are candidates for transformation */
/* or standardization.                                                        */
/*                                                                            */
/* The steps are:                                                             */
/* (1) Set QKB Locale and Prepare Data                                        */
/*     a) Set up QKB locale                                                   */
/*     b) Create an input data set                                            */
/* (2) Run DQMATCH Procedure                                                  */
/*     a) Criteria statements with default sensitivity level of 85            */
/*     b) Criteria statements with sensitivity level of 50                    */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create input data set */
data cust_db;
   length customer $ 22;
   length address $ 31;
   input customer $22. address $31.;
cards;
Bob Beckett           392 S. Main St. PO Box 2270
Robert E. Beckett     392 S. Main St. PO Box 2270
Rob Beckett           392 S. Main St. PO Box 2270
Paul Becker           392 N. Main St. PO Box 7720
Bobby Becket          392 S. Main St. PO Box 2270
Mr. Robert J. Beckeit P. O. Box 2270 392 S. Main St.
Mr. Robert E Beckett  392 South Main Street #2270
Mr. Raul Becker       392 North Main St.
;
run;

/* Run the dqMatch procedure to generate match codes with default sensitivity */
/* level of 85 and create cluster numbers.                                    */
/* The optional arguments specified for the proc dqMatch are data (cust_db),  */
/* out (matchcode_out1), cluster (clusterid). The optional argument specified */
/* for the two criteria statements are matchdef ('Name' and 'Address'), var   */
/* (customer and address) and matchcode (mc_name and mc_address).             */
proc dqMatch data=cust_db out=matchcode_out1 cluster=clusterid;
  criteria matchdef='Name' var=customer matchcode=mc_name;
  criteria matchdef='Address' var=address matchcode=mc_address;
run;

title 'Output Data from Matching with Default Sensitivity of 85';
proc print data=matchcode_out1;
run;

/* Run the dqMatch procedure to generate match codes with sensitivity level of */
/* 50 and create cluster numbers.                                              */
/* The optional arguments specified for the proc dqMatch are data (cust_db),   */
/* out (matchcode_out1), cluster (clusterid). The optional argument specified  */
/* for the two criteria statements are matchdef ('Name' and 'Address'), var    */
/* (customer and address) and matchcode (mc_name and mc_address).              */
proc dqMatch data=cust_db out=matchcode_out2 cluster=clusterid;
  criteria type='Name' var=customer matchcode=mc_name;
  criteria type='Address' var=address sensitivity=50 matchcode=mc_address;
run;

title 'Output Data from Matching with Sensitivities of 50';
proc print data=matchcode_out2;
run;
