library(docopt)
library(caret)
library(ggplot2)
library(randomForest)

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

# Confusion matrix
conf_mat <- confusionMatrix(predictions, test_data$Outcome)

conf_mat_table <- as.data.frame(conf_mat$table)
colnames(conf_mat_table) <- c("Prediction", "Reference", "Freq")

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

# Performance metrics
accuracy <- conf_mat$overall["Accuracy"]
precision <- conf_mat$byClass["Precision"]
recall <- conf_mat$byClass["Recall"]
f1 <- conf_mat$byClass["F1"]

metrics_table <- data.frame(
  Metric = c("Accuracy", "Precision", "Recall", "F1 Score"),
  Value = c(accuracy, precision, recall, f1)
)

# Save outputs
saveRDS(conf_mat, output_conf_mat)
saveRDS(metrics_table, output_metrics)
saveRDS(conf_mat_plot, output_plot)