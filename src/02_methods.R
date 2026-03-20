library(docopt)
library(tidyverse)
library(GGally)

doc <- "
Usage:
  02_methods.R <input_file> <output_data> <output_plot> <output_summary>
"

opt <- docopt(doc)

input_file <- opt$input_file
output_data <- opt$output_data
output_plot <- opt$output_plot
output_summary <- opt$output_summary

# Setup and Directory Check
if (!dir.exists(dirname(opt$output_plot))) {
  dir.create(dirname(opt$output_plot), recursive = TRUE)
}


# Load Processed Data from Step 1
data <- readRDS(opt$input_file)

# Factorize Outcome for Visualization
# Mapping 0/1 to No/Yes for clearer plot labels
data$Outcome <- factor(data$Outcome, levels = c(0, 1), labels = c('No', 'Yes'))

# Summary statistics
summary_stats <- summary(data)

# Feature Selection for EDA
# Selecting core columns for the pairwise relationship matrix
plot_df <- data %>%
  select(Pregnancies, Glucose, BloodPressure, SkinThickness, 
         Insulin, BMI, DiabetesPedigreeFunction, Age, Outcome)

# Generate Pairwise Relationship Plot
# Using GGally to visualize correlations, densities, and scatterplots
pair_plot <- ggpairs(
  plot_df,
  columns = 1:8,
  mapping = aes(color = Outcome, fill = Outcome),
  upper = list(continuous = wrap("cor", size = 3)),
  lower = list(continuous = wrap("points", alpha = 0.4, size = 0.5)),
  diag = list(continuous = wrap("densityDiag", alpha = 0.5))
) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Pairwise Relationships by Diabetes Outcome") +
  theme(axis.text = element_text(size = 7))

# Save Outputs for Downstream Scripts
saveRDS(data, opt$output_data)
ggsave(opt$output_plot, plot = pair_plot, width = 12, height = 10)
write.csv(as.data.frame(as.matrix(summary(data))), opt$output_summary)