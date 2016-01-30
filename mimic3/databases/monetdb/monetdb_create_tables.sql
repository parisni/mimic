--------------------------------------------------------
--  File created - Thursday-August-27-2015   
--------------------------------------------------------

-- Set the correct path to data files before running script.

-- Create the database and schema
CREATE USER MIMIC;
CREATE DATABASE MIMIC OWNER MIMIC;
\c mimic;
CREATE SCHEMA MIMICIII;

-- -- Example command for importing from a CSV to a table
-- COPY MIMICIII.admissions 
--     FROM '/home/natus/Projets/mimic/mimic3/csv/ADMISSIONS_DATA_TABLE.csv' 
--     DELIMITER ',' 
--     CSV HEADER;

--------------------------------------------------------
--  DDL for Table ADMISSIONS
--------------------------------------------------------

  CREATE TABLE MIMICIII.ADMISSIONS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ADMITTIME TIMESTAMP(0) NOT NULL, 
	DISCHTIME TIMESTAMP(0) NOT NULL, 
	DEATHTIME TIMESTAMP(0), 
	ADMISSION_TYPE VARCHAR(50) NOT NULL, 
	ADMISSION_LOCATION VARCHAR(50) NOT NULL, 
	DISCHARGE_LOCATION VARCHAR(50) NOT NULL, 
	INSURANCE VARCHAR(255) NOT NULL, 
	LANGUAGE VARCHAR(10), 
	RELIGION VARCHAR(50), 
	MARITAL_STATUS VARCHAR(50), 
	ETHNICITY VARCHAR(200) NOT NULL, 
	DIAGNOSIS VARCHAR(255),
        HAS_IOEVENTS_DATA SMALLINT NOT NULL,
        HAS_CHARTEVENTS_DATA SMALLINT NOT NULL
   ) ;
   
   
-- Example command for importing from a CSV to a table
COPY MIMICIII.ADMISSIONS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/ADMISSIONS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
 
--------------------------------------------------------
--  DDL for Table CALLOUT
--------------------------------------------------------

CREATE TABLE MIMICIII.CALLOUT 
    (   ROW_ID INT NOT NULL,
        SUBJECT_ID INT NOT NULL,
        HADM_ID INT NOT NULL,
        SUBMIT_WARDID INT,
        SUBMIT_CAREUNIT VARCHAR(15),
        CURR_WARDID INT,
        CURR_CAREUNIT VARCHAR(15),
        CALLOUT_WARDID INT,
        CALLOUT_SERVICE VARCHAR(10) NOT NULL,
        REQUEST_TELE SMALLINT NOT NULL,
        REQUEST_RESP SMALLINT NOT NULL,
        REQUEST_CDIFF SMALLINT NOT NULL,
        REQUEST_MRSA SMALLINT NOT NULL,
        REQUEST_VRE SMALLINT NOT NULL,
        CALLOUT_STATUS VARCHAR(20) NOT NULL,
        CALLOUT_OUTCOME VARCHAR(20) NOT NULL,
        DISCHARGE_WARDID INT,
        ACKNOWLEDGE_STATUS VARCHAR(20) NOT NULL,
        CREATETIME TIMESTAMP(0) NOT NULL,
        UPDATETIME TIMESTAMP(0) NOT NULL,
        ACKNOWLEDGETIME TIMESTAMP(0),
        OUTCOMETIME TIMESTAMP(0) NOT NULL,
        FIRSTRESERVATIONTIME TIMESTAMP(0),
        CURRENTRESERVATIONTIME TIMESTAMP(0)
        );

-- Example command for importing from a CSV to a table
COPY MIMICIII.CALLOUT 
    FROM '/home/natus/Projets/mimic/mimic3/csv/CALLOUT_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
    
