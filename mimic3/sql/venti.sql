WITH ventilation_filter AS
  ( SELECT DISTINCT subject_id,
    icustay_id,
    charttime
  FROM chartevents
  WHERE (
    -- ITEMIDs which indicate ventilation
    itemid        = '720'
  OR itemid       = '722' )
  AND icustay_id IS NOT NULL
  ORDER BY icustay_id,
    charttime
  )
,
  ventilation_begin AS
  (SELECT vf.subject_id,
    vf.icustay_id,
    charttime,
    CASE
      WHEN EXTRACT(DAY FROM charttime - LAG(charttime) OVER (partition BY icustay_id ORDER BY charttime)) > 0
      THEN 'Y' --if more then a day has passed, flag as 'Y'
      WHEN LAG(charttime, 1) OVER (partition BY icustay_id ORDER BY charttime ) IS NULL
      THEN 'Y' --if lag is null, then > 24hrs has passed
      ELSE 'N'
    END AS new_day
  FROM ventilation_filter vf
  )
,
  ventilation_end AS
  (SELECT vf.subject_id,
    vf.icustay_id,
    charttime,
    CASE
      WHEN LEAD(new_day, 1) OVER (partition BY icustay_id ORDER BY charttime) = 'Y'
      THEN 'Y' --if lead is 'Y', then the current row is end
      WHEN LEAD(new_day, 1) OVER (partition BY icustay_id ORDER BY charttime) IS NULL
      THEN 'Y' --if lead is null, then partition is over
      ELSE 'N' --else not an end day
    END AS end_day
  FROM ventilation_begin vf
  )
  --select * from ventilation_end; --504205 rows
  --Return results that is 'Y' for new_day
  ,
  ventilation_assemble_begin AS
  ( SELECT * FROM ventilation_begin WHERE new_day = 'Y'
  )
  --select * from ventilation_begin_remove_no; -- 17994 rows
  --Return results that is 'Y' for end_day
  ,
  ventilation_assemble_end AS
  ( SELECT * FROM ventilation_end WHERE end_day = 'Y'
  )
  --select * from ventilation_end_remove_no; -- 17994 rows
  --Return results has a match of begin day with end day.  end_day is found by
  -- min(end_day - begin_day) that has to be >= 0.
  ,
  ventilation_find_end_date AS
  (SELECT vab.subject_id,
    vab.icustay_id,
    vab.charttime as beginn,
    MIN(vae.charttime - vab.charttime) as endd
FROM ventilation_assemble_begin vab
JOIN ventilation_assemble_end vae
ON vab.icustay_id                                      = vae.icustay_id
WHERE EXTRACT(DAY FROM vae.charttime - vab.charttime) >= 0
GROUP BY vab.subject_id,
  vab.icustay_id,
  vab.charttime
  )
  --select * from ventilation_find_end_date; -- 17994 rows
  --Return results that has subject_id, icustay_id, seq, begin time, and end
  -- time
  ,
  assemble AS
  (SELECT subject_id,
    icustay_id,
    row_number() over (partition BY icustay_id order by beginn) AS seq, --
    -- create seq
    beginn  as begin_time,
    beginn + endd as end_time
FROM ventilation_find_end_date
  )
SELECT * FROM assemble;
