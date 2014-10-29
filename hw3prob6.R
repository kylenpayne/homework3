# Problem 6
# hw3prob6.R

library(gbm)

# implement ada boosting
gbm.spam <- gbm(full.form, distribution = "bernoulli", n.trees=500, shrinkage=1,
                bag.fraction=1, cv.folds=5, data=spam.train)


models <- list(gbm.spam)

preds.prob.6 <- lapply(models, function(x){
  do.call("predict", list(x, data=spam.test, type="response"))
})

pred.accuracy.6<- lapply(preds.prob.6, predict.accuracy)