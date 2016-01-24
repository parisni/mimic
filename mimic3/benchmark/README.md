All tests have been made on chartevents (297938224 tuples)
32 GO ram, 8 core, Ubuntu
postgresql 9.4;MonetDB 5.1;apache Drill 1.4; 
Query 1 = SELECT AVG(valuenum), itemid FROM mimiciii.chartevents  where itemid < 5000 GROUP BY itemid;
Query 2 = SELECT AVG(valuenum) FROM mimiciii.chartevents  where itemid = 5000
Query 3 = SELECT AVG(valuenum), itemid FROM mimiciii.chartevents  where itemid < 100000 GROUP BY itemid;
Query 4 = SELECT AVG(valuenum), itemid FROM mimiciii.chartevents  GROUP BY itemid

=Postgresql=

* Query 1
4 min 40

* Query 2
1 ms

* Query 3
4 min 30

* Query 4
4 min 30


=Postgresql partitioned 10 times=

* Query 1
2 min 30

* Query 2
1 ms

* Query 3
3 min

* Query 4
5min


=MonetDB=

* Query 1
22 seconds

* Query 2
1 ms

* Query 3
5 seconds

* Query 4
3 seconds


=Apache Drill=

* Query 1
19 seconds

* Query 2
6 seconds

* Query 3
21 seconds

* Query 4
17 seconds

=Conclusion=

* Not surprisingly, Postgresql partitionned & not partitionned has same results for fetching small amount of rows (query 2). btree Index complexity are O(log(n)).
Moreover, when fetching more rows, seq scan are used over the whole table. This leads partitionned table to have performances increased in query 1 and 3. However query 4 use whole rows then it scans all partitionned table as well. This leads same performances in this case and maybe counter productive results because of number of table to scan in partitionned way.
* MonetDB get the best results in most queries.(index & seq scans)
* Apache drill unlike others has no need to cache table; this means performances are stable. Moreover it is designed for distributed queries. Tests need to be done on a drill computer cluster


For now, MonetDB looks like the best solution mimic, involving a modest server configuration, and no computer cluster needs. It has no need for indexing, and is open source. However, there still is a problem with mimic dates format that need to be formated like 'yyyy-MM-dd HH:mm:ss'. For now they are considered as strings in monetDB. Problems have been found within some values like '\256' that made crash the bulk load. sed -i 's/\\//g' table.csv was used. Interestingly monetDB is very simple to install ; it has no need to update configuration for performance tuning. Indexes are created automatically.

Next step is testing postgresql clustered indexes & testing JOIN queries and drill cluster. Loading time will be taken in consideration too, as well as table volumetry. An interesting aspect can also be testing many users querying same time.
