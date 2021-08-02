### PROC步

------

#### 常用通用选项

VAR:规定用这个过程分析的一些变量；

WEIGHT:规定一个变量，它的值是这些观测的相应权数；

CLASS:在分析中指定一些变量为分类变量；

BY:规定一些变量，SAS过程对输入数据集用by变量定义的几个 数据组分别进行分析处理；

OUTPUT/OUT:给出用该过程产生的输出数据集的信息；

```SAS
OPTIONS COMPRESS = YES;

DATA CARS;
SET SASHELP.CARS;
RUN;
```

#### PROC SORT

(1)基本形式:

PROC SORT DATA = OUT = ; BY ; RUN;

SAS会按照第一个变量先排序，再对后面排序；

SAS默认排序是按升序排序，若需降序排序，在变量名前加DESCENDING；

(2)排序设置：

NODUPKEY、NOUNIQUEKEY、NODUP(探索);

```SAS
/* PROC SORT */
PROC SORT DATA = SASHELP.CARS;
BY MSRP;
RUN;
```

```SAS
PROC SORT DATA = SASHELP.CARS OUT = CARS_MSRP;
BY DESCENDING MSRP;
RUN;

PROC SORT DATA = SASHELP.CARS OUT = CARS_MAKE;
BY MAKE;
RUN;
```

```SAS
DATA CARS_DUP;
KEEP TYPE ORIGIN DRIVETRAIN;
SET SASHELP.CARS;
RUN;

PROC PRINT DATA = CARS_DUP(OBS=20);
RUN;
```

**The SAS System**

|  Obs |   Type | Origin | DriveTrain |
| ---: | -----: | -----: | ---------: |
|    1 |    SUV |   Asia |        All |
|    2 |  Sedan |   Asia |      Front |
|    3 |  Sedan |   Asia |      Front |
|    4 |  Sedan |   Asia |      Front |
|    5 |  Sedan |   Asia |      Front |
|    6 |  Sedan |   Asia |      Front |
|    7 | Sports |   Asia |       Rear |
|    8 |  Sedan | Europe |      Front |
|    9 |  Sedan | Europe |      Front |
|   10 |  Sedan | Europe |      Front |
|   11 |  Sedan | Europe |        All |
|   12 |  Sedan | Europe |        All |
|   13 |  Sedan | Europe |      Front |
|   14 |  Sedan | Europe |        All |
|   15 |  Sedan | Europe |      Front |
|   16 |  Sedan | Europe |        All |
|   17 |  Sedan | Europe |        All |
|   18 |  Sedan | Europe |        All |
|   19 |  Sedan | Europe |        All |
|   20 |  Sedan | Europe |        All |

```SAS
PROC SORT DATA = CARS_DUP(OBS=20) OUT = CARS_NDK NODUPKEY;
BY TYPE ORIGIN;
RUN;

PROC PRINT DATA = CARS_NDK;
RUN;
```

**The SAS System**

|  Obs |   Type | Origin | DriveTrain |
| ---: | -----: | -----: | ---------: |
|    1 |    SUV |   Asia |        All |
|    2 |  Sedan |   Asia |      Front |
|    3 |  Sedan | Europe |      Front |
|    4 | Sports |   Asia |       Rear |

```SAS
PROC SORT DATA = CARS_DUP(OBS=20) OUT = CARS_NQK NOUNIQUEKEY;
BY TYPE ORIGIN;
RUN;

PROC PRINT DATA = CARS_NQK;
RUN;
```

**The SAS System**

|  Obs |  Type | Origin | DriveTrain |
| ---: | ----: | -----: | ---------: |
|    1 | Sedan |   Asia |      Front |
|    2 | Sedan |   Asia |      Front |
|    3 | Sedan |   Asia |      Front |
|    4 | Sedan |   Asia |      Front |
|    5 | Sedan |   Asia |      Front |
|    6 | Sedan | Europe |      Front |
|    7 | Sedan | Europe |      Front |
|    8 | Sedan | Europe |      Front |
|    9 | Sedan | Europe |        All |
|   10 | Sedan | Europe |        All |
|   11 | Sedan | Europe |      Front |
|   12 | Sedan | Europe |        All |
|   13 | Sedan | Europe |      Front |
|   14 | Sedan | Europe |        All |
|   15 | Sedan | Europe |        All |
|   16 | Sedan | Europe |        All |
|   17 | Sedan | Europe |        All |
|   18 | Sedan | Europe |        All |

