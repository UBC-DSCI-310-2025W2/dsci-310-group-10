library(testthat)
library(caret)
library(here)
source(here("R", "load_data.R"))


test_that("load_data returns a data frame", {
  
  df <- load_data(61)  # iris dataset in OpenML
  
  expect_true(is.data.frame(df))
  expect_gt(nrow(df), 0)
  expect_gt(ncol(df), 0)
})


test_that("load_data returns consistent structure", {
  
  df <- load_data(61)
  
  expect_named(df)
})

test_that("load_data fails on invalid input", {
  
  expect_error(load_data(NA))
  expect_error(load_data(NULL))
})

test_that("load_data fails on invalid input", {
  
  expect_error(load_data(NA))
  expect_error(load_data(NULL))
})


