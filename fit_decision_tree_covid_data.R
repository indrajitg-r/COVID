# Load packages

library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(rattle)
library(caret)

#### Code assumes that the data set is loaded as a dataframe into the  variable covid_data ####
#### Fit a tree

mydt <- rpart(y~., method = "anova", data=covid_data, minsplit=5)

##### Print summary of the tree

summary(mydt)

#### Plot tree

fancyRpartPlot(mydt, caption=NULL)

#### Accuracy of the fitted tree

predicted_mydt <- predict(mydt)
RMSE(predicted_mydt, y)
