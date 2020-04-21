#' Create versioned dataset and record
#'
#' \code{adm_create_version} populates SQL Server temporal tables for all specified tables and records effective time.
#'
#' @param database \code{string}. The database to get metadata data for.
#' @param server \code{string}. The server holding the database.
#' @param version_description \code{string}. The name of the version.
#' @param version_tables \code{vector}. A vector of staging tables used in the version.
#'
#' @return \code{NULL}
#'
#' @examples
#'
#' \dontrun{
#' adm_create_version(database = "DatabaseName", server = "ServerName", version_description = "ExampleVersionName", version_tables = c("Table1", "Table2"))
#' }
#'
#' @export

adm_create_version <- function(database, server, version_description, version_tables) {

  database_tables <- admStructuredData::adm_list_tables(database = database, server = server)

  temporal_tables <- database_tables[database_tables$TableType == "Version",]$Name

  staging_tables <- database_tables[database_tables$TableType == "Staging",]$Name

  sql <- paste0("SELECT * FROM INFORMATION_SCHEMA.TABLES where TABLE_CATALOG = '", database,
                "' AND TABLE_SCHEMA = 'metadata' and TABLE_NAME = 'Versions';")

  version_table <- admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = TRUE)

  if (nrow(version_table) == 0) {

    admStructuredData:::adm_i_create_version_log_table(database = database, server = server)
    }

  if (is.null(version_tables)) {

    version_tables <- admStructuredData::adm_list_tables(database = database, server = server)

    version_tables <- version_tables[version_tables$TableType == "Staging",]$Name
    }

  admStructuredData:::adm_i_log_version(database = database, server = server, version_description = version_description, version_tables = version_tables)

  for (version_table in version_tables) {

    if (version_table %in% temporal_tables) {

      sql <- paste0("DELETE FROM [ver].[", version_table, "];")

      admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)

    } else if (version_table %in% staging_tables) {

      admStructuredData:::adm_i_create_temporal_table(database = database, server = server, table = version_table)
    }

    admStructuredData:::adm_i_populate_temporal_table(database = database, server = server, table = version_table)
  }

  sql <- paste0("UPDATE [metadata].[Versions] SET [Date] = GETUTCDATE() WHERE Description = '", version_description, "';")

  admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)

  message("Version: '", version_description, "' successfully created.")
}
