aging <- read_dta("./database1230_2.dta")
head(aging)
test <-sample(c(FALSE, TRUE), nrow(aging), replace=TRUE, prob=c(0.8,0.2))
train <- !test

library(e1071)
svm.fit <- svm(unemp ~ pop_retire + cpi + deflator + ln_prgdp + growth_prgdp 
               + labor, data=aging, subset=train)
svm.fit

svm.pred <- predict(svm.fit, newdata=subset(aging, test), type="class")
svm.pred

length(aging$unemp[test])
length(svm.pred)

test.ct <- table(Actual=aging$unemp[test], Predicted=svm.pred); test.ct

sum(diag(test.ct)) / sum(test.ct) # Accuracy