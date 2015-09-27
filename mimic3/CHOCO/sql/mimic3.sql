SELECT drug_name_poe, count(1) FROM prescriptions where drug_name_generic ilike '%epi%' GROUP BY drug_name_generic ORDER BY count DESC;


-- VASO
CREATE UNLOGGED TABLE ids_vaso(
    subject_id integer,
    hadm_id integer,
    icustay_id integer
);
CREATE INDEX ON ids_vaso (subject_id, hadm_id, icustay_id);
TRUNCATE ids_vaso;
INSERT INTO ids_vaso (subject_id,hadm_id, icustay_id) (SELECT distinct ioevents.subject_id, ioevents.hadm_id, ioevents.icustay_id 
    FROM ioevents, icustayevents
    WHERE 
    ioevents.icustay_id = icustayevents.icustay_id AND
    ioevents.starttime BETWEEN icustayevents.intime AND icustayevents.intime + '1 day' AND
    ioevents.ITEMID IN (select  itemid 
        from d_items 
        where lower(label) like '%evophed%' or lower(label) like '%pressin%' or lower(label) like '%ephrin%') 
);


--antibio
CREATE UNLOGGED TABLE ids_antibio(
    subject_id integer,
    hadm_id integer,
    icustay_id integer
);
CREATE INDEX ON ids_antibio (subject_id, hadm_id, icustay_id);
TRUNCATE ids_antibio;
INSERT INTO ids_antibio (subject_id,hadm_id, icustay_id) (
    SELECT distinct ioevents.subject_id, ioevents.hadm_id, ioevents.icustay_id 
    FROM ioevents, icustayevents
    WHERE 
    ioevents.icustay_id = icustayevents.icustay_id AND
    ioevents.starttime BETWEEN icustayevents.intime AND icustayevents.intime + '1 day' AND
    ioevents.ITEMID IN (
        select  itemid 
        from d_items 
        where label ILIKE '%cillin%' OR label ILIKE '%icill%' OR label ILIKE '%bactam%' OR label ILIKE '%andol%' OR label ILIKE '%cef%' OR label ILIKE '%ceph%' OR label ILIKE '%clavu%' OR label ILIKE '%penem%' OR label ILIKE '%nam%' OR label ILIKE '%lactam%' OR label ILIKE '%amika%' OR label ILIKE '%genta%' OR label ILIKE '%flox%' OR label ILIKE '%amycin%' OR label ILIKE '%omycin%' 
    )
);

