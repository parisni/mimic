
DROP TABLE IF EXISTS simult_approx CASCADE;
CREATE UNLOGGED TABLE simult_approx(
	hadm_id integer,
	charttime timestamp,
	type integer
);
TRUNCATE TABLE simult_approx;
INSERT INTO simult_approx 
SELECT hadm_id, date_trunc('hour', charttime), 1 FROM ch1_general_vars_temp UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 2 FROM ch1_general_vars_hr UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 3 FROM ch1_general_vars_rr UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 4 FROM ch1_general_vars_glasgow UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 5 FROM ch1_general_vars_gly UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 6 FROM ch1_general_vars_fluid UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 7 FROM ch2_infla_vars_wb UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 8 FROM ch2_infla_vars_crp  ;

DROP MATERIALIZED VIEW IF EXISTS tmp_sepsis;
CREATE MATERIALIZED VIEW tmp_sepsis AS 
with 
tmp AS (SELECT distinct hadm_id, charttime + interval '1h' * generate_series as moment, type FROM simult_approx, (SELECT * FROM generate_series(-12,12) ) AS t),
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, moment FROM tmp GROUP BY hadm_id, moment)
SELECT  distinct hadm_id, arr, moment FROM moment WHERE array_length(arr,1) >= 2;
DROP MATERIALIZED VIEW IF EXISTS tmp_lactate;
CREATE MATERIALIZED VIEW tmp_lactate AS 
with 
tmp AS (SELECT distinct hadm_id, charttime + interval '1h' * generate_series as moment, type FROM sepsis.shock_simult_approx, (SELECT * FROM generate_series(-12,12) ) AS t),
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, moment FROM tmp GROUP BY hadm_id, moment)
SELECT  distinct hadm_id, arr, moment FROM moment WHERE  '{1}' && arr AND array_length(arr,1) >= 2;

TRUNCATE TABLE simult_approx;
INSERT INTO simult_approx 
SELECT hadm_id, date_trunc('hour', moment), 1 FROM tmp_sepsis INNER JOIN ch0_infection_pop USING (hadm_id) 
UNION ALL
SELECT hadm_id, date_trunc('hour', moment), 2 FROM tmp_lactate;

DROP MATERIALIZED VIEW IF EXISTS sepsis_shock;
CREATE MATERIALIZED VIEW sepsis_shock AS 
with 
tmp AS (SELECT distinct hadm_id, charttime + interval '1h' * generate_series as moment, type FROM simult_approx, (SELECT * FROM generate_series(-12,12) ) AS t),
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, moment FROM tmp GROUP BY hadm_id, moment)
SELECT  distinct hadm_id, arr, moment FROM moment WHERE array_length(arr,1) >= 2;
