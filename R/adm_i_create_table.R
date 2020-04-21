#' Create a table
#'
#' \code{adm_i_create_table} is an internal function to create a table for data, based on an R dataframe structure.
#'
#' @param database \code{string}. The database to use.
#' @param server \code{string}. The server holding the database.
#' @param table \code{string}. The name to give the table staging table (without schema).
#' @param dataframe \code{string}. The dataframe to load.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_create_table(database = "DatabaseName", server = "ServerName", table = "ExampleTableName")
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_i_create_table <- function(database, server, table, dataframe) {

  column_names <- names(dataframe)
  column_types <- sapply(dataframe, class)

  sql <- paste0("CREATE TABLE [dbo].[", table, "] (", table, "ID INT NOT NULL IDENTITY PRIMARY KEY,")

  for (column in seq_len(length(column_types))) {

    column_name <- column_names[column]
    data_type <- admStructuredData:::adm_i_r_to_sql_data_type(column_types[column])

    sql <- paste0(sql, " [", column_name, "] ", data_type, ", ")
  }

  sql <- paste0(substr(sql, 1, nchar(sql) - 2), ");")


  connection <- admStructuredData:::adm_i_create_connection(database = database, server = server)

  DBI::dbGetQuery(connection, sql)

  DBI::dbDisconnect(connection)
}
