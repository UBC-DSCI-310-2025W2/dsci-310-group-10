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

# Read input data from script 1
data <- readRDS(input_file)

# Basic preprocessing
data$Outcome <- factor(data$Outcome, levels = c(0, 1), labels = c('No', 'Yes'))

# Summary statistics
summary_stats <- summary(data)

# EDA plot data
plot_df <- data %>%
  select(
    Pregnancies,
    Glucose,
    BloodPressure,
    SkinThickness,
    Insulin,
    BMI,
    DiabetesPedigreeFunction,
    Age,
    Outcome
  )

# Pair plot
pair_plot <- ggpairs(
  plot_df,
  aes(color = Outcome, alpha = 0.5),
  columns = 1:8,
  upper = list(continuous = wrap("cor", size = 3)),
  lower = list(continuous = "points"),
  diag = list(continuous = "densityDiag")
) +
  theme_minimal() +
  ggtitle("Pairwise Relationships Between Features and Outcome")

# Save outputs
saveRDS(data, output_data)
saveRDS(pair_plot, output_plot)
saveRDS(summary_stats, output_summary)