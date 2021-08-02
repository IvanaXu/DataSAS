
/* */
libname t "temp";
ods path(prepend) t.template(update);


/* */
PROC SORT DATA = SASHELP.CARS OUT = C NODUPKEY;
BY MAKE;
RUN;

PROC PRINT DATA = C;
RUN;


/* */
PROC UNIVARIATE DATA = SASHELP.CARS;
VAR HORSEPOWER;
RUN;


/* */
PROC UNIVARIATE DATA = SASHELP.CARS NOPRINT;
HISTOGRAM HORSEPOWER
/
MIDPOINTS = 100 TO 500 BY 20;
RUN;


/* */
PROC UNIVARIATE DATA = SASHELP.CARS NOPRINT;
HISTOGRAM HORSEPOWER
/
NORMAL ( 
    MU = EST
    SIGMA = EST
    COLOR = BLUE
    W = 1
)
BARLABEL = PERCENT
MIDPOINTS = 100 TO 500 BY 20;
RUN;


/* */
PROC SGPLOT DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')));
VBAR LENGTH;
TITLE 'LENGTHS OF BMW';
RUN;
QUIT;


/* */
PROC SGPLOT DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')));
VBAR LENGTH /GROUP = TYPE ;
TITLE 'LENGTHS OF BMW BY TYPES';
RUN;
QUIT;


/* */
PROC SGPLOT DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')));
VBAR LENGTH /GROUP = TYPE GROUPDISPLAY = CLUSTER;
TITLE 'CLUSTER OF BMW BY TYPES';
RUN;
QUIT;


/* */
PROC TEMPLATE;
  DEFINE STATGRAPH PIE0;
    BEGINGRAPH;
      LAYOUT REGION;
        PIECHART CATEGORY = type /
          DATALABELLOCATION = OUTSIDE
          CATEGORYDIRECTION = CLOCKWISE
          START = 180 NAME = 'pie';
        DISCRETELEGEND 'pie' /
          TITLE = 'BMW Types';
      ENDLAYOUT;
    ENDGRAPH;
  END;
RUN;

PROC SGRENDER 
    DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')))
    TEMPLATE = PIE0;
RUN;


/* */
PROC TEMPLATE;
  DEFINE STATGRAPH PIE1;
    BEGINGRAPH;
      LAYOUT REGION;
        PIECHART CATEGORY = type /
          DATALABELLOCATION = INSIDE
          DATALABELCONTENT=ALL
          CATEGORYDIRECTION = CLOCKWISE
          DATASKIN= SHEEN 
          START = 180 NAME = 'pie';
        DISCRETELEGEND 'pie' /
          TITLE = 'BMW Types';
      ENDLAYOUT;
    ENDGRAPH;
  END;
RUN;

PROC SGRENDER 
    DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')))
    TEMPLATE = PIE1;
RUN;


/* */
PROC TEMPLATE;
  DEFINE STATGRAPH PIE2;
    BEGINGRAPH;
      LAYOUT REGION;
        PIECHART CATEGORY = type / Group = make
          DATALABELLOCATION = INSIDE
          DATALABELCONTENT=ALL
          CATEGORYDIRECTION = CLOCKWISE
          DATASKIN= SHEEN 
          START = 180 NAME = 'pie';
        DISCRETELEGEND 'pie' /
          TITLE = 'Audi/BMW Types';
      ENDLAYOUT;
    ENDGRAPH;
  END;
RUN;

PROC SGRENDER 
    DATA = SASHELP.CARS(WHERE = (MAKE IN ('Audi', 'BMW')))
    TEMPLATE = PIE2;
RUN;


/* */
PROC SGSCATTER  
    DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')));
    PLOT HORSEPOWER * INVOICE 
    / DATALABEL = MAKE GROUP = TYPE GRID;
    TITLE 'HORSEPOWER VS. INVOICE FOR BMW MAKERS BY TYPES';
RUN;


/* */
PROC SGSCATTER DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW'))); 
    COMPARE Y = INVOICE  X = (HORSEPOWER LENGTH)  
    /GROUP = TYPE ELLIPSE = (ALPHA = 0.05 TYPE = PREDICTED); 
    TITLE
    'AVERAGE INVOICE VS. HORSEPOWER FOR BMW BY LENGTH'; 
    TITLE2
    '-- WITH 95% PREDICTION ELLIPSE --'
    ; 
    FORMAT
    INVOICE DOLLAR6.0;
RUN;


/* */
PROC SGSCATTER DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')));
    MATRIX HORSEPOWER INVOICE LENGTH
    / GROUP = TYPE;
    TITLE 'HORSEPOWER VS. INVOICE VS. LENGTH FOR BMW MAKERS BY TYPES';
RUN; 


/* */
PROC SGPLOT DATA = SASHELP.CARS(WHERE = (MAKE IN ('BMW')));
    VBOX HORSEPOWER 
    / CATEGORY = TYPE;
    TITLE 'HORSEPOWER OF BMW BY TYPES';