--------------------------------------------------------
--  DDL for Table CAREGIVERS
--------------------------------------------------------

  CREATE TABLE MIMICIII.CAREGIVERS
   (	ROW_ID INT NOT NULL, 
	CGID INT NOT NULL, 
	LABEL VARCHAR(15), 
	DESCRIPTION VARCHAR(30)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.CAREGIVERS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/CAREGIVERS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table CHARTEVENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.CHARTEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ICUSTAY_ID INT, 
	ITEMID INT, 
	CHARTTIME TIMESTAMP(0), 
	STORETIME TIMESTAMP(0), 
	CGID INT, 
	VALUE VARCHAR(255), 
	VALUENUM DOUBLE PRECISION, 
	UOM VARCHAR(50), 
	WARNING INT, 
	ERROR INT, 
	RESULTSTATUS VARCHAR(50), 
	STOPPED VARCHAR(50)
   ) ;

-- PARTITIONNING
-- CREATE CHARTEVENTS TABLE
CREATE TABLE chartevents_1 ( CHECK ( itemid >= 1  AND itemid < 161 )) INHERITS (chartevents);
CREATE TABLE chartevents_2 ( CHECK ( itemid >= 161  AND itemid < 428 )) INHERITS (chartevents);
CREATE TABLE chartevents_3 ( CHECK ( itemid >= 428  AND itemid < 615 )) INHERITS (chartevents);
CREATE TABLE chartevents_4 ( CHECK ( itemid >= 615  AND itemid < 742 )) INHERITS (chartevents);
CREATE TABLE chartevents_5 ( CHECK ( itemid >= 742  AND itemid < 3338 )) INHERITS (chartevents);
CREATE TABLE chartevents_6 ( CHECK ( itemid >= 3338  AND itemid < 3723 )) INHERITS (chartevents);
CREATE TABLE chartevents_7 ( CHECK ( itemid >= 3723  AND itemid < 8523 )) INHERITS (chartevents);
CREATE TABLE chartevents_8 ( CHECK ( itemid >= 8523  AND itemid < 220074 )) INHERITS (chartevents);
CREATE TABLE chartevents_9 ( CHECK ( itemid >= 220074  AND itemid < 323769 )) INHERITS (chartevents);
	
-- CREATE CHARTEVENTS TRIGGER
CREATE OR REPLACE FUNCTION chartevents_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN


IF ( NEW.itemid >= 1 AND NEW.itemid < 161 ) THEN INSERT INTO chartevents_1 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 161 AND NEW.itemid < 428 ) THEN INSERT INTO chartevents_2 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 428 AND NEW.itemid < 615 ) THEN INSERT INTO chartevents_3 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 615 AND NEW.itemid < 742 ) THEN INSERT INTO chartevents_4 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 742 AND NEW.itemid < 3338 ) THEN INSERT INTO chartevents_5 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 3338 AND NEW.itemid < 3723 ) THEN INSERT INTO chartevents_6 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 3723 AND NEW.itemid < 8523 ) THEN INSERT INTO chartevents_7 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 8523 AND NEW.itemid < 220074 ) THEN INSERT INTO chartevents_8 VALUES (NEW.*);
ELSIF ( NEW.itemid >= 220074 AND NEW.itemid < 323769 ) THEN INSERT INTO chartevents_9 VALUES (NEW.*);
	ELSE
		INSERT INTO chartevents_null VALUES (NEW.*);
       END IF;
RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insert_chartevents_trigger
    BEFORE INSERT ON chartevents
    FOR EACH ROW EXECUTE PROCEDURE chartevents_insert_trigger();

-- Example command for importing from a CSV to a table
COPY MIMICIII.CHARTEVENTS 
FROM '/home/natus/Projets/mimic/mimic3/csv/CHARTEVENTS_DATA_TABLE.csv' 
DELIMITER ',' 
CSV HEADER;

--------------------------------------------------------
--  DDL for Table CPTEVENTS
--------------------------------------------------------

