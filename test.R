library(optimbase)
library(stringr)
library(jtools)

source("wavetonum.R")
source('combineddata.R')
testfile<-"03-01-01-01-01-01-02.wav"
folder<-"Actor_02"

wavedata<- waveToNumWithSlicesAdded(folder=folder,filename = testfile,slice = 100)
filedata<- sapply(strsplit(as.character(basename(testfile)),regex("\\-|\\.")),FUN = function(str) strtoi(str, base=10))
filedata[7]<-case_when(filedata[7]%%2==1~"male",
                       TRUE~"female")
filedata<-data.frame(
  transpose(matrix(unlist(filedata)))
)[-1][-1][-1][-5]  


colnames(filedata)<- c("intensity", "statement", "repetition" , "gender")
combineddata<-data.frame(c(filedata,wavedata))
combineddata <- gscale(combineddata, scale.only = TRUE, vars = colnames(combineddata))

combineddata <- numencode(combineddata)

loaded_model<- readRDS("~/ai/glob/rglob/nbmodel.rds")
predictions= predict(loaded_model,combineddata)
print(predictions)
