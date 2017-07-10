set search_path TO 'sepsis';

DROP TABLE IF EXISTS angus_deliberation;
CREATE TABLE angus_deliberation (hadm_id integer);
INSERT INTO angus_deliberation
SELECT distinct hadm_id 
FROM 
(
SELECT distinct hadm_id 
FROM mimiciii.diagnoses_icd 
WHERE icd9_code ~ '^614|^021|^032|^575.0|^681|^016|^026|^094|^599.0|^008|^023|^104|^461|^324|^034|^098|^040|^463|^569.5|^039|^513|^485|^013|^682|^790.7|^027|^541|^111|^117|^009|^030|^015|^481|^562.03|^320|^001|^486|^018|^711.0|^017|^114|^510|^451|^011|^031|^041|^033|^003|^569.83|^024|^572.1|^095|^616|^590|^012|^103|^597|^615|^562.11|^996.6|^091|^572.0|^020|^110|^002|^566|^035|^482|^004|^686|^092|^421|^038|^116|^005|^325|^096|^097|^101|^562.13|^540|^999.3|^567|^465|^093|^542|^462|^494|^036|^090|^322|^025|^022|^100|^491.21|^115|^998.5|^010|^562.01|^102|^037|^464|^420|^118|^730|^014|^112|^601|^683'
INTERSECT
SELECT distinct hadm_id
FROM mimiciii.diagnoses_icd
WHERE icd9_code ~ '^785.5|^458|^96.7|^348.3|^293|^348.1|^287.4|^287.5|^286.9|^286.6|^570|^573.4|^584'
) as tmp;

--sepsis3 deliberation
DROP TABLE IF EXISTS sepsis3_deliberation;
CREATE TABLE sepsis3_deliberation (hadm_id integer);
INSERT INTO sepsis3_deliberation
SELECT distinct hadm_id
FROM ch0_infection_pop
WHERE hadm_id IN (
SELECT distinct hadm_id 
FROM mimiciii.icustays ic
LEFT JOIN mimiciii.mp_sofa so USING (icustay_id)
WHERE sofa_24hours >= 2 );

-- EACH GROUP
DROP TABLE IF EXISTS hadm_deliberation;
CREATE TABLE hadm_deliberation (
hadm_id integer,
accp integer,
angus integer,
sepsis3 integer
);
INSERT INTO hadm_deliberation
WITH 
accp AS (SELECT distinct hadm_id, 1 as value FROM accp_deliberation WHERE type = 2),
angus AS (SELECT hadm_id, 1 as value FROM angus_deliberation),
sepsis3 AS (SELECT hadm_id, 1 as value FROM sepsis3_deliberation)
SELECT a.hadm_id, coalesce(accp.value,0), coalesce(angus.value,0), coalesce(sepsis3.value,0)
FROM mimiciii.admissions a
LEFT JOIN accp USING (hadm_id)
LEFT JOIN angus USING (hadm_id)
LEFT JOIN sepsis3 USING (hadm_id);

