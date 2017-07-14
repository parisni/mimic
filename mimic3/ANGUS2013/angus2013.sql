-- SEPSIS ANGUS 2013
--- @author : Paris N, Aboab J

set search_path TO 'sepsis';

-- CHAP 0 - INFECTION POP
DROP TABLE IF EXISTS ch0_infection_pop CASCADE; CREATE TABLE IF NOT EXISTS ch0_infection_pop( subject_id integer, hadm_id integer);
INSERT INTO ch0_infection_pop (subject_id, hadm_id)(
SELECT DISTINCT subject_id, hadm_id FROM mimiciii.diagnoses_icd WHERE icd9_code IN ('03284','59781','36402','6142','68601','07889','37040','01710','0461','32341','07071','1339','59011','73078','V0254','0411','1177','6869','71194','64743','0389','69277','56210','04105','37602','1276','71520','01306','0509','01881','6163','0222','09833','0907','5552','0020','1111','1252','V018','1118','73084','0709','V020','V036','46451','V050','01090','57141','64754','V752','01011','01555','07271','06649','07959','01200','0880','6148','01313','37901','69553','64750','56781','09832','0066','1105','00861','0949','37022','0625','79552','6968','01480','73037','71126','38200','01120','0229','1305','09816','5400','0844','71179','01704','0971','01103','V1204','V739','46410','0270','73072','V033','71195','01762','07272','1201','00324','01693','1368','09940','07798','48241','01614','37603','37902','09830','0510','V1200','01550','01802','71175','1251','68102','01155','V0970','1272','5401','01650','01554','0662','0319','69515','09389','01360','3236','1268','6908','09814','71158','0823','4843','1223','01600','01330','0548','0542','V758','0272','56739','V068','01571','V016','5691','01212','36304','56722','36313','53641','0774','71115','73018','73099','3208','37213','01344','1160','V0252','0380','0041','3211','73095','34122','47402','1348','09815','00862','37731','5119','01583','1329','71125','09841','6150','00841','01744','01215','01774','37221','05320','V022','01690','01743','7908','01586','71532','71111','0930','0943','0871','01381','3229','73022','01301','71534','1220','0702','2892','09952','1300','0019','09486','09321','32372','00804','71510','01522','64741','11289','6145','01353','01594','64732','V286','09322','01343','04611','36305','73097','09040','0987','1371','01192','71104','V047','V053','0760','01781','01385','32381','3735','1254','01771','03689','73023','71163','37532','0739','00329','4820','01701','04501','4838','01135','47411','64731','01503','01153','1398','1320','V120','V756','1142','4644','0392','V0181','01156','6949','56202','01605','09152','V0950','1020','56211','60490','4831','01232','V753','0213','1129','99591','09381','0308','0080','01382','01184','1370','01233','09161','05379','37033','01592','V064','73076','1141','01502','73098','0538','73008','0369','0598','V735','1224','0321','0075','73081','48281','1318','5959','0331','01625','V013','1032','05474','0738','01333','1308','0846','5566','01096','01092','6988','0794','05473','3822','3238','64723','1110','59081','1369','09482','0906','01205','71524','V019','01712','01486','48881','01633','0092','36423','71191','32382','V0991','5130','6945','37233','71531','V051','1028','1211','48242','36002','01645','36001','0632','01570','1253','01702','01665','99669','0820','0720','9966','01634','37054','01323','1103','0798','36004','48240','57401','0085','37239','69555','0639','00321','1161','73000','01884','05411','0729','07888','1122','1174','71132','01552','11599','5733','5430','1124','5690','01352','00847','09836','0048','71199','11592','01220','05319','01181','3214','0629','01356','64711','05101','71167','01520','73085','05882','37230','0980','36400','01893','0501','V1201','09950','04184','0669','37543','0062','73012','09951','0942','6080','1373','71515','0410','01566','71136','0528','0951','05921','0230','37212','71521','V736','0771','11501','0471','64704','47400','01183','71124','9993','6826','71511','V0482','6012','0779','0796','6805','01485','06642','05821','01310','0864','36307','73020','0399','37222','V090','V742','37311','0651','73014','37220','64761','71590','64742','0550','61681','79571','0309','V0189','71140','3738','07052','3207','09885','01585','56949','01666','71535','01196','0499','07020','0462','01391','0609','V746','7856','0668','0901','46619','0318','0529','37301','64791','01733','59780','6808','71530','0030','1239','69511','71156','71116','01163','01280','11519','0429','59582','03281','0851','0990','0743','01752','01106','1162','01393','0865','0863','1200','V0259','0330','04110','1365','01116','36300','37732','01753','01354','32301','01632','4829','0832','01624','01883','79519','1112','01091','73092','V757','0339','09181','4661','71127','73083','01320','3708','04081','4847','71161','1349','04503','V7183','01553','48284','73032','0233','0840','1108','99667','01654','0088','4846','37962','01235','71594','37034','1033','6944','01341','01224','07951','V027','32302','V0182','5950','00801','37031','08881','6164','1026','01764','73024','01484','09953','71130','71538','0202','0740','01122','07054','01401','71533','37963','V744','0859','1031','64762','71176','5952','0889','37503','1269','3203','36410','01660','01145','5110','1104','64721','01390','71105','V0171','37205','46421','1040','01000','01206','V1203','1229','01101','0363','48282','V0251','05910','00845','08249','01141','48230','1256','6948','01326','0220','1275','01283','59589','01134','5563','48809','99762','5902','V0381','V749','09954','99859','69512','71514','01086','0706','01013','04102','0919','71143','73089','4845','71525','0770','1144','5118','0260','1321','37201','01603','56203','5951','09882','6820','3210','6959','64700','1372','01114','00581','0914','5692','07053','01646','V0179','0081','0852','1025','00867','71151','01383','48882','57142','03843','00846','01111','4610','37611','0338','V069','07999','01003','01396','09484','01613','04523','01635','73016','71123','05321','59800','71118','37059','71196','04186','61610','1048','71110','0952','04521','4808','01403','0279','0498','6084','09169','37733','64764','09949','1109','01783','0043','71518','37021','11595','71188','V740','0402','03810','36308','73027','07998','73074','0931','V0184','V733','0011','09320','0778','71184','01606','64714','32352','V092','0994','71103','13101','36312','07953','V038','V021','07023','01572','73075','71182','64783','0900','05609','1039','01014','1234','64760','V096','V7398','71522','5120','6140','09883','37907','01131','4748','0700','69018','01126','0929','V0489','0221','0074','01095','01695','7953','73070','04591','71152','37501','6807','05829','01610','48802','01661','V7388','00843','0781','V066','05909','01644','1030','69514','01573','0204','07070','3200','37313','1259','2891','6954','0310','68110','37900','0628','73039','0054','01766','0382','99592','09819','37905','01202','0029','4800','05679','04679','56213','V093','1202','6980','0819','37302','71135','64753','V0990','00800','04500','71159','0728','4731','5695','07982','6800','5954','01735','37502','99932','0810','0620','0091','6962','01124','V061','0468','01080','05811','37906','0862','0622','1279','1176','37909','07989','06641','51901','01671','07049','01700','04513','01593','07988','37601','71107','01110','1338','05371','01223','V750','37542','01380','13109','07811','71181','01720','73013','01123','01791','05922','09955','01780','37610','0664','V063','0360','0340','01384','01144','6823','01082','1106','01620','32363','1271','0653','01506','4841','71108','3929','01483','05410','36314','38202','37531','5909','0954','36311','0311','71593','01763','71180','01182','64780','5409','0957','07981','01511','1210','36012','0022','07032','09852','4742','1274','71160','71512','01805','71128','71500','56201','01194','V029','0082','0601','09324','0652','36322','00323','48889','09840','0912','V015','01746','73030','0071','6821','01125','01656','6019','01694','04502','79531','5559','01362','71154','1301','71580','6825','01705','0701','71536','4809','36320','69461','0551','0061','00865','0540','00866','0320','0658','68111','04672','4830','60491','5070','V0262','56729','37533','3821','36405','0073','01792','1261','51189','01672','27919','0502','05812','01350','1233','01324','01226','37032','01004','V7399','32342','53086','6159','71592','01203','0953','36301','6952','0911','71187','46430','01726','60499','11515','04182','64733','62571','48289','0783','01563','03681','0902','0530','71138','0993','01642','01281','6801','69552','71146','44024','0737','0418','V0382','5561','71162','37961','79675','1360','V040','1342','01584','11500','01560','6950','01643','01083','0822','07041','01756','99931','01773','V712','0511','1270','3218','71153','00322','05311','73080','01322','V028','61611','46450','01210','0568','48283','0521','64712','04590','4613','0986','07043','V012','64730','71537','0322','0238','0741','71178','0420','6822','01325','4618','5672','09837','01392','1363','01616','0630','73017','07279','09859','4749','01740','V042','01804','01716','01673','0412','0853','1000','13629','68100','09851','0090','0909','37020','01346','01581','4660','01222','71165','1236','V023','04181','05919','03289','6168','37734','01002','05444','01143','09834','1222','3222','1288','09049','79515','0205','0068','01590','03840','37210','01760','0209','0999','0042','36310','71190','57149','0208','0654','0086','01651','73086','1101','32081','1281','01282','01731','64713','04149','11283','3209','0979','04189','03819','0083','01402','0600','01340','73029','07950','71596','99663','V7381','05810','46411','0599','V743','01713','05441','6971','01754','03842','69519','01636','09189','73009','71100','0704','5731','37612','01225','1304','6861','5550','04593','01113','6031','1171','64763','5651','0210','01653','0843','1390','37202','6824','01676','01724','4871','0383','73079','11512','01696','78491','1340','57400','71504','3234','01604','47410','1024','0703','01894','01596','6941','01165','0543','1302','71171','01514','01892','6953','0239','0956','37204','01513','09323','71192','05571','56941','6803','01562','V010','3230','56738','06640','99661','01796','00320','64702','05889','71113','6868','01216','36000','01655','4612','08882','71109','0838','77181','09487','0748','51284','V065','0854','0730','0416','09849','01171','05102','01175','07022','1021','32362','56789','04520','7956','00809','6160','37052','68101','5565','01190','71591','05579','71134','V755','48239','0941','36421','1143','6802','71164','01652','37604','37730','01734','1215','01736','01093','0400','37530','71513','0231','07033','47412','04143','5568','5646','01565','7958','1029','01523','1330','00589','09843','0078','1225','73025','1009','5128','V017','0478','03283','71198','0401','0917','0578','0432','01510','0059','V0261','36403','6819','01331','0791','01784','4870','01772','01302','1170','6169','1364','5903','1374','99668','48819','71131','64710','01285','71527','99666','05449','V0971','03285','1113','3734','6806','V045','37541','0063','64720','0422','01010','0845','1119','09941','01755','0982','0829','0812','05912','71169','01015','69556','11284','0300','99665','64722','1250','05443','09850','1323','01161','1172','51281','V0253','71122','0414','0403','6984','07059','01176','0784','71193','56200','03812','56782','01623','1226','07799','0790','0660','61650','V031','0271','64784','4640','37203','0659','56943','46401','04082','37024','71177','0888','03844','0218','0527','07882','01890','0031','V060','4802','0811','01785','01741','01556','3824','01316','6970','0201','0040','V025','V062','01482','0232','5678','71121','01105','01564','5670','64790','0621','05600','1218','V754','37215','73082','0722','5970','04101','07881','V058','01172','04671','01361','01621','11511','64792','6964','71145','73026','0539','01516','0624','0050','07983','05881','01761','71197','56212','07030','11591','01515','05412','01193','73001','3232','01770','V748','05601','01112','01803','01715','0381','09182','0569','01663','09162','37331','01711','79505','09489','6013','51283','0302','37960','13621','04185','1341','2893','0051','6071','01714','V7389','0052','4821','0785','1175','01365','71157','01231','0301','01221','36011','9985','0522','51289','71120','05314','0828','V731','1208','5439','48249','01601','71119','1123','0433','1179','00869','0312','1102','09817','48801','V745','05920','01284','6040','01640','1280','6850','01364','73002','01136','73028','V094','99851','09853','0440','6851','4823','05419','01674','07051','69276','01732','0769','37206','37211','0579','01334','0430','0849','5562','71133','01311','71150','01321','71516','01230','01504','1209','71595','0913','01142','73006','V037','73094','5671','01765','V0981','99662','0650','3249','0663','0072','71523','0773','64751','6979','64782','09483','0261','3221','4732','0661','01526','01164','09835','05900','3237','0039','69460','0049','V032','01751','08241','04183','6982','04100','71589','3201','1216','69551','4740','3829','57410','71142','1263','V0951','79679','0958','01706','0490','0200','V052','01500','13100','64781','V044','3709','71517','0211','1273','6162','73077','01345','01170','0830','04042','01005','64744','V741','99664','6978','79539','3739','0394','11505','0772','37333','01016','V091','01152','09810','73090','1145','V0980','6804','01394','01885','01775','00803','01891','36422','V059','1232','4733','37613','03682','3241','0093','6147','71129','0861','73038','01703','3231','07044','0070','01146','71117','71139','0780','01366','1027','71144','1121','1227','V048','69554','V043','4803','01094','4848','56944','1149','5569','09382','64734','64793','01102','59010','0848','0842','0303','79551','32351','09041','V026','01133','01303','68609','01615','V0481','V1209','09881','1120','73087','01151','01521','09151','37312','37300','7907','0413','1277','11509','01626','09481','4730','3736','00849','6940','01742','1289','01723','0910','36411','6011','01782','01641','0278','37055','0500','73091','0799','0421','0212','01886','64703','6144','03849','01186','01630','01611','01173','04592','0998','05413','0228','07021','01286','01130','71598','73011','05442','01730','71173','1100','01800','0839','1362','6072','6963','71170','01406','05901','01312','71183','0545','71147','0792','V0389','01300','01405','10081','0623','61651','01001','71186','05322','27910','0905','07952','6149','09485','07819','37904','09886','01336','48232','0398','01580','0491','01512','73010','01595','37050','5650','6989','1219','0841','0361','0393','37049','7854','01576','01191','01395','32361','04119','01591','6827','05310','0638','0323','0903','01185','01882','4828','09042','4739','73093','01786','73003','1391','5551','6942','00842','0950','69559','4659','01386','1307','0847','5109','6943','6981','37739','01195','71528','0439','37332','1203','11502','1322','7806','04111','7955','0855','59801','0388','4658','71185','10089','0341','1173','73034','0860','00863','01691','01335','01180','V730','0053','59000','0362','71189','05313','V0260','64701','01140','01662','56942','1178','01801','69011','64752','73088','71526','04109','01794','01745','0520','73004','V759','01006','1213','V751','36303','01895','01505','71101','V035','01104','01150','6983','01725','0831','37903','05472','V011','1238','1214','01400','71137','V134','00802','5564','0570','01501','1125','01204','0203','V734','36424','37600','05312','6018','04141','01582','01896','0870','0869','V046','6951','3239','4878','0787','71102','1212','01551','0705','78060','13102','0021','37500','71106','4881','V0183','73035','01575','V039','5100','3202','09884','0069','5111','36306','01332','48811','00844','05671','0329','73033','6828','46431','0549','32089','01166','69513','09959','0955','0449','37035','6965','0223','37200','07810','04103','79579','36321','36401','73071','4824','0559','6960','59789','71166','0479','0415','09813','6809','73073','13103','0038','01675','01721','11590','08889','07812','09889','01631','1257','03811','73036','01154','69557','0023','V024','01315','69010','1255','0723','32371','48812','0269','11510','36013','01776','0879','V054','3240','6143','01314','0940','08240','V041','4801','07042','01806','4738','04089','01612','09842','69581','0850','34120','01012','48231','04510','0782','71509','4822','69550','46400','0546','01342','1262','09811','V030','3643','0939','69589','71149','0469','71114','71168','0793','73019','5990','0460','4880','36315','01355','36019','1022','37023','0390','01692','05471','04522','5732','1231','73015','0065','0721','0058','01115','78061','04104','01236','04512','V738','37214','V1202','09956','01561','5171','0010','71155','01160','38201','0463','01880','3212','99660','46611','32082','37334','01351','0417','04511','6151','1278','73007','56723','99933','1221','09839','11282','01404','07031','4611','01162','01174','56721','0519','01081','01622','37044','59001','64724','V014','V732','01790','01670','09812','0079','4650','69012','01100','05911','73005','09150','04112','6010','1309','71112','5679','71597','0419','0821','69558','59080','V0269','1228','64740','01305','05479','0970','68600','46420','01304','3823','57411','01602','71148','05329','73096','04619','01574','64794','0558','01213','3235','57140','01084','0060','6141','36014','04142','3213','0761','6829','01750','1319','34121','1023','01234','0391','01795','01525','51282','00864','3220','01363','0991','1230','71141','1260','73021','69510','6860','01121','01132','71172','0512','V034','71174','01214','6014','5560','01524','03841','05440','0959','1361','1140','0470','4619','1235','09831','01085','0219','01793','01211','59581','01201','0431','0920','V7182','37231','73031','0992','36003','0064','11285','01722','6961','5953','01664','36404','01481','1049','0786','61689','0631','47401')
);

