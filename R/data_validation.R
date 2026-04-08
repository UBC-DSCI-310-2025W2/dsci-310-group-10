# Expected columns for the dataset
expected_cols <- c("Pregnancies", "Glucose", "BloodPressure",
                   "SkinThickness", "Insulin", "BMI",
                   "DiabetesPedigreeFunction", "Age", "Outcome")

#' Check if input is a data frame
#'
#' Verifies that the provided object is a data frame.
#'
#' @param df An object to validate.
#'
#' @return No return value. Stops execution if input is not a data frame.
check_is_dataframe <- function(df) {
  if (!is.data.frame(df)) {
    stop("Input is not a data.frame.")
  }
}

#' Check required column names
#'
#' Ensures that all expected columns are present in the dataset.
#'
#' @param df A data frame to validate.
#' @param expected_cols A character vector of required column names.
#'
#' @return No return value. Stops execution if required columns are missing.
check_column_names <- function(df, expected_cols) {
  missing <- setdiff(expected_cols, colnames(df))
  if (length(missing) > 0) {
    stop(paste("Missing columns:", paste(missing, collapse = ", ")))
  }
}

#' Check for empty observations
#'
#' Identifies rows where all values are missing (completely empty rows).
#'
#' @param df A data frame to validate.
#'
#' @return No return value. Stops execution if empty rows are found.
check_no_empty_rows <- function(df) {
  empty_rows <- which(rowSums(is.na(df)) == ncol(df))
  if (length(empty_rows) > 0) {
    stop(paste("Empty rows found at indices:", paste(empty_rows, collapse = ", ")))
  }
}

#' Check missingness threshold
#'
#' Evaluates whether any column exceeds an acceptable proportion of missing values.
#'
#' @param df A data frame to validate.
#' @param threshold A numeric value representing the maximum allowed proportion of missing values (default = 0.2).
#'
#' @return No return value. Issues a warning if any column exceeds the threshold.
check_missing_threshold <- function(df, threshold = 0.2) {
  missing_prop <- colMeans(is.na(df))
  bad_cols <- names(missing_prop[missing_prop > threshold])
  
  if (length(bad_cols) > 0) {
    warning(paste("Columns exceeding missingness threshold:",
                  paste(bad_cols, collapse = ", ")))
  }
}

#' Check data types of columns
#'
#' Ensures that specified columns are of numeric type.
#'
#' @param df A data frame to validate.
#'
#' @return No return value. Stops execution if any column has incorrect type.
check_data_types <- function(df) {
  numeric_cols <- c("Pregnancies", "Glucose", "BloodPressure",
                    "SkinThickness", "Insulin", "BMI",
                    "DiabetesPedigreeFunction", "Age")
  
  for (col in numeric_cols) {
    if (!is.numeric(df[[col]])) {
      stop(paste("Column", col, "is not numeric"))
    }
  }
}

#' Check for duplicate observations
#'
#' Verifies that the dataset does not contain duplicate rows.
#'
#' @param df A data frame to validate.
#'
#' @return No return value. Stops execution if duplicate rows are found.
check_no_duplicates <- function(df) {
  if (any(duplicated(df))) {
    stop("Duplicate rows detected.")
  }
}

#' Check for invalid or anomalous values
#'
#' Ensures that key numeric variables fall within reasonable ranges.
#'
#' @param df A data frame to validate.
#'
#' @return No return value. Stops execution if invalid values are detected.
check_value_ranges <- function(df) {
  if (any(df$Glucose < 0 | df$Glucose > 300, na.rm = TRUE)) {
    stop("Glucose contains unrealistic values.")
  }
  if (any(df$BMI <= 0 | df$BMI > 100, na.rm = TRUE)) {
    stop("BMI contains unrealistic values.")
  }
  if (any(df$Age <= 0 | df$Age > 120, na.rm = TRUE)) {
    stop("Age contains unrealistic values.")
  }
}

#' Check outcome variable levels
#'
#' Ensures that the Outcome variable contains only valid category values (0 or 1),
#' excluding missing values from the check.
#'
#' @param df A data frame to validate.
#'
#' @return No return value. Stops execution if invalid category levels are found.
check_outcome_levels <- function(df) {
  valid_levels <- c(0, 1)
  outcome_values <- unique(df$Outcome[!is.na(df$Outcome)])
  
  if (!all(outcome_values %in% valid_levels)) {
    stop("Outcome contains invalid category levels.")
  }
}

#' Validate dataset
#'
#' Runs a series of validation checks to ensure data quality before analysis.
#'
#' @param df A data frame to validate.
#'
#' @return No return value. Stops execution if any critical validation fails.
validate_dataset <- function(df) {
  check_is_dataframe(df)
  check_column_names(df, expected_cols)
  check_no_empty_rows(df)
  check_missing_threshold(df)
  check_data_types(df)
  check_no_duplicates(df)
  check_value_ranges(df)
  check_outcome_levels(df)
}
