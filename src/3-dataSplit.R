load('data/data0.RData')

set.seed(991122)
sampleIndex = sample(1:421, 126, replace = F)

testData = data0[sampleIndex,]
trainData = data0[-sampleIndex,]

save(testData, file = 'data/1-split/testData.RData')
save(trainData, file = 'data/1-split/trainData.RData')

rm(data0, testData, trainData, sampleIndex)