```SAS
PROC SORT DATA = CARS_DUP(OBS=20) OUT = CARS_ND NODUP;
BY TYPE ORIGIN;
RUN;

PROC PRINT DATA = CARS_ND;
RUN;
```

**The SAS System**

|  Obs |   Type | Origin | DriveTrain |
| ---: | -----: | -----: | ---------: |
|    1 |    SUV |   Asia |        All |
|    2 |  Sedan |   Asia |      Front |
|    3 |  Sedan | Europe |      Front |
|    4 |  Sedan | Europe |        All |
|    5 |  Sedan | Europe |      Front |
|    6 |  Sedan | Europe |        All |
|    7 |  Sedan | Europe |      Front |
|    8 |  Sedan | Europe |        All |
|    9 | Sports |   Asia |       Rear |

#### PROC FREQ

(1)基本形式:

PROC FREQ DATA=;TABLE ;RUN;

对一个变量计算频数，称作ONE-WAY；

对两个变量计算频数，称作TWP-WAY；

对多个变量计算频数，称作交叉表；

(2)TABLE VAR后常接选项:

NOCOL:不打印列百分比

NOROW:不打印行百分比

NOPERCENT:不打印百分比

MISSING:统计缺失值

**/OUT:将频次表输出到数据集中**

(3)TABLE TYPE:

TABLE COL_A

TABLE COL_A * COL_B

TABLE (COL_A COL_C) * COL_B

TABLE COL_A * COL_B / NOROW NOCOL NOPERCENT

TABLE COL_A * COL_B / MISSING

```SAS
/* PROC FREQ */
PROC FREQ DATA = CARS NOPRINT;
TABLE DRIVETRAIN / OUT = CARS_FREQ;
RUN;

PROC PRINT DATA = CARS_FREQ;
RUN;
```

**The SAS System**

|  Obs | DriveTrain | COUNT | PERCENT |
| ---: | ---------: | ----: | ------: |
|    1 |        All |    92 | 21.4953 |
|    2 |      Front |   226 | 52.8037 |
|    3 |       Rear |   110 | 25.7009 |

```SAS
PROC FREQ DATA = CARS;
TABLE DRIVETRAIN * ORIGIN/NOCOL NOROW NOPERCENT MISSING;
RUN;
```

| Table of DriveTrain by Origin |        |        |      |       |
| ----------------------------: | -----: | -----: | ---: | ----- |
|                    DriveTrain | Origin |        |      |       |
|                               |   Asia | Europe |  USA | Total |
|                           All |     34 |     36 |   22 | 92    |
|                         Front |     99 |     37 |   90 | 226   |
|                          Rear |     25 |     50 |   35 | 110   |
|                         Total |    158 |    123 |  147 | 428   |

```SAS
PROC FREQ DATA = CARS;
TABLE ORIGIN * DRIVETRAIN/NOCOL NOROW NOPERCENT MISSING;
RUN;
```

| Table of Origin by DriveTrain |            |        |      |       |
| ----------------------------: | ---------: | -----: | ---: | ----- |
|                        Origin | DriveTrain |        |      |       |
|                               |       Asia | Europe |  USA | Total |
|                          Asia |         34 |     99 |   25 | 158   |
|                        Europe |         36 |     37 |   50 | 123   |
|                           USA |         22 |     90 |   35 | 147   |
|                         Total |         92 |    226 |  110 | 428   |

```SAS
PROC FREQ DATA = CARS;
TABLE DRIVETRAIN * ORIGIN;
WHERE TYPE = "SUV";
RUN;

PROC FREQ DATA = CARS(OBS=20);
TABLE TYPE * DRIVETRAIN * ORIGIN;
RUN;

PROC FREQ DATA = CARS;
TABLE (TYPE DRIVETRAIN) * ORIGIN;
RUN;
```

#### PROC UNIVARIATE

(1)基本形式:

PROC UNIVARIATE DATA = ;VAR ;RUN;

单变量过程，可以求单个变量的大部分统计指标

```SAS
/* PROC UNIVARIATE */
PROC UNIVARIATE DATA = CARS;
VAR MSRP;
RUN;
```

The UNIVARIATE Procedure

Variable: MSRP

|         Moments |            |                  |            |
| --------------: | ---------: | ---------------- | ---------- |
|               N |        428 | Sum Weights      | 428        |
|            Mean | 32774.8551 | Sum Observations | 14027638   |
|   Std Deviation | 19431.7167 | Variance         | 377591613  |
|        Skewness | 2.79809927 | Kurtosis         | 13.8792055 |
|  Uncorrected SS | 6.20985E11 | Corrected SS     | 1.61232E11 |
| Coeff Variation | 59.2884899 | Std Error Mean   | 939.267478 |

