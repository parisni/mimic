#@ahthor parisni
#splits chartevents ids in x groups to be partitionned equaly
require(data.table)
x <- fread("/tmp/itemid.csv") #SELECT itemid FROM chartevents
c <- table(x)
d <- c[as.character(sort(as.integer(names(c))))]
chunck <- function(x, n){
	l <- length(x)
	m <- sum(x) / n
	tmp <- 0
	mini <- names(x[1])
	ind = 0;
	create <- "-- CREATE CHARTEVENTS TABLE"
	trigg <- ""
	indexes <- ""
	for(i in 1:l){
		tmp = tmp +  x[i]
		if(tmp >= m){
			ind = ind + 1;
		 	create = paste0( c(create,printChartevent(ind,mini,names(x[i]))),collapse="\n")
		 	trigg = paste0( c(trigg,printTriggerIn(ind,mini,names(x[i]))),collapse="\n")
		 	indexes = paste0( c(indexes,printIndexes(ind)),collapse="\n")
			mini <- (names(x[i]))
			tmp <- 0
		}
	}
	cat(create)
	cat(printTrigger(trigg))
	cat(indexes)
}
printChartevent<- function(ind, mi, ma){
sprintf("CREATE TABLE chartevents_%d ( CHECK ( itemid >= %s  AND itemid < %s )) INHERITS (chartevents);",ind, mi, ma)
}

printTriggerIn <- function(ind, mi, ma){
if(ind==1){
	sprintf("IF ( NEW.itemid >= %s AND NEW.itemid < %s ) THEN INSERT INTO chartevents_%d VALUES (NEW.*);",mi,ma,ind)
}else{
	sprintf("ELSIF ( NEW.itemid >= %s AND NEW.itemid < %s ) THEN INSERT INTO chartevents_%d VALUES (NEW.*);", mi, ma, ind)
}
}

printTrigger <- function(str){
sprintf("
	
-- CREATE CHARTEVENTS TRIGGER
CREATE OR REPLACE FUNCTION chartevents_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN

%s
	ELSE
		INSERT INTO chartevents_null VALUES (NEW.*);
       END IF;
RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insert_chartevents_trigger
    BEFORE INSERT ON chartevents
    FOR EACH ROW EXECUTE PROCEDURE chartevents_insert_trigger();",str)
}

printIndexes <- function(ind){
sprintf("
---------------
-- CHARTEVENTS %d
---------------
drop index MIMICIII.CHARTEVENTS_%d_idx01;
CREATE INDEX CHARTEVENTS_%d_idx01 
  ON MIMICIII.CHARTEVENTS_%d (SUBJECT_ID, HADM_ID, ICUSTAY_ID) WITH (FILLFACTOR=100);


drop index MIMICIII.CHARTEVENTS_%d_idx02;
CREATE INDEX CHARTEVENTS_%d_idx02 
  ON MIMICIII.CHARTEVENTS_%d (ITEMID) WITH (FILLFACTOR=100);


drop index MIMICIII.CHARTEVENTS_%d_idx03;
CREATE INDEX CHARTEVENTS_%d_idx03 
  ON MIMICIII.CHARTEVENTS_%d (CHARTTIME, STORETIME) WITH (FILLFACTOR=100);


drop index MIMICIII.CHARTEVENTS_%d_idx04;
CREATE INDEX CHARTEVENTS_%d_idx04 
  ON MIMICIII.CHARTEVENTS_%d (CGID) WITH (FILLFACTOR=100);
",ind,ind,ind,ind,ind,ind,ind,ind,ind,ind,ind,ind,ind)
}
chunck(d, 10)
