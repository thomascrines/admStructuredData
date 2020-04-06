#' List files in a specified folder
#'
#' \code{adm_i_list_files} is an internal function to list files in a source directory.
#'
#' @param source_directory_path \code{string}. The path of the directory containing files.
#'
#' @return \code{character list}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_list_files(source_directory_path = "C:\\example_source_folder")
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_i_list_files <- function(source_directory_path) {

  files <- list.files(path = source_directory_path, pattern = "\\.xlsx$")
  message(paste0("Reading directory: ", source_directory_path))

  if (length(files) > 0) {

    message("Found files:")
    message(paste0("'", files, "'\n"))

  }

  else {

    stop(paste0("No files found in '", source_directory_path, "'"))

  }

  return(files)

}
