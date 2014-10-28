# hw3prob3.R

# load in local dependencies
library(e1071)

full.form <- Y ~ .;
selected.form <- Y ~ selected.vars;
lapply()


# three types of svm with full formula
models <- list(
svm.spam.linear = svm(full.form, data=spam.train, kernel="linear"),
svm.spam.quadratic = svm(full.form, data=spam.train, kernel="polynomial", degree=3),
svm.spam.gaussian = svm(full.form, data=spam.train, kernel="radial basis"),

#selected.vars <- union(union(vars.forward.aic, vars.forward.bic), vars.lasso)
# should be loaded into the main file by this point
svm.linear.selected  = svm(selected.form, data=spam.train, kernel="linear"),
svm.quadratic.selected = svm(selected.form, data=spam.train, kernel="polynomial", degree=3),
svm.gaussian.selected = svm(selected.form, data=spam.train, kernel="radial basis")

)

lapply(models, function(x){ xtable(summary(x))})

#predictions
preds.prob2 <- lappy(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

# prediction accuracy
table <- lappy(preds.prob2, predict.accuracy)


