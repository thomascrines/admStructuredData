#' Get table metadata
#'
#' \code{adm_table_metadata} returns details of all tables in a SQL Server database.
#'
#' @param database \code{string}. The database to get metadata data for.
#' @param server \code{string}. The server holding the database.
#'
#' @return \code{dataframe}
#'
#' @examples
#'
#' \dontrun{
#' adm_table_metadata(database = "DatabaseName", server = "ServerName")
#' }
#'
#' @export

adm_table_metadata <- function(database, server) {
  
  connection <- admStructuredData:::adm_create_connection(database = database, server = server)
  
  table_query <- "EXECUTE [dbo].[table_profile]"
  
  table_metadata <- DBI::dbGetQuery(connection, table_query)
  
  DBI::dbDisconnect(connection)
  
  return(table_metadata)
}
