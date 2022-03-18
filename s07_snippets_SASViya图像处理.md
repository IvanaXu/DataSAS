#### 1、保存图像
```SAS
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
```

#### 2、调整图像大小
```SAS
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
```

#### 3、改变图像
```SAS
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
```

#### 4、加载图像
```SAS
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
```

#### 5、显示图像
```SAS
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
```

#### 6、重新缩放图像比例
```SAS
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
```

#### 7、转换颜色
```SAS
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
```
