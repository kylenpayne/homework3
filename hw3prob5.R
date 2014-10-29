# Problem 5.R

# load in local dependencies
library(randomForest)

forest.spam <- randomForest(factor(Y) ~ ., data=spam.test, type="classification")

models <- list(forest.spam)

varImpPlot(forest.spam)

# get the predictions
preds.prob.5 <- lapply(models, function(x){
  do.call("predict", list(x, data=spam.test, type="prob"))
})

# prediction accuracy
table.prob.5 <- lapply(preds.prob.5, predict.accuracy)


