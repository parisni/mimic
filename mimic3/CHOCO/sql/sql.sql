SELECT SUBJECT_ID, HADM_ID, max(CRIT_1) as CRIT_1, max(CRIT_2) as CRIT_2
FROM (
    SELECT  
    "SUBJECT_ID",
    "HADM_ID", 1 as CRIT_1, 0 as CRIT_2
    from "MIMIC2V26"."icd9"
    WHERE code IN ('785.52','995.92')

    UNION

    select 
    "SUBJECT_ID",
    "HADM_ID", 0 as CRIT_1, 1 as CRIT_2
    from "MIMIC2V26"."poe_med" p, "MIMIC2V26"."poe_order" d
    WHERE 
    p.poe_id = d.poe_id 
    AND
    drug_name LIKE '%phrine%'
    AND (SUBJECT_ID, HADM_ID) IN (SELECT SUBJECT_ID, HADM_ID 
        FROM "MIMIC2V26"."poe_med" p, "MIMIC2V26"."poe_order" d
        WHERE 

        drug_name LIKE '%cillin%' OR drug_name 
        LIKE '%icill%' OR drug_name 
        LIKE '%bactam%' OR drug_name
        LIKE '%andol%' OR drug_name
        LIKE '%cef%' OR drug_name
        LIKE '%ceph%' OR drug_name
        LIKE '%clavu%' OR drug_name
        LIKE '%penem%' OR drug_name
        LIKE '%nam%' OR drug_name
        LIKE '%lactam%' OR drug_name
        LIKE '%amika%' OR drug_name
        LIKE '%genta%' OR drug_name
        LIKE '%flox%' OR drug_name
        LIKE '%amycin%' OR drug_name
        LIKE '%omycin%' 
    )
) AS tabl
GROUP BY SUBJECT_ID, HADM_ID
