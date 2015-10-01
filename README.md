# mimic

sql modified from various repos



--------------------------------------------------------------------------------------
# Partitionning on chartevents

## zoom 1
```
 bucket |      range      |   freq    |              bar               
--------+-----------------+-----------+--------------------------------
      1 | [1,8556)        | 225368823 | ******************************
      9 | [220045,228393) |  72568805 | **********
     10 | [228444,228445) |       596 | 

```
## zoom 2
```
 bucket |    range    |   freq    |              bar               
--------+-------------+-----------+--------------------------------
      1 | [1,947)     | 132071498 | ******************************
      2 | [956,1901)  |  16339179 | ****
      3 | [1903,2853) |    185447 | 
      4 | [2854,3803) |  35236472 | ********
      5 | [3803,4754) |    617580 | 
      6 | [4755,5704) |     69320 | 
      7 | [5704,6654) |  10194505 | **
      8 | [6655,7603) |    113335 | 
      9 | [7606,8555) |  30522541 | *******
     10 | [8555,8556) |     18946 | 

```

## zoom 3

```
 bucket |   range   |   freq   |              bar               
--------+-----------+----------+--------------------------------
      1 | [1,112)   | 16848854 | ***************
      2 | [112,223) | 32690813 | ******************************
      3 | [223,328) |  5683721 | *****
      4 | [338,444) |  9151309 | ********
      5 | [444,554) | 19133643 | ******************
      6 | [554,665) | 25875602 | ************************
      7 | [665,775) | 14287165 | *************
      8 | [775,862) |  7964779 | *******

```

## Decision about partitionning (see mimic3/R/create_partitionning_chartevents.R)

```
[1] "[1-161["
[2] "[161-428["
[3] "[428-615["
[4] "[615-742["
[5] "[742-3338["
[6] "[3338-3723["
[7] "[3723-8523["
[8] "[8523-220074["
[9] "[220074-223769["
[10] "[223769-228445["
```
