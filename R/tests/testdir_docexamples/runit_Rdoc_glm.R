setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source('../findNSourceUtils.R')

test.rdocglm.golden <- function(H2Oserver) {
	


prostate.hex = h2o.importURL(H2Oserver, path = "https://raw.github.com/0xdata/h2o/master/smalldata/logreg/prostate.csv", key = "prostate.hex")
h2o.glm(y = "CAPSULE", x = c("AGE","RACE","PSA","DCAPS"), data = prostate.hex, family = "binomial", nfolds = 10, alpha = 0.5)
myX = setdiff(colnames(prostate.hex), c("ID", "DPROS", "DCAPS", "VOL"))
h2o.glm(y = "VOL", x = myX, data = prostate.hex, family = "gaussian", nfolds = 5, alpha = 0.1)

airlines.hex =  h2o.importURL(H2Oserver, path = "https://raw.github.com/0xdata/h2o/master/smalldata/airlines/AirlinesTrain.csv.zip")
h2o.glm(x = c('Distance', 'Origin', 'Dest', 'UniqueCarrier'), y = 'IsDepDelayed', family = 'binomial', data = airlines.hex)

testEnd()
}

doTest("R Doc GLM example", test.rdocglm.golden)