| Basic Statistical Measures |          |                     |             |
| -------------------------: | -------: | ------------------- | ----------- |
|                            | Location |                     | Variability |
|                       Mean | 32774.86 | Std Deviation       | 19432       |
|                     Median | 27635.00 | Variance            | 377591613   |
|                       Mode | 13270.00 | Range               | 182185      |
|                            |          | Interquartile Range | 18886       |

Note: The mode displayed is the smallest of 18 modes with a count of 2.

| Tests for Location: Mu0=0 |      |           |             |         |
| ------------------------: | ---: | --------: | ----------- | ------- |
|                      Test |      | Statistic |             | p Value |
|               Student's t |    t |  34.89406 | Pr > \|t\|  | <.0001  |
|                      Sign |    M |       214 | Pr >= \|M\| | <.0001  |
|               Signed Rank |    S |     45903 | Pr >= \|S\| | <.0001  |

|            | Quantiles (Definition 5) |
| ---------: | -----------------------: |
|      Level |                 Quantile |
|   100% Max |                 192465.0 |
|        99% |                  94820.0 |
|        95% |                  73195.0 |
|        90% |                  52795.0 |
|     75% Q3 |                  39215.0 |
| 50% Median |                  27635.0 |
|     25% Q1 |                  20329.5 |
|        10% |                  15460.0 |
|         5% |                  13670.0 |
|         1% |                  11155.0 |
|     0% Min |                  10280.0 |

| Extreme Observations |        |        |         |
| -------------------: | -----: | -----: | ------: |
|                      | Lowest |        | Highest |
|                Value |    Obs |  Value |     Obs |
|                10280 |    207 |  94820 |     262 |
|                10539 |    169 | 121770 |     271 |
|                10760 |    383 | 126670 |     272 |
|                10995 |    346 | 128420 |     263 |
|                11155 |    208 | 192465 |     335 |

```SAS
PROC UNIVARIATE DATA = CARS;
VAR MAKE;
RUN;
/*
377  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
377! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
378  
379  PROC UNIVARIATE DATA = CARS;
ERROR: Variable Make in list does not match type prescribed for this list.
380  VAR MAKE;
381  RUN;
NOTE: The SAS System stopped processing this step because of errors.
NOTE: PROCEDURE UNIVARIATE used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
382  
383  ods html5 (id=saspy_internal) close;ods listing;

384  
*/
```

```SAS
PROC UNIVARIATE DATA = CARS(OBS=100);
VAR MSRP;
CLASS MAKE;
RUN;
```

#### PROC TRANSPOSE

(1)基本形式:

PROC TRANSPOSE DATA = OUT = ;VAR ;RUN;

实现对数据集的转置，即把观测变为变量，变量变为观测；

(2)常用选项:

PREFIX:规定转置后的变量名前缀；

SUFFIX:规定转置后的变量名后缀；

OUT:规定输出数据集；

ID:使用其后规定的变量值作为输出数据集中被转置的变量名；

VAR:规定需要转置的变量名；

BY:规定分组的变量名；

```SAS
/* PROC TRANSPOSE */
DATA CARS_MAMS;
KEEP MAKE TYPE MSRP;
SET SASHELP.CARS;
RUN;

PROC SORT DATA = CARS_MAMS OUT = CARS_MAMSD NODUPKEY;
BY MAKE TYPE;
RUN;

PROC PRINT DATA = CARS_MAMSD;
RUN;
```

**The SAS System**

