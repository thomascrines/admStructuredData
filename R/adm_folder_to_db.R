#' Upload all Excel worksheets in a folder to SDR
#'
#' \code{adm_folder_to_db} uploads all worksheets in all Excel workbooks in a specified location to a specified database. Processed folders are then moved from the source folder to an archive folder.
#'
#' @param database \code{string}. The database to write the data to.
#' @param server \code{string}. The server holding the database.
#' @param source \code{string}. The path of the directory containing Excel files.
#' @param append \code{string}. Default: \code{false}. Whether to append worksheets to existing tables with the same name.
#' @param overwrite \code{string}. Default: \code{false}. Whether to overwrite existing tables with worksheets with the same name.
#' @param archive \code{string}. The path of the directory to send processed files to.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_folder_to_db(database = "DatabaseName", server = "ServerName\\Instance", file_path = "C:\\Temp\\ExcelFile.xlsx")
#' }
#' \dontrun{
#' adm_folder_to_db(database = "DatabaseName", server = "ServerName\\Instance", file_path = "C:\\Temp\\ExcelFile.xlsx", archive = "C:\\ArchiveFolder\\")
#' }
#'
#' @export

adm_folder_to_db <- function(database, server, source, append = FALSE, overwrite = FALSE, archive = NULL) {

  files <- admStructuredData:::adm_list_files(source)

  for (file in files) {

    file_path <- file.path(source, file)

    admStructuredData:::adm_workbook_to_db(database = database, server = server, file_path = file_path, append = append, overwrite = overwrite, archive = archive)

    }

  message("Processing complete")

}
