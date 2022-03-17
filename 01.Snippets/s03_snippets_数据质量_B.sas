/******************************************************************************/
/* The snippet provides examples for performing identification analysis       */
/* using DQIDENTIFYINFOGET, DQIDENTIFYMULTI and DQIDENTIFYIDGET functions.    */
/* The DQIDENTIFYINFOGET function returns a list of names that are supported  */
/* by a given identification analysisi definition. The DQIDENTIFYMULTI        */
/* function returns all of the identification analysis of a character value.  */
/* The DQIDENTIFYIDGET function retuurns a list of identity names.            */
/******************************************************************************/

/**************************************************************************/
/* Set system options values and load locale(s) into memory               */
/**************************************************************************/
%dqload();

data analysis;
    length identities result $ 300;
    length email individ ssn 8;

    /* Run the dqIdentifyInfoGet function. The required argument specified is  */
    /* identification-analysis-definition. The optional argument specified is  */
    /* locale ('ENUSA').                                                       */
    identities = dqIdentifyInfoGet('Field Content','ENUSA');
    put 'The identities for Field Content are: ' identities;


    /* Run the dqIdentifyMulti function. The required arguments are character  */
    /* value ('Samual Adams') and identification-analysis-definition           */
    /* Field Content').                                                        */
    result = dqIdentifyMulti('Samual Adams', 'Field Content');
    put 'The result of the dqIdentifyMulti is: ' result;

    /* Run the dqIdentifyIdGet function to return an individual score for an   */
    /* identity from a delimited string of identification analysis score.      */
    /* The required arguments are delimited-string (result), identity-name     */
    /* ('INDIVIDUAL') for example and identification-analysis-definition       */
    /* (Field Content'). The optional argument locale is not specified. The    */
    /* default locale is used.                                                 */
    put 'The Identification Analysis identified the following identities:';

    email = dqIdentifyIdGet(result, 'E-MAIL', 'Field Content');
    put email=;
    individ = dqIdentifyIdGet(result, 'INDIVIDUAL', 'Field Content');
    put individ=;
    ssn = dqIdentifyIdGet(result, 'SOCIAL SECURITY NUMBER', 'Field Content');
    put ssn=;
 run;
