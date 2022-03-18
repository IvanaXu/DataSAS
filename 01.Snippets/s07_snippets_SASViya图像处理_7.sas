/*****************************************************************************/
/*  This snippet uses the processImages action and the CONVERT_COLOR option. */
/*  Possible values for the type parameter are:                              */
/*  'BGR2HSV', 'BGR2RGB', 'BGR2YUV', 'COLOR2GRAY', 'GRAY2COLOR', 'HSV2BGR',  */
/*  'RGB2BGR' or 'YUV2BGR'                                                   */
/*****************************************************************************/
proc cas;
   image.processImages / casout={name='_outimages_', replace=1} imageTable={name='_images_'}
      imageFunctions={
         {functionOptions={functionType='CONVERT_COLOR', type='BGR2HSV'}}
      };
run;
