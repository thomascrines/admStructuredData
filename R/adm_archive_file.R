#' Move file from source to archive directory
#'
#' \code{adm_archive_file} is an internal function that moves a file from a source directory to an archive directory.
#'
#' @param file_path \code{string}. The full path of the file to process.
#' @param archive \code{string}. The path of the directory to send the file to.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_archive_file(file_path = "C:\\Users\\source\\file.xlsx", archive = "C:\\Users\\archive")
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_archive_file <- function(file_path, archive) {

  file_name <- basename(file_path)
  archive_file_path <- paste0(archive, "\\", file_name)

  tryCatch({

    file.rename(from = file_path, to = archive_file_path)

  }, error = function(cond) {

    stop(paste0("Failed to move file from: '", file_path, "' to: '", archive_file_path, "'\nOriginal error message: '", cond, "'"))

  })
}
