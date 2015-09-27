-- micro
COPY (with esbl as (SELECT subject_id, hadm_id, text FROM noteevents WHERE category ILIKE 'DISCHARGE' AND text ~* 'esbl')
SELECT *
FROM microbiologyevents m 
WHERE (subject_id, hadm_id) IN ( SELECT subject_id, hadm_id FROM esbl)) TO '/tmp/esbl_micro.csv' CSV HEADER;

-- medoc
COPY (with esbl as (SELECT subject_id, hadm_id, text FROM noteevents WHERE category ILIKE 'DISCHARGE' AND text ~* 'esbl')
SELECT *
FROM ioevents m
LEFT JOIN d_items  i ON i.itemid = m.itemid
WHERE (subject_id, hadm_id) IN ( SELECT subject_id, hadm_id FROM esbl)) TO '/tmp/esbl_medoc.csv' CSV HEADER;

-- cpt rendus
COPY (SELECT * FROM noteevents WHERE category ILIKE 'DISCHARGE' AND text ~* 'esbl') TO '/tmp/esbl_courrier.csv' CSV HEADER ;

-- d_items
COPY ( SELECT *
FROM d_items ) TO '/tmp/dico.csv' CSV HEADER;
