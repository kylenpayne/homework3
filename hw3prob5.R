# Problem 5.R

# load in local dependencies
library(randomForest)

forest.spam <- randomForest(full.form, data=spam.test)

models <- list(forest.spam)

varImpPlot(forest.spam)

# get the predictions
preds.prob2 <- lappy(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

# prediction accuracy
table.prob5 <- lappy(pred, predict.accuracy)


