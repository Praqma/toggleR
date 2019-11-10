context('API')

library(httr)
library(toggleR)

test_that('Fetching groups work', {
  expect_equal(get.toggl.groups(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE"))$status_code, 200)
})
