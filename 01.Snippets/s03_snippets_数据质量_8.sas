/******************************************************************************/
/* The snippet illustrates the use of DQEXTRACT and DQEXTTOKENGET functions.  */
/* The DQEXTRACT function returns a delimited string of extraction token      */
/* values from an input character value that are detected by the extraction-  */
/* definition. The DQEXTTOKENGET function returns an extraction token value   */
/* from a delimited string of extraction token values.                        */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

data extractAddress;
   length delimstr address_extract $ 400;

   contactinfo='4000 East Sky Harbor Blvd Chesterfield MO 63005 426-758-4180';

   /* Run the dqExtract function. The required arguments specified are          */
   /* character-value (contactinfo) and extract-definition ('Contact Info').    */
   /* The optional argument locale is not specified. The default locale is used.*/
   delimstr = dqExtract(contactinfo, 'Contact Info');
   put delimstr=;

   /* Run the dqExtTokenGet function. The required arguments specified are      */
   /* delimited-string (delimstr) and token ('Address'). The optional argument  */
   /* locale is not specified. The default locale is used.                      */
   address_extract = dqExtTokenGet(delimstr, 'Address', 'Contact Info');
   put address_extract =;

run;
