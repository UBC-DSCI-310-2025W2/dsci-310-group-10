library(tidyverse)
library(docopt)
library(OpenML)


source("R/load_data.R")

doc <- "
Usage:
  01_load_data.R <dataset_id> <output_file>
"

opt <- docopt(doc)

dataset_id <- opt$dataset_id
output_file <- opt$output_file

df <- load_data(dataset_id)

saveRDS(df, output_file)