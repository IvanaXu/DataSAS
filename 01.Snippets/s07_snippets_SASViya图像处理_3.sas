/*****************************************************************************/
/*  This snippet uses the processImages action and the MUTATIONS option.     */
/*  Possible values for the type parameter are:                              */
/*  'COLOR_JITTERING', 'COLOR_SHIFTING', 'DARKEN'. 'HORIZONTAL_FLIP',        */
/*  'INVERT_PIXELS', 'LIGHTEN', 'ROTATE_LEFT', 'ROTATE_RIGHT', 'SHARPEN',    */
/*  or 'VERTICAL_FLIP'                                                       */
/*****************************************************************************/
proc cas;
   image.processImages / casout={name='_outimages_', replace=1}
      imageTable={name='_images_'}
      imageFunctions={
         {functionOptions={functionType='MUTATIONS',
            type='HORIZONTAL_FLIP'}}
      };
run;
