/**************************************************************************/
/* The snippet illustrates the use of the DQMATCH function to generate a  */
/* match code from a character value. The matchcodes reflect the relative */
/* similarity of data values. Matchcodes are created based on a specified */
/* match definition in a specified locale. The matchcodes are written to  */
/* an output SAS data set. Values that generate the same matchcodes are   */
/* candidates for transformation or standardization.                      */
/**************************************************************************/

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

/* Run the dqMatch function to return match codes. The required arguments    */
/* are character-value (address)and match-definition ('Address').            */
/* The optional arguments specified are sensitivity (50 or 85) and locale    */
/* ('ENUSA'). If the sensitivity value is not specified, the default value   */
/* is 85. Valid values range from 50 to 95. If the locale value is not       */
/* specified, the default locale value is used.                              */
data matchcode_out;
  set cust_db;
  mc_50=dqMatch(address,'Address', 50,'ENUSA');
  mc_85=dqMatch(address,'Address', 85,'ENUSA');
run;

title 'Output Data from Matching with Sensitivity of 50 and 85';
proc print data=matchcode_out;
run;
