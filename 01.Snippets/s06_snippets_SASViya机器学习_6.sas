/****************************************************************************/
/* This snippet showcases a sample Machine Learning workflow for            */
/* unsupervised learning using SASHELP.IRIS data set. The steps include:    */
/*                                                                          */
/* (1) PREPARE DATA                                                         */
/*     a) Load data set into CAS                                            */
/*                                                                          */
/* (2) PERFORM UNSUPERVISED LEARNING                                        */
/*     a) Generate Principal Components                                     */
/*     b) Analyze Clusters                                                  */
/*                                                                          */
/* (3) VISUALIZE THE RESULTS                                                */
/*     a) Examine the clustering plot                                       */
/*     b) Identify clusters in a PCA plot                                   */
/****************************************************************************/


/****************************************************************************/
/* Define the macro variables for later use in the program                  */
/****************************************************************************/
/* Specify a folder path to write the temporary output files */
%let outdir = &_SASWORKINGDIR;

/* Create a CAS engine libref to save the output data sets */
%let caslibname = mycas;
libname &caslibname cas caslib=casuser;

/* Specify the data set names */
%let sasdata = sashelp.iris;
%let casdata = &caslibname..iris;

/* Specify the data set inputs */
%let interval_vars=sepallength sepalwidth petallength petalwidth;

/****************************************************************************/
/* Load data into CAS                                                       */
/****************************************************************************/
data &casdata;
	set &sasdata;
	rowid = _n_;
run;

/****************************************************************************/
/* Unsupervised Learning: Principal Component Analysis                      */
/****************************************************************************/
proc pca data=&casdata prefix=PC method=EIG plots=all;
	var &interval_vars;
	output out=&casdata._scored_pca copyvars=(_all_) score=PC_;
	code file="&outdir/pca.sas";
run;

/****************************************************************************/
/* Unsupervised Learning: Cluster Analysis                                  */
/****************************************************************************/
proc kclus data=&casdata._scored_pca standardize=STD impute=MEAN
        distance=EUCLIDEAN maxiters=50 maxclusters=3;
	input &interval_vars;
	score out=&casdata._scored_kclus copyvars=(_all_);
	ods output clustersum=clus_clustersum;
	code file="&outdir/cluster.sas";
run;

/****************************************************************************/
/* Visualize the results using a clustering plot for segment frequency      */
/****************************************************************************/
data clus_clustersum;
    set clus_clustersum;
	clusterLabel = catx(' ', 'Cluster', cluster);
run;

proc template;
    define statgraph simplepie;
	begingraph;
		entrytitle "Segment Frequency";
		layout region;
		piechart category=clusterLabel response=frequency;
		endlayout;
	endgraph;
    end;
run;

proc sgrender data=clus_clustersum template=simplepie;
run;

/****************************************************************************/
/* Visualize the results by identifying clusters in a PCA plot              */
/****************************************************************************/
proc sgplot data=&casdata._scored_kclus(keep=PC_1 PC_2 _cluster_id_);
	title "Identify Clusters in a PCA Plot";
	scatter x=PC_1 y=PC_2 / group=_cluster_id_;
run;
title;
