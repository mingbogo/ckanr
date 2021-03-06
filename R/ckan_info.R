#' Get information on a CKAN server
#'
#' @export
#' @param ... Curl args passed on to \code{\link[httr]{GET}} (optional)
#' @return for \code{ckan_info} a list with many slots with various info.
#' for \code{ckan_version}, list of length two, with actual version as character,
#' and another with version converted to numeric (any dots or letters removed)
#' @examples \dontrun{
#' ckan_info()
#' ckan_info(servers()[5])
#'
#' ckan_version(servers()[5])
#' }
ckan_info <- function(url = get_default_url(), ...) {
  res <- httr::GET(file.path(url, "api/util/status"))
  stop_for_status(res)
  jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))
}

#' @export
#' @param url Base url to use. Default: \url{http://data.techno-science.ca}. See
#' also \code{\link{ckanr_setup}} and \code{\link{get_default_url}}. (required)
#' @rdname ckan_info
ckan_version <- function(url) {
  ver <- ckan_info(url)$ckan_version
  nn <- as.numeric(
    paste0(
      unlist(regmatches(ver, gregexpr("[[:digit:]]+", ver))),
      collapse = "")
  )
  list(version = ver, version_num = nn)
}
