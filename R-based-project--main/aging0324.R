getwd()
setwd('C:/Users/enmao/OneDrive - Carleton University/DATA 5000')
getwd()
library(foreign)
install.packages("haven")
library(haven)
aging <- read_dta("./database1230_2.dta")
head(aging)
dim(aging)

#Q1: how to deal with the NA terms
aging[,c('unemp','pop_retire','deflator','ln_prgdp','growth_prgdp','labor')]

#Q2: what is the difference between factor and as.numeric
#titanic$age[is.na(titanic$age] <- mean(titanic$age, na.rm = TRUE)

test <-sample(c(FALSE, TRUE), nrow(aging), replace=TRUE, prob=c(0.8,0.2))
train <- !test

#install.packages("nnet")
library(nnet)

nnet.fit <- nnet(unemp ~ pop_retire + cpi + deflator + ln_prgdp + growth_prgdp 
                 + labor, data=aging, subset=train, size=5)
nnet.fit

nnet.pred <- predict(nnet.fit, newdata = subset(aging,test), type = "class")