|  Obs |          Make |   Type |    MSRP |
| ---: | ------------: | -----: | ------: |
|    1 |         Acura |    SUV | $36,945 |
|    2 |         Acura |  Sedan | $23,820 |
|    3 |         Acura | Sports | $89,765 |
|    4 |          Audi |  Sedan | $25,940 |
|    5 |          Audi | Sports | $84,600 |
|    6 |          Audi |  Wagon | $40,840 |
|    7 |           BMW |    SUV | $37,000 |
|    8 |           BMW |  Sedan | $28,495 |
|    9 |           BMW | Sports | $48,195 |
|   10 |           BMW |  Wagon | $32,845 |
|   11 |         Buick |    SUV | $37,895 |
|   12 |         Buick |  Sedan | $22,180 |
|   13 |      Cadillac |    SUV | $52,795 |
|   14 |      Cadillac |  Sedan | $30,835 |
|   15 |      Cadillac | Sports | $76,200 |
|   16 |      Cadillac |  Truck | $52,975 |
|   17 |     Chevrolet |    SUV | $42,735 |
|   18 |     Chevrolet |  Sedan | $11,690 |
|   19 |     Chevrolet | Sports | $44,535 |
|   20 |     Chevrolet |  Truck | $36,100 |
|   21 |     Chevrolet |  Wagon | $22,225 |
|   22 |      Chrysler |  Sedan | $17,985 |
|   23 |      Chrysler | Sports | $34,495 |
|   24 |      Chrysler |  Wagon | $31,230 |
|   25 |         Dodge |    SUV | $32,235 |
|   26 |         Dodge |  Sedan | $13,670 |
|   27 |         Dodge | Sports | $81,795 |
|   28 |         Dodge |  Truck | $17,630 |
|   29 |          Ford |    SUV | $41,475 |
|   30 |          Ford |  Sedan | $13,270 |
|   31 |          Ford | Sports | $18,345 |
|   32 |          Ford |  Truck | $22,010 |
|   33 |          Ford |  Wagon | $17,475 |
|   34 |           GMC |    SUV | $31,890 |
|   35 |           GMC |  Sedan | $25,640 |
|   36 |           GMC |  Truck | $16,530 |
|   37 |         Honda | Hybrid | $20,140 |
|   38 |         Honda |    SUV | $27,560 |
|   39 |         Honda |  Sedan | $13,270 |
|   40 |         Honda | Sports | $33,260 |
|   41 |        Hummer |    SUV | $49,995 |
|   42 |       Hyundai |    SUV | $21,589 |
|   43 |       Hyundai |  Sedan | $10,539 |
|   44 |       Hyundai | Sports | $18,739 |
|   45 |      Infiniti |  Sedan | $28,495 |
|   46 |      Infiniti |  Wagon | $34,895 |
|   47 |         Isuzu |    SUV | $31,849 |
|   48 |        Jaguar |  Sedan | $29,995 |
|   49 |        Jaguar | Sports | $69,995 |
|   50 |          Jeep |    SUV | $27,905 |
|   51 |           Kia |    SUV | $19,635 |
|   52 |           Kia |  Sedan | $16,040 |
|   53 |           Kia |  Wagon | $11,905 |
|   54 |    Land Rover |    SUV | $72,250 |
|   55 |         Lexus |    SUV | $45,700 |
|   56 |         Lexus |  Sedan | $32,350 |
|   57 |         Lexus | Sports | $63,200 |
|   58 |         Lexus |  Wagon | $32,455 |
|   59 |       Lincoln |    SUV | $52,775 |
|   60 |       Lincoln |  Sedan | $32,495 |
|   61 |          MINI |  Sedan | $16,999 |
|   62 |         Mazda |    SUV | $21,087 |
|   63 |         Mazda |  Sedan | $15,500 |
|   64 |         Mazda | Sports | $22,388 |
|   65 |         Mazda |  Truck | $14,840 |
|   66 | Mercedes-Benz |    SUV | $76,870 |
|   67 | Mercedes-Benz |  Sedan | $26,060 |
|   68 | Mercedes-Benz | Sports | $90,520 |
|   69 | Mercedes-Benz |  Wagon | $33,780 |
|   70 |       Mercury |    SUV | $29,995 |
|   71 |       Mercury |  Sedan | $21,595 |
|   72 |       Mercury |  Wagon | $22,595 |
|   73 |    Mitsubishi |    SUV | $30,492 |
|   74 |    Mitsubishi |  Sedan | $14,622 |
|   75 |    Mitsubishi | Sports | $25,092 |
|   76 |    Mitsubishi |  Wagon | $17,495 |
|   77 |        Nissan |    SUV | $33,840 |
|   78 |        Nissan |  Sedan | $12,740 |
|   79 |        Nissan | Sports | $26,910 |
|   80 |        Nissan |  Truck | $19,479 |
|   81 |        Nissan |  Wagon | $28,739 |
|   82 |    Oldsmobile |  Sedan | $18,825 |
|   83 |       Pontiac |    SUV | $21,595 |
|   84 |       Pontiac |  Sedan | $15,495 |
|   85 |       Pontiac | Sports | $33,500 |
|   86 |       Pontiac |  Wagon | $17,045 |
|   87 |       Porsche |    SUV | $56,665 |
|   88 |       Porsche | Sports | $79,165 |
|   89 |          Saab |  Sedan | $30,860 |
|   90 |          Saab |  Wagon | $40,845 |
|   91 |        Saturn |    SUV | $20,585 |
|   92 |        Saturn |  Sedan | $10,995 |
|   93 |        Saturn |  Wagon | $23,560 |
|   94 |         Scion |  Sedan | $12,965 |
|   95 |         Scion |  Wagon | $14,165 |
|   96 |        Subaru |  Sedan | $19,945 |
|   97 |        Subaru | Sports | $25,045 |
|   98 |        Subaru |  Truck | $24,520 |
|   99 |        Subaru |  Wagon | $21,445 |
|  100 |        Suzuki |    SUV | $23,699 |
|  101 |        Suzuki |  Sedan | $12,884 |
|  102 |        Suzuki |  Wagon | $16,497 |
|  103 |        Toyota | Hybrid | $20,510 |
|  104 |        Toyota |    SUV | $35,695 |
|  105 |        Toyota |  Sedan | $14,085 |
|  106 |        Toyota | Sports | $22,570 |
|  107 |        Toyota |  Truck | $12,800 |
|  108 |        Toyota |  Wagon | $16,695 |
|  109 |    Volkswagen |    SUV | $35,515 |
|  110 |    Volkswagen |  Sedan | $18,715 |
|  111 |    Volkswagen |  Wagon | $19,005 |
|  112 |         Volvo |    SUV | $41,250 |
|  113 |         Volvo |  Sedan | $25,135 |
|  114 |         Volvo |  Wagon | $26,135 |

