setwd("~/Google Drive/Coursera/DataScience/Machine Learning/assignment")

library(caret)
library(doMC)
doMC::registerDoMC(cores=2)

# Load data
training <- read.csv("pml-training.csv", quote="\"", header=T, na.strings = c("NA", "", "#DIV/0!"))
to_predict <- read.csv("pml-testing.csv", quote="\"", header=T, na.strings = c("NA", "", "#DIV/0!"))



# Clean data
# Remove Columns with NAs
training <- training[,-c(1:8)]
training <- training[ , apply(training, 2, function(x) !any(is.na(x)))]

dim(training)

train_control <- trainControl(method="cv", number=10)

tree <- train(classe ~ ., data=training, method="rpart", trControl=train_control)
rf <- train(classe ~ ., data=training, method="rf", ntree=5, trControl=train_control)

print(tree)
print(rf)

predict(rf, to_predict)
