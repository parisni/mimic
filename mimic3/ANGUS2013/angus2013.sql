-- SEPSIS ANGUS 2013
--- @author : Paris N, Aboab J

CREATE TABLE ids_angus13 (
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON ids_angus13 (subject_id, hadm_id);
TRUNCATE TABLE ids_angus13;
TRUNCATE TABLE ids_angus13;

-- INFECTION POP
CREATE TABLE infection_population(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON infection_population (subject_id, hadm_id);
INSERT INTO infection_population (subject_id, hadm_id)(
	with infectionPopulation as ( --ALL INFECTION CODES ACCORDING TO ANGUS (documentée ou suspectée ~ ANGUS_2013)
		SELECT    h.subject_ID,
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
	SELECT * FROM infectionPopulation
);
-- GENERAL VARS 
-- WEIGHT BALANCE
CREATE TABLE weight_balance_fluid(
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
			AND uom ILIKE 'kg'
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
	SELECT * FROM weightForFluidBalance);

CREATE TABLE general_vars(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON general_vars (subject_id, hadm_id);
INSERT INTO general_vars (subject_id, hadm_id)(
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	((ce.subject_id , ce.hadm_id) IN (SELECT creat.subject_id, creat.hadm_id FROM creat)) OR
	--thromb !! A FAIRE 
	(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) OR --les unités semblent etre en secondes
	--paralithiq ileus => NO WAY
	( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet !! UNITÉ À VÉRIF
	( ce.itemid IN ( 4948, 225651, 225690 ) AND uom ILIKE 'mg/dL' AND ce.valuenum > 4) OR -- BILLIRUBIN !! il faut aussi traduire d'autres unités
	-- END ORGAN DISFONCTION VARS

)
);
--BEGIN TISSU_PERF

CREATE TABLE tissue_perf(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON tissue_perf (subject_id, hadm_id);
INSERT INTO tissue_perf (subject_id, hadm_id) (
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	FROM infection_population h, 
	WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
	AND ( 
	-- BEGIN TISSUS PERF  VARIABLES
	--hyperlacatemeir
	( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) -- lactate !! unité  mmmol/L
	--marbrures  => no way
	--time recolor => no way

	--END TISSU_PERF
)
)
	FROM 
	mimiciii.chartevents ce
	AND ( 
		-- DEB GENERAL VARS    
		( ce.itemid = 678 AND ce.valuenum NOT BETWEEN 96.8 AND 101 ) OR -- temperature
		( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) OR --  heart rate 
		(ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valuenum > 20) OR -- respi rate
		( ce.itemid IN (198) AND ce.valuenum < 12 ) OR -- glasgow
		(ce.icustay_id IN (SELECT icustay_id FROM weight_balance_fluid)) OR
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
)
)
-- END GENERAL VARS

-- BEGIN INFLA VARS

CREATE TABLE infla_vars(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON infla_vars (subject_id, hadm_id);
INSERT INTO infla_vars (subject_id, hadm_id)(
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	FROM infection_population h, 
	mimiciii.chartevents ce
	WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
	AND ( 
	( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum NOT BETWEEN 4000 AND 12000 )  OR --GENERAL VAR - WHITE BLOOD CELL
	-- immature form => NO WAY
	( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) OR -- GENERAL VAR - CRP !! justification neccess
)
)
	-- END INFLA VARS


-- BEGIN HEMO_VARS

CREATE TABLE hemo_vars(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON hemo_vars (subject_id, hadm_id);
INSERT INTO hemo_vars (subject_id, hadm_id)(
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	FROM infection_population h, 
	mimiciii.chartevents ce
	WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
	AND ( 
	-- BEGIN HEMODYNAMIQ VARIABLES
	--1. arterial hypotension
	(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 ) OR --systolic pressure AND
	(ce.itemid IN ( 220052, 220181, 443, 456, 52, 224, 5731, 2647, 2294, 2732, 6702, 224322, 225312, 220052, 220181 ) AND ce.valuenum < 70 ) OR--mean arterial pressure
	--2elevated mixed venous ox sat
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 70) OR
	--3 elevated cardiac index
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 3.5 ) 
)
)
-- END HEMO_VARS

-- BEGIN ORGAN DISFONC
CREATE TABLE arterial_hypox (
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
	SELECT * 
	FROM arterialHypox
);

CREATE TABLE creat(
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
	SELECT * FROM creat
);


CREATE TABLE organ_dysf(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON organ_dysf (subject_id, hadm_id);
INSERT INTO organ_dysf (subject_id, hadm_id) (
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	FROM infection_population h, 
	mimiciii.chartevents ce
	WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
	AND ( 
	-- BEGIN ORGAN DISFONCTION VARS
	(ce.icustay_id IN (SELECT icustay_id FROM arterial_hypox)) OR
	( ce.itemid IN ( 43522, 43171, 43173, 43365, 43373, 43374, 43379, 43380, 43576, 43654 ) AND ce.valuenum < 0.5 ) OR --URINES !!CAUTION : ONLY METAVIZ HERE !! UNITÉS
	((ce.subject_id , ce.hadm_id) IN (SELECT creat.subject_id, creat.hadm_id FROM creat)) OR
	--thromb !! A FAIRE 
	(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) OR --les unités semblent etre en secondes
	--paralithiq ileus => NO WAY
	( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet !! UNITÉ À VÉRIF
	( ce.itemid IN ( 4948, 225651, 225690 ) AND uom ILIKE 'mg/dL' AND ce.valuenum > 4) OR -- BILLIRUBIN !! il faut aussi traduire d'autres unités
	-- END ORGAN DISFONCTION VARS

)
);

--BEGIN TISSU_PERF
CREATE TABLE tissue_perf(
	subject_id integer,
	hadm_id integer
);
CREATE INDEX ON tissue_perf (subject_id, hadm_id);
INSERT INTO tissue_perf (subject_id, hadm_id) (
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	FROM mimiciii.chartevents 
	WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
	AND ( 
	-- BEGIN TISSUS PERF  VARIABLES
	--hyperlacatemeir
	( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) -- lactate !! unité  mmmol/L
	--marbrures  => no way
	--time recolor => no way

	--END TISSU_PERF
)
)

INSERT INTO ids_angus13 (subject_id,hadm_id) (
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	FROM infection_population h, 
	general_vars gv,
	infla_vars iv,
	hemo_vars hv,
	organ_dysf od
	WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
	AND ( 
		-- DEB GENERAL VARS    
		( ce.itemid = 678 AND ce.valuenum NOT BETWEEN 96.8 AND 101 ) OR -- temperature
		( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) OR --  heart rate 
		(ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valuenum > 20) OR -- respi rate
		( ce.itemid IN (198) AND ce.valuenum < 12 ) OR -- glasgow
		(ce.icustay_id IN (SELECT icustay_id FROM weight_balance_fluid)) OR
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
		)) OR--  GENERAL VAR FLUID BALANCE
	-- END GENERAL VARS

	-- BEGIN INFLAMATORY VARS
	( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum NOT BETWEEN 4000 AND 12000 )  OR --GENERAL VAR - WHITE BLOOD CELL
	-- immature form => NO WAY
	( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) OR -- GENERAL VAR - CRP !! justification neccess
	-- procalcitonine => NO WAY

	-- END INFLAMATORY VARS

	-- BEGIN HEMODYNAMIQ VARIABLES
	--1. arterial hypotension
	(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 ) OR --systolic pressure AND
	(ce.itemid IN ( 220052, 220181, 443, 456, 52, 224, 5731, 2647, 2294, 2732, 6702, 224322, 225312, 220052, 220181 ) AND ce.valuenum < 70 ) OR--mean arterial pressure
	--2elevated mixed venous ox sat
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 70) OR
	--3 elevated cardiac index
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 3.5 )  OR

	-- END HEMODYNAMIQ VARIABLES

	-- BEGIN ORGAN DISFONCTION VARS
	(ce.icustay_id IN (SELECT icustay_id FROM arterial_hypox)) OR
	( ce.itemid IN ( 43522, 43171, 43173, 43365, 43373, 43374, 43379, 43380, 43576, 43654 ) AND ce.valuenum < 0.5 ) OR --URINES !!CAUTION : ONLY METAVIZ HERE !! UNITÉS
	((ce.subject_id , ce.hadm_id) IN (SELECT creat.subject_id, creat.hadm_id FROM creat)) OR
	--thromb !! A FAIRE 
	(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) OR --les unités semblent etre en secondes
	--paralithiq ileus => NO WAY
	( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet !! UNITÉ À VÉRIF
	( ce.itemid IN ( 4948, 225651, 225690 ) AND uom ILIKE 'mg/dL' AND ce.valuenum > 4) OR -- BILLIRUBIN !! il faut aussi traduire d'autres unités
	-- END ORGAN DISFONCTION VARS

	-- BEGIN TISSUS PERF  VARIABLES
	--hyperlacatemeir
	( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) -- lactate !! unité  mmmol/L
	--marbrures  => no way
	--time recolor => no way
	-- END TISSUS PERF  VARIABLES

)
)

INSERT INTO ids_angus13 (subject_id,hadm_id) (
	with infectionPopulation as ( --ALL INFECTION CODES ACCORDING TO ANGUS (documentée ou suspectée ~ ANGUS_2013)
		SELECT    h.subject_ID,
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
	)-- SEPSIS => 67053 admissions (mimiciii)
	, weightForFluidBalance as (--GENERAL VAR : icu where weight variation up to 2 kg
		-- TODO : weight in LBS
		WITH    rows AS
		(
			SELECT subject_id, hadm_id, icustay_id, valuenum,itemid, charttime ,ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn 
			FROM    mimiciii.chartevents
			WHERE  itemid IN (763, 
				--  3580, -- !! poids nouveau nés ?
				3581, 3582, 3693, 224639, 226512, 226531) 
			AND uom ILIKE 'kg'
		),
		diff AS (
			SELECT  mc.subject_id, mc.hadm_id, mc.icustay_id,mp.itemid, mp.valuenum - mc.valuenum   as diffe, mc.valuenum, mp.charttime - mc.charttime   as diffetime, mc.valuenum as w1, mp.valuenum as w2
			FROM    rows mc
			JOIN    rows mp
			ON       mc.icustay_id = mp.icustay_id
			-- ON      mc.rn = mp.rn - 1 -->not successiv but all combinaisons
		) 
		SELECT  subject_id, hadm_id, icustay_id
		FROM diff WHERE diffetime  BETWEEN '0 day'::INTERVAL AND '1 day'::INTERVAL  AND w2 - w1 > w1 * 0.02  -- dépendant du poids cad 20g / kg cad 20ml/kg
	)-- 6444 admissions dans mimic III
	, creat as (--GENERAL VAR : icu where weight variation up to 2 kg
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
		SELECT DISTINCT subject_id, hadm_id, icustay_id
		FROM diff WHERE diffe > 0.5 AND diffetime > '0 day'::INTERVAL  --
	),-- 6695 hadm in mimiciii,
	arterialHypox as (
		SELECT DISTINCT c1.subject_id, c1.hadm_id
		FROM mimiciii.chartevents c1, mimiciii.chartevents c2 
		WHERE c1.icustay_id = c2.icustay_id 
		AND c1.itemid IN (3837, 3838, 3785, 227039) --po2 
		AND c2.itemid IN (227010,227009, 226754, 7570, 2981, 3420)--fio2 
		AND c1.charttime - c2.charttime BETWEEN '-10 min'::INTERVAL AND '10 min'::INTERVAL
		AND (c1.valuenum / (c2.valuenum/100)) < 300 --!! unités : po2 = mmHG (!=klpascal) & fio2 = % (si fraction => )
	) -- 1121 hadm
	, anguspopulation as (
		SELECT    h.subject_ID,
		h.hadm_id
		FROM mi.infection_population h, 
		mimiciii.chartevents ce
		WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
		AND ( 
			-- DEB GENERAL VARS    
			( ce.itemid = 678 AND ce.valuenum NOT BETWEEN 96.8 AND 101 ) OR -- temperature
			( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) OR --  heart rate 
			(ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valunum > 20) OR -- respi rate
			( ce.itemid IN (198) AND ce.valuenum < 12 ) OR -- glasgow
			(ce.icustay_id IN (SELECT icustay_id FROM weightForFluidBalance)) OR
			( ce.itemid IN (2338, 2416, 1529, 1812,807,811, 1310, 3447, 1455,3744, 3745, 225664,228388, 220621, 226537) AND ce.valuenum > 120 AND NOT EXISTS (--GENERAL VAR - GLYCEMIE !! mg/dl without diabete (icd9)
					SELECT 1 
					FROM chartevents ce2 
					WHERE 
					ce.subject_id = ce2.subject_id AND ce.hadm_id = ce2.hadm_id AND ce.icustay_id = ce2.icustay_id AND
					ce2.itemid IN ( 250, 648 )
				)
			) OR 
			( (  ce.subject_id, hadm_id) IN (
					SELECT subject_id, hadm_id 
					FROM mimiciii.weight_balance_fluid
			)) OR --  GENERAL VAR FLUID BALANCE
		-- END GENERAL VARS

		-- BEGIN INFLAMATORY VARS
		( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum NOT BETWEEN 4000 AND 12000 )  OR --GENERAL VAR - WHITE BLOOD CELL
		-- immature form => NO WAY
		( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) OR -- GENERAL VAR - CRP !! justification neccess
		-- procalcitonine => NO WAY

		-- END INFLAMATORY VARS

		-- BEGIN HEMODYNAMIQ VARIABLES
		--1. arterial hypotension
		(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 ) OR --systolic pressure AND
		(ce.itemid IN ( 220052, 220181, 443, 456, 52, 224, 5731, 2647, 2294, 2732, 6702, 224322, 225312, 220052, 220181, ) AND ce.valuenum < 70 ) OR--mean arterial pressure
		--2elevated mixed venous ox sat
		(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 70) OR
		--3 elevated cardiac index
		(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 3.5 ) OR

		-- END HEMODYNAMIQ VARIABLES

		-- BEGIN ORGAN DISFONCTION VARS
		(ce.icustay_id IN (SELECT icustay_id FROM mimiciii.arterial_hypox)) OR
		( ce.itemid IN ( 43522, 43171, 43173, 43365, 43373, 43374, 43379, 43380, 43576, 43654 ) AND ce.valuenum < 0.5 ) OR --URINES !!CAUTION : ONLY METAVIZ HERE !! UNITÉS
		(ce.icustay_id AND ce.hadm IN (SELECT icustay_id FROM creat)) OR
		--thromb !! A FAIRE 
		(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) OR --les unités semblent etre en secondes
		--paralithiq ileus => NO WAY
		( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet !! UNITÉ À VÉRIF
		( ce.itemid IN ( 4948, 225651, 225690 ) AND uom ILIKE 'mg/dL' AND ce.valuenum > 4) OR -- BILLIRUBIN !! il faut aussi traduire d'autres unités
		-- END ORGAN DISFONCTION VARS

		-- BEGIN TISSUS PERF  VARIABLES
		--hyperlacatemeir
		( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) -- lactate !! unité  mmmol/L
		--marbrures  => no way
		--time recolor => no way
		-- END TISSUS PERF  VARIABLES
	) 
)
SELECT DISTINCT subject_id, hadm_id
FROM anguspopulation
);
-- END
INSERT INTO ids_angus13 (subject_id,hadm_id) (
	SELECT  DISTINCT   h.subject_id, h.hadm_id
	FROM infection_population h, 
	mimiciii.chartevents ce
	WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
	AND ( 
		-- DEB GENERAL VARS    
		( ce.itemid = 678 AND ce.valuenum NOT BETWEEN 96.8 AND 101 ) OR -- temperature
		( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) OR --  heart rate 
		(ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valuenum > 20) OR -- respi rate
		( ce.itemid IN (198) AND ce.valuenum < 12 ) OR -- glasgow
		(ce.icustay_id IN (SELECT icustay_id FROM weight_balance_fluid)) OR
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
		)) OR--  GENERAL VAR FLUID BALANCE
	-- END GENERAL VARS

	-- BEGIN INFLAMATORY VARS
	( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum NOT BETWEEN 4000 AND 12000 )  OR --GENERAL VAR - WHITE BLOOD CELL
	-- immature form => NO WAY
	( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) OR -- GENERAL VAR - CRP !! justification neccess
	-- procalcitonine => NO WAY

	-- END INFLAMATORY VARS

	-- BEGIN HEMODYNAMIQ VARIABLES
	--1. arterial hypotension
	(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 ) OR --systolic pressure AND
	(ce.itemid IN ( 220052, 220181, 443, 456, 52, 224, 5731, 2647, 2294, 2732, 6702, 224322, 225312, 220052, 220181 ) AND ce.valuenum < 70 ) OR--mean arterial pressure
	--2elevated mixed venous ox sat
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 70) OR
	--3 elevated cardiac index
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 3.5 )  OR

	-- END HEMODYNAMIQ VARIABLES

	-- BEGIN ORGAN DISFONCTION VARS
	(ce.icustay_id IN (SELECT icustay_id FROM arterial_hypox)) OR
	( ce.itemid IN ( 43522, 43171, 43173, 43365, 43373, 43374, 43379, 43380, 43576, 43654 ) AND ce.valuenum < 0.5 ) OR --URINES !!CAUTION : ONLY METAVIZ HERE !! UNITÉS
	((ce.subject_id , ce.hadm_id) IN (SELECT creat.subject_id, creat.hadm_id FROM creat)) OR
	--thromb !! A FAIRE 
	(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) OR --les unités semblent etre en secondes
	--paralithiq ileus => NO WAY
	( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet !! UNITÉ À VÉRIF
	( ce.itemid IN ( 4948, 225651, 225690 ) AND uom ILIKE 'mg/dL' AND ce.valuenum > 4) OR -- BILLIRUBIN !! il faut aussi traduire d'autres unités
	-- END ORGAN DISFONCTION VARS

	-- BEGIN TISSUS PERF  VARIABLES
	--hyperlacatemeir
	( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) -- lactate !! unité  mmmol/L
	--marbrures  => no way
	--time recolor => no way
	-- END TISSUS PERF  VARIABLES

)
)

INSERT INTO ids_angus13 (subject_id,hadm_id) (
	with infectionPopulation as ( --ALL INFECTION CODES ACCORDING TO ANGUS (documentée ou suspectée ~ ANGUS_2013)
		SELECT    h.subject_ID,
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
	)-- SEPSIS => 67053 admissions (mimiciii)
	, weightForFluidBalance as (--GENERAL VAR : icu where weight variation up to 2 kg
		-- TODO : weight in LBS
		WITH    rows AS
		(
			SELECT subject_id, hadm_id, icustay_id, valuenum,itemid, charttime ,ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn 
			FROM    mimiciii.chartevents
			WHERE  itemid IN (763, 
				--  3580, -- !! poids nouveau nés ?
				3581, 3582, 3693, 224639, 226512, 226531) 
			AND uom ILIKE 'kg'
		),
		diff AS (
			SELECT  mc.subject_id, mc.hadm_id, mc.icustay_id,mp.itemid, mp.valuenum - mc.valuenum   as diffe, mc.valuenum, mp.charttime - mc.charttime   as diffetime, mc.valuenum as w1, mp.valuenum as w2
			FROM    rows mc
			JOIN    rows mp
			ON       mc.icustay_id = mp.icustay_id
			-- ON      mc.rn = mp.rn - 1 -->not successiv but all combinaisons
		) 
		SELECT  subject_id, hadm_id, icustay_id
		FROM diff WHERE diffetime  BETWEEN '0 day'::INTERVAL AND '1 day'::INTERVAL  AND w2 - w1 > w1 * 0.02  -- dépendant du poids cad 20g / kg cad 20ml/kg
	)-- 6444 admissions dans mimic III
	, creat as (--GENERAL VAR : icu where weight variation up to 2 kg
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
		SELECT DISTINCT subject_id, hadm_id, icustay_id
		FROM diff WHERE diffe > 0.5 AND diffetime > '0 day'::INTERVAL  --
	),-- 6695 hadm in mimiciii,
	arterialHypox as (
		SELECT DISTINCT c1.subject_id, c1.hadm_id
		FROM mimiciii.chartevents c1, mimiciii.chartevents c2 
		WHERE c1.icustay_id = c2.icustay_id 
		AND c1.itemid IN (3837, 3838, 3785, 227039) --po2 
		AND c2.itemid IN (227010,227009, 226754, 7570, 2981, 3420)--fio2 
		AND c1.charttime - c2.charttime BETWEEN '-10 min'::INTERVAL AND '10 min'::INTERVAL
		AND (c1.valuenum / (c2.valuenum/100)) < 300 --!! unités : po2 = mmHG (!=klpascal) & fio2 = % (si fraction => )
	) -- 1121 hadm
	, anguspopulation as (
		SELECT    h.subject_ID,
		h.hadm_id
		FROM mi.infection_population h, 
		mimiciii.chartevents ce
		WHERE ce.subject_id = h.subject_id  AND ce.hadm_id = h.hadm_id
		AND ( 
			-- DEB GENERAL VARS    
			( ce.itemid = 678 AND ce.valuenum NOT BETWEEN 96.8 AND 101 ) OR -- temperature
			( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) OR --  heart rate 
			(ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valunum > 20) OR -- respi rate
			( ce.itemid IN (198) AND ce.valuenum < 12 ) OR -- glasgow
			(ce.icustay_id IN (SELECT icustay_id FROM weightForFluidBalance)) OR
			( ce.itemid IN (2338, 2416, 1529, 1812,807,811, 1310, 3447, 1455,3744, 3745, 225664,228388, 220621, 226537) AND ce.valuenum > 120 AND NOT EXISTS (--GENERAL VAR - GLYCEMIE !! mg/dl without diabete (icd9)
					SELECT 1 
					FROM chartevents ce2 
					WHERE 
					ce.subject_id = ce2.subject_id AND ce.hadm_id = ce2.hadm_id AND ce.icustay_id = ce2.icustay_id AND
					ce2.itemid IN ( 250, 648 )
				)
			) OR 
			( (  ce.subject_id, hadm_id) IN (
					SELECT subject_id, hadm_id 
					FROM mimiciii.weight_balance_fluid
			)) OR --  GENERAL VAR FLUID BALANCE
		-- END GENERAL VARS

		-- BEGIN INFLAMATORY VARS
		( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum NOT BETWEEN 4000 AND 12000 )  OR --GENERAL VAR - WHITE BLOOD CELL
		-- immature form => NO WAY
		( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) OR -- GENERAL VAR - CRP !! justification neccess
		-- procalcitonine => NO WAY

		-- END INFLAMATORY VARS

		-- BEGIN HEMODYNAMIQ VARIABLES
		--1. arterial hypotension
		(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 ) OR --systolic pressure AND
		(ce.itemid IN ( 220052, 220181, 443, 456, 52, 224, 5731, 2647, 2294, 2732, 6702, 224322, 225312, 220052, 220181, ) AND ce.valuenum < 70 ) OR--mean arterial pressure
		--2elevated mixed venous ox sat
		(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 70) OR
		--3 elevated cardiac index
		(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 3.5 ) OR

		-- END HEMODYNAMIQ VARIABLES

		-- BEGIN ORGAN DISFONCTION VARS
		(ce.icustay_id IN (SELECT icustay_id FROM mimiciii.arterial_hypox)) OR
		( ce.itemid IN ( 43522, 43171, 43173, 43365, 43373, 43374, 43379, 43380, 43576, 43654 ) AND ce.valuenum < 0.5 ) OR --URINES !!CAUTION : ONLY METAVIZ HERE !! UNITÉS
		(ce.icustay_id AND ce.hadm IN (SELECT icustay_id FROM creat)) OR
		--thromb !! A FAIRE 
		(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) OR --les unités semblent etre en secondes
		--paralithiq ileus => NO WAY
		( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100000 ) OR -- platelet !! UNITÉ À VÉRIF
		( ce.itemid IN ( 4948, 225651, 225690 ) AND uom ILIKE 'mg/dL' AND ce.valuenum > 4) OR -- BILLIRUBIN !! il faut aussi traduire d'autres unités
		-- END ORGAN DISFONCTION VARS

		-- BEGIN TISSUS PERF  VARIABLES
		--hyperlacatemeir
		( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 ) -- lactate !! unité  mmmol/L
		--marbrures  => no way
		--time recolor => no way
		-- END TISSUS PERF  VARIABLES
	) 
)
SELECT DISTINCT subject_id, hadm_id
FROM anguspopulation
);
