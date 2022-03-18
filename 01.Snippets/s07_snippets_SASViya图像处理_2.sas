/*****************************************************************************/
/*  This snippet uses the processImages action and the RESIZE option.        */
/*  The available resize parameters are height and width.  These are the     */
/*  number of rows and number of columns, respectively.                      */
/*****************************************************************************/
proc cas;
   image.processImages / casout={name='_outimages_', replace=1} imageTable={name='_images_'}
      imageFunctions={
         {functionOptions={functionType='RESIZE', height=100, width=100}}
      };
run;
