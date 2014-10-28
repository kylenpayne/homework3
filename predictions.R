# predictions.R

if(!exists(zero.one, mode="function") & !exists(deviance, mode="function")) source("classif.R")

predict.accuracy <- function(list, xtable=TRUE){
  pred.zero.one <- lapply(list, zero.one)
  pred.deviance <- lapply(list, deviance)
  
  table<-as.matrix(data.frame(pred.zero.one, pred.deviance))
  if(xtable==TRUE){
    library(xtable)
    t <- xtable(table)
    return(t)
  } else{
    return(table)
  }
}