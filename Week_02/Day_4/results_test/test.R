

# second test : one expectation
test_that("Character input returns an error", {
  expect_error(is_leap_year("year"))
})