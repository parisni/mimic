-- SEPSIS ANGUS 2013
--- @author : Paris N, Aboab J, Mayaud L


-- BEGIN SEPSIS - INFECTION POP
DROP TABLE IF EXISTS infection_population;
CREATE TABLE IF NOT EXISTS infection_population(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON infection_population (subject_id, hadm_id);
INSERT INTO infection_population (subject_id, hadm_id)(
	with infectionPopulation as ( --ALL INFECTION CODES ACCORDING TO ANGUS (documentée ou suspectée ~ ANGUS_2013)
		SELECT    h.subject_id,
		h.hadm_id   
		FROM mimiciii.admissions h, 
		mimiciii.diagnoses_icd code
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
	SELECT DISTINCT * FROM infectionPopulation
);
-- END SEPSIS - INFECTION POP | HADM = 23963

-- BEGIN - CHAP 1 GENERAL VARS 
-- WEIGHT BALANCE
DROP TABLE IF EXISTS weight_balance_fluid;
CREATE TABLE IF NOT EXISTS weight_balance_fluid(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON weight_balance_fluid (subject_id, hadm_id);
INSERT INTO weight_balance_fluid (subject_id, hadm_id) (
	with weightForFluidBalance as (--GENERAL VAR : icu where weight variation up to 2 kg
		-- TODO : weight in LBS
		WITH    rows AS
		(
			SELECT subject_id, hadm_id, icustay_id, valuenum,itemid, charttime ,ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn 
			FROM    mimiciii.chartevents
			WHERE  itemid IN (763, 
				--  3580, -- !! poids nouveau nés ?
				3581, 3582, 3693, 224639, 226512, 226531) 
			AND valueuom ILIKE 'kg'
		),
		diff AS (
			SELECT  mc.subject_id, mc.hadm_id, mc.icustay_id,mp.itemid, mp.valuenum - mc.valuenum   as diffe, mc.valuenum, mp.charttime - mc.charttime   as diffetime, mc.valuenum as w1, mp.valuenum as w2
			FROM    rows mc
			JOIN    rows mp
			ON       mc.icustay_id = mp.icustay_id
			-- ON      mc.rn = mp.rn - 1 -->not successiv but all combinaisons
		) 
		SELECT  subject_id, hadm_id
		FROM diff WHERE diffetime  BETWEEN '0 day'::INTERVAL AND '1 day'::INTERVAL  AND w2 - w1 > w1 * 0.02  -- dépendant du poids cad 20g / kg cad 20ml/kg
	)
	SELECT DISTINCT * FROM weightForFluidBalance
);

DROP TABLE IF EXISTS general_vars;
CREATE TABLE IF NOT EXISTS general_vars(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON general_vars (subject_id, hadm_id);
INSERT INTO general_vars (subject_id, hadm_id)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id
    FROM mimiciii.chartevents ce
    WHERE
		-- DEB GENERAL VARS    
		( ce.itemid = 678 AND ce.valuenum NOT BETWEEN 96.8 AND 101 ) OR -- temperature
		( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) OR --  heart rate 
		(ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valuenum > 20) OR -- respi rate
		( ce.itemid IN (198) AND ce.valuenum < 12 ) OR -- glasgow
		( ce.itemid IN (2338, 2416, 1529, 1812,807,811, 1310, 3447, 1455,3744, 3745, 225664,228388, 220621, 226537) AND ce.valuenum > 120 AND NOT EXISTS (--GENERAL VAR - GLYCEMIE !! mg/dl without diabete (icd9)
				SELECT 1 
				FROM mimiciii.chartevents ce2 
				WHERE 
				ce.subject_id = ce2.subject_id AND ce.hadm_id = ce2.hadm_id AND ce.icustay_id = ce2.icustay_id AND
				ce2.itemid IN ( 250, 648 )
			)
		) OR 
		( (  ce.subject_id, ce.hadm_id) IN (
				SELECT subject_id, hadm_id 
				FROM weight_balance_fluid
		)) --  GENERAL VAR FLUID BALANCE
	-- END GENERAL VARS
);
-- END - CHAP 1 GENERAL VARS | HADM = 56093


--BEGIN - CHAP 2 INFLA VARS
DROP TABLE IF EXISTS infla_vars;
CREATE TABLE IF NOT EXISTS infla_vars(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON infla_vars (subject_id, hadm_id);
INSERT INTO infla_vars (subject_id, hadm_id)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id
	FROM
	mimiciii.chartevents ce
	WHERE  
	( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum NOT BETWEEN 4000 AND 12000 )  OR --GENERAL VAR - WHITE BLOOD CELL
	-- immature form => NO WAY
	( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) -- GENERAL VAR - CRP !! justification neccess
);
--END - CHAP 2 INFLA VARS | HADM = 33569


--BEGIN - CHAP 3 HEMO_VARS
DROP TABLE IF EXISTS hemo_vars;
CREATE TABLE IF NOT EXISTS hemo_vars(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON hemo_vars (subject_id, hadm_id);
INSERT INTO hemo_vars (subject_id, hadm_id)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id
	FROM 
	mimiciii.chartevents ce
    WHERE
	-- BEGIN HEMODYNAMIQ VARIABLES
	--1. arterial hypotension
--	(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 ) OR --systolic pressure | 29206 ENLEVÉ POUR SELECTIVITÉ
--	(ce.itemid IN ( 220052, 220181, 443, 456, 52, 224, 5731, 2647, 2294, 2732, 6702, 224322, 225312, 220052, 220181 ) AND ce.valuenum < 70 ) OR--mean arterial pressure | 44231 ENLEVÉ POUR SELECTIVITÉ
	--2elevated mixed venous ox sat | 5540
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 70) OR
	--3 elevated cardiac index | 7962
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 3.5 ) 
);
--END - CHAP 3 HEMO_VARS | HADM = 44579

--BEGIN - CHAP 4 ORGAN DISFONC
DROP TABLE IF EXISTS arterial_hypox;
CREATE TABLE IF NOT EXISTS arterial_hypox (
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON arterial_hypox (subject_id, hadm_id);
INSERT INTO arterial_hypox (subject_id, hadm_id) (
	WITH arterialHypox as (
		SELECT DISTINCT c1.subject_id, c1.hadm_id
		FROM mimiciii.chartevents c1, mimiciii.chartevents c2 
		WHERE c1.icustay_id = c2.icustay_id 
		AND c1.itemid IN (3837, 3838, 3785, 227039) --po2 
		AND c2.itemid IN (227010,227009, 226754, 7570, 2981, 3420)--fio2 
		AND c1.charttime - c2.charttime BETWEEN '-10 min'::INTERVAL AND '10 min'::INTERVAL
		AND (c1.valuenum / (c2.valuenum/100)) < 300 --!! unités : po2 = mmHG (!=klpascal) & fio2 = % (si fraction => )
	) -- 1121 hadm
	SELECT DISTINCT * 
	FROM arterialHypox
);

DROP TABLE IF EXISTS creat;
CREATE TABLE IF NOT EXISTS creat(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON creat (subject_id, hadm_id);
INSERT INTO creat (subject_id, hadm_id) (
	WITH creat as(--GENERAL VAR : icu where weight variation up to 2 kg
		-- TODO : weight in LBS
		WITH    rows AS
		(
			SELECT subject_id, hadm_id, icustay_id, valuenum,itemid, charttime ,ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn 
			FROM    mimiciii.chartevents
			WHERE  itemid IN (791, 1525, 3750, 220615) 
		),
		diff AS (
			SELECT  mc.subject_id, mc.hadm_id, mc.icustay_id,mp.itemid, mp.valuenum - mc.valuenum   as diffe, mc.valuenum, mp.charttime - mc.charttime   as diffetime, mc.valuenum as w1, mp.valuenum as w2
			FROM    rows mc
			JOIN    rows mp
			ON       mc.icustay_id = mp.icustay_id
		) 
		SELECT DISTINCT subject_id, hadm_id
		FROM diff WHERE diffe > 0.5 AND diffetime > '0 day'::INTERVAL  --
	)
	SELECT DISTINCT * FROM creat
);--creat | 6695

DROP TABLE IF EXISTS organ_dysf;
CREATE TABLE IF NOT EXISTS organ_dysf(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON organ_dysf (subject_id, hadm_id);
INSERT INTO organ_dysf (subject_id, hadm_id) (
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id
	FROM 
	mimiciii.chartevents ce
    WHERE
	((ce.subject_id, ce.hadm_id) IN (SELECT subject_id, hadm_id FROM arterial_hypox)) OR -- arterial_hypox | 1121
	( ce.itemid IN ( 43522, 43171, 43173, 43365, 43373, 43374, 43379, 43380, 43576, 43654 ) AND ce.valuenum < 0.5 ) OR --URINES !!CAUTION : ONLY METAVIZ HERE !! UNITÉS 
	((ce.subject_id , ce.hadm_id) IN (SELECT creat.subject_id, creat.hadm_id FROM creat)) OR --creat | 6695
	--thromb !! A FAIRE 
	(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) OR --les unités semblent etre en secondes -- thromb | 351
	--paralithiq ileus => NO WAY
--	( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet !! UNITÉ À VÉRIF | | 54737 ENLEVÉ POUR SELECTIVITÉ
	( ce.itemid IN ( 4948, 225651, 225690 ) AND valueuom ILIKE 'mg/dL' AND ce.valuenum > 4) -- BILLIRUBIN !! il faut aussi traduire d'autres unités | 1400
);
--BEGIN - CHAP 4 ORGAN DISFONC | HADM = 54761


--BEGIN - CHAP 5 TISSU_PERF
DROP TABLE IF EXISTS tissue_perf;
CREATE TABLE IF NOT EXISTS tissue_perf(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON tissue_perf (subject_id, hadm_id);
INSERT INTO tissue_perf (subject_id, hadm_id) (
	SELECT  DISTINCT ce.subject_id, ce.hadm_id
	FROM mimiciii.chartevents ce
    WHERE
	-- BEGIN TISSUS PERF  VARIABLES
	--hyperlacatemeir
	( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) -- lactate !! unité  mmmol/L
	--marbrures  => no way
	--time recolor => no way

	--END TISSU_PERF
);
--END - CHAP 5 TISSU_PERF | 22708


-- BEGIN SEPSIS
DROP TABLE IF EXISTS angus2013_sepsis;
CREATE TABLE IF NOT EXISTS angus2013_sepsis (
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON angus2013_sepsis (subject_id, hadm_id);
TRUNCATE TABLE angus2013_sepsis;
INSERT INTO angus2013_sepsis (subject_id,hadm_id) (
    SELECT  DISTINCT   ip.subject_id, ip.hadm_id
    FROM infection_population ip
    WHERE (ip.subject_id, ip.hadm_id) IN (
        SELECT subject_id, hadm_id
        FROM general_vars 
        UNION
        SELECT subject_id, hadm_id
        FROM infla_vars 
        UNION
        SELECT subject_id, hadm_id
        FROM hemo_vars 
        UNION
        SELECT subject_id, hadm_id
        FROM organ_dysf 
        UNION
        SELECT subject_id, hadm_id
        FROM tissue_perf 
    )
);
-- END SEPSIS | HADM = 23007


-- BEGIN SEVERE SEPSIS
DROP TABLE IF EXISTS angus2013_sepsis_severe;
CREATE TABLE IF NOT EXISTS angus2013_sepsis_severe (
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON angus2013_sepsis_severe (subject_id, hadm_id);
TRUNCATE TABLE angus2013_sepsis_severe;
INSERT INTO angus2013_sepsis_severe (subject_id,hadm_id) (
    SELECT  DISTINCT   ip.subject_id, ip.hadm_id
    FROM angus2013_sepsis ip
    WHERE (ip.subject_id, ip.hadm_id) IN (
        SELECT subject_id, hadm_id
        FROM organ_dysf
    )
);
-- END SEVERE SEPSIS | HADM = 22700

-- BEGIN SEPSIC SHOCK / TO BE DONE
--TRUNCATE ids_vaso;
CREATE TABLE IF NOT EXISTS ids_vaso(
	    subject_id integer,
	    hadm_id integer,
	    icustay_id integer
);
CREATE INDEX ON ids_vaso (subject_id, hadm_id, icustay_id);
INSERT INTO ids_vaso (subject_id,hadm_id, icustay_id) (SELECT distinct io.subject_id, io.hadm_id, io.icustay_id 
	    FROM mimiciii.ioevents io, mimiciii.icustayevents ic
	    WHERE 
	    io.subject_id = ic.subject_id AND
	    io.hadm_id = ic.hadm_id AND
	    io.icustay_id = ic.icustay_id AND
	  -- io.starttime BETWEEN ic.intime AND ic.intime + '1 day' AND
	    io.itemid in (select  itemid 
		        from mimiciii.d_items 
			where lower(label) like '%evophed%' or lower(label) like '%pressin%' or lower(label) like '%ephrin%') 
		);
--TODO: TRANSFORM IO into 
DROP TABLE IF EXISTS angus2013_sepsis_shock;
CREATE TABLE IF NOT EXISTS angus2013_sepsis_shock (
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON angus2013_sepsis_shock (subject_id, hadm_id);
TRUNCATE TABLE angus2013_sepsis_shock;
INSERT INTO angus2013_sepsis_shock (subject_id,hadm_id) (
    SELECT  DISTINCT   ip.subject_id, ip.hadm_id
    FROM angus2013_sepsis ip
    WHERE (ip.subject_id, ip.hadm_id) IN (
       -- SELECT subject_id, hadm_id
       -- FROM mimiciii.chartevents ce
--	WHERE 
--	(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 )  --systolic pressure AND ENLEVÉ POUR SELECTIVITÉ
  --      UNION
        SELECT subject_id, hadm_id
        FROM tissue_perf  --only lactate there
	WHERE (subject_id, hadm_id) IN (-- qui ont eu une vaso
		SELECT e.subject_id, e.hadm_id 
		FROM ids_vaso e)
    )
);
-- END SEPSIC SHOCK | 2432

-- TEST1: sepsis Confrontation HUMAN VS MACHINE
SELECT count(1) FROM (SELECT    h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '99591')) as test ; -- | 3030

SELECT count(1) FROM( SELECT  h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '99591') AND (h.subject_id, h.hadm_id) IN (SELECT * FROM angus2013_sepsis)) as test2; --|2977
-- TEST2: sepsis SEVERE Confrontation HUMAN VS MACHINE
SELECT count(1) FROM (SELECT    h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '99592')) as test ; -- | 8673

SELECT count(1) FROM( SELECT  h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '99592') AND (h.subject_id, h.hadm_id) IN (SELECT * FROM angus2013_sepsis_severe)) as test2; --2592

--TEST3: shoc confrontation HUMAN VS MACHINE
SELECT count(1) FROM (SELECT    h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '78552')) as test ; -- | 5560

SELECT count(1) FROM( SELECT  h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '78552') AND (h.subject_id, h.hadm_id) IN (SELECT * FROM angus2013_sepsis_shock)) as test2; --1200

-- TEST4: ceux qui sont en sepsis severe praticien, et pas angus severe, sont ils dans angus sepsis ?
 SELECT count(1) FROM (SELECT  h.subject_id,
	h.hadm_id<
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '99592') AND (h.subject_id, h.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis_severe) AND (h.subject_id, h.hadm_id) IN  (SELECT * FROM angus2013_sepsis)) as test2; -- | 5770

-- TEST5: ceux qui sont en sepsis shock praticien, et pas angus shoc, sont ils dans angus sepsis ?
 SELECT count(1) FROM (SELECT  h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '78552') AND (h.subject_id, h.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis_shock) AND (h.subject_id, h.hadm_id) IN  (SELECT * FROM angus2013_sepsis)) as test2; -- | 4194

-- TEST: Vérification des décès des septic choc INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '78552') AND (h.subject_id, h.hadm_id) IN (SELECT * FROM angus2013_sepsis_shock)),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 560 cad 55% de décédés
-- TEST: Vérification des décès des septic choc MACHINE
with sc as (SELECT subject_id FROM angus2013_sepsis_shock),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 1091 cad 55% de décédés
-- TEST: Vérification des décès des septic choc INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '78552') ),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 560 cad 55% de décédés
-- TEST: Vérification des décès des septic choc INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '78552') AND (h.subject_id, h.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis_shock)),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 560 cad 30% de décédés
-- THE END

