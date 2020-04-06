#' Get column metadata
#'
#' \code{adm_metadata_columns} returns details of all columns in a SQL Server table.
#'
#' @param database \code{string}. The database to get metadata data for.
#' @param server \code{string}. The server holding the database.
#' @param table \code{string}. The table to get metadata data for.
#'
#' @return \code{dataframe}
#'
#' @examples
#'
#' \dontrun{
#' adm_metadata_columns(database = "DatabaseName", server = "ServerName", table = "TableName")
#' }
#'
#' @export

adm_metadata_columns <- function(database, server, table) {

  sql <- paste0("SET NOCOUNT ON;

                DECLARE	@table_catalog nvarchar(128) = '", database, "',
                @table_schema nvarchar(128) = 'dbo',
                @table_name nvarchar(128) = '", table, "';

                DECLARE @sql_statement nvarchar(2000),
                @param_definition nvarchar(500),
                @column_name nvarchar(128),
                @data_type nvarchar(128),
                @null_count int,
                @distinct_values int,
                @minimum_value nvarchar(225),
                @maximum_value nvarchar(225);

                DECLARE @T1 AS TABLE	(ColumnName nvarchar(128),
                DataType nvarchar(128),
                NullCount int,
                DistinctValues int,
                MinimumValue nvarchar(255),
                MaximumValue nvarchar(255));

                INSERT INTO @T1 (ColumnName, DataType)
                SELECT	COLUMN_NAME,
                REPLACE(CONCAT(DATA_TYPE, '(', CHARACTER_MAXIMUM_LENGTH, ')', '(', DATETIME_PRECISION, ')'), '()', '')
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE	TABLE_CATALOG = @table_catalog
                AND TABLE_SCHEMA = @table_schema
                AND TABLE_NAME = @table_name;

                DECLARE column_cursor CURSOR
                FOR SELECT ColumnName, DataType FROM @T1;

                OPEN column_cursor;

                FETCH NEXT FROM column_cursor
                INTO @column_name, @data_type;

                WHILE @@FETCH_STATUS = 0
                BEGIN

                SET @sql_statement =
                CONCAT(N'SET @null_countOUT =
                (SELECT COUNT(*)
                FROM [', @table_catalog, '].[', @table_schema, '].[', @table_name, ']
                WHERE [', @column_name, '] IS NULL)

                SET @distinct_valuesOUT =
                (SELECT COUNT(DISTINCT([', @column_name, ']))
                FROM [', @table_catalog, '].[', @table_schema, '].[', @table_name, ']
                WHERE [', @column_name, '] IS NOT NULL) ')

                IF (@data_type != 'bit')
                BEGIN
                SET @sql_statement =
                CONCAT(@sql_statement,
                'SET @minimum_valueOUT =
                CAST((SELECT MIN([', @column_name, '])
                FROM [', @table_catalog, '].[', @table_schema, '].[', @table_name, ']
                WHERE [', @column_name, '] IS NOT NULL)
                AS nvarchar(225))

                SET @maximum_valueOUT =
                CAST((SELECT MAX([', @column_name, '])
                FROM [', @table_catalog, '].[', @table_schema, '].[', @table_name, ']
                WHERE [', @column_name, '] IS NOT NULL)
                AS nvarchar(225))')
                END
                ELSE
                BEGIN
                SET @sql_statement =
                CONCAT(@sql_statement,
                'SET @minimum_valueOUT = NULL

                SET @maximum_valueOUT = NULL');
                END

                SET @param_definition = N'@null_countOUT int OUTPUT,
                @distinct_valuesOUT int OUTPUT,
                @minimum_valueOUT nvarchar(255) OUTPUT,
                @maximum_valueOUT nvarchar(255) OUTPUT';

                print(@sql_statement)

                EXECUTE sp_executesql	@sql_statement,
                @param_definition,
                @null_countOUT = @null_count OUTPUT,
                @distinct_valuesOUT = @distinct_values OUTPUT,
                @minimum_valueOUT = @minimum_value OUTPUT,
                @maximum_valueOUT = @maximum_value OUTPUT;

                UPDATE @T1
                SET NullCount = @null_count,
                DistinctValues = @distinct_values,
                MinimumValue = @minimum_value,
                MaximumValue = @maximum_value
                WHERE ColumnName = @column_name;

                FETCH NEXT FROM column_cursor
                INTO @column_name, @data_type;
                END

                CLOSE column_cursor;
                DEALLOCATE column_cursor;

                SELECT * FROM @T1;")

  data <- admStructuredData:::adm_i_execute_sql(database = database, server = server, sql = sql, output = TRUE)

  data

}
