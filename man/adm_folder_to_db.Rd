% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/adm_folder_to_db.R
\name{adm_folder_to_db}
\alias{adm_folder_to_db}
\title{Upload all Excel worksheets in a folder to SDR}
\usage{
adm_folder_to_db(
  database,
  server,
  source,
  append = FALSE,
  overwrite = FALSE,
  archive = NULL
)
}
\arguments{
\item{database}{\code{string}. The database to write the data to.}

\item{server}{\code{string}. The server holding the database.}

\item{source}{\code{string}. The path of the directory containing Excel files.}

\item{append}{\code{string}. Default: \code{false}. Whether to append worksheets to existing tables with the same name.}

\item{overwrite}{\code{string}. Default: \code{false}. Whether to overwrite existing tables with worksheets with the same name.}

\item{archive}{\code{string}. The path of the directory to send processed files to.}
}
\value{
\code{null}
}
\description{
\code{adm_folder_to_db} uploads all worksheets in all Excel workbooks in a specified location to a specified database. Processed folders are then moved from the source folder to an archive folder.
}
\examples{

\dontrun{
adm_folder_to_db(database = "DatabaseName", server = "ServerName\\\\Instance", file_path = "C:\\\\Temp\\\\ExcelFile.xlsx")
}
\dontrun{
adm_folder_to_db(database = "DatabaseName", server = "ServerName\\\\Instance", file_path = "C:\\\\Temp\\\\ExcelFile.xlsx", archive = "C:\\\\ArchiveFolder\\\\")
}

}
