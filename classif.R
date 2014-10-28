# classif.R
# This file contains several functions for assessing the 
# classification accuracy of models

# 0-1 classification error
true <<- spam.test$Y
zero.one <- function(pred){

  logical <- ifelse(pred <= .5 && true == 0 || pred > .5 && true == 1, 0, 1)
  
  accuracy <- 1-mean(logical)
  
  return(accuracy)
}

# deviance, or log-likelihood
# true is assumed to be 0-1, pred in [0,1]
deviance <- function(pred, true){
  return(sum(true*log(pred) + (1-true)*log(1-pred)))
}

