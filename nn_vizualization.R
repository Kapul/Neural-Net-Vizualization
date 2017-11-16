rm(list = ls())

require(nnet)
require(clusterGeneration)
require(RCurl)
require(lattice)
library(NeuralNetTools)


##########################
# generate data for neural network
##########################

set.seed(2)
num.vars<-20
num.obs<-100000

##########################
# arbitrary correlation matrix and random variables
##########################

cov.mat<-genPositiveDefMat(num.vars,covMethod=c("unifcorrmat"))$Sigma
rand.vars<-mvrnorm(num.obs,rep(0,num.vars),Sigma=cov.mat)
parms<-runif(num.vars,-10,10)

##########################
# response variable as linear combination of random variables and random error term
##########################

y<-rand.vars %*% matrix(parms) + rnorm(num.obs,sd=20)

rand.vars<-data.frame(rand.vars)
y<-data.frame((y-min(y))/(max(y)-min(y)))
names(y)<-'y'

##########################
# neural network estimation
##########################

s <- 20
mod1<-nnet(rand.vars,y,size=s,linout=T)

##########################
# heat map of weights
##########################

alpha <- matrix(mod1$wts[1:(s*(num.vars+1))], ncol = num.vars+1, byrow = TRUE)
heatmap(alpha[,2:(num.vars+1)])

##########################
# visualizations of weights
##########################

# Neural interpretation diagram 

plotnet(mod1, alpha = 0.3, nid = TRUE, rel_rsc = 2, pos_col = 'yellow', neg_col = 'red', 
        circle_col = 'white')

# Delere not strong enough links

mod2 <- mod1
mod2$wts[1:(s*(num.vars+1))] <- (abs(mod2$wts[1:(s*(num.vars+1))])>1)*mod2$wts[1:(s*(num.vars+1))]
mod2$wts[1:(s*(num.vars+1))] <- (0/mod2$wts[1:(s*(num.vars+1))] == 0)*mod2$wts[1:(s*(num.vars+1))]
mod2$wts[(s*(num.vars+1)+1):441] <- (abs(mod2$wts[(s*(num.vars+1)+1):441])>0.1)*mod2$wts[(s*(num.vars+1)+1):441]
mod2$wts[(s*(num.vars+1)+1):441] <- (0/mod2$wts[(s*(num.vars+1)+1):441] == 0)*mod2$wts[(s*(num.vars+1)+1):441]







