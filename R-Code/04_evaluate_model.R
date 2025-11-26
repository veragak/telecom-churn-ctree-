############################################################
# Evaluate out-of-sample performance (test set)
############################################################
pred_test <- predict(tree_final, newdata = test)

# Confusion matrix
conf_mat <- table(Predicted = pred_test, Actual = test$Churn)
cm_df <- as.data.frame(conf_mat) 

ggplot(cm_df, aes(x = Actual, y = Predicted, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 6) +
  scale_fill_gradient(low = "white", high = "orange") +
  theme_minimal() +
  labs(title = "Confusion Matrix Heatmap") +
  theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))

# Overall accuracy
test_accuracy <- mean(pred_test == test$Churn)
pred_train <- predict(tree_final)
train_accuracy <- mean(pred_train == train$Churn)

cm_raw <- confusionMatrix(pred_test, test$Churn, positive = "Yes")
cm_raw

cm <- cm_raw$table
stats <- data.frame(
  `Train Accuracy` = train_accuracy,
  `Test Accuracy` = cm_raw$overall["Accuracy"],
  Kappa = cm_raw$overall["Kappa"],
  Sensitivity = cm_raw$byClass["Sensitivity"],
  Specificity = cm_raw$byClass["Specificity"],
  `Balanced Accuracy` = cm_raw$byClass["Balanced Accuracy"]
)

kable(stats, digits = 3, caption = "Performance Metrics") %>%
  kable_styling(full_width = FALSE, position = "center")
