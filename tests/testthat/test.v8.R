context('API')

library(httr)
library(jsonlite)
library(toggleR)

token <- Sys.getenv("TOGGL_TOKEN")
workspace <- Sys.getenv("TOGGL_WORKSPACE")

test_that('There is a TOGGL_TOKEN', {
  expect_equal(length(token), 1)
  expect_false(is.element('', token))
})

test_that('There is a TOGGL_WORKSPACE', {
  expect_equal(length(workspace), 1)
  expect_false(is.element('', workspace))
})

test_that('Fetching clients work', {
  expect_equal(get.toggl.v8(token, workspace, 'clients')$status_code, 200)
})

test_that('Fetching groups work', {
  expect_equal(get.toggl.v8(token, workspace, 'groups')$status_code, 200)
})
