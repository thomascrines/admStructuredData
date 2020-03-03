#' Get table metadata
#'
#' \code{adm_table_metadata} returns details of all tables in a SQL Server database.
#'
#' @param database \code{string}. The database to get metadata data for.
#' @param server \code{string}. The server holding the database.
#'
#' @return \code{dataframe}
#'
#' @examples
#'
#' \dontrun{
#' adm_table_metadata(database = "DatabaseName", server = "ServerName")
#' }
#'
#' @export

adm_table_metadata <- function(database, server) {

  connection <- admStructuredData:::adm_create_connection(database = database, server = server)

  table_query <- "SET NOCOUNT ON;

                 SELECT	t.name AS 'TableName',
                 p.rows AS 'NumberOfRows',
                 SUM(a.used_pages) * 8 AS 'Size(KB)',
                 t.modify_date AS 'LastSchemaUpdate'
                 FROM sys.tables t
                 INNER JOIN sys.indexes i
                 ON t.OBJECT_ID = i.object_id
                 INNER JOIN sys.partitions p
                 ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
                 INNER JOIN sys.allocation_units a
                 ON p.partition_id = a.container_id
                 WHERE	t.is_ms_shipped = 0
                 GROUP BY	t.Name,
                 p.Rows,
                 t.modify_date
                 ORDER BY 'TableName';"

  table_metadata <- DBI::dbGetQuery(connection, table_query)

  DBI::dbDisconnect(connection)

  return(table_metadata)
}
