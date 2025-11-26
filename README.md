# Telecom Churn Prediction Using Conditional Inference Trees (CTree)

This project analyses telecom customer data to identify the key drivers of churn
and build a predictive model using **Conditional Inference Trees (CTree)**.
Unlike classical CART trees, CTree uses statistical hypothesis testing to decide
splits, preventing overfitting and avoiding variable-selection bias.

This work was originally developed for the course  
**FEM11152 – Seminar Data Science for Marketing Analytics (Erasmus School of Economics)**  
and has been reorganized into a clean, reproducible data-science pipeline.

---

## Repository Structure

- `R-Code/`
  - `01_prepare_data.R` — load and prepare dataset  
  - `02_tune_alpha.R` — evaluate different α (significance levels)  
  - `03_fit_final_model.R` — train the final Conditional Inference Tree  
  - `04_evaluate_model.R` — confusion matrix & performance metrics  

- `data/`
  - `Churn_2526.RData` — or the CSV dataset used in the analysis  

- `figures/`
  - `ctree_final.png` — final trained tree  
  - `confusion_matrix.png` — model performance visualization  

- `report/`
  - `telecom_churn_ctree.Rmd` — full reproducible analysis  
  - `telecom_churn_ctree.pdf` — final written report  

- `README.md`

---

## Project Overview

### **Objective**
To determine whether customer churn can be predicted using demographic,
contract-related, and usage variables, and to understand which factors
contribute most to churn risk.

### **Method: Conditional Inference Trees (CTree)**

CTree improves on classical CART by:
- using permutation-based statistical test
- avoiding biased variable selection  
- preventing overfitting without pruning  
- basing splits on p-values rather than impurity measures  

### **Workflow**

1. **Data Preparation**
   - Load churn dataset  
   - Clean variable types  
   - Handle categorical variables  
   - Split into training and testing  

2. **Tuning α (significance level)**
   - Tested multiple α values (e.g., 0.01–0.30)  
   - Observed tree complexity and accuracy  
   - Identified α where the tree “saturates” (no more significant splits)  

3. **Model Training**
   - Fit final CTree using optimal α  
   - Export final tree visualization (`ctree_final.png`)  

4. **Model Evaluation**
   - Predictions on test set  
   - Confusion matrix  
   - Accuracy, balanced accuracy, sensitivity, specificity  
   - Visualization (`confusion_matrix.png`)  

---

## Key Insights

- Tree complexity increased with higher α until stabilizing at a saturation point.  
- Certain variables (e.g., contract type, monthly charges, tenure) were strong churn predictors.  
- The final model achieved good out-of-sample performance and offered strong interpretability.  

---

## How to Run the Analysis

- Open the scripts located in:
  - `R-Code/01_prepare_data.R`  
  - `R-Code/02_tune_alpha.R`  
  - `R-Code/03_fit_final_model.R`  
  - `R-Code/04_evaluate_model.R`

- Ensure the dataset is placed inside:
  - `data/Churn_2526.RData`  
  *(or replace the filename with your CSV)*

- Run the scripts in numerical order to:
  - load & clean data  
  - tune α  
  - fit CTree  
  - evaluate model  
  - generate figures automatically in `figures/`  

---

## Required R Packages

Install required packages:

```r
install.packages(c(
  "tidyverse",
  "partykit",
  "ggplot2",
  "caret",
  "pROC",
  "janitor"
))
```
---

### Final Conditional Inference Tree

Click the image below to view the full-size tree:

[View Final CTree](figures/ctree_final.png)
