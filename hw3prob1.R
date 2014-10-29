# Stat 542 HW3 Problem 1
# Kyle N. Payne
# 10/25/2014


#if(!exists(zero.one, mode="function") & !exists(deviance, mode="function")) source("classif.R")

#if(!exists(predict.accuracy, mode="function")) source("predictions.R")
# load in the local dependencies 
library(glmnet)
library(xtable)

# forward selection using AIC
null <- glm(factor(Y)~ 1, family=binomial(link="logit"), data=spam.train)
full <- glm(factor(Y) ~., family=binomial(link="logit"), data=spam.train)

#latex table for the full model
table.full <- xtable(summary(full))

forward.aic<-step(null, scope=list(lower=null, upper=full), direction="forward")

forward.bic<-step(null, scope=list(lower=null, upper=full), direction="forward", k=log(nobs(null)))

# for lasso regression, the glmnet package
# requires that one inputs a separate feature matrix
# and response variable.

lasso.logistic <- glmnet(features.train, response.train, family=c("binomial"), alpha = 1)

plot(lasso.logistic, xvar="dev", label=T) # plot of the deviance statistic

lasso.logistic.cv <- cv.glmnet(features.train, response.train, 
                               family = "binomial", type.measure = "class", alpha=1)

plot(lasso.logistic.cv)

# return coef
mat.coef <- as.matrix(coef(lasso.logistic.cv, s = "lambda.min"))

lasso.table<- xtable(mat.coef)


pred.full <- predict.glm(full, newdata=spam.test, type="response")
pred.forward.aic <- predict.glm(forward.aic, newdata=spam.test, type="response")
pred.forward.bic <- predict.glm(forward.bic, newdata=spam.test, type="response")
pred.lasso <- predict(lasso.logistic, newx=features.test, type="response")

# get prediction accuracy
predictions <- list(pred.full, pred.forward.aic, pred.forward.bic, pred.lasso)

table <- predict.accuracy(predictions)




