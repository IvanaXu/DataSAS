/*****************************************************************************/
/*  This snippet loads the image action set. The path parameter points to a  */
/*  directory that contains the images to be loaded.  The path parameter is  */
/*  subdirectory in the caslib directory where the images are stored.        */
/*                                                                           */
/*  A typical workflow is to load images and then process them by resizing,  */
/*  rescaling or mutating them using one of the other snippets.  The output  */
/*  from one snippet can be used as input to another snippet.  Images can    */
/*  be saved to disk for further processing by using the save images snippet.*/
/*****************************************************************************/
proc cas;
   image.loadImages / casout={name='_images_', replace=1}
      caslib="CASUSER"
      path="name of subdirectory in the caslib root directory";
run;
