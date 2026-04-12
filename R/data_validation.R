library(pointblank)
library(dplyr)

# Expected columns
expected_cols <- c("Pregnancies", "Glucose", "BloodPressure",
                   "SkinThickness", "Insulin", "BMI",
                   "DiabetesPedigreeFunction", "Age", "Outcome")

#' Validate dataset using pointblank + custom checks
#'
#' Runs a series of validation checks to ensure data quality before analysis.
#'
#' @param df A data frame to validate.
#'
#' @return No return value. Stops execution if validation fails.
validate_dataset <- function(df) {
  
  # 1. Check input is a data frame
  if (!is.data.frame(df)) {
    stop("Input is not a data.frame.")
  }
  
  # 2. Check for completely empty rows (all NA)
  if (any(rowSums(is.na(df)) == ncol(df))) {
    stop("Empty rows detected.")
  }
  
  # 3. Missingness threshold (column-wise)
  missing_prop <- colMeans(is.na(df))
  bad_cols <- names(missing_prop[missing_prop > 0.2])
  
  if (length(bad_cols) > 0) {
    warning(paste("Columns exceeding missingness threshold:",
                  paste(bad_cols, collapse = ", ")))
  }
  
  # 4. Prepare data for Outcome validation (remove NA only for this check)
  df_outcome_checked <- df %>%
    filter(!is.na(Outcome))
  
  # 5. Create pointblank agent
  agent <- create_agent(tbl = df_outcome_checked) %>%
    
    # 6. Correct column names
    col_exists(vars(!!!expected_cols)) %>%
    
    # 7. Correct data types
    col_is_numeric(vars(Pregnancies, Glucose, BloodPressure,
                        SkinThickness, Insulin, BMI,
                        DiabetesPedigreeFunction, Age)) %>%
    
    # 8. No duplicate observations
    rows_distinct() %>%
    
    # 9. Valid value ranges (anomalies)
    col_vals_between(Glucose, left = 0, right = 300) %>%
    col_vals_between(BMI, left = 0, right = 100) %>%
    col_vals_between(Age, left = 0, right = 120) %>%
    
    # 10. Correct category levels (Outcome ∈ {0,1})
    col_vals_in_set(Outcome, set = c(0, 1))
  
  # Run validation
  agent <- interrogate(agent)

  
  # 11. Fail pipeline if any validation fails
  # Always show validation report
  get_sundered_data(agent, type = "combined")
  
  if (any(agent$validation_set$f_failed > 0)) {
    stop("Data validation failed.")
  }
  
  message("All validation checks passed.")
}
