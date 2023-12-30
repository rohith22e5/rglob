library(e1071)
library(superml)
source("combineddata.R")

mydata<- getdata()


datadone<-numencode(mydata)

datadone$emotion<-as.factor(datadone$emotion)
testrows<-sample(1:nrow(datadone),trunc(nrow(datadone)*0.3))
testdataset<-datadone[testrows,]
traindataset<-datadone[]

NBModel=naiveBayes(formula(traindataset),data=traindataset,laplace=3)
predictions = predict(NBModel, testdataset, threshold = 0.01)
print(predictions)

# look at the predictions and the class of the test data
# print(predictionsTrue)
# print(testData$emotion)

# confusion matrix to check accuracy
accuracy <- mean(predictions == testdataset$emotion)
print(accuracy)

saveRDS(NBModel,file="nbmodel.rds")
