#' Split data into training and test sets
#'
#' This function splits a data frame into training and test sets.
#'
#' @param data A data frame.
#' @param prop A numeric proportion for the training set. Default is 0.8.
#' @param seed An integer random seed. Default is 123.
#'
#' @return A list with two elements:
#' \item{train}{training data frame}
#' \item{test}{test data frame}
#'
#' @export
split_data <- function(data, prop = 0.8, seed = 123) {

  # check input is data frame
  if (!is.data.frame(data)) {
    stop("data must be a data frame.")
  }

  # check prop is valid
  if (!is.numeric(prop) || length(prop) != 1 || prop <= 0 || prop >= 1) {
    stop("prop must be a single number between 0 and 1.")
  }

  # check seed
  if (!is.numeric(seed) || length(seed) != 1) {
    stop("seed must be a single numeric value.")
  }

  set.seed(seed)

  # sample indices
  train_index <- sample(
    seq_len(nrow(data)),
    size = floor(prop * nrow(data))
  )

  # split
  train <- data[train_index, , drop = FALSE]
  test <- data[-train_index, , drop = FALSE]

  return(list(train = train, test = test))
}