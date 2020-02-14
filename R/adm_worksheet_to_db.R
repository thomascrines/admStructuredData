#' Process worksheet from Excel file to write to SQL Server database
#'
#' \code{adm_worksheet_to_db} is an internal function that processes an Excel worksheet to be written to a SQL Server database.
#'
#' @param database \code{string}. The name of the database to write the sheet to.
#' @param server \code{string}. The name of the server containing the database.
#' @param file_path \code{string}. The full path of the file containing the worksheet.
#' @param worksheet \code{string}. The name of the worksheet to be processed.
#' @param append \code{string}. Default: \code{false}. Whether to append worksheet to existing table with the same name.
#' @param overwrite \code{string}. Default: \code{false}. Whether to overwrite existing table with worksheet with the same name.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_worksheet_to_db(database = "DatabaseName", server = "ServerName", file_path = "C:\\Temp\\ExcelFile.xlsx", worksheet = "WorksheetName")
#' }
#'
#' @export

adm_worksheet_to_db <- function(database, server, file_path, worksheet, overwrite = FALSE, append = FALSE) {

  file_name <- basename(file_path)
  df <- readxl::read_excel(file_path, sheet = worksheet)
  database_table_name <- gsub(" ", "_", paste0(tolower(gsub("\\..*", "", file_name)), "_", tolower(worksheet)))
  connection <- admStructuredData:::adm_create_connection(database = database, server = server)

  tryCatch({

    DBI::dbWriteTable(connection, name = database_table_name, value = df, overwrite = overwrite, append = append)
    message(paste0("Excel worksheet: '", worksheet, "' successfully written to: '", database_table_name, "'"))

  }, error = function(cond) {

    stop(paste0("Failed to write worksheet: ", worksheet, " to database: '", database, "'\nOriginal error message: ", cond))

  })

  DBI::dbDisconnect(connection)

}
