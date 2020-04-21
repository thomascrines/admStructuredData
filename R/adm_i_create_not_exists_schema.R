#' Create a schema in a SQL Server database if it doesn't already exist
#'
#' \code{adm_i_create_not_exists_schema} checks if a given schema exists in a SQL Server database, and creates it if not.
#'
#' @param database \code{string}. The database to connect to.
#' @param server \code{string}. The server holding the database.
#' @param schema \code{string}. The schema to check for/create.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_create_not_exists_schema(database = "DatabaseName", server = "ServerName", schema = "dbo")
#' }
#'
#' @keywords internal
#'
#' @noRd


adm_i_create_not_exists_schema <- function(database, server, schema) {

  sql <- paste0("IF (SELECT COUNT(*) FROM INFORMATION_SCHEMA.SCHEMATA
                WHERE CATALOG_NAME = '", database, "' AND SCHEMA_NAME = '", schema, "') = 0
                BEGIN
                EXEC('CREATE SCHEMA [", schema, "]');
                END")

  admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)
}
