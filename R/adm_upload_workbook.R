#' Process files to write to SQL Server database
#'
#' \code{adm_upload_workbook} writes all worksheets in an Excel workbook to a SQL Server database.
#'
#' @param database \code{string}. The name of the database to write the file to.
#' @param server \code{string}. The name of the server containing the database.
#' @param file_path \code{string}. The full path of the file to process.
#' @param append \code{string}. Default: \code{false}. Whether to append worksheets to existing tables with the same name.
#' @param overwrite \code{string}. Default: \code{false}. Whether to overwrite existing tables with worksheets with the same name.
#' @param archive_directory_path \code{string}. Optional. The path of the directory to move the processed file to.

#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_upload_workbook(database = "DatabaseName", server = "ServerName\\Instance", file_path = "C:\\Temp\\ExcelFile.xlsx")
#' }
#' \dontrun{
#' adm_upload_workbook(database = "DatabaseName", server = "ServerName\\Instance"file_path = "C:\\Temp\\ExcelFile.xlsx", archive_directory_path = "C:\\ArchiveFolder\\")
#' }
#'
#' @export

adm_upload_workbook <- function(database, server, file_path, append = FALSE, overwrite = FALSE, archive_directory_path = NULL) {

  file_name <- basename(file_path)
  source <- dirname(file_path)

  message(paste0("Processing file: '", file_name, "'"))

  worksheets <- readxl::excel_sheets(path = file_path)

  for (worksheet in worksheets) {

    admStructuredData::adm_upload_worksheet(database = database, server = server, file_path = file_path, worksheet = worksheet, append = append, overwrite = overwrite)

  }

  message(paste0("'", file_name, "' successfully processed"))

  if (is.null(archive_directory_path) == FALSE) {

    admStructuredData:::adm_i_archive_file(file_path = file_path, archive_directory_path = archive_directory_path)

    message(paste0("'", file_name, "' moved from: '", source, "' to: '", archive_directory_path, "'\n"))
  }
}
