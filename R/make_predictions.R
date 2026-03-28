#' Generate predictions from a trained model
#'
#' This function takes a trained model object and a new dataset to produce 
#' a vector of predicted class labels. It ensures the output size remains 
#' consistent with the input data.
#'
#' @param model A fitted model object (e.g., from \code{caret::train} or \code{glm}).
#' @param new_data A data frame or tibble containing the features for prediction.
#'
#' @return A factor vector of predicted class labels with the same length 
#' as the number of rows in \code{new_data}.
#'
#' @details This function wraps the generic \code{predict} function and 
#' includes validation checks to ensure output-input alignment, which is 
#' critical for reproducible pipelines.
#'
#' @examples
#' # Assuming 'final_model' and 'test_data' are loaded:
#' # preds <- make_predictions(final_model, test_data)
#'
#' @export
make_predictions <- function(model, new_data) {
# 1. Input validation
if (!is.data.frame(new_data)) {
    stop("new_data must be a data frame or tibble.")
}

if (nrow(new_data) == 0) {
    stop("new_data cannot be empty.")
}

# 2. Generate predictions
# Using tryCatch to provide informative error messages if columns don't match
preds <- tryCatch({
    predict(model, newdata = new_data)
}, error = function(e) {
    stop(paste("Prediction failed. Ensure new_data has correct columns:", e$message))
})

# 3. Robustness Check: Output length = Input rows
if (length(preds) != nrow(new_data)) {
    stop(sprintf(
    "Output length (%d) does not match input rows (%d).",
    length(preds), nrow(new_data)
    ))
}

return(preds)
}