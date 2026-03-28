test_that("load_diabetes_data returns a data frame", {
  df <- load_diabetes_data(43483)
  
  expect_s3_class(df, "data.frame")
  expect_true(nrow(df) > 0)
  expect_true(ncol(df) > 0)
})

test_that("load_diabetes_data contains Outcome column", {
  df <- load_diabetes_data(43483)
  
  expect_true("Outcome" %in% colnames(df))
})

test_that("load_diabetes_data errors for invalid dataset_id", {
  expect_error(load_diabetes_data("43483"))
  expect_error(load_diabetes_data(NA))
  expect_error(load_diabetes_data(c(43483, 1)))
})