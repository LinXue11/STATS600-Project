load('data/2-pcreg/logitRegRed.RData')
load('data/2-pcreg/PCA.RData')
load('data/3-shrinkage/logitLasso.Rdata')
load('data/3-shrinkage/logitRidge.Rdata')

summary(logitRegRed)
logitRidge$beta
logitLasso$beta

