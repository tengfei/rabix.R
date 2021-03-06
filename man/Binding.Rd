% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/40-Process-class.R
\docType{class}
\name{Binding-class}
\alias{Binding}
\alias{Binding-class}
\title{Binding}
\description{
Binding
}
\section{Fields}{

\describe{
\item{\code{loadContents}}{[logical] Only applies when type is File. Read
up to the first 64 KiB of text from the file and place it in the
"contents" field of the file object for manipulation by
expressions.}

\item{\code{secondaryFiles}}{[] Only applies when type is File. Describes
files that must be included alongside the primary file. If the
value is Expression, the context of the expression is the input or
output File parameter to which this binding applies. Where the
value is a string, it specifies that the following pattern should
be applied to the primary file: If string begins with one or more
caret characters, for each caret, remove the last file extension
from the path (the last period . and all following characters). If
there are no file extensions, the path is unchanged.  Append the
remainder of the string to the end of the file path.}
}}
\examples{
Binding(loadContents = TRUE, secondaryFiles = "./test.txt")
}