CREATE TABLE MIMICIII.CPTEVENTS
(	ROW_ID INT NOT NULL, 
SUBJECT_ID INT NOT NULL, 
HADM_ID INT NOT NULL, 
COSTCENTER VARCHAR(10) NOT NULL, 
CHARTDATE TIMESTAMP(0), 
CPT_CD VARCHAR(10) NOT NULL, 
CPT_NUMBER INT, 
	CPT_SUFFIX VARCHAR(5), 
	TICKET_ID_SEQ INT, 
	SECTIONHEADER VARCHAR(50), 
	SUBSECTIONHEADER VARCHAR(255), 
	DESCRIPTION VARCHAR(200)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.CPTEVENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/CPTEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table DATETIMEEVENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.DATETIMEEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ICUSTAY_ID INT, 
	ITEMID INT NOT NULL, 
	CHARTTIME TIMESTAMP(0) NOT NULL, 
	STORETIME TIMESTAMP(0) NOT NULL, 
	CGID INT NOT NULL, 
	VALUE TIMESTAMP(0), 
	UOM VARCHAR(50) NOT NULL, 
	WARNING SMALLINT, 
	ERROR SMALLINT, 
	RESULTSTATUS VARCHAR(50), 
	STOPPED VARCHAR(50)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.DATETIMEEVENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/DATETIMEEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table DIAGNOSES_ICD
--------------------------------------------------------

  CREATE TABLE MIMICIII.DIAGNOSES_ICD
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	SEQUENCE INT, 
	ICD9_CODE VARCHAR(20)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.DIAGNOSES_ICD 
    FROM '/home/natus/Projets/mimic/mimic3/csv/DIAGNOSES_ICD_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table DRGCODES
--------------------------------------------------------

  CREATE TABLE MIMICIII.DRGCODES
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	DRG_TYPE VARCHAR(20) NOT NULL, 
	DRG_CODE VARCHAR(20) NOT NULL, 
	DESCRIPTION VARCHAR(255), 
	DRG_SEVERITY SMALLINT, 
	DRG_MORTALITY SMALLINT
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.DRGCODES 
    FROM '/home/natus/Projets/mimic/mimic3/csv/DRGCODES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_CPT
--------------------------------------------------------

  CREATE TABLE MIMICIII.D_CPT
   (	ROW_ID INT NOT NULL, 
	CATEGORY SMALLINT NOT NULL, 
	SECTIONRANGE VARCHAR(100) NOT NULL, 
	SECTIONHEADER VARCHAR(50) NOT NULL, 
	SUBSECTIONRANGE VARCHAR(100) NOT NULL, 
	SUBSECTIONHEADER VARCHAR(255) NOT NULL, 
	CODESUFFIX VARCHAR(5), 
	MINCODEINSUBSECTION INT NOT NULL, 
	MAXCODEINSUBSECTION INT NOT NULL
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.D_CPT 
    FROM '/home/natus/Projets/mimic/mimic3/csv/D_CPT_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_ICD_DIAGNOSES
--------------------------------------------------------

  CREATE TABLE MIMICIII.D_ICD_DIAGNOSES
   (	ROW_ID INT NOT NULL, 
	ICD9_CODE VARCHAR(10) NOT NULL, 
	SHORT_TITLE VARCHAR(50) NOT NULL, 
	LONG_TITLE VARCHAR(255) NOT NULL
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.D_ICD_DIAGNOSES 
    FROM '/home/natus/Projets/mimic/mimic3/csv/D_ICD_DIAGNOSES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_ICD_PROCEDURES
--------------------------------------------------------

  CREATE TABLE MIMICIII.D_ICD_PROCEDURES
   (	ROW_ID INT NOT NULL, 
	ICD9_CODE VARCHAR(10) NOT NULL, 
	SHORT_TITLE VARCHAR(50) NOT NULL, 
	LONG_TITLE VARCHAR(255) NOT NULL
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.D_ICD_PROCEDURES 
    FROM '/home/natus/Projets/mimic/mimic3/csv/D_ICD_PROCEDURES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_ITEMS
--------------------------------------------------------

  CREATE TABLE MIMICIII.D_ITEMS
   (	ROW_ID INT NOT NULL, 
	ITEMID INT NOT NULL, 
	LABEL VARCHAR(200), 
	ABBREVIATION VARCHAR(100), 
	DBSOURCE VARCHAR(20), 
	LINKSTO VARCHAR(50), 
	CODE VARCHAR(20), 
	CATEGORY VARCHAR(100), 
	UNITNAME VARCHAR(100), 
	PARAM_TYPE VARCHAR(30), 
	LOWNORMALVALUE DOUBLE PRECISION, 
	HIGHNORMALVALUE DOUBLE PRECISION
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.D_ITEMS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/D_ITEMS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table D_LABITEMS
--------------------------------------------------------

  CREATE TABLE MIMICIII.D_LABITEMS
   (	ROW_ID INT NOT NULL, 
	ITEMID INT NOT NULL, 
	LABEL VARCHAR(100) NOT NULL, 
	FLUID VARCHAR(100) NOT NULL, 
	CATEGORY VARCHAR(100) NOT NULL, 
	LOINC_CODE VARCHAR(100)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.D_LABITEMS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/D_LABITEMS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table ICUSTAYEVENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.ICUSTAYEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ICUSTAY_ID INT NOT NULL, 
	DBSOURCE VARCHAR(20) NOT NULL, 
	FIRST_CAREUNIT VARCHAR(20) NOT NULL, 
	LAST_CAREUNIT VARCHAR(20) NOT NULL,
	FIRST_WARDID SMALLINT NOT NULL,
	LAST_WARDID SMALLINT NOT NULL,
	INTIME TIMESTAMP(0) NOT NULL, 
	OUTTIME TIMESTAMP(0), 
	LOS DOUBLE PRECISION
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.ICUSTAYEVENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/ICUSTAYEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
    
--------------------------------------------------------
--  DDL for Table IOEVENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.IOEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ICUSTAY_ID INT, 
	STARTTIME TIMESTAMP(0), 
	ENDTIME TIMESTAMP(0), 
	ITEMID INT, 
	VOLUME DOUBLE PRECISION, 
	VOLUMEUOM VARCHAR(30), 
	RATE DOUBLE PRECISION, 
	RATEUOM VARCHAR(30), 
	STORETIME TIMESTAMP(0), 
	CGID BIGINT, 
	ORDERID BIGINT, 
	LINKORDERID BIGINT, 
	ORDERCATEGORYNAME VARCHAR(100), 
	SECONDARYORDERCATEGORYNAME VARCHAR(100), 
	ORDERCOMPONENTTYPEDESCRIPTION VARCHAR(200), 
	ORDERCATEGORYDESCRIPTION VARCHAR(50), 
	PATIENTWEIGHT DOUBLE PRECISION, 
	TOTALVOLUME DOUBLE PRECISION, 
	TOTALVOLUMEUOM VARCHAR(50), 
	STATUSDESCRIPTION VARCHAR(30), 
	STOPPED VARCHAR(30), 
	NEWBOTTLE INT, 
	ISOPENBAG SMALLINT, 
	CONTINUEINNEXTDEPT SMALLINT, 
	CANCELREASON SMALLINT, 
	COMMENTS_STATUS VARCHAR(30), 
	COMMENTS_TITLE VARCHAR(100), 
	COMMENTS_DATE TIMESTAMP(0), 
	ORIGINALCHARTTIME TIMESTAMP(0), 
	ORIGINALAMOUNT DOUBLE PRECISION, 
	ORIGINALAMOUNTUOM VARCHAR(30), 
	ORIGINALROUTE VARCHAR(30), 
	ORIGINALRATE DOUBLE PRECISION, 
	ORIGINALRATEUOM VARCHAR(30), 
	ORIGINALSITE VARCHAR(30)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.IOEVENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/IOEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table LABEVENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.LABEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	ITEMID INT NOT NULL, 
	CHARTTIME TIMESTAMP(0), 
	VALUE VARCHAR(200), 
	VALUENUM DOUBLE PRECISION, 
	UOM VARCHAR(20), 
	FLAG VARCHAR(20)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.LABEVENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/LABEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table MICROBIOLOGYEVENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.MICROBIOLOGYEVENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	CHARTDATE TIMESTAMP(0), 
	CHARTTIME TIMESTAMP(0), 
	SPEC_ITEMID INT, 
	SPEC_TYPE_CD VARCHAR(10), 
	SPEC_TYPE_DESC VARCHAR(100), 
	ORG_ITEMID INT, 
	ORG_CD INT, 
	ORG_NAME VARCHAR(100), 
	ISOLATE_NUM SMALLINT, 
	AB_ITEMID INT, 
	AB_CD INT, 
	AB_NAME VARCHAR(30), 
	DILUTION_TEXT VARCHAR(10), 
	DILUTION_COMPARISON VARCHAR(20), 
	DILUTION_VALUE DOUBLE PRECISION, 
	INTERPRETATION VARCHAR(5)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.MICROBIOLOGYEVENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/MICROBIOLOGYEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table NOTEEVENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.NOTEEVENTS
   (	ROW_ID INT NOT NULL, 
	RECORD_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT, 
	CHARTDATE TIMESTAMP(0), 
	CATEGORY VARCHAR(50), 
	DESCRIPTION VARCHAR(255), 
	CGID INT, 
	ISERROR CHAR(1), 
	TEXT TEXT
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.NOTEEVENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/NOTEEVENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table PATIENTS
--------------------------------------------------------

  CREATE TABLE MIMICIII.PATIENTS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	GENDER VARCHAR(5) NOT NULL, 
	DOB TIMESTAMP(0) NOT NULL, 
	DOD TIMESTAMP(0), 
	DOD_HOSP TIMESTAMP(0), 
	DOD_SSN TIMESTAMP(0), 
	HOSPITAL_EXPIRE_FLAG VARCHAR(5) NOT NULL
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.PATIENTS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/PATIENTS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table PRESCRIPTIONS
--------------------------------------------------------

  CREATE TABLE MIMICIII.PRESCRIPTIONS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ICUSTAY_ID INT, 
	STARTTIME TIMESTAMP(0), 
	ENDTIME TIMESTAMP(0), 
	DRUG_TYPE VARCHAR(100) NOT NULL, 
	DRUG VARCHAR(100) NOT NULL, 
	DRUG_NAME_POE VARCHAR(100), 
	DRUG_NAME_GENERIC VARCHAR(100), 
	FORMULARY_DRUG_CD VARCHAR(120), 
	GSN VARCHAR(200), 
	NDC VARCHAR(120), 
	PROD_STRENGTH VARCHAR(120), 
	DOSE_VAL_RX VARCHAR(120), 
	DOSE_UNIT_RX VARCHAR(120), 
	FORM_VAL_DISP VARCHAR(120), 
	FORM_UNIT_DISP VARCHAR(120), 
	ROUTE VARCHAR(120)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.PRESCRIPTIONS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/PRESCRIPTIONS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table PROCEDURES_ICD
--------------------------------------------------------

  CREATE TABLE MIMICIII.PROCEDURES_ICD
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	PROC_SEQ_NUM INT NOT NULL, 
	ICD9_CODE VARCHAR(20) NOT NULL
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.PROCEDURES_ICD 
    FROM '/home/natus/Projets/mimic/mimic3/csv/PROCEDURES_ICD_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;

--------------------------------------------------------
--  DDL for Table SERVICES
--------------------------------------------------------

  CREATE TABLE MIMICIII.SERVICES
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	TRANSFERTIME TIMESTAMP(0) NOT NULL, 
	PREV_SERVICE VARCHAR(20), 
	CURR_SERVICE VARCHAR(20)
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.SERVICES 
    FROM '/home/natus/Projets/mimic/mimic3/csv/SERVICES_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
 
--------------------------------------------------------
--  DDL for Table TRANSFERS
--------------------------------------------------------

  CREATE TABLE MIMICIII.TRANSFERS
   (	ROW_ID INT NOT NULL, 
	SUBJECT_ID INT NOT NULL, 
	HADM_ID INT NOT NULL, 
	ICUSTAY_ID INT, 
	DBSOURCE VARCHAR(20) NOT NULL, 
	EVENTTYPE VARCHAR(20), 
	PREV_CAREUNIT VARCHAR(20), 
	CURR_CAREUNIT VARCHAR(20), 
	PREV_WARDID SMALLINT,
	CURR_WARDID SMALLINT,
	INTIME TIMESTAMP(0), 
	OUTTIME TIMESTAMP(0), 
	LOS DOUBLE PRECISION
   ) ;

-- Example command for importing from a CSV to a table
COPY MIMICIII.TRANSFERS 
    FROM '/home/natus/Projets/mimic/mimic3/csv/TRANSFERS_DATA_TABLE.csv' 
    DELIMITER ',' 
    CSV HEADER;
