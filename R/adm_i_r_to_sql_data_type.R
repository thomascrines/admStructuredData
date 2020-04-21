#' Map an R data type to a SQL Server data type
#'
#' \code{adm_i_r_to_sql_data_type} is an internal function to create a temporal table for published data, based on a staging table structure.
#'
#' @param r_data_type \code{string}. The data type in R.
#'
#' @return \code{string}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_r_to_sql_data_type(r_data_type = "factor")
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_i_r_to_sql_data_type <- function(r_data_type) {

  sql_data_type <- switch(r_data_type,
                          "numeric" = "float",
                          "logical" = "bit",
                          "character" = "varchar(255)",
                          "factor" = "varchar(255)",
                          "POSIXct" = "datetime2(3)",
                          "integer" = "int")

  sql_data_type

}
