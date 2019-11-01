#' Process files to write to SQL Server database
#'
#' \code{adm_workbook_to_db} writes all worksheets in an Excel workbook to a SQL Server database.
#'
#' @param database \code{string}. The name of the database to write the file to.
#' @param server \code{string}. The name of the server containing the database.
#' @param file_path \code{string}. The full path of the file to process.
#' @param archive \code{string}. Optional. The path of the directory to move the processed file to.

#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_workbook_to_db(database = "DatabaseName", server = "ServerName\\Instance", file_path = "C:\\Temp\\ExcelFile.xlsx")
#' }
#' \dontrun{
#' adm_workbook_to_db(database = "DatabaseName", server = "ServerName\\Instance"file_path = "C:\\Temp\\ExcelFile.xlsx", archive = "C:\\ArchiveFolder\\")
#' }
#'
#' @export

adm_workbook_to_db <- function(database, server, file_path, archive = NULL) {

  file_name <- basename(file_path)
  source <- dirname(file_path)

  message(paste0("Processing file: '", file_name, "'"))

  worksheets <- readxl::excel_sheets(path = file_path)

  for (worksheet in worksheets) {

    admStructuredData:::adm_worksheet_to_db(database = database, server = server, file_path = file_path, worksheet = worksheet)

  }

  message(paste0("'", file_name, "' successfully processed"))

  if (is.null(archive) == FALSE) {

    admStructuredData:::adm_archive_file(file_path = file_path, archive = archive)

    message(paste0("'", file_name, "' moved from: '", source, "' to: '", archive, "'\n"))

  }

}
