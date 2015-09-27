WITH
  raw_elix AS
  (
    SELECT DISTINCT
      --adm.hadm_id
      --, adm.admit_dt
      --, dp.dod - adm.admit_dt
      co.*
      , case when dp.HOSPITAL_EXPIRE_FLG = 'Y' then 1
      else 0 end as hospital_mortality
      ,CASE
        WHEN dp.dod                    IS NULL
        OR extract(day from dp.dod-adm.admit_dt)+extract(hour from dp.dod-adm.admit_dt)/24>28
        THEN 0
        ELSE 1
      END AS twenty_eight_day_mortality
      ,CASE
        WHEN dp.dod                    IS NULL
        OR extract(day from dp.dod-adm.admit_dt)+extract(hour from dp.dod-adm.admit_dt)/24>365
        THEN 0
        ELSE 1
      END AS one_year_mortality
      ,CASE
        WHEN dp.dod                    IS NULL
        OR extract(day from dp.dod-adm.admit_dt)+extract(hour from dp.dod-adm.admit_dt)/24>365*2
        THEN 0
        ELSE 1
      END AS two_year_mortality
      ,CASE
        WHEN dp.dod                    IS NULL
        OR extract(day from dp.dod-adm.admit_dt)+extract(hour from dp.dod-adm.admit_dt)/24>365
        THEN 365
        when extract(day from dp.dod-adm.admit_dt) < 0
        then 0
        ELSE extract(day from dp.dod-adm.admit_dt)
        END AS one_yr_survival_days
      , case when dp.dod is null
      or extract(day from dp.dod-adm.admit_dt)+extract(hour from dp.dod-adm.admit_dt)/24>365
      then 1
      else 0
      end as one_yr_censor_flg
      
       ,CASE
        WHEN dp.dod                    IS NULL
        OR extract(day from dp.dod-adm.admit_dt)+extract(hour from dp.dod-adm.admit_dt)/24>365*2
        THEN 365*2
        when extract(day from dp.dod-adm.admit_dt) < 0
        then 0
        ELSE extract(day from dp.dod-adm.admit_dt)
        END AS two_yr_survival_days
      , case when dp.dod is null
      or extract(day from dp.dod-adm.admit_dt)+extract(hour from dp.dod-adm.admit_dt)/24>365*2
      then 1
      else 0
      end as two_yr_censor_flg

    FROM
      admissions adm
     JOIN  patients dp ON dp.subject_id=adm.subject_id
    join comorbidity_scores co on adm.hadm_id=co.hadm_id
  )

select * from raw_elix order by 1,2;
