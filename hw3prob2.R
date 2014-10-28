# Stat 542 HW3 Problem 1
# Kyle N. Payne
# 10/25/2014


if(!exists(zero.one, mode="function") & !exists(deviance, mode="function")) source("classif.R")
if(!exist(predict.accuracy, mode="function")) source("predictions.R")
# load in the dependencies 

library(xtable)
library(MASS)
library(klaR)

## For the LDA and QDA function, I chose to use the S3 method for 'formula', 
# it's just easier to comprehend.

lda.spam <- lda(Y ~ ., data=spam.train)
rda.spam <- rda(Y ~ ., data=spam.train)
naive.spam.para <- NaiveBayes(Y ~ ., data=spam.train)
naive.spam.kernel <- NaiveBayes(Y ~ ., data=spam.train, usekernel=T)
# take the union of the variables selected by the various methods in hw3prob1.R
# this idea is based on extracting the terms from the glm via an attr call.

#> attr(forward.aic$terms, "term.labels")
#[1] "Cdollar"     "Whp"         "Wremove"     "Wgeorge"     "CAPave"      "Wedu"        "Wfree"      
#[8] "W000"        "Wmeeting"    "Wbusiness"   "Wour"        "Wmoney"      "Wcs"         "CAPtotal"   
#[15] "Cexclam"     "Wyour"       "Wconference" "Wre"         "Winternet"   "Wcredit"     "Wproject"   


vars.forward.aic <- attr(forward.aic$terms, "term.labels")
vars.forward.bic <- attr(forward.bic$terms, "terms.labels")
vars.lasso <- names(mat.coef)

selected.vars <- union(union(vars.forward.aic, vars.forward.bic), vars.lasso)

models <- list(
  lda.spam = lda(Y ~ ., data=spam.train)
  rda.spam = rda(Y ~ ., data=spam.train)
  naive.spam.para = NaiveBayes(Y ~ ., data=spam.train)
  naive.spam.kernel = NaiveBayes(Y ~ ., data=spam.train, usekernel=T)
  
  # everything again with selected variables
  lda.spam.selected.vars = lda(Y ~ selected.vars, data=spam.train)
  rda.spam.selected.vars = rda(Y ~ selected.vars, data=spam.train)
  naive.spam.para.selected.vars = NaiveBayes(Y ~ selected.vars, data=spam.train)
  naive.spam.kernel.selected.vars = NaiveBayes(Y ~ selected.vars, data=spam.train, usekernel=T) 
  
)

preds.prob2 <- lappy(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

# prediction accuracy
table <- lappy(pred, predict.accuracy)


