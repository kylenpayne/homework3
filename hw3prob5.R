# Problem 5.R

# load in local dependencies
library(randomForest)

forest.spam <- randomForest(full.form, data=spam.test)

models <- list(forest.spam)

varImpPlot(forest.spam)

# get the predictions
preds.prob.5 <- lappy(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

# prediction accuracy
table.prob.5 <- lappy(pred.prob.5, predict.accuracy)


