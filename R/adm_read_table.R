#' Read a SQL Server Table
#'
#' \code{adm_read_table} reads the contents of a SQL Server database table to R.
#'
#' @param database \code{string}. The database containing the table.
#' @param server \code{string}. The server holding the database.
#' @param table \code{string}. The table to read data from.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_read_table(database = "DatabaseName", server = "ServerName", table = "TableName")
#' }
#'
#' @export


adm_read_table <- function(database, server, table) {

  connection <- admStructuredData:::adm_create_connection(database = database, server = server)

  data <- DBI::dbReadTable(connection, table)

  DBI::dbDisconnect(connection)

  data

}
