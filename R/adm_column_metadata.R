#' Get column metadata
#'
#' \code{adm_column_metadata} returns details of all columns in a SQL Server table.
#'
#' @param database \code{string}. The database to get metadata data for.
#' @param server \code{string}. The server holding the database.
#'
#' @return \code{dataframe}
#'
#' @examples
#'
#' \dontrun{
#' adm_column_metadata(database = "DatabaseName", server = "ServerName", table = "TableName")
#' }
#'
#' @export

adm_column_metadata <- function(database, server, table) {
  
  connection <- admStructuredData:::adm_create_connection(database = database, server = server)
  
  column_query <- paste0("EXEC [dbo].[column_profile] @table_catalog = '", database, "', @table_schema = 'dbo', @table_name = '", table, "'")
  
  column_metadata <- DBI::dbGetQuery(connection, column_query)
  
  DBI::dbDisconnect(connection)
  
  return(column_metadata)
}
