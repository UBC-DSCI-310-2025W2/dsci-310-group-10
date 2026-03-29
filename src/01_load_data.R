library(OpenML)

source("R/load_data.R")

args <- commandArgs(trailingOnly = TRUE)

dataset_id <- as.numeric(args[1])
output_file <- args[2]

df <- load_diabetes_data(dataset_id)

saveRDS(df, output_file)