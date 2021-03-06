% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adm_read_table.R
\name{adm_read_table}
\alias{adm_read_table}
\title{Read a SQL Server Table}
\usage{
adm_read_table(database, server, table)
}
\arguments{
\item{database}{\code{string}. The database containing the table.}

\item{server}{\code{string}. The server holding the database.}

\item{table}{\code{string}. The table to read data from.}
}
\value{
\code{null}
}
\description{
\code{adm_read_table} reads the contents of a SQL Server database table to R.
}
\examples{

\dontrun{
adm_read_table(database = "DatabaseName", server = "ServerName", table = "TableName")
}

}
