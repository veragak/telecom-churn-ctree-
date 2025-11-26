############################################################
# Fit Final Conditional Inference Tree
############################################################
alpha_final <- 0.20      
ctrl_final  <- ctree_control(mincriterion = 1 - alpha_final)
tree_final <- ctree(Churn ~ ., data = train, control = ctrl_final)

# Plot the tree 
plot(
  tree_final,
  gp = grid::gpar(fontsize = 4),
  tp_args = list(id = FALSE)
)


#variable importance
varimp(tree_final)

# Get variable importance
vi <- varimp(tree_final)

# Convert to 1-row data frame (variables as columns)
vi_row <- as.data.frame(t(vi))   # transpose

# Pretty table
kable(vi_row, digits = 3, caption = "Variable Importance (CTree Model)") %>%
  kable_styling(full_width = FALSE, position = "center")