-- TEST: Vérification des décès des septic severes INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '99592') AND (h.subject_id, h.hadm_id) IN (SELECT * FROM angus2013_sepsis_severe)),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 698 cad 48% de décédés
-- TEST: Vérification des décès des septic choc MACHINE
with sc as (SELECT subject_id FROM angus2013_sepsis_severe),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 1091 cad 53% de décédés
-- TEST: Vérification des décès des septic choc INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '99592') ),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 2364 cad 28% de décédés
-- TEST: Vérification des décès des septic choc INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '99592') AND (h.subject_id, h.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis_severe)),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 1587 cad 27% de décédés

-- TEST: Vérification des décès des septic INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '99591') AND (h.subject_id, h.hadm_id) IN (SELECT * FROM angus2013_sepsis)),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 698 cad 20% de décédés
-- TEST: Vérification des décès des septic choc MACHINE
with sc as (SELECT subject_id FROM angus2013_sepsis),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 1091 cad 33% de décédés
-- TEST: Vérification des décès des septic choc INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '99591') ),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 2364 cad 20% de décédés
-- TEST: Vérification des décès des septic choc INTERSECT Machine/Human
with sc as (SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '99591') AND (h.subject_id, h.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis)),
dcd as (SELECT dod FROM mimiciii.patients WHERE subject_id IN (SELECT * FROM sc))
SELECT count(*) FROM dcd WHERE dod IS NOT NULL; --MORTS -> 560 cad 30% de décédés

