#' Read a SQL Server Table into R
#'
#' \code{adm_import_table} reads the contents of a SQL Server database table to R.
#'
#' @param database \code{string}. The database containing the table.
#' @param server \code{string}. The server holding the database.
#' @param table \code{string}. The table to read data from.
#' @param version \code{boolean}. Whether to retrieve the published table (as opposed to the staging table). Defaults to \code{FALSE}.
#' @param date \code{boolean}. The date to use to retrieve a versioned table. Defaults to \code{NULL}.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun{
#' adm_import_table(database = "DatabaseName", server = "ServerName", table = "TableName", version = FALSE)
#' }
#'
#' @export

adm_import_table <- function(database, server, table, version = FALSE, date = NULL) {

  if (version == TRUE) {

    schema <- "ver"

  } else {

    schema <- "dbo"
  }

  sql <- paste0("SELECT * FROM [", schema, "].[", table, "];")

  if (version == TRUE & !is.null(date)) {

    sql <- paste0(substr(sql, 1, nchar(sql) - 1), " FOR SYSTEM_TIME AS OF '", date, "'")
  }

  data <- admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = TRUE)

  data
}
