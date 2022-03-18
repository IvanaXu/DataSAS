/*****************************************************************************/
/*  This snippet uses the saveImages action to save the specified images to  */
/*  the specified subdirectory of a previously defined caslib, such as       */
/*  CASUSER.  The names of the saved images will start with the value of the */
/*  prefix parameter.                                                        */
/*****************************************************************************/
proc cas;
   image.saveImages / caslib="CASUSER" prefix='trans'
      subdirectory='name of subdirectory in the caslib root directory'
      images={table={name='_outimages_'}, image='_image_'};
run;
