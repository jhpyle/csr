# CSR reporting with dBASE II

This repository contains a dBASE II command file for generating the
Case Service Report (CSR) as part of the annual Grant Activity Report
(GAR) for LSC.

## Installation

1. Download this repository as a ZIP file.
2. Use [PKUNZIP] to unzip the contents of the ZIP file onto your dBASE
   II program disk (or your dBASE II directory on C:\ if you have an
   IBM XT).

## Creating CLOSED.CSV and OPEN.CSV

Create two reports in Legal Server, one for cases closed in a given
calendar year and the other for cases open at the end the calendar
year.

### Closed case report

The columns in the closed case report should be:

* Race
* Gender
* Problem Code
* Close Reason
* Age
* CSR Eligible
* LSC Eligible
* Domestic Violence
* Veteran
* Disabled
* Language
* Funding Code
* Adults in Household
* Children in Household

The report should be saved as a CSV file called `CLOSED.CSV` where
each line looks something like this:

    W,F,01,A ,59,t,t,,f,t,English,4,1,0

### Open case report

The columns in the open case report should be:

* Problem Code
* Funding Code

The report should be saved as a CSV file called `OPEN.CSV` where
each line looks something like this:

    01,10

## Modifying

You will need to customize `CSR.PRG` somewhat to adapt it to your
legal services program.

To customize `CSR.PRG`, run dBASE II and enter:

    . modi comm csr

To save your changes, press Ctrl-w.

The `CSR.PRG` that comes with the repository prepares a report for two
service areas: PA-1 and MPA. Cases are separated into the two services
areas and split into PAI and non-PAI based on the funding code. Your
program may use different funding codes to represent service areas and
PAI status.

You will also need to change the heading in `CSR.PRG` from `GAR 2021`
to `GAR 2022`, etc. However, the script otherwise can run without
modification in future years, as long as you do not change funding
codes.

## Running

To generate the CSR report:

1. Run dBASE II.
2. Turn your printer on.
3. Put the floppy disk with `CLOSED.CSV` and `OPEN.CSV` in drive A.
4. Run the CSR command file:

    . do csr

## Explanation of files

The `CSR.PRG` command file makes use of the following database files:

* CLOSSTRU.DBF
* CSROSTRU.DBF
* CSRSTRU.DBF
* CTLYSTRU.DBF
* DEMOSTRU.DBF
* LTLYSTRU.DBF
* OPENSTRU.DBF
* OTLYSTRU.DBF
* PCATNAME.DBF
* PCNAMES.DBF

These files contain database structures, except for `PCATNAME.DBF`,
which contains legal problem category names, and `PCNAMES.DBF`, which
contains legal problem names.

The following command files are used:

* CSR.PRG
* AREADEMO.PRG
* AREALANG.PRG
* OPENREP.PRG
* PCREP.PRG
* RACEDEMO.PRG

The main command file is `CSR.PRG`. The other files are subroutines
called when the report is printed.

## Support

If you have any questions, feel free to contact the developer,
Jonathan Pyle, at 215-981-3843.

[pkunzip]: https://www.pkware.com/zip/products/pkzip
