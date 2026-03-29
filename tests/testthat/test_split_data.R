library(testthat)
library(here)

source(here("R", "split_data.R"))

test_that("split_data returns a list with train and test", {
  df <- data.frame(x = 1:10, y = letters[1:10])

  result <- split_data(df, prop = 0.8, seed = 123)

  expect_true(is.list(result))
  expect_named(result, c("train", "test"))
})

test_that("split_data returns correct train and test sizes", {
  df <- data.frame(x = 1:10)

  result <- split_data(df, prop = 0.8, seed = 123)

  expect_equal(nrow(result$train), 8)
  expect_equal(nrow(result$test), 2)
})

test_that("split_data is reproducible with the same seed", {
  df <- data.frame(x = 1:10)

  result1 <- split_data(df, prop = 0.8, seed = 123)
  result2 <- split_data(df, prop = 0.8, seed = 123)

  expect_equal(result1$train, result2$train)
  expect_equal(result1$test, result2$test)
})

test_that("split_data gives different splits with different seeds", {
  df <- data.frame(x = 1:10)

  result1 <- split_data(df, prop = 0.8, seed = 123)
  result2 <- split_data(df, prop = 0.8, seed = 456)

  expect_false(identical(result1$train, result2$train))
})

test_that("split_data ensures no overlap between train and test", {
  df <- data.frame(x = 1:10)

  result <- split_data(df, prop = 0.8, seed = 123)

  expect_equal(length(intersect(result$train$x, result$test$x)), 0)
})

test_that("split_data preserves all rows", {
  df <- data.frame(x = 1:10)

  result <- split_data(df, prop = 0.8, seed = 123)

  combined <- rbind(result$train, result$test)

  expect_equal(nrow(combined), nrow(df))
  expect_setequal(combined$x, df$x)
})

test_that("split_data preserves column names", {
  df <- data.frame(a = 1:10, b = letters[1:10])

  result <- split_data(df, prop = 0.8, seed = 123)

  expect_named(result$train, names(df))
  expect_named(result$test, names(df))
})

test_that("split_data errors when input is not a data frame", {
  expect_error(split_data(123, prop = 0.8, seed = 123))
})

test_that("split_data errors when prop is invalid", {
  df <- data.frame(x = 1:10)

  expect_error(split_data(df, prop = -0.1, seed = 123))
  expect_error(split_data(df, prop = 0, seed = 123))
  expect_error(split_data(df, prop = 1, seed = 123))
  expect_error(split_data(df, prop = c(0.8, 0.7), seed = 123))
})

test_that("split_data errors when seed is invalid", {
  df <- data.frame(x = 1:10)

  expect_error(split_data(df, prop = 0.8, seed = c(1, 2)))
})