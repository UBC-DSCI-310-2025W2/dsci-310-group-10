library(testthat)
library(caret)
library(here)

# Source the function
source(here("R", "make_predictions.R"))

# SETUP: Create a dummy model for isolated testing
set.seed(123)
train_df <- data.frame(
  feat1 = rnorm(20),
  feat2 = rnorm(20),
  target = factor(sample(c("0", "1"), 20, replace = TRUE))
)
dummy_model <- train(target ~ ., data = train_df, method = "knn", tuneLength = 1)

#simple cases
test_that("make_predictions returns correct format and length for standard input", {
  test_data <- data.frame(feat1 = rnorm(10), feat2 = rnorm(10))
  result <- make_predictions(dummy_model, test_data)
  
  expect_s3_class(result, "factor")
  expect_equal(length(result), nrow(test_data))
  expect_setequal(levels(result), levels(train_df$target))
})

#edge cases
test_that("make_predictions handles minimal input (single row)", {
  single_row <- data.frame(feat1 = 0.5, feat2 = -0.5)
  result <- make_predictions(dummy_model, single_row)
  
  expect_equal(length(result), 1)
})

test_that("make_predictions handles large datasets", {
  large_data <- data.frame(feat1 = rnorm(1000), feat2 = rnorm(1000))
  result <- make_predictions(dummy_model, large_data)
  
  expect_equal(length(result), 1000)
})

#error cases
test_that("make_predictions errors when input is not a dataframe", {
  expect_error(make_predictions(dummy_model, c(1, 2, 3)), "must be a data frame")
})

test_that("make_predictions errors for empty dataframe", {
  expect_error(make_predictions(dummy_model, data.frame()), "cannot be empty")
})

test_that("make_predictions errors when feature columns are missing", {
  bad_data <- data.frame(wrong_name = rnorm(5))
  expect_error(make_predictions(dummy_model, bad_data), "Prediction failed")
})