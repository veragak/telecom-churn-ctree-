############################################################
# Tune α for the Conditional Inference Tree
############################################################
alphas <- c(0.01, 0.05, 0.10, 0.20, 0.25, 0.30)

#empty table for results
results <- data.frame(
  alpha     = alphas,
  mincrit   = 1 - alphas, # mincriterion (0–1), required evidence for a split
  nodes     = NA, #number of terminal nodes (final group of costumers created by the splits)
  train_acc = NA, #accuracy on trainning set
  test_acc  = NA #accuracy on the testing set
)

for (i in seq_along(alphas)) {
  a <- alphas[i]
  
  ctrl <- ctree_control(mincriterion = 1 - a) #This tells the tree how strict to be.
  #fit a CIT predicting Churn using all other variables (.) using the training data and the current  α 
  
  fit  <- ctree(Churn ~ ., data = train, control = ctrl)
  
  # number of terminal nodes
  results$nodes[i] <- width(fit)
  
  # training accuracy
  pred_train <- predict(fit)
  #calculates training accuracy (how many predictions match the true Churn values)
  results$train_acc[i] <- mean(pred_train == train$Churn) 
  
  # test accuracy
  pred_test <- predict(fit, newdata = test)
  #calculates testing accuracy (how many predictions match the true Churn values)
  results$test_acc[i]  <- mean(pred_test == test$Churn)
}

#pretty results table
results %>%
  kable(
    format   = "latex",   
    digits   = 3,
    booktabs = TRUE,
    col.names = c(
      "Alpha ($\\alpha$)",
      "Min Criterion",
      "Terminal Nodes",
      "Train Accuracy",
      "Test Accuracy"
    ),
    caption  = "CIT Performance for Different Alpha Levels",
    escape   = FALSE      
  ) %>%
  kable_styling(
    latex_options = c("striped", "hold_position"),
    full_width    = FALSE,
    position      = "center"
  )
