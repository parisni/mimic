-- DELIBERATION (SHOCK > SEVERE > SIMPLE)
DROP TABLE accp_deliberation;
CREATE UNLOGGED TABLE accp_deliberation (
hadm_id integer,
type integer
);
INSERT INTO accp_deliberation
WITH tmp AS (
SELECT distinct hadm_id, 1 as type FROM accp_simple
UNION ALL
SELECT distinct hadm_id, 2 as type FROM accp_severe
UNION ALL
SELECT distinct hadm_id, 3 as type FROM accp_shock
)
SELECT hadm_id, max(type) as type
FROM tmp
GROUP BY hadm_id;