-- SEPSIS ANGUS 2001
CREATE UNLOGGED TABLE ids_angus (
    subject_id integer,
    hadm_id integer
);
CREATE INDEX ON ids_angus (subject_id, hadm_id, icustay_id);
TRUNCATE TABLE ids_angus;
INSERT INTO ids_angus (subject_id,hadm_id) (
    with infectionPopulation as ( --ALL INFECTION CODES ACCORDING TO ANGUS (documentée ou suspectée ~ ANGUS_2013)
        SELECT    h.subject_ID,
        h.hadm_id   
        FROM admissions h, 
        diagnoses_icd code
        WHERE code.SUBJECT_ID = h.SUBJECT_ID 
        and ( substr( code.icd9_code , 1 , 3 ) in (  
                '001' -- Cholera; 
                ,  '002'  --Typhoid/paratyphoid fever; 
                , '003'  --Other salmonella infection; 
                , '004'  --Shigellosis; 
                , '005'  --Other foodpoisoning; 
                , '008'  --Intestinal infection nototherwise classiÞed;
                , '009'  -- Ill-deÞned intestinal infection; 
                , '010'  --Primary tuberculosis infection; 
                , '011'  --Pulmonary tuberculosis; 
                , '012'  --Other respiratory tuberculosis;
                , '013'  --Central nervous system tuberculosis; 
                , '014'  --Intestinal tuberculosis; 
                , '015'  --Tuberculosis of bone or joint; 
                , '016'  --Genitourinary tuberculosis; 
                , '017'  --Tuberculosisnot otherwise classiÞed; 
                , '018'  --Miliary tuberculosis; 
                , '020'  --Plague; 
                , '021'  --Tularemia;
                , '022'  --Anthrax; 
                , '023'  --Brucellosis; 
                , '024'  --Glorers; 
                , '025'  --Melioidosis; 
                , '026'  --Rat-bite fever;
                , '027'  --Other bacterial zoonoses; 
                , '030'  --Leprosy; 
                , '031'  --Other mycobacterial disease;
                , '032'  --Diphtheria; 
                , '033'  --Whooping cough;
                , '034'  --Streptococcal throat/scarlet fever;
                , '035'  --Erysipelas; 
                , '036'  --Meningococcal infection; 
                , '037'  --Tetanus; 
                , '038'  --Septicemia;
                , '039'  --Actinomycotic infections; 
                , '040'  --Other bacterial diseases; 
                , '041'  --Bacterial infectionin other diseases not otherwise speciÞed;
                , '090'  --Congenital syphilis; 
                , '091'  --Earlysymptomatic syphilis; 
                , '092'  --Early syphilislatent; 
                , '093'  --Cardiovascular syphilis; 
                , '094' --Neurosyphilis; 
                , '095'  --Other late symptomatic syphilis; 
                , '096'  --Late syphilis latent;
                , '097'  --Other and unspeciÞed syphilis; 
                , '098' --Gonococcal infections; 
                , '100'  --Leptospirosis; 
                , '101'  --VincentÕs angina; 
                , '102'  --Yaws; 
                , '103' --Pinta; 
                , '104'  --Other spirochetal infection;
                , '110' -- Dermatophytosis; 
                , '111'  --Dermatomycosis not otherwise classiÞed or speciÞed;
                , '112' -- Coridiasis; 
                , '114'  --Coccidioidomycosis; 
                , '115' -- Histoplasmosis; 
                , '116'  --Blastomycotic infection; 
                , '117'  --Other mycoses; 
                , '118' --Opportunistic mycoses; 
                , '320'  --Bacterialmeningitis; 
                , '322'  --Meningitis  unspeciÞed;
                , '324'  --Central nervous system abscess; 
                , '325' --Phlebitis of intracranial sinus; 
                , '420'  --Acutepericarditis; 
                , '421'  --Acute or subacute endocarditis; 
                , '451'  --Thrombophlebitis;
                , '461' --Acute sinusitis;
                , '462'  --Acute pharyngitis;
                , '463' -- Acute tonsillitis; 
                , '464'  --Acute laryngitis/tracheitis;
                , '465'  --Acute upper respiratory infection of multiple sites/not otherwisespeciÞe d ; 
                , '481' --  P n e umo c o c c a lpneumonia; 
                , '482'  --Other bacterial pneumonia; 
                , '485'  --Bronchopneumonia with organism not otherwise speciÞed; 
                , '486' --Pneumonia  organism not otherwisespeciÞed; 
                , '494' --Bronchiectasis; 
                , '510'  --Empyema; 
                , '513' --Lung/mediastinum abscess; 
                , '540'  --Acuteappendicitis; 
                , '541'  --Appendicitis not otherwise speciÞed; 
                , '542'  --Other appendicitis;
                , '566'  --Anal or rectal abscess; 
                , '567'  --Peritonitis; 
                , '590'  --Kidney infection; 
                , '597'  --Urethritis/urethral syndrome; 
                , '601' --Prostatic inßammation;
                , '614'  --Female pelvic inßammation disease; 
                , '615'  --Uterine in-ßammatory disease; 
                , '616'  --Other femalegenital inßammation;
                , '681'  --Cellulitis  Þnger/toe; 
                , '682'  --Other cellulitis or abscess;
                , '683'  --Acute lymphadenitis;
                , '686'  --Other local skin infection; 
                , '730'  --Osteomyelitis; 
            )
            or substr( code.icd9_code , 1, 6) in (       
                '491.21' -- Acute exacerbation ofobstructive chronic bronchitis; 
                , '562.01' -- Diverticulitis of small intestinewithout hemorrhage; 
                , '562.03'  --Diverticulitis of small intestine with hemorrhage;
                , '562.11'  --Diverticulitis of colon withouthemorrhage; 
                , '562.13'  --Diverticulitis of colon with hemorrhage; 
                , '569.83' -- Perforation ofintestine; 
            )
            or substr( code.icd9_code , 1, 5) in (       
                '569.5' -- Intestinal abscess; 
                , '572.0'  --Abscess of liver; 
                , '572.1' --Portal pyemia;
                , '575.0'  --Acute cholecystitis;
                , '599.0'  --Urinary tractinfection not otherwise speciÞed; 
                , '711.0'  --Pyogenic arthritis; 
                , '790.7'  --Bacteremia; 
                , '996.6'  --Infection or inßammation ofdevice/graft; 
                , '998.5'  --Postoperative infection; 
                , '999.3'  --Infectious complication ofmedical care not otherwise classiÞed. 
            )
        )  
    )
    , anguspopulation as (
        SELECT    h.subject_ID,
        h.hadm_id   
        FROM infectionPopulation h, 
        diagnoses_icd code
        WHERE code.SUBJECT_ID = h.SUBJECT_ID     -- INFECTION + ORGAN FAILURE
        AND ( code.icd9_code like '785.5%' -- Cardiovascular Shock without trauma
            or code.icd9_code like '458%' -- Hypotension
            or code.icd9_code like '348.3%' -- Neurologic Encephalopathy 
            or code.icd9_code like '293%' -- Transient organic psychosis 
            or code.icd9_code like '348.1%' -- Anoxic brain damage 
            or code.icd9_code like '287.4%' -- Hematologic Secondary thrombocytopenia 
            or code.icd9_code like '287.5%' -- Thrombocytopenia, unspeciÞed
            or code.icd9_code like '286.9%' -- Other/unspeciÞed coagulation defect
            or code.icd9_code like '286.6%' -- DeÞbrination syndrome
            or code.icd9_code like '570%' -- Hepatic Acute and subacute necrosis of liver
            or code.icd9_code like '573.4%' -- Hepatic infarction
            or code.icd9_code like '584%' -- Renal Acute renal failure 
        ) 
        union     -- JOIN WITH MECH VENT+INFECTION patients
        SELECT    ip.hadm_id, 
        ip.subject_ID
        FROM infectionPopulation ip,
        procedures_icd code
        WHERE   ip.subject_id = code.subject_id 
        and ip.hadm_id = code.hadm_id         
        AND   code. icd9_code in (  '101729', -- NON Invasive Respiratory Mechanical ventilation
            '101781', -- Invasive Respiratory Mechanical ventilation
            '101782',  -- Invasive Respiratory Mechanical ventilation
            '101783') -- Invasive Respiratory Mechanical ventilation

    )

    select distinct subject_id, hadm_id
    from anguspopulation
)
;

-- BETA BLOQUANTS
SELECT * FROM noteevents WHERE category ILIKE 'DISCHARGE';

-- SERVICES
SELECT * FROM transfers;

