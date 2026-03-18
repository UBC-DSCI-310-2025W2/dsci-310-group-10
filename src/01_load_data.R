library(tidyverse)
library(docopt)
library(OpenML)

doc <- "
Usage:
  01_load_data.R <dataset_id> <output_file>
"

opt <- docopt(doc)

dataset_id <- as.numeric(opt$dataset_id)
output_file <- opt$output_file

# Download dataset from OpenML
oml_data <- getOMLDataSet(data.id = dataset_id)

# Extract dataframe
df <- oml_data$data

# Save dataset
saveRDS(df, output_file)