```SAS
PROC TRANSPOSE DATA = CARS_MAMSD;
VAR MSRP;
BY MAKE;
RUN;

/* DATAX */
/*
457  ods listing close;ods html5 (id=saspy_internal) file=stdout options(bitmap_mode='inline') device=svg style=HTMLBlue; ods
457! graphics on / outputfmt=png;
NOTE: Writing HTML5(SASPY_INTERNAL) Body file: STDOUT
458  
459  PROC TRANSPOSE DATA = CARS_MAMSD;
460  VAR MSRP;
461  BY MAKE;
462  RUN;
NOTE: There were 114 observations read from the data set WORK.CARS_MAMSD.
NOTE: The data set WORK.DATA4 has 38 observations and 8 variables.
NOTE: Compressing data set WORK.DATA4 increased size by 100.00 percent. 
      Compressed is 2 pages; un-compressed would require 1 pages.
NOTE: PROCEDURE TRANSPOSE used (Total process time):
      real time           0.00 seconds
      cpu time            0.00 seconds
      
463  
464  ods html5 (id=saspy_internal) close;ods listing;

465 
*/
```

```SAS
PROC TRANSPOSE DATA = CARS_MAMSD OUT = CARS_M PREFIX = ID_;
VAR MSRP;
BY MAKE;
ID TYPE;
RUN;

PROC PRINT DATA = CARS_M;
RUN;
```

**The SAS System**

