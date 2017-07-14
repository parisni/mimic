		set search_path = mimiciii;
	     WITH arterialHypox as (
                SELECT DISTINCT c1.subject_id, c1.hadm_id, c1.charttime
                FROM mimiciii.chartevents c1, mimiciii.chartevents c2
                WHERE c1.icustay_id = c2.icustay_id 
                AND c1.itemid IN (3837, 3838, 3785) --po2  , 227039 is false
                AND c2.itemid IN (3420)-- fio2 , 227010,227009, 226754, 7570, 2981, 3420 are false 
                AND c1.charttime - c2.charttime BETWEEN '-10 min'::INTERVAL AND '10 min'::INTERVAL
                AND (c1.valuenum / (c2.valuenum/100)) < 300 --!! unités : po2 = mmHG (!=klpascal) & fio2 = % (si fraction => )
        ) -- 1121 hadm
        SELECT count(1)
        FROM arterialHypox

