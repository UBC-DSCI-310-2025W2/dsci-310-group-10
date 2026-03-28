#' Load diabetes dataset from OpenML
#'
#' Downloads a dataset from OpenML using a dataset ID and returns
#' the data as a data frame.
#'
#' @param dataset_id A numeric OpenML dataset ID.
#'
#' @return A data frame containing the downloaded dataset.
#'
#' @examples
#' \dontrun{
#' load_diabetes_data(43483)
#' }
load_diabetes_data <- function(dataset_id) {
  if (missing(dataset_id)) {
    stop("`dataset_id` must be provided.", call. = FALSE)
  }
  
  if (!is.numeric(dataset_id) || length(dataset_id) != 1 || is.na(dataset_id)) {
    stop("`dataset_id` must be a single non-missing numeric value.", call. = FALSE)
  }
  
  oml_data <- OpenML::getOMLDataSet(data.id = dataset_id)
  df <- oml_data$data
  
  if (!is.data.frame(df)) {
    stop("Downloaded object is not a data frame.", call. = FALSE)
  }
  
  return(df)
}