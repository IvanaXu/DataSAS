/*******************************************************************/
/* The snippet illustrates the use of the DQGENDER function to     */
/* return a gender from the name of an individual.                 */
/*******************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* The required arguments specified for the DQGENDER function are  */
/* character-value (name) and gender-analysis-definition ('Name'). */
/* The optional argument is locale ('ENUSA').                      */
data _null_;
   length name $100;
   length gender $ 20;

   name='Mrs. Sallie Mae Pravlik';

   gender=dqGender(name, 'Name', 'ENUSA');
   put gender=;
run;
