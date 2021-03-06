# retrieve package settings, internal function, not exported
default <- function(name, allow_null = FALSE) {
  name <- enquo(name) %>% quos_to_text(variable = "setting")
  value <- getOption(str_c("ll.", name))
  if (!allow_null && is.null(value)) stop("ll setting '", name, "' does not exist, make sure to set the default first", call. = FALSE)
  return(value)
}

# set package setting, internal function, not exported
set_default <- function(name, value, overwrite = TRUE) {
  if (overwrite || !str_c("ll.", name) %in% names(options()))
    options(list(value) %>% setNames(str_c("ll.", name)))
  return(invisible(value))
}

# turn debug on
turn_debug_on <- function() {
  set_default("debug", TRUE)
}

#' Set default database connection or pool
#' @param con database connection or pool object
#' @export
ll_set_db_con <- function(con) {
  set_default("con", enquo(con))
}

#' Set default access token for particle API requests
#' @param token the particle acocunt access token, keep secret!!
#' @export
ll_set_access_token <- function(token) {
  set_default("access_token", token)
}

#' Set default group ID
#'
#' Note that this is not checked wheter it exists, simply used as the default for other functions.
#'
#' @param group_id group
#' @export
ll_set_group_id <- function(group_id) {
  set_default("group_id", group_id)
}

#' Set default request timeout
#'
#' @param group_id group
#' @export
ll_set_request_timeout <- function(timeout) {
  set_default("request_timeout", timeout)
}


#' Turn information messages on/off
#'
#' These functions turn information messages on/off in all subsequent function calls by changing the global settings for the \code{quiet} parameter of c3 functions.
#' These functions can be called stand alone or within a pipeline to turn messages on/off at a certain point during the pipeline.
#'
#' @param data a data frame - returned invisibly as is if provided (e.g. in the middle of a pipeline)
#' @name ll_info_messages
NULL

#' @rdname ll_info_messages
#' @family settings functions
#' @export
ll_turn_info_messages_on <- function(data = NULL) {
  set_default("quiet", FALSE)
  message("Info: information messages turned on")
  if (!missing(data)) return(invisible(data))
}

#' @rdname ll_info_messages
#' @export
ll_turn_info_messages_off <- function(data = NULL) {
  set_default("quiet", TRUE)
  if (!missing(data)) return(invisible(data))
}
