############################################################
# Load Libraries
############################################################
library(tidyverse)
library(partykit)   # for ctree
library(caret)      # for confusionMatrix
library(knitr)
library(kableExtra)
library(ggplot2)
library(car)

############################################################
# Import and Clean Data
############################################################
load("Churn.2526.RData")
list.files()

#Looking at the data
# all data looks clean, categorical variables are already factor, 
# and numeric ones are numeric
str(data)
head(data)
summary(data)
anyNA(data)

# Select only numeric predictors
numeric_vars <- data[sapply(data, is.numeric)]
# Compute correlation matrix
cor_matrix <- cor(numeric_vars, use = "everything")
cor_matrix

############################################################
# Train-Test Split
############################################################
n <- nrow(data) # number of rows 
set.seed(123) # make the random split reproducible
train_idx <- sample(seq_len(n), size = 0.7 * n) # pick 70% indices at random

train <- data[train_idx, ] # training data (what the model "sees")
test  <- data[-train_idx,] # test data (held-out, for evaluation)

nrow(train); nrow(test)
