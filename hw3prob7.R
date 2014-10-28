# hw3prob7.R

# load local dependencies
library(nnet)

nnet.spam <- nnet(Y ~., size =10, data=spam.test)

# neural net summary with 1 hidden layer
xtable(as.matrix(summary(xtable(nnet.spam))))

models <- list(nnet.spam)

preds.prob7 <- lappy(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

# prediction accuracy
table <- lappy(pred, predict.accuracy)


