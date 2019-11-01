
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sdrUpload

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Travis-CI Build
Status](https://api.travis-ci.org/thomascrines/admStructuredData.svg?branch=master)](https://travis-ci.org/thomascrines/admStucturedData)
<!-- badges: end -->

admStructuredData is an R package which allows SG analysts to upload
data from Excel workbooks to the Analytical Data Management (ADM)
structured data repository.

Data can be uploaded from a single worksheet, all worksheets in a
workbook, or all workbooks in a folder.

To use the package you will need to have access to a database in the ADM
structured data repository; if you don’t have this please contact the
[ADM support team](mailto:adm.support@gov.scot).

## Installation

Install opendatascot from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("thomascrines/admStructuredData")
```

If the above does not work, you can install from source:

1.  Go to the sdrUpload
    [repository](https://github.com/thomascrines/admStructuredData) on
    GitHub
2.  Click **Clone or download** then **Download ZIP**
3.  Save the file locally and unzip
4.  Install with
install.packages():

<!-- end list -->

``` r
install.packages("C:\\DownloadDirectory\\admStructuredData-master\\admStructuredData-master", repos = NULL,
                 type="source", lib = "C:\\YourLibraryPath")
```

## Prerequisites

To use admStructuredData you will need to have access to a database in
the ADM structured data repository; if you don’t have this please
contact the [ADM support team](mailto:adm.support@gov.scot). Most
functions will require ‘database’ and ‘server’ arguments; the values for
these will be provided by the ADM team when your database is set up.

Some functions allow processed files to be moved to an archive folder.
To use this feature, the archive folder has to be made in advance.

## Examples

The following examples are….

Write data from an Excel worksheet to a database table:
`adm_worksheet_to_db(database = "DatabaseName", server = "ServerName",
file_path = "C:\\Temp\\Sdr\\ExcelFile.xlsx", worksheet =
"WorksheetName")`

Write data all Excel sheets contained in an Excel workbook to database
tables: `adm_workbook_to_db(database = "DatabaseName", server =
"ServerName\\Instance", file_path = "C:\\Temp\\Sdr\\ExcelFile.xlsx")`

sdr\_process\_workbook can also accept an archive argument, to move the
processed file from the original location to a specified directory:
`adm_workbook_to_db(database = "DatabaseName", server =
"ServerName\\Instance"file_path = "C:\\Temp\\Sdr\\ExcelFile.xlsx",
archive = "C:\\Temp\\Sdr\\ArchiveFolder\\")`

Write data from all Excel sheets contained in all Excel files contained
in a source directory to database tables: `adm_folder_to_db(database =
"DatabaseName", server = "ServerName\\Instance", file_path =
"C:\\Temp\\Sdr\\ExcelFile.xlsx")`

sdr\_process\_folder can also accept an archive argument, to move
processed files from the original location to a specified directory:
`adm_folder_to_db(database = "DatabaseName", server =
"ServerName\\Instance", file_path = "C:\\Temp\\Sdr\\ExcelFile.xlsx",
archive = "C:\\Temp\\Sdr\\ArchiveFolder\\")`

Delete a table from a database: `adm_delete_table(database =
"DatabaseName", server = "ServerName", table = "TableName")`

Return a list of tables in a database: `adm_list_tables(database =
"DatabaseName", server = "DatabaseServer")`

Return data from a database table: `adm_read_table(database =
"DatabaseName", server = "ServerName", table = "TableName")`
