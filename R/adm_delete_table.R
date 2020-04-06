#' Delete a table in the 'dbo' schema from a database
#'
#' \code{adm_delete_table} opens an ODBC connection and deletes a specified table.
#'
#' @param database \code{string}. The database to delete the table from.
#' @param server \code{string}. The server holding the database.
#' @param table \code{string}. The table to be deleted.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_delete_table(database = "DatabaseName", server = "ServerName", table = "TableName")
#' }
#'
#' @export

adm_delete_table <- function(database, server, table) {

  connection <- admStructuredData:::adm_i_create_connection(database = database, server = server)

  tryCatch({

    odbc::dbRemoveTable(conn = connection, name = table)

  }, error = function(cond) {

    stop(paste0("Failed to delete table: '", table, "' from database: '", database, "' on server: '", server, "'\nOriginal error message: ", cond))

  })

  DBI::dbDisconnect(connection)

  message("Table: '", table, "' successfully deleted from database: '", database, "' on server '", server, "'")

}
