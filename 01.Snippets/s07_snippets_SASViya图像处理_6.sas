/*****************************************************************************/
/*  This snippet uses the processImages action and the RESCALE option.       */
/*  The resecale parameters are alpha, beta and type.  Possible values for   */
/*  type are 'TO_32F', 'TO_64F', or 'TO_8U'                                  */
/*****************************************************************************/
proc cas;
   image.processImages / casout={name='_outimages_', replace=1} imageTable={name='_images_'}
      imageFunctions={
         {functionOptions={functionType='RESCALE', alpha=.75, beta=.75, type='TO_32F'}}
      };
run;
