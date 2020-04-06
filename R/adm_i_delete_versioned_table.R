#' Delete a temporal table from the 'ver' schema
#'
#' \code{adm_i_delete_versioned_table} is an internal function that moves a file from a source directory to an archive directory.
#'
#' @param database \code{string}. The database to delete the table from.
#' @param server \code{string}. The server holding the database.
#' @param table \code{string}. The name of the table to delete.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_delete_versioned_table(database = "DatabaseName", server = "ServerName", table = "TableName")
#' }
#'
#' @keywords internal
#'
#' @noRd


adm_i_delete_versioned_table <- function(database, server, table) {

sql <- paste0("ALTER TABLE [ver].[", table, "] SET (SYSTEM_VERSIONING = OFF)")

admStructuredData:::adm_i_execute_sql(database, server, sql, FALSE)

sql <- paste0("DROP TABLE [ver].[", table, "]")

admStructuredData:::adm_i_execute_sql(database, server, sql, FALSE)

sql <- paste0("DROP TABLE [ver].[", table, "History]")

admStructuredData:::adm_i_execute_sql(database, server, sql, FALSE)

}
