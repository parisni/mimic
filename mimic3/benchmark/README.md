* All tests have been made on chartevents (297938224 tuples)
* 32 GO ram, 8 core, Ubuntu
* postgresql 9.4;MonetDB 5.1;apache Drill 1.4; 

1. Query 1 = SELECT AVG(valuenum), itemid FROM mimiciii.chartevents  where itemid < 5000 GROUP BY itemid;
1. Query 2 = SELECT AVG(valuenum) FROM mimiciii.chartevents  where itemid = 5000
1. Query 3 = SELECT AVG(valuenum), itemid FROM mimiciii.chartevents  where itemid < 100000 GROUP BY itemid;
1. Query 4 = SELECT AVG(valuenum), itemid FROM mimiciii.chartevents  GROUP BY itemid
1. Query 5 = SELECT count(DISTINCT a.subject_id) FROM mimiciii.patients as a JOIN mimiciii.chartevents as b ON a.subject_id = b.subject_id WHERE b.itemid < 5000;

# Postgresql (creation time: ?)

* Query 1
= 4 min 40

* Query 2
= 1 ms

* Query 3
= 4 min 30

* Query 4
= 4 min 30

* Query 5
= 5 min 30

#  Postgresql partitioned 10 times (creation time: ?)

* Query 1
= 2 min 30

* Query 2
= 1 ms

* Query 3
= 3 min

* Query 4
= 5 min

* Query 5
= 4 min

# MonetDB (creation time: ?)

* Query 1
= 22 seconds

* Query 2
= 1 ms

* Query 3
= 5 seconds

* Query 4
= 3 seconds

* Query 5
= 50 seconds

# Apache Drill (creation time: 28 min)

* Query 1
= 19 seconds

* Query 2
= 6 seconds

* Query 3
= 21 seconds

* Query 4
= 17 seconds

* Query 5
= 22 seconds

# Apache Drill - Partitionned by itemid (creation time: 55 min)

* Query 1
= 7 seconds

* Query 2
= 500 ms

* Query 3
= 9 seconds

* Query 4
= 11 seconds

* Query 5
= 14 seconds

# Apache Hive 2 (ORC format)

* Query 1
= 27 seconds

* Query 2
= 12 sexonds

* Query 3
= 23 seconds

* Query 4
= 24 seconds

* Query 5
= 14 seconds

# Conclusion

* Not surprisingly, Postgresql partitionned & not partitionned has same results for fetching small amount of rows (query 2). btree Index complexity are O(log(n)).
Moreover, when fetching more rows, seq scan are used over the whole table. This leads partitionned table to have performances increased in query 1 and 3. However query 4 use whole rows then it scans all partitionned table as well. This leads same performances in this case and maybe counter productive results because of number of table to scan in partitionned way.
* MonetDB get the best results in most queries.(index & seq scans)
* Apache drill unlike others has no need to cache table; this means performances are stable. Moreover it is designed for distributed queries. Tests need to be done on a drill computer cluster


For now, MonetDB looks like the best solution mimic, involving a modest server configuration, and no computer cluster needs. It has no need for indexing, and is open source. However, there still is a problem with mimic dates format that need to be formated like 'yyyy-MM-dd HH:mm:ss'. For now they are considered as strings in monetDB. Problems have been found within some values like '\256' that made crash the bulk load. sed -i 's/\\\\//g' table.csv was used. Interestingly monetDB is very simple to install ; it has no need to update configuration for performance tuning. Indexes are created automatically.




EDIT-1:
Having:
- added a new query 5 containing a JOIN
- tested drill partitionned by itemid (partitionning far much easier to implement than postgresql)


* Query 5 has same kind of results on postgres, partitionning helps a bit.
* MonetDB looks a bit disapointing with JOIN.
* Drill is the best for joining.
* Drill partitionned looks like the best overall solution. Unlike the non-partitionned way, it seems that it has got a caching time for the first query (around 1 min). Moreover, the time needeed to build the table is 2 times longer

Next step is testing postgresql clustered indexes & (testing JOIN) queries and drill cluster. (Loading time will be taken in consideration too), as well as table volumetry. An interesting aspect can also be testing many users querying same time.


EDIT-2:
Having:
- tested on apache hive

Will:
- activate the HIVE LLAP functionality  (~in memory)
