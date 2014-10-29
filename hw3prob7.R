# hw3prob7.R

# load local dependencies
library(nnet)

nnet.spam <- nnet(Y ~., size =10, data=spam.test)

# neural net summary with 1 hidden layer
summary(nnet.spam)

models <- list(nnet.spam)

preds.prob.7 <- lapply(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

# prediction accuracy
table.pred.prob.7 <- lapply(preds.prob.7, predict.accuracy)


