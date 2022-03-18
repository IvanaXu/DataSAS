/*****************************************************************************/
/*  This snippet can be used to display an image that is saved on disk in    */
/*  SAS Studio.  It creates an annotation data set containing a reference to */
/*  the image and uses PROC SGPLOT to display it. The image= variable is the */
/*  fully-qualified name of the location of the image to be displayed. This  */
/*  location must be accessible from the SAS server                          */
/*****************************************************************************/
data _tempanno_;
   function='image';
   image="<image to display>";
   layer="front";
run;
data _tempdata_;x=0;y=0;run;
proc sgplot data=_tempdata_ sganno=_tempanno_ ;
scatter x=x y=y;
xaxis display=none;
yaxis display=none;
run;
