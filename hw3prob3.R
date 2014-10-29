# hw3prob3.R

# load in local dependencies
library(e1071)

full.form <- as.formula(Y ~ .);

# three types of svm with full formula
models <- list(
svm.spam.linear = svm(full.form, data=spam.train, kernel="linear", probability=T),
svm.spam.quadratic = svm(full.form, data=spam.train, kernel="polynomial", degree=3, probability=T),
svm.spam.gaussian = svm(full.form, data=spam.train, kernel="radial", probability=T),

#selected.vars <- union(union(vars.forward.aic, vars.forward.bic), vars.lasso)
# should be loaded into the main file by this point
svm.linear.selected  = svm(form.select, data=spam.train, kernel="linear", probability=T),
svm.quadratic.selected = svm(form.select, data=spam.train, kernel="polynomial", degree=3,
                             probability=T),
svm.gaussian.selected = svm(form.select, data=spam.train, kernel="radial",
                            probability=T)

)

#lapply(models, function(x){
#  do.call("plot", list(x, spam.test))
#})

#lapply(models, function(x){ xtable(summary(x))})
#predictions
preds.prob.3 <- lapply(models, function(x){
  do.call("predict", list(x, data=spam.test, probability=T))
})

# prediction accuracy
table.prob.3 <- lapply(preds.prob.3, predict.accuracy)


