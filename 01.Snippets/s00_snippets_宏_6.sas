/*----------------------------------------------*/
  /*       Macro Parameters                       */
  /*----------------------------------------------*/


/* Positional Paramaters */

%macro pospar(var1,var2,var3,var4,var5);
      %put &var1 &var2 &var3 &var4 &var5;
  %mend pospar;

  %pospar();

  /* results should be: *blank*  */


  %pospar(str1,str2,str3,str4,str5)


  /*  results should be: str1 str2 str3 str4 str5  */

  %pospar(str1)

  /* results should be: str1  */


/* Keyword Parameters  */

  %macro keypar(var1=str1,var2=str2,var3=);
  %put &var1 &var2 &var3;
  %mend keypar;

  %keypar();

  /* results should be: str1 str2  */


  %keypar();

  /* results should be: str1 str2  */

  %keypar(var1=abc,var2=def,var3=ghi)

  /* results should be: abc def ghi */

