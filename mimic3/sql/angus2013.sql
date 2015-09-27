-- SEPSIS ANGUS 2013
---@author : Paris N, Aboab J

CREATE TABLE ids_angus13 (
    subject_id integer,
    hadm_id integer
);
CREATE INDEX ON ids_angus13 (subject_id, hadm_id);
TRUNCATE TABLE ids_angus13;
INSERT INTO ids_angus13 (subject_id,hadm_id) (
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
    , weightForFluidBalance as(--GENERAL VAR : icu where weight variation up to 2 kg
-- TODO : weight in LBS
        WITH    rows AS
        (
            SELECT subject_id, hadm_id, icustay_id, valuenum, ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn
            FROM    mimiciii.chartevents
            WHERE  itemid IN (763, 3580, 3581, 3582, 3693, 224639, 226512, 226531) 
            AND uom ILIKE 'kg'
        ),
        diff AS (
            SELECT  mc.subject_id, mc.hadm_id, mc.icustay_id, mp.valuenum - mc.valuenum   as diffe, mc.valuenum 
            FROM    rows mc
            JOIN    rows mp
            ON      mc.rn = mp.rn - 1
        ) 
        SELECT DISTINCT subject_id, hadm_id, icustay_id
        FROM diff
        WHERE diffe > 2
    )
    , anguspopulation as (
        SELECT    h.subject_ID,
        h.hadm_id,
        h.icustay_id
        FROM infectionPopulation h, 
        chartevents ce
        WHERE ce.SUBJECT_ID = h.SUBJECT_ID     -- INFECTION + ORGAN FAILURE
        AND ( ( ce.itemid = 678 AND ce.valuenum NOT BETWEEN 96.8 AND 101 ) OR -- GENERAL VAR - TEMPERATURE
            ( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) OR -- GENERAL VAR - HEART RATE 
            (ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valunum > 20) OR --GENERAL VAR - RESPI RATE
            ( ce.itemid IN (198) AND ce.valuenum < 12 ) OR --GENERAL VAR - GLASGOW
            ( ce.itemid IN (2338, 2416, 1529, 1812,807,811, 1310, 3447, 1455,3744, 3745, 225664,228388, 220621, 226537) AND ce.valuenum > 120 AND NOT EXISTS (--GENERAL VAR - GLYCEMIE
                    SELECT 1 
                    FROM chartevents ce2 
                    WHERE 
                    ce.subject_id = ce2.subject_id AND ce.hadm_id = ce2.hadm_id AND ce.icustay_id = ce2.icustay_id AND
                    ce2.itemid IN ( 250, 648 )
                )
            ) OR 
            ( (  ce.subject_id, hadm_id, icustay_id) IN (
                    SELECT subject_id, hadm_id, icustay_id 
                    FROM weightForFluidBalance
            )) OR --  GENERAL VAR FLUID BALANCE
        ( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum BETWEEN 4000 AND 12000 )  OR --GENERAL VAR - WHITE BLOOD CELL
        ( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) OR -- GENERAL VAR - CRP
        --  () OR -- GENERAL VAR - PROCALCITONINE NON DISPO
        ( ce.itemid IN ( 791, 1525, 3750, 220615 ) AND ce.valuenum > 0.5 ) OR -- creatinine
        ( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet
        ( ce.itemid IN ( 4948, 225651, 225690 ) AND uom ILIKE 'mg/dL' AND ce.valuenum > 4) OR -- BILLIRUBIN
        ( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) OR -- LACTATE
        ( ce.itemid IN ( 43522, 43171, 43173, 43365, 43373, 43374, 43379, 43380, 43576, 43654 ) AND ce.valuenum < 0.5 ) OR --CAUTION : ONLY METAVIZ HERE

       -- ( ce.itemid IN ( 3837, 3838, 3785, 227039 ) ) --po2 TO BE CONTINUED. Idea : mean per days for both ?
       -- ce.itemid IN (  227010,227009, 226754, 7570, 2981, 3420 ) --fio2
    ) 

)

select distinct subject_id, hadm_id
from anguspopulation
);
