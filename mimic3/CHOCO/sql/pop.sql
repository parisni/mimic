-- récupérer 2 critères ; sert à récupérer variables ; à affiner avec dates (requetes suivantes)
SELECT SUBJECT_ID, HADM_ID, ICUSTAY_ID, to_char(icustay_intime,'YYYY-MM-DD HH24:MI:SS'), max(CRIT_1) as CRIT_1, max(CRIT_2) as CRIT_2
FROM 
"MIMIC2V26"."icustay_detail" dd,

(
    SELECT  
    "poe_order"."SUBJECT_ID", "poe_order"."HADM_ID", "ICUSTAY_ID", 1 as CRIT_1, 0 as CRIT_2
    from "MIMIC2V26"."icd9",
    "MIMIC2V26"."poe_order"
    WHERE 
    "poe_order"."HADM_ID" = "icd9"."HADM_ID"
    AND
    code IN ('785.52','995.92')

    UNION

    select 
    "SUBJECT_ID",
    "HADM_ID", "ICUSTAY_ID", 0 as CRIT_1, 1 as CRIT_2
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
WHERE ICUSTAY_ID NOT LIKE  '?'
AND dd.ICUSTAY_TIME = tabl.ICUSTAY_TIME
GROUP BY SUBJECT_ID, HADM_ID, ICUSTAY_ID


-- affinage 1

select 
"SUBJECT_ID",
"HADM_ID", 
to_char("START_DT",'YYYY-MM-DD HH24:MI:SS') as START_DT,
to_char("STOP_DT",'YYYY-MM-DD HH24:MI:SS') as STOP_DT
from "MIMIC2V26"."poe_med" p, "MIMIC2V26"."poe_order" d
WHERE 
p.poe_id = d.poe_id 
AND (
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
AND (SUBJECT_ID, HADM_ID) IN (SELECT SUBJECT_ID, HADM_ID 
    FROM "MIMIC2V26"."poe_med" p, "MIMIC2V26"."poe_order" d
    WHERE 
    drug_name LIKE '%phrine%')

-- affinage 2

select "HADM_ID", 
to_char("START_DT",'YYYY-MM-DD HH24:MI:SS') as START_DT, 
to_char("STOP_DT",'YYYY-MM-DD HH24:MI:SS') as STOP_DT
from "MIMIC2V26"."poe_med" p, "MIMIC2V26"."poe_order" d
WHERE 
p.poe_id = d.poe_id 
AND 
drug_name LIKE '%phrine%'
AND (SUBJECT_ID, HADM_ID) IN (SELECT SUBJECT_ID, HADM_ID 
    FROM "MIMIC2V26"."poe_med" p, "MIMIC2V26"."poe_order" d
    WHERE 
    (
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
)

-- récupérer commorbidités
select 
"SUBJECT_ID",
"HADM_ID",
CONGESTIVE_HEART_FAILURE,
CARDIAC_ARRHYTHMIAS,
HYPERTENSION,
CHRONIC_PULMONARY,
DIABETES_UNCOMPLICATED,
DIABETES_COMPLICATED,
RENAL_FAILURE,
LIVER_DISEASE,
AIDS,
METASTATIC_CANCER
from "MIMIC2V26"."comorbidity_scores" 
WHERE (subject_id, hadm_id) IN (SELECT SUBJECT_ID, HADM_ID
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
    GROUP BY SUBJECT_ID, HADM_ID)

-- récupérer dates
select 
"ICUSTAY_ID",
"SUBJECT_ID",
"GENDER",
to_char("DOB",'YYYY-MM-DD HH24:MI:SS'),
to_char("DOD",'YYYY-MM-DD HH24:MI:SS'),
"EXPIRE_FLG",
"HOSPITAL_EXPIRE_FLG",
"SOFA_FIRST",
"SOFA_MIN",
"SOFA_MAX"
from "MIMIC2V26"."icustay_detail" 
WHERE
(SUBJECT_ID,  ICUSTAY_ID) IN (
    SELECT SUBJECT_ID, ICUSTAY_ID
    FROM (
        SELECT  
        "poe_order"."SUBJECT_ID", "poe_order"."HADM_ID", "ICUSTAY_ID", 1 as CRIT_1, 0 as CRIT_2
        from "MIMIC2V26"."icd9",
        "MIMIC2V26"."poe_order"
        WHERE 
        "poe_order"."HADM_ID" = "icd9"."HADM_ID"
        AND
        code IN ('785.52','995.92')

        UNION

        select 
        "SUBJECT_ID",
        "HADM_ID", "ICUSTAY_ID", 0 as CRIT_1, 1 as CRIT_2
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
    WHERE ICUSTAY_ID NOT LIKE  '?'
    GROUP BY SUBJECT_ID, HADM_ID, ICUSTAY_ID
)
-- récupérer les 24 premieres heures de fréquence cardiaque

SELECT dd.icustay_id as ICUSTAY_ID, avg(TO_DOUBLE(FC.value1))
FROM
"MIMIC2V26"."icustay_detail" dd,
(select 
    "SUBJECT_ID",
    "ICUSTAY_ID",
    "ITEMID",
    "CHARTTIME",
    "ELEMID",
    "REALTIME",
    "CGID",
    "CUID",
    "VALUE1",
    "VALUE1NUM",
    "VALUE1UOM"
    from "MIMIC2V26"."chartevents"
    WHERE ITEMID = 211
    AND 
    (SUBJECT_ID,  ICUSTAY_ID) IN (
        SELECT SUBJECT_ID, ICUSTAY_ID
        FROM (
            SELECT  
            "poe_order"."SUBJECT_ID", "poe_order"."HADM_ID", "ICUSTAY_ID", 1 as CRIT_1, 0 as CRIT_2
            from "MIMIC2V26"."icd9",
            "MIMIC2V26"."poe_order"
            WHERE 
            "poe_order"."HADM_ID" = "icd9"."HADM_ID"
            AND
            code IN ('785.52','995.92')

            UNION

            select 
            "SUBJECT_ID",
            "HADM_ID", "ICUSTAY_ID", 0 as CRIT_1, 1 as CRIT_2
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
        WHERE ICUSTAY_ID NOT LIKE  '?'
        GROUP BY SUBJECT_ID, HADM_ID, ICUSTAY_ID

    )
) AS FC
WHERE FC.icustay_id = dd.icustay_id
AND
DAYS_BETWEEN (icustay_intime , realtime ) <= 1
GROUP BY dd.icustay_id

-- champs text

select 
"ICUSTAY_ID",
concat('"',concat("TEXT",'"'))
from "MIMIC2V26"."noteevents"
WHERE (ICUSTAY_ID) IN (
    SELECT ICUSTAY_ID
    FROM (
        SELECT  
        "ICUSTAY_ID"
        from "MIMIC2V26"."icd9",
        "MIMIC2V26"."poe_order"
        WHERE 
        "poe_order"."HADM_ID" = "icd9"."HADM_ID"
        AND
        code IN ('785.52','995.92')

        UNION

        select 
        "ICUSTAY_ID"
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
    WHERE ICUSTAY_ID NOT LIKE  '?'
    GROUP BY ICUSTAY_ID
)
AND "CATEGORY" LIKE 'DISCHARGE_SUMMARY'


--  test