-- TEST: Paarmis les HUMAN sepsis, ceux qui sont pas sepsis  sont ils severe / shoc (haute mortalité ..) => non, machine ne les considère pas comme sepsis
SELECT  h.subject_id
FROM mimiciii.admissions h,
mimiciii.diagnoses_icd code
WHERE code.SUBJECT_ID = h.SUBJECT_ID
and (code.icd9_code = '99591') AND (h.subject_id, h.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis) AND ((h.subject_id, h.hadm_id)  IN (SELECT * FROM angus2013_sepsis_severe) OR  (h.subject_id, h.hadm_id)  IN (SELECT * FROM angus2013_sepsis_shock));

-- TEST:  
-- TEST : Parmis les machine shoc, quelle part de Machine Sévère ?
with test as (SELECT  h1.subject_id,
        h1.hadm_id
        FROM angus2013_sepsis_shock h1)
SELECT count(1) FROM (SELECT  h.subject_id,
	h.hadm_id
	FROM angus2013_sepsis_severe h
	WHERE (subject_id,hadm_id) IN (SELECT * FROM test)) as test2; -- 1055
--TEST6: INTERSECTION entre les rejets shoc & sévère
with test as (SELECT  h1.subject_id,
        h1.hadm_id
        FROM mimiciii.admissions h1,
        mimiciii.diagnoses_icd code
        WHERE code.SUBJECT_ID = h1.SUBJECT_ID
        and (code.icd9_code = '78552') AND (h1.subject_id, h1.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis_shock) AND (h1.subject_id, h1.hadm_id) IN  (SELECT * FROM angus2013_sepsis))
