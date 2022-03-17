/**************************************************************************/
/* The snippet illustrates the use of the DQCASE function to transform a  */
/* character constant, according to the specified case definition, and    */
/* return a character value with standardized capitalization.             */
/**************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/***************************************************************************/
/* Run the DQCASE function to apply the 'proper (organization)' definition */
/* to transform organization names to Proper case                          */
/***************************************************************************/
data _null_;
length org_name result $ 25;

org_name='aaa motor service';
result = dqCase(org_name, 'proper (organization)');

/* send results to log */
put 'Data has been transformed from ' org_name 'to ' result /;
run;