-- CHAP 1 - GENERAL VARS 
-- TODO: WEIGHT as LBS / KG -> precise itemid -> only kg are valuable
-- TODO: WEIGHT 24h/48/72h -> precise window
-- TODO: Temperature as C / F -> precise itemid -> done

DROP TABLE IF EXISTS ch1_general_vars_temp; CREATE TABLE IF NOT EXISTS ch1_general_vars_temp( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch1_general_vars_temp (subject_id, hadm_id, charttime)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id, charttime
    FROM mimiciii.chartevents ce
    WHERE
		( ce.itemid IN (  676, 677, 3655 ) AND ce.valuenum NOT BETWEEN 36 AND 38.3 )  -- temperature celcius
		OR ( ce.itemid IN ( 3652, 3654, 678, 679, 6643 ) AND ce.valuenum NOT BETWEEN 96.8 AND 101 )  -- temperature faren
);
DROP TABLE IF EXISTS ch1_general_vars_hr;CREATE TABLE IF NOT EXISTS ch1_general_vars_hr( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch1_general_vars_hr (subject_id, hadm_id, charttime)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id, charttime
    FROM mimiciii.chartevents ce
    WHERE
		( ce.itemid IN (220045, 220048, 211) AND ce.valuenum > 90) --  heart rate 
);
DROP TABLE IF EXISTS ch1_general_vars_rr; CREATE TABLE IF NOT EXISTS ch1_general_vars_rr( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch1_general_vars_rr (subject_id, hadm_id, charttime )(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id, charttime
    FROM mimiciii.chartevents ce
    WHERE
		(ce.itemid IN (618, 614, 615, 618, 651, 1151, 1884, 3603, 3337) AND ce.valuenum > 20) -- respi rate
);
DROP TABLE IF EXISTS ch1_general_vars_glasgow; CREATE TABLE IF NOT EXISTS ch1_general_vars_glasgow( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch1_general_vars_glasgow (subject_id, hadm_id, charttime)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id, charttime
    FROM mimiciii.chartevents ce
    WHERE
		( ce.itemid IN (198) AND ce.valuenum < 13 ) -- glasgow
);
DROP TABLE IF EXISTS ch1_general_vars_gly; CREATE TABLE IF NOT EXISTS ch1_general_vars_gly( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch1_general_vars_gly (subject_id, hadm_id, charttime)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id, charttime
    FROM mimiciii.chartevents ce
    WHERE
		( ce.itemid IN (2338, 2416, 1529, 1812,807,811, 1310, 3447, 1455,3744, 3745, 225664,228388, 220621, 226537) AND ce.valuenum > 120 AND NOT EXISTS (-- GLYCEMIE  mg/dl without diabete (icd9)
				SELECT 1 
				FROM mimiciii.chartevents ce2 
				WHERE 
				ce.subject_id = ce2.subject_id 
				AND ce.hadm_id = ce2.hadm_id 
				AND ce.icustay_id = ce2.icustay_id 
				AND ce2.itemid IN ( 250, 648 )
			)
		)  
);
DROP TABLE IF EXISTS ch1_general_vars_fluid; CREATE TABLE IF NOT EXISTS ch1_general_vars_fluid( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch1_general_vars_fluid (subject_id, hadm_id, charttime)(
	with weightForFluidBalance as (--GENERAL VAR : icu where weight variation up to 2 kg
		-- TODO : weight in LBS
		WITH    rows AS
		(
			SELECT subject_id, hadm_id, icustay_id, valuenum, itemid, charttime, ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn 
			FROM    mimiciii.chartevents
			WHERE  itemid IN (763, 224639 --kg only because other data are strange  cf csv
				--  3580, -- !! poids nouveau nés ?
				--  3581, 3582, 3693,224639, 226512, 226531
			)
		),
		diff AS (
			SELECT  mc.subject_id, mc.charttime, mc.hadm_id, mc.icustay_id,mp.itemid, mp.valuenum - mc.valuenum   as diffe, mc.valuenum, mp.charttime - mc.charttime   as diffetime, mc.valuenum as w1, mp.valuenum as w2
			FROM    rows mc
			JOIN    rows mp
			ON       mc.icustay_id = mp.icustay_id
			-- ON      mc.rn = mp.rn - 1 -->not successiv but all combinaisons
		) 
		SELECT  subject_id, hadm_id, charttime
		FROM diff 
		WHERE (diffetime  BETWEEN '0 day'::INTERVAL AND '1 day'::INTERVAL  AND w2 - w1 > w1 * 0.02  -- dépendant du poids cad 20g / kg cad 20ml/kg
			OR diffetime  BETWEEN '1 day'::INTERVAL AND '2 day'::INTERVAL  AND w2 - w1 > w1 * 0.04  -- dépendant du poids cad 20g / kg cad 20ml/kg
			OR diffetime  BETWEEN '2 day'::INTERVAL AND '3 day'::INTERVAL  AND w2 - w1 > w1 * 0.06)  -- dépendant du poids cad 20g / kg cad 20ml/kg
	)
	SELECT DISTINCT * FROM weightForFluidBalance
);

-- CHAP 2 INFLA VARS
-- immature form => NO WAY
-- TODO: Procalcitonin is missing ? => YES
-- TODO: ALISATAIR immature band forms from labevents as ITEMID = 51144; WHEN > 10%
DROP TABLE IF EXISTS ch2_infla_vars_wb; CREATE TABLE IF NOT EXISTS ch2_infla_vars_wb( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch2_infla_vars_wb (subject_id, hadm_id, charttime)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id, charttime
	FROM
	mimiciii.chartevents ce
	WHERE  
	( ce.itemid IN ( 1542, 1127, 861, 4200 ) AND ce.valuenum NOT BETWEEN 4000 AND 12000 )  --GENERAL VAR - WHITE BLOOD CELL
);

DROP TABLE IF EXISTS ch2_infla_vars_crp; CREATE TABLE IF NOT EXISTS ch2_infla_vars_crp( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch2_infla_vars_crp (subject_id, hadm_id, charttime)(
	SELECT  DISTINCT   ce.subject_id, ce.hadm_id, charttime
	FROM
	mimiciii.chartevents ce
	WHERE  
	( ce.itemid IN ( 227444, 220612 ) AND ce.valuenum > 15 ) -- GENERAL VAR - CRP !! justification neccess
);


-- CHAP 3 HEMO_VARS
DROP TABLE IF EXISTS ch3_hemo_vars_hypo_art; CREATE TABLE IF NOT EXISTS ch3_hemo_vars_hypo_art( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch3_hemo_vars_hypo_art (subject_id, hadm_id, charttime)(
	SELECT DISTINCT ce.subject_id, ce.hadm_id, charttime
	FROM 
	mimiciii.chartevents ce
    WHERE valuenum IS NOT NULL AND (
	-- BEGIN HEMODYNAMIQ VARIABLES
	--1. arterial hypotension
	(ce.itemid IN (442, 455, 480, 482, 484, 6, 51, 55, 6701, 224167, 224309, 225309, 224652, 227243, 228152, 220050, 220179) AND ce.valuenum < 90 ) OR --systolic pressure | 29206 ENLEVÉ POUR SELECTIVITÉ
	(ce.itemid IN ( 220052, 220181, 443, 456, 52, 224, 5731, 2647, 2294, 2732, 6702, 224322, 225312, 220052, 220181 ) AND ce.valuenum < 70 ) --mean arterial pressure | 44231 ENLEVÉ POUR SELECTIVITÉ
)
);
DROP TABLE IF EXISTS ch3_hemo_vars_mix_ven; CREATE TABLE IF NOT EXISTS ch3_hemo_vars_mix_ven( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch3_hemo_vars_mix_ven (subject_id, hadm_id, charttime)(
	SELECT DISTINCT ce.subject_id, ce.hadm_id, charttime
	FROM 
	mimiciii.chartevents ce
    WHERE valuenum IS NOT NULL AND (
	--2elevated mixed venous ox sat | 5540
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 70)
)
);
DROP TABLE IF EXISTS ch3_hemo_vars_card_index; CREATE TABLE IF NOT EXISTS ch3_hemo_vars_card_index( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch3_hemo_vars_card_index (subject_id, hadm_id, charttime)(
	SELECT DISTINCT ce.subject_id, ce.hadm_id, charttime
	FROM 
	mimiciii.chartevents ce
    WHERE valuenum IS NOT NULL AND (
	--3 elevated cardiac index | 7962
	(ce.itemid IN ( 823 , 227686 , 225674 ) AND ce.valuenum > 3.5)
)
);

-- CHAP 4 ORGAN DISFONC
-- paralithiq ileus => NO WAY
-- TODO: Manage Units problems mmHG, klPascal
-- TODO: ALISTAIR: fio2 before pao2
DROP TABLE IF EXISTS ch4_organ_dysf_art_hypox; CREATE TABLE IF NOT EXISTS ch4_organ_dysf_art_hypox ( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch4_organ_dysf_art_hypox (subject_id, hadm_id, charttime) (
WITH 
		po2 AS (SELECT subject_id, hadm_id, icustay_id, charttime, valuenum FROM mimiciii.chartevents WHERE itemid IN (3837, 3838, 3785) --po2  , 227039 is false
		),
		fio2 AS (SELECT subject_id, hadm_id, icustay_id, charttime, valuenum FROM mimiciii.chartevents WHERE itemid IN (3420)-- fio2 , 227010,227009, 226754, 7570, 2981, 3420 are false 
		),
	 arterialHypox as (
		SELECT DISTINCT po2.subject_id, po2.hadm_id, po2.charttime
		FROM po2 po2
		JOIN fio2 fio2 USING (icustay_id)
		WHERE po2.charttime - fio2.charttime BETWEEN '-10 min'::INTERVAL AND '10 min'::INTERVAL
		AND (po2.valuenum / (fio2.valuenum/100)) < 300 --!! unités : po2 = mmHG (!=klpascal) & fio2 = % (si fraction => )
	) -- 1121 hadm
	SELECT *
	FROM arterialHypox
);

DROP TABLE IF EXISTS ch4_organ_dysf_creat; CREATE TABLE IF NOT EXISTS ch4_organ_dysf_creat( subject_id integer, hadm_id integer, charttime timestamp);
-- TODO: variable window on diffetime ch4_organ_dysf_creat -> test
INSERT INTO ch4_organ_dysf_creat (subject_id, hadm_id, charttime) (
	WITH ch4_organ_dysf_creat as(--GENERAL VAR : 0.5 or 44
WITH tmp as (SELECT * FROM mimiciii.chartevents 
	WHERE itemid IN (791, 1525) --3750, 220615 are removed because value strange & few record
),
  rows as (                      SELECT subject_id, hadm_id, icustay_id, valuenum, itemid, charttime, ROW_NUMBER() OVER (ORDER BY subject_id, hadm_id, icustay_id, charttime) AS rn
                        FROM    tmp),
			
                diff AS (
                        SELECT  mc.subject_id, mc.hadm_id, mc.charttime, mc.icustay_id,mp.itemid, mp.valuenum - mc.valuenum   as diffe, mc.valuenum, mp.charttime - mc.charttime   as diffetime, mc.valuenum as w1, mp.valuenum as w2
                        FROM    rows mc
                        JOIN    rows mp
                        ON       mc.icustay_id = mp.icustay_id
                ),
                pop as (SELECT DISTINCT subject_id, hadm_id, charttime
                FROM diff WHERE diffe > 0.3 AND diffetime BETWEEN '0 day' AND  '2 day' )
	SELECT * FROM pop  --all are mg/dL
	)
	SELECT DISTINCT * FROM ch4_organ_dysf_creat
);-- ch4_organ_dysf_creat | 6695

DROP TABLE IF EXISTS ch4_organ_dysf_thromb; CREATE TABLE IF NOT EXISTS ch4_organ_dysf_thromb( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch4_organ_dysf_thromb (subject_id, hadm_id, charttime) (
	SELECT ce.subject_id, ce.hadm_id, charttime
	FROM 
	mimiciii.chartevents ce
    WHERE
        (
	--thromb !! 
	(ce.itemid IN ( 844 , 1537 , 227465 , 227469) AND ce.valuenum > 60 ) --les unités semblent etre en secondes -- thromb | 351
        )
);
DROP TABLE IF EXISTS ch4_organ_dysf_billi; CREATE TABLE IF NOT EXISTS ch4_organ_dysf_billi( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch4_organ_dysf_billi (subject_id, hadm_id, charttime) (
	SELECT ce.subject_id, ce.hadm_id, charttime
	FROM 
	mimiciii.chartevents ce
    WHERE
        (
	( ce.itemid IN ( 4948, 225651, 225690 ) AND valueuom ILIKE 'mg/dL' AND ce.valuenum > 4) -- BILLIRUBIN !! il faut aussi traduire d'autres unités | 1400
        )
);
DROP TABLE IF EXISTS ch4_organ_dysf_plat; CREATE TABLE IF NOT EXISTS ch4_organ_dysf_plat( subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch4_organ_dysf_plat (subject_id, hadm_id, charttime) (
	SELECT ce.subject_id, ce.hadm_id, ce.charttime
	FROM 
	mimiciii.chartevents ce
    WHERE
        (
	( ce.itemid IN ( 225678, 227457, 828, 3789, 6256 ) AND ce.valuenum < 100 ) -- platelet !! UNITÉ À VÉRIF | | 54737 ENLEVÉ POUR SELECTIVITÉ
        )
);
DROP TABLE IF EXISTS ch4_organ_dysf_urin; CREATE TABLE IF NOT EXISTS ch4_organ_dysf_urin(subject_id integer, hadm_id integer, charttime timestamp);
INSERT INTO ch4_organ_dysf_urin (subject_id, hadm_id, charttime) (
WITH urine AS (SELECT subject_id, hadm_id, icustay_id, value, charttime, ROW_NUMBER() OVER(PARTITION BY icustay_id ORDER BY charttime) as position 
FROM mimiciii.outputevents WHERE  itemid IN (40055, 40069, 40094, 40715, 226627)  ),
              tmp as ( SELECT o1.subject_id, o1.hadm_id,  o1.position, o2.position, o1.charttime, EXTRACT(epoch FROM (o2.charttime - o1.charttime))/3600 as duree, coalesce(o2.value,o1.value) as val,   
               coalesce(o2.value,o1.value) / (EXTRACT(epoch FROM (o2.charttime - o1.charttime))/3600) vol_per_hour, 
               CASE WHEN (coalesce(o2.value,o1.value) / (EXTRACT(epoch FROM (o2.charttime - o1.charttime))/3600) < 22.5 AND EXTRACT(epoch FROM (o2.charttime - o1.charttime))/3600 >=2) THEN 
               TRUE 
               END as result 
               FROM urine o1
               LEFT JOIN urine o2 
               ON 
               o1.icustay_id = o2.icustay_id 
               AND o1.position = o2.position -1 
               AND o1.charttime <> o2.charttime) 
               SELECT subject_id, hadm_id, charttime FROM tmp WHERE result IS TRUE
);

-- CHAP 5 TISSU_PERF
--marbrures  => no way
--time recolor => no way
DROP TABLE IF EXISTS ch5_tissue_perf;
CREATE TABLE IF NOT EXISTS ch5_tissue_perf(
	subject_id integer,
	hadm_id integer,
	charttime timestamp
);
INSERT INTO ch5_tissue_perf (subject_id, hadm_id, charttime) (
	SELECT  DISTINCT ce.subject_id, ce.hadm_id, charttime
	FROM mimiciii.chartevents ce
    WHERE
	-- BEGIN TISSUS PERF  VARIABLES
	--hyperlacatemei
	( ce.itemid IN ( 818, 1531, 225668 ) AND ce.valuenum > 1 AND valuenum < 155 ) -- lactate  unité  mmmol/L ! BORNE SUP 155
UNION
	SELECT subject_id, hadm_id, charttime FROM mimiciii.labevents WHERE itemid = 50813 AND valuenum >1 AND valuenum < 155
);

--
--
-- CALCULUS
--
--
DROP TABLE IF EXISTS work_simult_approx CASCADE;
CREATE  TABLE work_simult_approx(
	hadm_id integer,
	charttime timestamp,
	type integer
);
-- ANGUS
DROP TABLE IF EXISTS sepsis_angus;
CREATE TABLE  sepsis_angus AS
SELECT distinct hadm_id 
FROM 
(
SELECT distinct hadm_id 
FROM mimiciii.diagnoses_icd 
WHERE icd9_code ~ '^614|^021|^032|^575.0|^681|^016|^026|^094|^599.0|^008|^023|^104|^461|^324|^034|^098|^040|^463|^569.5|^039|^513|^485|^013|^682|^790.7|^027|^541|^111|^117|^009|^030|^015|^481|^562.03|^320|^001|^486|^018|^711.0|^017|^114|^510|^451|^011|^031|^041|^033|^003|^569.83|^024|^572.1|^095|^616|^590|^012|^103|^597|^615|^562.11|^996.6|^091|^572.0|^020|^110|^002|^566|^035|^482|^004|^686|^092|^421|^038|^116|^005|^325|^096|^097|^101|^562.13|^540|^999.3|^567|^465|^093|^542|^462|^494|^036|^090|^322|^025|^022|^100|^491.21|^115|^998.5|^010|^562.01|^102|^037|^464|^420|^118|^730|^014|^112|^601|^683'
INTERSECT
SELECT distinct hadm_id
FROM mimiciii.diagnoses_icd
WHERE icd9_code ~ '^785.5|^458|^96.7|^348.3|^293|^348.1|^287.4|^287.5|^286.9|^286.6|^570|^573.4|^584'
) as tmp;

-- tmp_lactate
TRUNCATE work_simult_approx;
INSERT INTO work_simult_approx 
SELECT hadm_id, date_trunc('hour', charttime), 1 FROM mimiciii.labevents WHERE itemid = 50813 AND valuenum >= 2 UNION ALL
SELECT hadm_id, date_trunc('hour', starttime), 2 FROM mimiciii.mp_dobutamine JOIN mimiciii.icustays USING (icustay_id) UNION ALL
SELECT hadm_id, date_trunc('hour', starttime), 3 FROM mimiciii.mp_dopamine JOIN mimiciii.icustays USING (icustay_id) UNION ALL
SELECT hadm_id, date_trunc('hour', starttime), 4 FROM mimiciii.mp_epinephrine JOIN mimiciii.icustays USING (icustay_id) UNION ALL
SELECT hadm_id, date_trunc('hour', starttime), 5 FROM mimiciii.mp_norepinephrine JOIN mimiciii.icustays USING (icustay_id);

DROP MATERIALIZED VIEW IF EXISTS ch2;
CREATE MATERIALIZED VIEW ch2 AS 
with 
tmp AS (SELECT distinct hadm_id, charttime + interval '1h' * generate_series as moment, type FROM work_simult_approx, (SELECT * FROM generate_series(-12,12) ) AS t),
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, moment FROM tmp GROUP BY hadm_id, moment)
SELECT  distinct hadm_id, arr, moment FROM moment WHERE array_length(arr,1) >= 2;

DROP MATERIALIZED VIEW IF EXISTS tmp_lactate CASCADE;
CREATE MATERIALIZED VIEW tmp_lactate AS 
with 
tmp AS (SELECT distinct hadm_id, charttime + interval '1h' * generate_series as moment, type FROM work_simult_approx, (SELECT * FROM generate_series(-12,12) ) AS t),
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, moment FROM tmp GROUP BY hadm_id, moment)
SELECT  distinct hadm_id, arr, moment FROM moment WHERE  '{1}' && arr AND array_length(arr,1) >= 2;

--SEPSIS ACCP
TRUNCATE work_simult_approx;
INSERT INTO work_simult_approx 
SELECT hadm_id, date_trunc('hour', charttime), 1 FROM ch1_general_vars_temp UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 2 FROM ch1_general_vars_hr UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 3 FROM ch1_general_vars_rr UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 4 FROM ch1_general_vars_glasgow UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 5 FROM ch1_general_vars_gly UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 6 FROM ch1_general_vars_fluid UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 7 FROM ch2_infla_vars_wb UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 8 FROM ch2_infla_vars_crp  UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 9 FROM  ch3_hemo_vars_hypo_art UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 10 FROM ch3_hemo_vars_mix_ven UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 11 FROM ch3_hemo_vars_card_index UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 12 FROM ch4_organ_dysf_creat UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 13 FROM ch4_organ_dysf_thromb UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 14 FROM ch4_organ_dysf_billi UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 15 FROM ch4_organ_dysf_plat UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 16 FROM ch4_organ_dysf_urin UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 17 FROM ch5_tissue_perf ;

DROP MATERIALIZED VIEW IF EXISTS ch1;
CREATE MATERIALIZED VIEW ch1 AS 
with 
tmp AS (SELECT distinct hadm_id, charttime + interval '1h' * generate_series as moment, type FROM work_simult_approx, (SELECT * FROM generate_series(-12,12) ) AS t),
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, moment FROM tmp GROUP BY hadm_id, moment), 
ch2 as (SELECT array_remove(array_remove(array_remove(array_remove(array_remove(array_remove(array_remove(array_remove(array_remove(arr,9),10),11),12),13),14),15),16),17) as arr, hadm_id, moment FROM moment WHERE arr && ARRAY[9, 10, 11, 12, 13, 14, 15, 16, 17] ) 
SELECT  distinct hadm_id, arr, moment FROM ch2 WHERE array_length(arr,1) >= 2;

DROP TABLE IF EXISTS accp_severe;
CREATE  TABLE accp_severe AS
WITH 
crit1 AS (SELECT hadm_id FROM ch0_infection_pop), 
crit2 AS (SELECT distinct ch1.hadm_id FROM ch1 LEFT JOIN tmp_lactate ON (tmp_lactate.hadm_id = ch1.hadm_id AND tmp_lactate.moment = ch1.moment) WHERE tmp_lactate.hadm_id IS NULL) 
SELECT DISTINCT hadm_id FROM (SELECT * FROM crit1 INTERSECT SELECT * FROM crit2 ) as tmp3 ;

-- TMP_SIMPLE
TRUNCATE TABLE work_simult_approx;
INSERT INTO work_simult_approx 
SELECT hadm_id, date_trunc('hour', charttime), 1 FROM ch1_general_vars_temp UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 2 FROM ch1_general_vars_hr UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 3 FROM ch1_general_vars_rr UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 4 FROM ch1_general_vars_glasgow UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 5 FROM ch1_general_vars_gly UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 6 FROM ch1_general_vars_fluid UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 7 FROM ch2_infla_vars_wb UNION ALL
SELECT hadm_id, date_trunc('hour', charttime), 8 FROM ch2_infla_vars_crp  ;

DROP MATERIALIZED VIEW IF EXISTS tmp_sepsis CASCADE;
CREATE MATERIALIZED VIEW tmp_sepsis AS 
with 
tmp AS (SELECT distinct hadm_id, charttime + interval '1h' * generate_series as moment, type FROM work_simult_approx, (SELECT * FROM generate_series(-12,12) ) AS t),
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, moment FROM tmp GROUP BY hadm_id, moment)
SELECT  distinct hadm_id, arr, moment FROM moment WHERE array_length(arr,1) >= 2;

--SEPSIS SHOCK

DROP MATERIALIZED VIEW IF EXISTS accp_shock;
CREATE MATERIALIZED VIEW accp_shock AS
SELECT tmp_sepsis.hadm_id, tmp_sepsis.moment FROM tmp_sepsis 
INNER JOIN ch0_infection_pop USING (hadm_id) 
INNER JOIN tmp_lactate ON (tmp_lactate.hadm_id = tmp_sepsis.hadm_id AND date_trunc('hour', tmp_sepsis.moment) = date_trunc('hour', tmp_lactate.moment));
--SEPSIS SIMPLE
DROP MATERIALIZED VIEW IF EXISTS accp_simple;
CREATE MATERIALIZED VIEW accp_simple AS
SELECT tmp_sepsis.hadm_id, tmp_sepsis.moment FROM tmp_sepsis 
INNER JOIN ch0_infection_pop USING (hadm_id) 
LEFT JOIN tmp_lactate ON (tmp_lactate.hadm_id = tmp_sepsis.hadm_id AND date_trunc('hour', tmp_sepsis.moment) = date_trunc('hour', tmp_lactate.moment)) WHERE tmp_lactate.hadm_id IS NULL;

-- DELIBERATION (SHOCK > SEVERE > SIMPLE)
DROP TABLE IF EXISTS accp_deliberation;
CREATE  TABLE accp_deliberation (
hadm_id integer,
type integer
);
INSERT INTO accp_deliberation
WITH tmp AS (
SELECT distinct hadm_id, 1 as type FROM accp_simple
UNION ALL
SELECT distinct hadm_id, 2 as type FROM accp_severe
UNION ALL
SELECT distinct hadm_id, 3 as type FROM accp_shock
)
SELECT hadm_id, max(type) as type
FROM tmp
GROUP BY hadm_id;

--ANTIBIO & BACT in same window
TRUNCATE TABLE work_simult_approx;
INSERT INTO work_simult_approx 
WITH lactate as (SELECT ce.hadm_id, charttime, valuenum FROM mimiciii.chartevents ce WHERE  ce.itemid IN ( 818, 1531, 225668 ) UNION ALL SELECT hadm_id, charttime, valuenum FROM mimiciii.labevents WHERE itemid = 50813)
SELECT DISTINCT hadm_id, date_trunc('hour',startdate), 1 FROM mimiciii.prescriptions WHERE drug ~* '(icill)|(bactam)|(andol)|(cef)|(ceph)|(clavu)|(penem)|(nam)|(lactam)|(amika)|(genta)|(flox)|(amycin)|(omycin)' 
UNION ALL SELECT DISTINCT hadm_id, date_trunc('hour', coalesce(charttime, chartdate+ '12 hour'::INTERVAL)) + interval '1h' * generate_series, 2  FROM  mimiciii.microbiologyevents, (SELECT * FROM generate_series(-24,+72) ) AS t
UNION ALL SELECT DISTINCT hadm_id, date_trunc('hour', charttime)+ interval '1h' * generate_series, 2  FROM  (SELECT hadm_id, charttime FROM mimiciii.labevents WHERE itemid = 51463) as r, (SELECT * FROM generate_series(-24,+72) ) AS t 
UNION ALL SELECT hadm_id, date_trunc('hour', charttime), 3 FROM lactate WHERE  valuenum < 2
UNION ALL SELECT hadm_id, date_trunc('hour', starttime), 4 FROM (SELECT hadm_id, starttime FROM mimiciii.mp_norepinephrine JOIN mimiciii.icustays USING (icustay_id) UNION ALL SELECT hadm_id, starttime FROM mimiciii.mp_epinephrine JOIN mimiciii.icustays USING (icustay_id)) as vaso;



DROP MATERIALIZED VIEW IF EXISTS atb_bact_window;
CREATE MATERIALIZED VIEW atb_bact_window AS
with 
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, charttime FROM work_simult_approx GROUP BY hadm_id, charttime),
nb as (SELECT  distinct hadm_id, arr, charttime FROM moment WHERE arr @> '{1,2}'::int[])
SELECT distinct hadm_id, charttime FROM nb;

DROP MATERIALIZED VIEW IF EXISTS atb_bact_window_lactate;
CREATE MATERIALIZED VIEW atb_bact_window_lactate AS
with 
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, charttime FROM work_simult_approx GROUP BY hadm_id, charttime),
nb as (SELECT  distinct hadm_id, arr, charttime FROM moment WHERE arr @> '{1,2,3}'::int[])
SELECT distinct hadm_id, charttime FROM nb;
DROP MATERIALIZED VIEW IF EXISTS atb_bact_window_vaso;

CREATE MATERIALIZED VIEW atb_bact_window_vaso AS
with 
moment AS (SELECT  array_agg( DISTINCT type) as arr, hadm_id, charttime FROM work_simult_approx GROUP BY hadm_id, charttime),
nb as (SELECT  distinct hadm_id, arr, charttime FROM moment WHERE arr @> '{1,2,4}'::int[])
SELECT distinct hadm_id, charttime FROM nb;

-- ANGUS DELIB
DROP TABLE IF EXISTS angus_deliberation;
CREATE TABLE angus_deliberation (hadm_id integer, type integer);
INSERT INTO angus_deliberation
SELECT distinct hadm_id, 1
FROM 
(
SELECT distinct hadm_id 
FROM mimiciii.diagnoses_icd 
WHERE icd9_code ~ '^614|^021|^032|^575.0|^681|^016|^026|^094|^599.0|^008|^023|^104|^461|^324|^034|^098|^040|^463|^569.5|^039|^513|^485|^013|^682|^790.7|^027|^541|^111|^117|^009|^030|^015|^481|^562.03|^320|^001|^486|^018|^711.0|^017|^114|^510|^451|^011|^031|^041|^033|^003|^569.83|^024|^572.1|^095|^616|^590|^012|^103|^597|^615|^562.11|^996.6|^091|^572.0|^020|^110|^002|^566|^035|^482|^004|^686|^092|^421|^038|^116|^005|^325|^096|^097|^101|^562.13|^540|^999.3|^567|^465|^093|^542|^462|^494|^036|^090|^322|^025|^022|^100|^491.21|^115|^998.5|^010|^562.01|^102|^037|^464|^420|^118|^730|^014|^112|^601|^683'
INTERSECT
SELECT distinct hadm_id
FROM mimiciii.diagnoses_icd
WHERE icd9_code ~ '^785.5|^458|^96.7|^348.3|^293|^348.1|^287.4|^287.5|^286.9|^286.6|^570|^573.4|^584'
) as tmp
JOIN atb_bact_window USING (hadm_id);
UPDATE angus_deliberation SET type = 2 WHERE hadm_id IN (SELECT hadm_id FROM atb_bact_window_vaso);

--sepsis3 deliberation


DROP TABLE IF EXISTS sepsis3_deliberation;
CREATE TABLE sepsis3_deliberation (hadm_id integer, type integer);
INSERT INTO sepsis3_deliberation
SELECT distinct hadm_id, 2
FROM ch0_infection_pop
WHERE hadm_id IN ( SELECT distinct hadm_id FROM mimiciii.icustays ic LEFT JOIN mimiciii.mp_sofa so USING (icustay_id) WHERE sofa_24hours >= 2 )
AND hadm_id IN (SELECT hadm_id FROM atb_bact_window);

UPDATE sepsis3_deliberation SET type = 1 WHERE hadm_id IN (SELECT hadm_id FROM atb_bact_window_lactate) 
OR hadm_id IN (SELECT hadm_id FROM  mimiciii.admissions WHERE hadm_id NOT IN (SELECT ce.hadm_id FROM mimiciii.chartevents ce WHERE  ce.itemid IN ( 818, 1531, 225668 ) UNION ALL SELECT hadm_id FROM mimiciii.labevents WHERE itemid = 50813) as lact);

-- EACH GROUP
DROP TABLE IF EXISTS hadm_deliberation;
CREATE TABLE hadm_deliberation (
hadm_id integer,
accp integer,
angus integer,
sepsis3 integer
);
INSERT INTO hadm_deliberation
WITH 
accp AS (SELECT distinct hadm_id, 1 as value FROM accp_deliberation WHERE type = 2),
angus AS (SELECT hadm_id, 1 as value FROM angus_deliberation),
sepsis3 AS (SELECT hadm_id, 1 as value FROM sepsis3_deliberation)
SELECT a.hadm_id, coalesce(accp.value,0), coalesce(angus.value,0), coalesce(sepsis3.value,0)
FROM mimiciii.admissions a
LEFT JOIN accp USING (hadm_id)
LEFT JOIN angus USING (hadm_id)
LEFT JOIN sepsis3 USING (hadm_id);

