

/* --------------------------------------------------------------------------------------------- */
/* Before */
%MACRO RCYC1(ST=, ED=,);
    DATA _NULL_;
        CALL SYMPUT("DEV", INTCK("MONTH", INPUT("&ST.01", YYMMDD8.), INPUT("&ED.01", YYMMDD8.)));
    RUN;
    %PUT &DEV.;

    %DO I = 0 %TO &DEV.;
        DATA _NULL_;
            CALL SYMPUT("NMON", PUT(INTNX("MONTH", INPUT("&ST.01", YYMMDD8.), &I.), YYMMN6.));
        RUN;
        %PUT &I. &NMON.;

        DATA CARS_&NMON.;
        SET SASHELP.CARS(OBS=10);
        RUN;
    %END;
%MEND RCYC1;
%RCYC1(ST=201801, ED=201802);
/* --------------------------------------------------------------------------------------------- */


%LET C1 = "DEV";
%LET C2 = "MONTH";
%LET C3 = "NMON";

%MACRO RCYC2(ST=, ED=,);
    %LET MST = "&ST.01";
    %LET MED = "&ED.01";

    DATA _NULL_;
        CALL SYMPUT(&C1., INTCK(&C2., INPUT(&MST., YYMMDD8.), INPUT(&MED., YYMMDD8.)));
    RUN;
    %PUT &DEV.;

    %DO I = 0 %TO &DEV.;
        DATA _NULL_;
            CALL SYMPUT(&C3., PUT(INTNX(&C2., INPUT(&MST., YYMMDD8.), &I.), YYMMN6.));
        RUN;
        %PUT &I. &NMON.;

        DATA CARS_&NMON.;
        SET SASHELP.CARS(OBS=10);
        RUN;
    %END;
%MEND RCYC2;
%RCYC2(ST=201801, ED=201802);