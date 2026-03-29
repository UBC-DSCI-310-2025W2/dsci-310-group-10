#' Load dataset from OpenML
#'
#' @param dataset_id Numeric OpenML dataset ID
#' @return A data.frame
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