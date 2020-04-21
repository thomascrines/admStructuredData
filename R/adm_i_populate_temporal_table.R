#' Populate a temporal table with staged data
#'
#' \code{adm_i_populate_temporal_table} is an internal function to populate a temporal table for published data with data from a staging table.
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
#' adm_i_populate_temporal_table(database = "DatabaseName", server = "ServerName", table = "ExampleTableName")
#' }
#'
#' @keywords internal
#'
#' @noRd
#'

adm_i_populate_temporal_table <- function(database, server, table) {

  metadata <- admStructuredData::adm_metadata_columns(database = database, server = server, table = table)

  column_string <- ""

  for (row in seq_len(nrow(metadata))) {

    column_name <- metadata[row, 1]

    column_string <- paste0(column_string, " [", column_name, "], ")
  }

  column_string <- substr(column_string, 1, nchar(column_string) - 2)

  sql <- paste0("INSERT INTO [vsn].[", table, "] (", column_string, ") select ", column_string, " from [dbo].[", table, "];")

  admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)
}
