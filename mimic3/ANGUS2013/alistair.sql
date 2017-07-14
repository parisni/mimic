		set search_path = sepsis;
DROP TABLE IF EXISTS hadm_deliberation_severe;
CREATE TABLE hadm_deliberation_severe (
hadm_id integer,
accp integer,
angus integer,
sepsis3 integer
);
INSERT INTO hadm_deliberation_severe
WITH 
accp AS (SELECT distinct hadm_id, 1 as value FROM accp_deliberation WHERE type = 2),
angus AS (SELECT hadm_id, 1 as value FROM angus_deliberation WHERE type = 1),
sepsis3 AS (SELECT hadm_id, 1 as value FROM sepsis3_deliberation WHERE type =1)
SELECT a.hadm_id, coalesce(accp.value,0), coalesce(angus.value,0), coalesce(sepsis3.value,0)
FROM mimiciii.admissions a
LEFT JOIN accp USING (hadm_id)
LEFT JOIN angus USING (hadm_id)
LEFT JOIN sepsis3 USING (hadm_id);


DROP TABLE IF EXISTS hadm_deliberation_shock;
CREATE TABLE hadm_deliberation_shock (
hadm_id integer,
accp integer,
angus integer,
sepsis3 integer
);
INSERT INTO hadm_deliberation_shock
WITH 
accp AS (SELECT distinct hadm_id, 1 as value FROM accp_deliberation WHERE type = 3),
angus AS (SELECT hadm_id, 1 as value FROM angus_deliberation WHERE type = 2),
sepsis3 AS (SELECT hadm_id, 1 as value FROM sepsis3_deliberation WHERE type =2)
SELECT a.hadm_id, coalesce(accp.value,0), coalesce(angus.value,0), coalesce(sepsis3.value,0)
FROM mimiciii.admissions a
LEFT JOIN accp USING (hadm_id)
LEFT JOIN angus USING (hadm_id)
LEFT JOIN sepsis3 USING (hadm_id);
