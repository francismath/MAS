library(e1071)
#install.packages('caret')
library(caret)

# Regression example
getwd()
setwd('P:/')
getwd()
library(foreign)
#install.packages("haven")
library(haven)
aging <- read_dta("./DATA 5000/database1230_2.dta")

head(aging)
library(caTools)
set.seed(23)

split = sample.split(aging$unemp , SplitRatio = 0.75)
train =subset(aging, split==TRUE)
test =subset(aging, split==FALSE)
dim(test)

library(caret)

set.seed(1)
model <- train(
  unemp ~ pop_retire,
  data = train,
  method = 'knn' , 
)
model

library(ggplot2)
plot(model, main = 'model')
y_pred = predict(model, newdata = test)
y_pred
plot(y_pred, main='prediction', col='red', col.main ='green', col.sub = 'blue',
     col.lab = 'sienna2', col.axis = 'maroon4', xlab = 'Aged Dependency Ratio',
     ylab = 'Unemployment Rate')
par(bg = "aliceblue")