SELECT count(1) FROM (SELECT  h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '99592') AND (h.subject_id, h.hadm_id) NOT IN (SELECT * FROM angus2013_sepsis_severe) AND (h.subject_id, h.hadm_id) IN  (SELECT * FROM angus2013_sepsis)
	AND (h.subject_id, h.hadm_id)  IN (SELECT * FROM test) ) as test2
--TEST6: INTERSECTION entre les rejets shoc & sévère
with test as (SELECT  h1.subject_id,
        h1.hadm_id
        FROM mimiciii.admissions h1,
        mimiciii.diagnoses_icd code
        WHERE code.SUBJECT_ID = h1.SUBJECT_ID
        and (code.icd9_code = '78552') AND (h1.subject_id, h1.hadm_id)  IN (SELECT * FROM angus2013_sepsis_shock) AND (h1.subject_id, h1.hadm_id) IN  (SELECT * FROM angus2013_sepsis))
SELECT count(1) FROM (SELECT  h.subject_id,
	h.hadm_id
	FROM mimiciii.admissions h,
	mimiciii.diagnoses_icd code
	WHERE code.SUBJECT_ID = h.SUBJECT_ID
	and (code.icd9_code = '99592') AND (h.subject_id, h.hadm_id)  IN (SELECT * FROM angus2013_sepsis_severe) AND (h.subject_id, h.hadm_id) IN  (SELECT * FROM angus2013_sepsis)
	AND (h.subject_id, h.hadm_id)  IN (SELECT * FROM test) ) as test2
