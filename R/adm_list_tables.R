#' List tables in a SQL Server database
#'
#' \code{adm_list_tables} lists all base tables in a SQL Server database on a specified server.
#'
#' @param database \code{string}. A SQL Server database name.
#' @param server \code{string}. A SQL Server database server.
#'
#' @return \code{dataframe}
#'
#' @examples
#'
#' \dontrun{
#' adm_list_tables(database = "DatabaseName", server = "DatabaseServer")
#' }
#'
#' @export

adm_list_tables <- function(database, server) {

  sql <- "SELECT SCHEMA_NAME(t.schema_id) AS 'Schema',
  t.name AS 'Name',
  CASE
  WHEN t.temporal_type = 0 THEN 'Staging'
  WHEN t.temporal_type = 2 THEN 'Version'
  END AS 'TableType'
  FROM sys.tables t
  WHERE t.temporal_type != 1 AND SCHEMA_NAME(t.schema_id) != 'metadata'"

  data <- admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = TRUE)

  data
}