|  Obs |          Make | _NAME_ |  ID_SUV | ID_Sedan | ID_Sports | ID_Wagon | ID_Truck | ID_Hybrid |
| ---: | ------------: | -----: | ------: | -------: | --------: | -------: | -------: | --------: |
|    1 |         Acura |   MSRP | $36,945 |  $23,820 |   $89,765 |        . |        . |         . |
|    2 |          Audi |   MSRP |       . |  $25,940 |   $84,600 |  $40,840 |        . |         . |
|    3 |           BMW |   MSRP | $37,000 |  $28,495 |   $48,195 |  $32,845 |        . |         . |
|    4 |         Buick |   MSRP | $37,895 |  $22,180 |         . |        . |        . |         . |
|    5 |      Cadillac |   MSRP | $52,795 |  $30,835 |   $76,200 |        . |  $52,975 |         . |
|    6 |     Chevrolet |   MSRP | $42,735 |  $11,690 |   $44,535 |  $22,225 |  $36,100 |         . |
|    7 |      Chrysler |   MSRP |       . |  $17,985 |   $34,495 |  $31,230 |        . |         . |
|    8 |         Dodge |   MSRP | $32,235 |  $13,670 |   $81,795 |        . |  $17,630 |         . |
|    9 |          Ford |   MSRP | $41,475 |  $13,270 |   $18,345 |  $17,475 |  $22,010 |         . |
|   10 |           GMC |   MSRP | $31,890 |  $25,640 |         . |        . |  $16,530 |         . |
|   11 |         Honda |   MSRP | $27,560 |  $13,270 |   $33,260 |        . |        . |   $20,140 |
|   12 |        Hummer |   MSRP | $49,995 |        . |         . |        . |        . |         . |
|   13 |       Hyundai |   MSRP | $21,589 |  $10,539 |   $18,739 |        . |        . |         . |
|   14 |      Infiniti |   MSRP |       . |  $28,495 |         . |  $34,895 |        . |         . |
|   15 |         Isuzu |   MSRP | $31,849 |        . |         . |        . |        . |         . |
|   16 |        Jaguar |   MSRP |       . |  $29,995 |   $69,995 |        . |        . |         . |
|   17 |          Jeep |   MSRP | $27,905 |        . |         . |        . |        . |         . |
|   18 |           Kia |   MSRP | $19,635 |  $16,040 |         . |  $11,905 |        . |         . |
|   19 |    Land Rover |   MSRP | $72,250 |        . |         . |        . |        . |         . |
|   20 |         Lexus |   MSRP | $45,700 |  $32,350 |   $63,200 |  $32,455 |        . |         . |
|   21 |       Lincoln |   MSRP | $52,775 |  $32,495 |         . |        . |        . |         . |
|   22 |          MINI |   MSRP |       . |  $16,999 |         . |        . |        . |         . |
|   23 |         Mazda |   MSRP | $21,087 |  $15,500 |   $22,388 |        . |  $14,840 |         . |
|   24 | Mercedes-Benz |   MSRP | $76,870 |  $26,060 |   $90,520 |  $33,780 |        . |         . |
|   25 |       Mercury |   MSRP | $29,995 |  $21,595 |         . |  $22,595 |        . |         . |
|   26 |    Mitsubishi |   MSRP | $30,492 |  $14,622 |   $25,092 |  $17,495 |        . |         . |
|   27 |        Nissan |   MSRP | $33,840 |  $12,740 |   $26,910 |  $28,739 |  $19,479 |         . |
|   28 |    Oldsmobile |   MSRP |       . |  $18,825 |         . |        . |        . |         . |
|   29 |       Pontiac |   MSRP | $21,595 |  $15,495 |   $33,500 |  $17,045 |        . |         . |
|   30 |       Porsche |   MSRP | $56,665 |        . |   $79,165 |        . |        . |         . |
|   31 |          Saab |   MSRP |       . |  $30,860 |         . |  $40,845 |        . |         . |
|   32 |        Saturn |   MSRP | $20,585 |  $10,995 |         . |  $23,560 |        . |         . |
|   33 |         Scion |   MSRP |       . |  $12,965 |         . |  $14,165 |        . |         . |
|   34 |        Subaru |   MSRP |       . |  $19,945 |   $25,045 |  $21,445 |  $24,520 |         . |
|   35 |        Suzuki |   MSRP | $23,699 |  $12,884 |         . |  $16,497 |        . |         . |
|   36 |        Toyota |   MSRP | $35,695 |  $14,085 |   $22,570 |  $16,695 |  $12,800 |   $20,510 |
|   37 |    Volkswagen |   MSRP | $35,515 |  $18,715 |         . |  $19,005 |        . |         . |
|   38 |         Volvo |   MSRP | $41,250 |  $25,135 |         . |  $26,135 |        . |         . |

#### PROC SURVEYSELECT

(1)基本形式:

PROC SURVEYSELECT DATA = METHOD = N = ;RUN;

PROC SURVEYSELECT DATA = METHOD = SAMPRATE = ;RUN;

实现对数据的随机抽样；

(2)常用选项:

METHOD：随机抽样的方法

**SRS（Simple Random Sampling，不放回简单随机抽样）；**

**URS（Unrestricted Random Sampling，放回简单随机抽样）；**

**SYS（Systematic Sampling，系统抽样）；**

SEED：随机种子数，随机数产生器；

非负整数，若为0则以当前时间作为当前随机中子数，则可实现每次抽取的样本不同；

若取大于0的整数，则下次抽样时若输入相同值即可得到相同的样本；

```SAS
/* PROC SURVEYSELECT */
PROC SURVEYSELECT 
    DATA = CARS_MAMS METHOD = SRS N = 3 
    OUT = CARS_SRS_N3;
RUN;

PROC PRINT DATA = CARS_SRS_N3;
RUN;
```

**The SAS System**

The SURVEYSELECT Procedure

