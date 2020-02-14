#' Write dataframe to SQL Server database
#'
#' \code{adm_dataframe_to_db} writes a dataframe to a SQL Server database.
#'
#' @param database \code{string}. The name of the database to write the sheet to.
#' @param server \code{string}. The name of the server containing the database.
#' @param database_table_name \code{string}. The name of the table to uplaod to in the database.
#' @param dataframe \code{string}. The dataframe to upload.
#' @param overwrite \code{string}. Default: \code{false}. Whether to overwrite existing table with worksheet with the same name.
#' @param append \code{string}. Default: \code{false}. Whether to append worksheet to existing table with the same name.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_dataframe_to_db(database = "DatabaseName", server = "ServerName", database_table_name = "example_database_table", dataframe = example_dataframe)
#' }
#'
#' @export

adm_dataframe_to_db <- function(database, server, database_table_name, dataframe, overwrite = FALSE, append = FALSE) {

  connection <- admStructuredData:::adm_create_connection(database = database, server = server)

  tryCatch({

    DBI::dbWriteTable(connection, name = database_table_name, value = dataframe, overwrite = overwrite, append = append)
    message(paste0("Dataframe successfully written to: '", database_table_name, "'"))

  }, error = function(cond) {

    stop(paste0("Failed to write dataframe to database: '", database, "'\nOriginal error message: ", cond))

  })

  DBI::dbDisconnect(connection)

}
