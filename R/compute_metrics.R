#' Compute classification performance metrics
#'
#' This function takes predicted labels and true labels, computes a confusion
#' matrix, and returns key performance metrics including accuracy, precision,
#' recall, and F1 score.
#'
#' @param predictions A factor vector of predicted class labels.
#' @param truth A factor vector of true class labels.
#'
#' @return A list containing:
#' \item{accuracy}{Overall accuracy of the model}
#' \item{precision}{Precision for the positive class}
#' \item{recall}{Recall (sensitivity) for the positive class}
#' \item{f1}{F1 score for the positive class}
#'
#' @details This function uses \code{caret::confusionMatrix} to compute evaluation
#' metrics. Both \code{predictions} and \code{truth} must be factors with the same
#' levels.
#'
#' @examples
#' preds <- factor(c(1, 0, 1, 1))
#' actual <- factor(c(1, 0, 0, 1))
#' compute_metrics(preds, actual)
#'
#' @export

compute_metrics <- function(predictions, truth) {
  if (!is.factor(predictions) || !is.factor(truth)) {
    stop("Both predictions and truth must be factors.")
  }
  
  if (length(predictions) != length(truth)) {
    stop("Predictions and truth must have the same length.")
  }
  
  if (!setequal(levels(predictions), levels(truth))) {
    stop("Predictions and truth must have the same factor levels.")
  }
  
  # Define positive class safely
  positive_class <- "1"
  
  # If "1" is not present in data, fallback to another level
  if (!(positive_class %in% levels(truth))) {
    positive_class <- levels(truth)[1]
  }
  
  cm <- confusionMatrix(predictions, truth, positive = positive_class)
  
  list(
    accuracy = unname(cm$overall["Accuracy"]),
    precision = unname(cm$byClass["Precision"]),
    recall = unname(cm$byClass["Recall"]),
    f1 = unname(cm$byClass["F1"])
  )
}