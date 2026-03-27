library(docopt)
library(caret)
library(ggplot2)
library(randomForest)


source("R/compute_metrics.R")

doc <- "
Usage:
  04_results.R <model_file> <test_data_file> <output_conf_mat> <output_metrics> <output_plot>
"

opt <- docopt(doc)

model_file <- opt$model_file
test_data_file <- opt$test_data_file
output_conf_mat <- opt$output_conf_mat
output_metrics <- opt$output_metrics
output_plot <- opt$output_plot

# Read inputs from script 3
rf_model <- readRDS(model_file)
test_data <- readRDS(test_data_file)

# Make predictions
predictions <- predict(rf_model, newdata = test_data)

# Ensure consistent factor levels
predictions <- factor(predictions, levels = levels(test_data$Outcome))
truth <- factor(test_data$Outcome, levels = levels(test_data$Outcome))

# Confusion matrix
conf_mat <- confusionMatrix(predictions, truth)

# Convert confusion matrix to table for plotting
conf_mat_table <- as.data.frame(conf_mat$table)
colnames(conf_mat_table) <- c("Prediction", "Reference", "Freq")

# Compute metrics 
metrics <- compute_metrics(predictions, truth)

# Metrics table
metrics_table <- data.frame(
  Metric = c("Accuracy", "Precision", "Recall", "F1 Score"),
  Value = c(
    metrics$accuracy,
    metrics$precision,
    metrics$recall,
    metrics$f1
  )
)

# Confusion matrix plot
conf_mat_plot <- ggplot(conf_mat_table, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 6) +
  scale_fill_gradient(low = "white", high = "steelblue") +
  labs(
    title = "Confusion Matrix - Random Forest",
    x = "Actual",
    y = "Predicted"
  ) +
  theme_minimal(base_size = 14)

# Save outputs
saveRDS(conf_mat, output_conf_mat)
write.csv(metrics_table, output_metrics, row.names = FALSE)
ggsave(output_plot, conf_mat_plot, width = 6, height = 5)