#' Rename SQL server database table
#'
#' \code{adm_rename_table} renames a table in a SQL Server database.
#'
#' @param database \code{string}. The name of the database containing the table.
#' @param server \code{string}. The name of the server containing the database.
#' @param current_name \code{string}. The name of the existing table to rename.
#' @param new_name \code{string}. The name to rename the table to.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_rename_table(database = "DatabaseName", server = "ServerName", current_name = "table_name", new_name = "table_name_new")
#' }
#'
#' @export

adm_rename_table <- function(database, server, current_name, new_name) {

  tables <- admStructuredData::adm_list_tables(database, server)
  tables <- tables[tables$Name == current_name, ]

  for (row in seq_len(nrow(tables))) {

    schema <- tables[row, ]$Schema

    if (schema == "dbo") {

      sql <- paste0("EXEC sp_rename '", schema, ".", current_name, "', '", new_name, "';")

      admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)

    } else if (schema == "ver") {

      sql <- paste0("EXEC sp_rename '", schema, ".", current_name, "', '", new_name, "';")

      admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)

      sql <- paste0("EXEC sp_rename '", schema, ".", current_name, "History', '", new_name, "History';")

      admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = FALSE)
    }
  }
}