| Selection Method | Simple Random Sampling |
| ---------------: | ---------------------- |
|                  |                        |

|        Input Data Set | CARS_MAMS   |
| --------------------: | ----------- |
|    Random Number Seed | 286169112   |
|           Sample Size | 3           |
| Selection Probability | 0.007009    |
|       Sampling Weight | 142.66667   |
|       Output Data Set | CARS_SRS_N3 |

------

**The SAS System**

|  Obs |   Make |  Type |    MSRP |
| ---: | -----: | ----: | ------: |
|    1 |  Honda |   SUV | $19,860 |
|    2 |    Kia | Sedan | $12,360 |
|    3 | Subaru | Wagon | $21,445 |

```SAS
PROC SURVEYSELECT 
    DATA = CARS_MAMS METHOD = SRS SAMPRATE = 0.01 
    OUT = CARS_SRS_P1;
RUN;

PROC PRINT DATA = CARS_SRS_P1;
RUN;
```

**The SAS System**

The SURVEYSELECT Procedure

| Selection Method | Simple Random Sampling |
| ---------------: | ---------------------- |
|                  |                        |

|        Input Data Set | CARS_MAMS   |
| --------------------: | ----------- |
|    Random Number Seed | 325312536   |
|         Sampling Rate | 0.01        |
|           Sample Size | 5           |
| Selection Probability | 0.011682    |
|       Sampling Weight | 85.6        |
|       Output Data Set | CARS_SRS_P1 |

------

**The SAS System**

|  Obs |          Make |  Type |    MSRP |
| ---: | ------------: | ----: | ------: |
|    1 |         Dodge | Sedan | $21,795 |
|    2 | Mercedes-Benz | Sedan | $33,480 |
|    3 |       Mercury |   SUV | $29,995 |
|    4 |    Mitsubishi |   SUV | $33,112 |
|    5 |        Subaru | Sedan | $25,645 |

```SAS
PROC SURVEYSELECT 
    DATA = CARS_MAMS METHOD = SRS SAMPRATE = 0.01 
    OUT = CARS_SRS_N1;
STRATA MAKE;
RUN;

PROC PRINT DATA = CARS_SRS_N1;
RUN;
```

**The SAS System**

The SURVEYSELECT Procedure

| Selection Method | Simple Random Sampling |
| ---------------: | ---------------------- |
|  Strata Variable | Make                   |

|        Input Data Set | CARS_MAMS   |
| --------------------: | ----------- |
|    Random Number Seed | 312152788   |
| Stratum Sampling Rate | 0.1         |
|      Number of Strata | 38          |
|     Total Sample Size | 62          |
|       Output Data Set | CARS_SRS_N1 |

------

**The SAS System**