RUN;


/* */
PROC SGPANEL DATA = SASHELP.CARS(WHERE = (MAKE IN ('Audi', 'BMW')));
    PANELBY MAKE;
    VBOX HORSEPOWER / CATEGORY = TYPE;
    TITLE 'HORSEPOWER OF Audi/BMW BY TYPES';
RUN; 


/* */
PROC SGPANEL DATA = SASHELP.CARS(WHERE = (MAKE IN ('Audi', 'BMW')));
    PANELBY MAKE / COLUMNS = 1 NOVARNAME;
    VBOX HORSEPOWER / CATEGORY = TYPE;
    TITLE 'HORSEPOWER OF Audi/BMW BY TYPES';
RUN; 


/* */
data Tumor;
   infile datalines missover;
   input ID Time Dead Dose P1-P15;
   label ID='Subject ID';
   datalines;
 1 47 1  1.0  0  5  6  8 10 10 10 10
 2 71 1  1.0  0  0  0  0  0  0  0  0  1  1  1  1 1 1 1
 3 81 0  1.0  0  1  1  1  1  1  1  1  1  1  1  1 1 1 1
 4 81 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0 0
 5 81 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0 0
 6 65 1  1.0  0  0  0  1  1  1  1  1  1  1  1  1 1
 7 71 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0 0
 8 69 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0
 9 67 1  1.0  0  0  1  1  2  2  2  2  3  3  3  3 3 3
10 81 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0 0
11 37 1  1.0  9  9  9
12 81 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0 0
13 77 0  1.0  0  0  0  0  1  1  1  1  1  1  1  1 1 1 1
14 81 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0 0
15 81 0  1.0  0  0  0  0  0  0  0  0  0  0  0  0 0 0 0
16 54 0  2.5  0  1  1  1  2  2  2  2  2  2  2  2
17 53 0  2.5  0  0  0  0  0  0  0  0  0  0  0  0
18 38 0  2.5  5 13 14
19 54 0  2.5  2  6  6  6  6  6  6  6  6  6  6  6
20 51 1  2.5 15 15 15 16 16 17 17 17 17 17 17
21 47 1  2.5 13 20 20 20 20 20 20 20
22 27 1  2.5 22
23 41 1  2.5  6 13 13 13
24 49 1  2.5  0  3  3  3  3  3  3  3  3
25 53 0  2.5  0  0  1  1  1  1  1  1  1  1  1  1
26 50 1  2.5  0  0  2  3  4  6  6  6  6  6
27 37 1  2.5  3 15 15
28 49 1  2.5  2  3  3  3  3  4  4  4  4
29 46 1  2.5  4  6  7  9  9  9  9
30 48 0  2.5 15 26 26 26 26 26 26 26
31 54 0 10.0 12 14 15 15 15 15 15 15 15 15 15 15
32 37 1 10.0 12 16 17
33 53 1 10.0  3  6  6  6  6  6  6  6  6  6  6  6
34 45 1 10.0  4 12 15 20 20 20
35 53 0 10.0  6 10 13 13 13 15 15 15 15 15 15 20
36 49 1 10.0  0  2  2  2  2  2  2  2  2
37 39 0 10.0  7  8  8
38 27 1 10.0 17
39 49 1 10.0  0  6  9 14 14 14 14 14 14
40 43 1 10.0 14 18 20 20 20
41 28 0 10.0  8
42 34 1 10.0 11 18
43 45 1 10.0 10 12 16 16 16 16
44 37 1 10.0  0  1  1
45 43 1 10.0  9 19 19 19 19
;

proc print data = tumor;
run;


/* */
data tumor1;
set tumor;
array p[10];
do droptime=1 to dim(p);
if missing(p[droptime]) then leave;
end;
droptime =droptime-1;
do MeasureTime =1 to dim(p);
Npap =p[MeasureTime];
output;
end;
keep ID MeasureTime Npap droptime;
run;


proc means data=tumor1 nway noprint;
class DropTime MeasureTime;
var Npap;
output out =meanout mean=mean_Npap;
run;


proc template;
define statgraph scatterplot;
dynamic _X_ _Y_ _VMCG_ _MSIZE_ _LMCG_;
begingraph;
entrytitle "Figure 1. Triangle plot about (non)informative dropout.";
layout overlay;       
scatterplot x=_X_ y=_Y_ /name="sca"  markercolorgradient=_VMCG_       markerattrs=(symbol=squarefilled size=_MSIZE_);
discretelegend "sca";
continuouslegend "sca"/ orient=vertical halign=right title=_LMCG_;
endlayout;
endgraph;
end;
run;

ods graphics on/width=1000 height=1000;
proc sgrender data =meanout template=scatterplot;
dynamic _X_='MeasureTime' _Y_='DropTime' _VMCG_='mean_Npap'
_MSIZE_='30pt' _LMCG_='Npap';
Label MeasureTime="Measurement Time" DropTime="Dropout Time";
run;
