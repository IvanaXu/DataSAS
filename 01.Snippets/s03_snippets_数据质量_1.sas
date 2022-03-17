/******************************************************************************/
/* The snippet illustrates the use of DQSTANDARDIZE function to standardize   */
/* the casing, spacing, and format of an input character value and return an  */
/* updated character value.                                                   */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create input data set */
data addresses;
input id $3. address $31.;
cards;
1   4D 664TH ST
2   820 MAIN
3   307 SOUTH BRKS
4   511 SOUTHWEST HWY W
5   1631 WESTSPRING ST
6   274 NORTH 500 EAST APARTMENT 1
7   3138 CLINTUN AVE
8   13434 2ND NE
9   9598 HIGHWAY 2 BOX 2037
10  BOX 2914 UNIT 7900
;
run;

/* Run the dqStandardize function to create output data set.          */
/* The required arguments specified are character-value (address)     */
/* and standardization-definition ('Address'). The optional argument  */
/* locale is not specified. The default locale is used.               */
data addresses_out  (drop=id);
   set addresses;
   length stdAddress $ 31.;

   stdAddress=dqStandardize(address,'Address');
run;

title 'Standardized Version of the Addresses';
proc print data=addresses_out;
run;
