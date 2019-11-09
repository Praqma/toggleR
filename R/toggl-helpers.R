#' Fetch a list of clients from toggl.
#'
#' @param toggl_token A toggl API token to access https://toggl.com.
#' @param workspace_id The workspace id for the wanted workspace.
#' @param verbose A flag to enable more verbose output, Default value: FALSE
#' @return The list (JSON) of clients accessable using \code{toggl_token} from the toggl workspace with id: \code{workspace_id}.
#' @family get.toggl
#' @examples
#' get.toggl.clients(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE"))
#' @export
get.toggl.clients <- function(toggl_token, workspace_id, verbose = FALSE) {
  username <- toggl_token
  password <- "api_token"


  base <- "https://toggl.com/api"
  endpoint <- "v8/workspaces"
  what <- "clients"

  call <- paste(base, endpoint, workspace_id, what, sep = "/")

  if (verbose) {
    result <- GET(call, authenticate(username, password), verbose())
  } else {
    result <- GET(call, authenticate(username, password))
  }
  return(result)
}

#' Fetch a list of groups from toggl.
#'
#' @param toggl_token A toggl API token to access https://toggl.com.
#' @param workspace_id The workspace id for the wanted workspace.
#' @param verbose A flag to enable more verbose output, Default value: FALSE
#' @return The list (JSON) of groups accessable using \code{toggl_token} from the toggl workspace with id: \code{workspace_id}.
#' @family get.toggl
#' @examples
#' get.toggl.groups(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE"))
#' @export
get.toggl.groups <- function(toggl_token, workspace_id, verbose = FALSE) {
  username <- toggl_token
  password <- "api_token"


  base <- "https://toggl.com/api"
  endpoint <- "v8/workspaces"
  what <- "groups"

  call <- paste(base, endpoint, workspace_id, what, sep = "/")

  if (verbose) {
    result <- GET(call, authenticate(username, password), verbose())
  } else {
    result <- GET(call, authenticate(username, password))
  }
  return(result)
}
