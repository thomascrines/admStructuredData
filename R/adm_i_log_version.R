#' Log the name of, and tables used in, a version
#'
#' \code{adm_i_log_version} is an internal function to log the name of, and tables used in, a version.
#'
#' @param database \code{string}. The database the version is created from.
#' @param server \code{string}. The server holding the database.
#' @param version_description \code{string}. A description of the version (for user's reference).
#' @param version_tables \code{factor}. A list of all tables used in the version.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_log_version(database = "DatabaseName", server = "ServerName", version_description = "Example version Description", tables = c("Table1Name", "Table2Name", "Table3Name"))
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_i_log_version <- function(database, server, version_description, version_tables) {

  version_tables_string <- ""

  for (version_table in version_tables) {

    version_tables_string <- paste0(version_tables_string, version_table, ";")
  }

  sql <- paste0("INSERT INTO [mta].[versions] ([ID], [Description], [Tables]) VALUES (NEWID(), '", version_description, "', '", version_tables_string, "')")

  admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)

}
