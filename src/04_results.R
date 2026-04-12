# Script: 04_results.R
# Description: Evaluates model and generates final results.
# Input: results/model.rds, results/test_data.rds
# Output: results/final_results.csv, results/final_plot.png
# Usage: Rscript src/04_results.R results/model.rds results/test_data.rds results/conf_mat.rds results/final_results.csv results/final_plot.png
library(docopt)
library(caret)
library(ggplot2)
library(randomForest)
library(here)
library(diabetestools)

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

rf_model <- readRDS(model_file)
test_data <- readRDS(test_data_file)

predictions <- make_predictions(rf_model, test_data)

predictions <- factor(predictions, levels = levels(test_data$Outcome))
truth <- factor(test_data$Outcome, levels = levels(test_data$Outcome))

conf_mat <- confusionMatrix(predictions, truth)

conf_mat_table <- as.data.frame(conf_mat$table)
colnames(conf_mat_table) <- c("Prediction", "Reference", "Freq")

metrics <- compute_metrics(predictions, truth)

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
