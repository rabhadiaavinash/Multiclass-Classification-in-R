
# Multiclass classification on CMC dataset


#In this example, we will try to predict the 

#choice of contraceptive preferred by women (1=No-use, 2=Long-term, 3=Short-term).

# we will model the choice of contraceptive method cmc as a function of all these variables.



cmcData <- read.csv("http://archive.ics.uci.edu/ml/machine-learning-databases/cmc/cmc.data",
            stringsAsFactors=FALSE, header=F)


colnames(cmcData) <- c("wife_age", "wife_edu", "hus_edu", "num_child", 
                       "wife_rel", "wife_work", "hus_occu", "sil", "media_exp", "cmc")


head(cmcData)

View(cmcData)


#Convert Numerics to Factors


cmcData$wife_edu <- factor(cmcData$wife_edu, levels=sort(unique(cmcData$wife_edu)))
cmcData$wife_edu
cmcData$hus_edu <- factor(cmcData$hus_edu, levels=sort(unique(cmcData$hus_edu)))
cmcData$hus_edu 
cmcData$wife_rel <- factor(cmcData$wife_rel, levels=sort(unique(cmcData$wife_rel)))
cmcData$wife_rel
cmcData$wife_work <- factor(cmcData$wife_work, levels=sort(unique(cmcData$wife_work)))
cmcData$hus_occu <- factor(cmcData$hus_occu, levels=sort(unique(cmcData$hus_occu)))
cmcData$sil <- factor(cmcData$sil, levels=sort(unique(cmcData$sil)))
cmcData$media_exp <- factor(cmcData$media_exp, levels=sort(unique(cmcData$media_exp)))
cmcData$cmc <- factor(cmcData$cmc, levels=sort(unique(cmcData$cmc)))
cmcData$cmc



head(cmcData)

str(cmcData)

# Prepare Training and Test Data
set.seed(100)

nrow(cmcData)

0.7*nrow(cmcData)

trainingRows <- sample(1:nrow(cmcData), 0.7*nrow(cmcData))
trainingRows
training <- cmcData[trainingRows, ]
training
test <- cmcData[-trainingRows, ]
test


#Build Multinomial Model

library(nnet)
multinomModel <- multinom(cmc ~ ., data=training) # multinom Model


summary (multinomModel) # model summary


predicted_scores <- predict (multinomModel, test, "probs") # predict on new data
predicted_scores

nrow(predicted_scores)

predicted_class <- predict (multinomModel, test,"class")
predicted_class

table(predicted_class, test$cmc)






