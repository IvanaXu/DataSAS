/*****************************************************************************/
/* The snippet illustrates the use of the DQLOCALEQUESS function to apply    */
/* the input character value to the locale-guess definition that are listed  */
/* in the DQLOCALE= system option or session option. The function returns    */
/* the name of a locale.                                                     */
/*****************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();/*****************************************************************************/
/* The snippet illustrates the use of the DQLOCALEQUESS function to apply    */
/* the input character value to the locale-guess definition that are listed  */
/* in the DQLOCALE= system option or session option. The function returns    */
/* the name of a locale.                                                     */
/*****************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

/* Create input data set */
data phone_guess;
   length phone $ 30 actual $ 5;
   input phone $char30.;
cards;
(212) 987-7654
713-940-6100
+1 414 242 8202
1(303)5466306
(001) 719-260-5533
612.736.4436
+1 800 328 2407
;
run;

/* Run the dqLocaleGuess function to Return the name of a locale as the value */
/* of guess variable. The required arguments are character-value (phone) and  */
/* locale-guess-definition ('Phone').                                         */
data guessLocale;
   set work.phone_guess;
   length guess $ 10;

   locale=dqLocaleGuess(phone, 'Phone');

   put phone=   locale=;
run;

/* Create input data set */
data phone_guess;
   length phone $ 30 actual $ 5;
   input phone $char30.;
cards;
(212) 987-7654
713-940-6100
+1 414 242 8202
1(303)5466306
(001) 719-260-5533
612.736.4436
+1 800 328 2407
;
run;

/* Run the dqLocaleGuess function to Return the name of a locale as the value */
/* of guess variable. The required arguments are character-value (phone) and  */
/* locale-guess-definition ('Phone').                                         */
data guessLocale;
   set work.phone_guess;
   length guess $ 10;

   locale=dqLocaleGuess(phone, 'Phone');

   put phone=   locale=;
run;
