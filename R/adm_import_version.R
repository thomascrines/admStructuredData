#' Return all tables used in a version in a list
#'
#' \code{adm_import_version} returns all tables as were for a specific version.
#'
#' @param database \code{string}. The database to get data from.
#' @param server \code{string}. The server holding the database.
#' @param version_description \code{string}. The description of the version as in [metadata].[Versions]
#'
#' @return \code{NULL}
#'
#' @examples
#'
#' \dontrun{
#' adm_import_version(database = "DatabaseName", server = "ServerName", version_description = "Example version description")
#' }
#'
#' @export

adm_import_version <- function(database, server, version_description) {

  sql <- paste0("select * from [metadata].[Versions] WHERE [Description] = '", version_description, "';")

  version_details <- admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = TRUE)

  version_tables <- strsplit(version_details$Tables, ";")

  dataset_string <- "list("

  for (version_table in version_tables[[1]]) {

    data <- admStructuredData::adm_import_table(database = database, server = server, table = version_table, version = TRUE, date = version_details$Date)

    assign(version_table, data)

    dataset_string <- paste0(dataset_string, version_table, ", ")
  }

  dataset_string <- paste0(substr(dataset_string, 1, nchar(dataset_string) - 2), ")")

  dataset <- eval(parse(text = dataset_string))

  dataset
}
