library(docopt)
library(randomForest)
library(caret)

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

set.seed(123)

# Train/test split
train_index <- createDataPartition(df$Outcome, p = 0.8, list = FALSE)

train_data <- df[train_index, ]
test_data <- df[-train_index, ]

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