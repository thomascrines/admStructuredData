#' Create a temporal table based on an existing table structure
#'
#' \code{adm_i_create_temporal_table} is an internal function to create a temporal table for published data, based on a staging table structure.
#'
#' @param database \code{string}. The database the tables are in.
#' @param server \code{string}. The server holding the database.
#' @param table \code{string}. The name of the existing staging table (without schema).
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_create_temporal_table(database = "DatabaseName", server = "ServerName", table = "ExampleTableName")
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_i_create_temporal_table <- function(database, server, table) {

  metadata <- admStructuredData::adm_metadata_columns(database = database, server = server, table = table)

  sql <- paste0("CREATE TABLE [ver].[", table, "] (", table, "ID INT NOT NULL IDENTITY PRIMARY KEY,")

  for (row in seq_len(nrow(metadata))) {

    column_name <- metadata[row, "ColumnName"]
    data_type <- metadata[row, "DataType"]

    sql <- paste0(sql, " [", column_name, "] ", data_type, ", ")
  }

  sql <- paste0(sql,
                "SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL, ",
                "SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL, ",
                "PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)) ",
                "WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [ver].[", table, "History]));")

  connection <- admStructuredData:::adm_i_create_connection(database = database, server = server)

  DBI::dbGetQuery(connection, sql)

  DBI::dbDisconnect(connection)
}
