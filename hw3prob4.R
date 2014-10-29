# hw3prob4.R

library(tree)

form.full <- as.formula(Y ~ .)


tree.spam <- tree(form.full, data=spam.test, 
                  mindev=0.005, minsize=2, split="deviance") # big 'ol tree
plot(tree.spam)
text(tree.spam)

#prune dat thing
prune.tree.spam = prune.tree(tree.spam, method="deviance");
plot(prune.tree.spam);
prune.tree.spam$size
prune.tree.spam$dev
prune.tree.spam$k

# The weakest link is
tree.snip = snip.tree(tree.spam, 5)
summary(tree.snip)$size
dev=tree.snip$frame$dev

nodenum = as.numeric(row.names(tree.spam$frame)); N=length(nodenum);
alp=rep(0,N) 
for (i in 1:N) {
    if (sum(nodenum==2*nodenum[i])>0){
      tL=2*nodenum[i]; tR=tL+1;
      # this is the impurity measure
      alp[i]=dev[i]-dev[nodenum==tL]-dev[nodenum==tR]
  }}
sort(alp)
a=min(alp[alp !=0], na.rm=T)
nodenum[alp == a]
a=min(alp[alp !=0], na.rm=T)
nodenum[alp == a]


models<-list(tree.snip)

# get the predictions
preds.prob.4 <- lapply(models, function(x){
  do.call("predict", list(x, data=spam.test))
})

# prediction accuracy
table.prob.4 <- lapply(preds.prob.4, predict.accuracy)

