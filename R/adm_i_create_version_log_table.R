#' Create a table to record versions
#'
#' \code{adm_i_create_version_log_table} is an internal function to create a table to log versions to.
#'
#' @param database \code{string}. The database to use.
#' @param server \code{string}. The server holding the database.
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_create_version_log_table(database = "DatabaseName", server = "ServerName")
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_i_create_version_log_table <- function(database, server) {

  sql <- "CREATE TABLE [mta].[Versions](
  [ID] [uniqueidentifier] NOT NULL,
  [Description] [varchar](255) NOT NULL,
  [Tables] [varchar](500) NOT NULL,
  [Date] [datetime2](3) NULL,
  UNIQUE NONCLUSTERED
  (
    [Description] ASC
  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]"

  admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql)
}
