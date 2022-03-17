/*----------------------------------------------*/
  /*       Macro Char Functions                   */
  /*----------------------------------------------*/


  /*------------------------------*/
  /*       %EVAL FUNCTION         */
  /*------------------------------*/

  %let num1=%eval(32767+7233);
  %put &num1 should be 40000;


  /*------------------------------*/
  /*       %INDEX FUNCTION        */
  /*------------------------------*/

  %let a=a very long value;
  %let b=%index(&a,v);
  %put v appears at position &b..;         /* at 3 */

  /*------------------------------*/
  /*       %LENGTH FUNCTION       */
  /*------------------------------*/

  %macro aproc;
     proc print; run;
  %mend aproc;

  %put %length(&a) should be 17;

  %put %length(%aproc) should be 16;

  /*------------------------------*/
  /*       %SCAN FUNCTION         */
  /*------------------------------*/

	%LET P=CATS AND DOGS;
	%LET Q=%SCAN(&P,3,%str( ));
	%put &q SHOULD BE DOGS;


  /*-------------------------------*/
  /*      %substr function         */
  /*-------------------------------*/

   %LET FIRST=THIS BOOK;
   %LET SECOND=%SUBSTR(&FIRST,6,4);
   %put &second SHOULD BE BOOK;


  /*-------------------------------*/
  /*      %UPCASE function         */
  /*-------------------------------*/

  %let string=%upcase(a string to upcase);
  %put &string should be A STRING TO UPCASE;