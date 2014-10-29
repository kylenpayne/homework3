# classif.R
# This file contains several functions for assessing the 
# classification accuracy of models

# 0-1 classification error

zero.one <- function(pred){
  true <<- spam.test$Y
  
  logical <- numeric(length(pred))
  
  for(i in 1:length(pred)){
    if((pred[i]<=.5 & true[i]==0) | (pred[i] > .5 & true[i]==1)){
      logical[i]<-0
    }else{
      logical[i]<-1
    }
  }
  
  accuracy <- 1-mean(logical)
  
  return(accuracy)
}

# deviance, or log-likelihood
# true is assumed to be 0-1, pred in [0,1]
deviance <- function(pred){
  l.p <- numeric(length(pred))
  l.ip <- numeric(length(pred))
  true <<- spam.test$Y
  for(i in 1:length(pred)){
    if(is.na(log(pred[i]))){
      l.p[i] <- 0
      l.ip[i] <- 1
    }else{
      l.p[i] <- log(pred[i])
      l.ip[i] <- log(1-pred[i])
    }
  }
  
  return(sum(true*l.p + (1-true)*l.ip))
}


i