|  Obs |          Make |   Type |     MSRP | SelectionProb | SamplingWeight |
| ---: | ------------: | -----: | -------: | ------------: | -------------: |
|    1 |         Acura |  Sedan |  $43,755 |       0.14286 |         7.0000 |
|    2 |          Audi |  Sedan |  $34,480 |       0.10526 |         9.5000 |
|    3 |          Audi | Sports |  $84,600 |       0.10526 |         9.5000 |
|    4 |           BMW |  Sedan |  $69,195 |       0.10000 |        10.0000 |
|    5 |           BMW | Sports |  $33,895 |       0.10000 |        10.0000 |
|    6 |         Buick |  Sedan |  $28,345 |       0.11111 |         9.0000 |
|    7 |      Cadillac |  Truck |  $52,975 |       0.12500 |         8.0000 |
|    8 |     Chevrolet |  Sedan |  $14,610 |       0.11111 |         9.0000 |
|    9 |     Chevrolet |  Sedan |  $20,370 |       0.11111 |         9.0000 |
|   10 |     Chevrolet |  Sedan |  $25,000 |       0.11111 |         9.0000 |
|   11 |      Chrysler | Sports |  $34,495 |       0.13333 |         7.5000 |
|   12 |      Chrysler |  Wagon |  $31,230 |       0.13333 |         7.5000 |
|   13 |         Dodge |  Sedan |  $24,885 |       0.15385 |         6.5000 |
|   14 |         Dodge |  Truck |  $20,215 |       0.15385 |         6.5000 |
|   15 |          Ford |  Sedan |  $19,135 |       0.13043 |         7.6667 |
|   16 |          Ford |  Sedan |  $30,315 |       0.13043 |         7.6667 |
|   17 |          Ford | Sports |  $29,380 |       0.13043 |         7.6667 |
|   18 |           GMC |  Truck |  $29,322 |       0.12500 |         8.0000 |
|   19 |         Honda |    SUV |  $19,860 |       0.11765 |         8.5000 |
|   20 |         Honda |    SUV |  $18,690 |       0.11765 |         8.5000 |
|   21 |        Hummer |    SUV |  $49,995 |       1.00000 |         1.0000 |
|   22 |       Hyundai |  Sedan |  $15,389 |       0.16667 |         6.0000 |
|   23 |       Hyundai |  Sedan |  $20,339 |       0.16667 |         6.0000 |
|   24 |      Infiniti |  Sedan |  $29,795 |       0.12500 |         8.0000 |
|   25 |         Isuzu |    SUV |  $31,849 |       0.50000 |         2.0000 |
|   26 |        Jaguar |  Sedan |  $74,995 |       0.16667 |         6.0000 |
|   27 |        Jaguar | Sports |  $69,995 |       0.16667 |         6.0000 |
|   28 |          Jeep |    SUV |  $20,130 |       0.33333 |         3.0000 |
|   29 |           Kia |  Sedan |  $26,000 |       0.18182 |         5.5000 |
|   30 |           Kia |  Wagon |  $11,905 |       0.18182 |         5.5000 |
|   31 |    Land Rover |    SUV |  $72,250 |       0.33333 |         3.0000 |
|   32 |         Lexus |    SUV |  $64,800 |       0.18182 |         5.5000 |
|   33 |         Lexus |    SUV |  $39,195 |       0.18182 |         5.5000 |
|   34 |       Lincoln |  Sedan |  $44,925 |       0.11111 |         9.0000 |
|   35 |          MINI |  Sedan |  $16,999 |       0.50000 |         2.0000 |
|   36 |         Mazda | Sports |  $25,193 |       0.18182 |         5.5000 |
|   37 |         Mazda | Sports |  $25,700 |       0.18182 |         5.5000 |
|   38 | Mercedes-Benz |  Sedan |  $37,630 |       0.11538 |         8.6667 |
|   39 | Mercedes-Benz |  Sedan |  $52,120 |       0.11538 |         8.6667 |
|   40 | Mercedes-Benz |  Wagon |  $33,780 |       0.11538 |         8.6667 |
|   41 |       Mercury |  Sedan |  $21,595 |       0.11111 |         9.0000 |
|   42 |    Mitsubishi |  Sedan |  $25,700 |       0.15385 |         6.5000 |
|   43 |    Mitsubishi | Sports |  $25,092 |       0.15385 |         6.5000 |
|   44 |        Nissan |    SUV |  $27,339 |       0.11765 |         8.5000 |
|   45 |        Nissan |  Sedan |  $32,780 |       0.11765 |         8.5000 |
|   46 |    Oldsmobile |  Sedan |  $28,790 |       0.33333 |         3.0000 |
|   47 |       Pontiac |  Sedan |  $15,495 |       0.18182 |         5.5000 |
|   48 |       Pontiac |  Sedan |  $24,295 |       0.18182 |         5.5000 |
|   49 |       Porsche | Sports | $192,465 |       0.14286 |         7.0000 |
|   50 |          Saab |  Sedan |  $40,670 |       0.14286 |         7.0000 |
|   51 |        Saturn |  Sedan |  $15,825 |       0.12500 |         8.0000 |
|   52 |         Scion |  Sedan |  $12,965 |       0.50000 |         2.0000 |
|   53 |        Subaru |  Sedan |  $29,345 |       0.18182 |         5.5000 |
|   54 |        Subaru |  Wagon |  $21,445 |       0.18182 |         5.5000 |
|   55 |        Suzuki |    SUV |  $17,163 |       0.12500 |         8.0000 |
|   56 |        Toyota |    SUV |  $54,765 |       0.10714 |         9.3333 |
|   57 |        Toyota |  Sedan |  $11,560 |       0.10714 |         9.3333 |
|   58 |        Toyota |  Sedan |  $11,290 |       0.10714 |         9.3333 |
|   59 |    Volkswagen |  Sedan |  $18,715 |       0.13333 |         7.5000 |
|   60 |    Volkswagen |  Sedan |  $21,055 |       0.13333 |         7.5000 |
|   61 |         Volvo |  Sedan |  $31,745 |       0.16667 |         6.0000 |
|   62 |         Volvo |  Sedan |  $34,845 |       0.16667 |         6.0000 |