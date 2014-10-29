# Problem 6
# hw3prob6.R

library(gbm)

# implement ada boosting
gbm.spam <- gbm(full.form, distribution = "adaboosting", n.trees=500, shrinkage=1,
                bag.fraction=1, cv.folds=5)


par(mfrow=c(2,2)); size=c(10,50,100,500);
for(i in 1:4){
  plot(c(0,1),c(0,1),type="n");
  points(x,as.numeric(y), col=8); ## add sample points
  y.pred=predict(gbm.spam, data.frame(x=spam.test), n.trees=size[i])
  lines(spam.test, 1/(1+exp(-2*y.pred)))
  lines(x, px, col=8);
  title(paste("# of Iterations = ", size[i]))
}

models <- list(gbm.spam)

preds.prob.6 <- lappy(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

pred.accuracy.6<- lappy(preds.prob.6, predict.accuracy)