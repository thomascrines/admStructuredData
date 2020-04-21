#' Execute a SQL statement in a SQL Server database
#'
#' \code{adm_i_execute_sql} is an internal function to connect to a SQL Server database, execute a query, and close the connection.
#'
#' @param database \code{string}. The database to execute the SQL statement in.
#' @param server \code{string}. The server holding the database.
#' @param sql \code{string}. The SQL statement to execute.
#' @param output \code{string}. Whether to return the the output of the query (defaults to \code{FALSE})
#'
#' @return \code{null}
#'
#' @examples
#'
#' \dontrun {
#' adm_i_execute_sql(database = "DatabaseName", server = "ServerName", sql = "SELECT * FROM dbo.ExampleTable")
#' }
#'
#' @keywords internal
#'
#' @noRd

adm_i_execute_sql <- function(database, server, sql, output = FALSE) {

  output_data <- NULL

  connection <- admStructuredData:::adm_i_create_connection(database = database, server = server)

  if (output == TRUE) {

    output_data <- DBI::dbGetQuery(connection, sql)

  } else {

    DBI::dbGetQuery(connection, sql)
  }

  DBI::dbDisconnect(connection)

  output_data

}
