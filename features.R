# a file that contains all of the features
# definitions and loads the Rdata file into R.

load("spamHW3.Rdata")
# loads in the dataset neccesary for this homework

data(spam.train)
data(spam.test)


# these are only neccesary for R functions
# that do not take data.frame as arguments
features.train <- as.matrix(spam.train[,-dim(spam.train)[2]])
features.test <- as.matrix(spam.test[,-dim(spam.test)[2]])

response.train <- as.matrix(spam.train[,"Y"])
response.test <- as.matrix(spam.test[,"Y"])
