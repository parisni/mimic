
CREATE TABLE IF NOT EXISTS weight_balance_fluid72(
	subject_id integer,
	hadm_id integer
);
INSERT INTO weight_balance_fluid72 (subject_id, hadm_id) (
	with weightForFluidBalance as (--GENERAL VAR : icu where weight variation up to 2 kg
		-- TODO : weight in LBS
		WITH    rows AS
		(
			SELECT subject_id, hadm_id, icustay_id, valuenum, itemid, charttime, ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn 
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
		FROM diff WHERE diffetime  BETWEEN '0 hour'::INTERVAL AND '72 hour'::INTERVAL  AND w2 - w1 > w1 * 0.02  -- dépendant du poids cad 20g / kg cad 20ml/kg
	)
	SELECT DISTINCT * FROM weightForFluidBalance
);
