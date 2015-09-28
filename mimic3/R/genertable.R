require(data.table)
#setwd("/tmp/mimic/")
transformClass <- function(vect,name){
ifelse(vect%in%"integer","integer",
       
ifelse(grepl("TIME$",name) && vect%in%"character","timestamp",
ifelse( vect%in%"character","text","type error"
 )
) 
)
}

transformClass <- function(tmp){
ifelse(grepl("ID$",names(tmp)),"integer",ifelse(grepl("TIME$",names(tmp)),"timestamp","text"))
}
files <- list.files(".",pattern=".csv$")
for(file in files){
hTmp<- paste0(system2("head", c("--lines=1000",file),stdout = TRUE),collapse="\n")
tmp <- fread(hTmp)
tableName <- tolower(gsub("_DATA_TABLE.csv$","",file))
vectCol <- sprintf("%s %s",tolower(names(tmp)),transformClass(tmp))
cols <- paste0(vectCol,collapse=",\n")
cat(sprintf("BEGIN;\nCREATE TABLE %s \n(\n%s\n);\nCOPY %s from '/tmp/mimic/%s' DELIMITER ',' NULL '' CSV HEADER;\nCOMMIT;\n",tableName,cols,tableName, file),append=T)
}
