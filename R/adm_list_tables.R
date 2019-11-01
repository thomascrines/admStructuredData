#' List tables in a SQL Server database
#'
#' \code{adm_list_tables} lists all base tables in a SQL Server database on a specified server.
#'
#' @param database \code{string}. A SQL Server database name.
#' @param server \code{string}. A SQL Server database server.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_list_tables(database = "DatabaseName", server = "DatabaseServer")
#' }
#'
#' @export

adm_list_tables <- function(database, server) {

  connection <- admStructuredData:::adm_create_connection(database = database, server = server)
  query_string <- paste0("SELECT TABLE_NAME FROM ", database, ".INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'")

  data <- DBI::dbGetQuery(connection, query_string)

  DBI::dbDisconnect(connection)

  data

}
