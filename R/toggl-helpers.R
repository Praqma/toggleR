#' Fetch a list from toggl using the v8 api.
#'
#' @param toggl_token A toggl API token to access https://toggl.com.
#' @param workspace_id The workspace id for the wanted workspace.
#' @param what What to fetch
#' @param verbose A flag to enable more verbose output, Default value: FALSE
#' @return The list (JSON) of clients accessable using \code{toggl_token} from the toggl workspace with id: \code{workspace_id}.
#' @family get.toggl
#' @examples
#' get.toggl.v8(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE"), "clients")
#' @export
get.toggl.v8 <- function(toggl_token, workspace_id, what, verbose = FALSE) {
  username <- toggl_token
  password <- "api_token"

  base <- "https://toggl.com/api"
  endpoint <- "v8/workspaces"

  call <- paste(base, endpoint, workspace_id, what, sep = "/")

  if (verbose) {
    result <- GET(call, authenticate(username, password), verbose())
  } else {
    result <- GET(call, authenticate(username, password))
  }
  return(result)
}
#' Fetch a list from toggl using the v8 api.
#'
#' @param toggl_token A toggl API token to access https://toggl.com.
#' @param workspace_id The workspace id for the wanted workspace.
#' @param what What to fetch
#' @param verbose A flag to enable more verbose output, Default value: FALSE
#' @return The list (JSON) of clients accessable using \code{toggl_token} from the toggl workspace with id: \code{workspace_id}.
#' @family get.toggl
#' @examples
#' get.toggl.v8(Sys.getenv("TOGGL_TOKEN"), Sys.getenv("TOGGL_WORKSPACE"), "clients")
#' @export
get.toggl.v8.data <- function(toggl_token, workspace_id, what, verbose = FALSE) {
  json.response <- get.toggl.v8(toggl_token, workspace_id, what, verbose)

  if (json.response$status_code == 200) {
    return(fromJSON(content(json.response, "text")))
  }

  print(json.response)
  return("ERROR")
}
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
  return(get.toggl.v8.data(toggl_token, workspace_id, "clients"))
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
  return(get.toggl.v8.data(toggl_token, workspace_id, "groups"))
}


