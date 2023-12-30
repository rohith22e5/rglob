 library(jtools)
combineddata<- function(){
  csv_files <- list.files(pattern = "emotion_Actor_(0[1-9]|1[0-9]|2[0-4])\\.csv")
  total_data<-data.frame()
  first<-TRUE
  for(file in csv_files){
    if(first){
      data<-read.csv(file,header = TRUE)
    }else{
      data<-read.csv(file)
    }
    print(head(data))
    total_data<-rbind(total_data,data)
    print(head(total_data))
  }
  write.csv(total_data, "combined_data.csv", row.names = FALSE)
  
  
}

getdata<-function(filename= "combined_data.csv" ){
   read.csv(filename)
}

numencode<- function(data){
  columns<-1:ncol(data)
  names<- colnames(data)
  for (col in columns) {
    if (!is.numeric(data[,col])) {# if not, scale
      print(paste("Scaling column: ", col))
      name<-names[col]
      if(name=='gender'){
        library(dplyr)
        
        # Assuming your data frame is named "your_data" and the column is "gender"
        data <- data %>%
          mutate(gender = ifelse(gender == "female", 2, 1))
        
      }else{
      data[,col] <- as.numeric(as.character(data[,col]))
      }# only scale this one column
    }
  }
  data
  
}