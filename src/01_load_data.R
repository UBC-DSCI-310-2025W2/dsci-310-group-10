# Script: 01_load_data.R
# Description: Loads dataset from OpenML and saves it as an RDS file.
# Input: OpenML dataset ID (e.g., 43483)
# Output: data/clean_data.rds
# Usage: Rscript src/01_load_data.R 43483 data/clean_data.rds
library(tidyverse)
library(docopt)
library(OpenML)
library(farff)
library(diabetestools)

source("R/data_validation.R")

doc <- "
Usage:
  01_load_data.R <dataset_id> <output_file>
"

opt <- docopt(doc)

dataset_id <- opt$dataset_id
output_file <- opt$output_file

df <- load_data(dataset_id)

message("Running data validation checks...")
validate_dataset(df)

saveRDS(df, output_file)
