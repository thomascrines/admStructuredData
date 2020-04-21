#' Write dataframe to SQL Server database
#'
#' \code{adm_upload_dataframe} writes a dataframe to a SQL Server database.
#'
#' @param database \code{string}. The name of the database to write the sheet to.
#' @param server \code{string}. The name of the server containing the database.
#' @param table \code{string}. The name of the table to upload to in the database.
#' @param dataframe \code{string}. The dataframe to upload.
#' @param overwrite \code{string}. Default: \code{false}. Whether to overwrite existing table with worksheet with the same name.
#' @param append \code{string}. Default: \code{false}. Whether to append worksheet to existing table with the same name.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_upload_dataframe(database = "DatabaseName", server = "ServerName", table = "example_database_table", dataframe = example_dataframe)
#' }
#'
#' @export

adm_upload_dataframe <- function(database, server, table, dataframe, overwrite = FALSE, append = FALSE) {

  connection <- admStructuredData:::adm_i_create_connection(database = database, server = server)

  tables <- admStructuredData::adm_list_tables(database = database, server = server)

  if (nrow(tables[tables$Schema == "dbo" & tables$Name == table,]) == 0) {

    admStructuredData:::adm_i_create_table(database = database, server = server, table = table, dataframe = dataframe)

    overwrite = TRUE

    }

  tryCatch({

    DBI::dbWriteTable(connection, name = table, value = dataframe, overwrite = overwrite, append = append)

    message(paste0("Dataframe successfully written to: '", table, "'"))

  }, error = function(cond) {

    stop(paste0("Failed to write dataframe to database: '", database, "'\nOriginal error message: ", cond))

  })

  DBI::dbDisconnect(connection)

}
