#' Load dataset from OpenML
#'
#' This function retrieves a dataset from OpenML using its dataset ID.
#'
#' @param dataset_id Numeric OpenML dataset ID. For this project, use 43483.
#'
#' @return A data.frame containing predictors and the target variable "Outcome".
#'
#' @details This function requires an internet connection to download data from OpenML.
#'
#' @examples
#' \dontrun{
#' df <- load_data(43483)
#' head(df)
#' }
#'
#' @import OpenML
#' @export
load_data <- function(dataset_id) {
  
  if (is.null(dataset_id) || is.na(dataset_id)) {
    stop("dataset_id must be provided and numeric.")
  }
  
  dataset_id <- as.numeric(dataset_id)
  
  oml_data <- OpenML::getOMLDataSet(data.id = dataset_id)
  
  df <- oml_data$data
  
  return(df)
}
