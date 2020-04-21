#' Return list of versions in version table
#'
#' \code{adm_list_versions} lists all base tables in a SQL Server database on a specified server.
#'
#' @param database \code{string}. A SQL Server database name.
#' @param server \code{string}. A SQL Server database server.
#'
#' @return \code{dataframe}
#'
#' @examples
#'
#' \dontrun{
#' adm_list_versions(database = "DatabaseName", server = "DatabaseServer")
#' }
#'
#' @export

adm_list_versions <- function(database, server) {

  sql <- "select [Description], [Tables], [Date] from [mta].[Versions];"

  data <- admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = TRUE)

  data
}
