 /*----------------------------------------------*/
 /*       %DO  statement                         */
 /*----------------------------------------------*/

 %macro shownote(length);
    %if &length = LONG %then %do;
       %put NOTE: This is a longer note.;
       %put NOTE: It is shown if the macro parameter is set to the value LONG.;
       %put NOTE: The default note is much shorter.;
    %end;
    %else %put NOTE: This is a short note;
%mend shownote;

%shownote(LONG)

  /* results should be:
  
 NOTE: This is a longer note.
 NOTE: It is shown if the macro parameter is set to the value LONG.
 NOTE: The default note is much shorter.
 
 */