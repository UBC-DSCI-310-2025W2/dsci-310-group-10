# Script: 03_model.R
# Description: Trains machine learning model using processed data.
# Input: data/processed_data.rds
# Output: results/model.rds, results/test_data.rds
# Usage: Rscript src/03_model.R data/processed_data.rds results/model.rds results/test_data.rds
library(docopt)
library(randomForest)
library(caret)
library(here)

source(here("R", "split_data.R"))

doc <- "
Usage:
  03_model.R <input_file> <output_model> <output_test_data>
"

opt <- docopt(doc)

input_file <- opt$input_file
output_model <- opt$output_model
output_test_data <- opt$output_test_data

# Read processed dataset
df <- readRDS(input_file)

# Ensure Outcome is a factor
df$Outcome <- as.factor(df$Outcome)

# Train/test split using split_data function
split <- split_data(df, prop = 0.8, seed = 123)
train_data <- split$train
test_data <- split$test

# Train random forest model
rf_model <- randomForest(
  Outcome ~ .,
  data = train_data,
  ntree = 500,
  importance = TRUE
)

# Save outputs
saveRDS(rf_model, output_model)
saveRDS(test_data, output_test_data)