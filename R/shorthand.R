#' Shorthand functions for cwl packages constructors
#'
#' Shorthand functions for cwl packages constructors
#'
#' @param type [ANY] Specify valid types of data that may be assigned
#' to this parameter.
#' 
#' @param label [character] A short, human-readable label of this
#' parameter object.
#' 
#' @param description [character] A long, human-readable description
#' of this parameter object.
#' 
#' @param streamable [logical] Currently only applies if type is
#' File. A value of true indicates that the file is read or written
#' sequentially without seeking. An implementation may use this flag
#' to indicate whether it is valid to stream file contents using a
#' named pipe. Default: false.
#' 
#' @param default [ANY] The default value for this parameter if not
#' provided in the input object.
#'
#' @param \dots For \code{InputParameter}, it will be
#' passed to [CommandLineBinding], which could be created by command
#' \code{CLB}. For parameters that accepted please check
#' \code{CommandLineBiding} in cwl package. For your convenience, this
#' manual also contain a section for \code{CommandLineBinding}. For
#' \code{OutPar} or \code{OutputParameter}, it will be passed to
#' \code{CommandOutputParameter}. Please check the following section
#' as well.
#'
#' @section Shorthand:
#' CLB <- CommandLineBinding
#' argslist <- CLBList <- CommandLineBindingList
#' COB <- CommandOutputBinding
#' IPList <- InputParameterList
#' OPList <- OutputParameterList
#' InPar <- InputParameter
#' OutPar <- OutputParameter
#'
#' @section CommandLineBinding:
#' \describe{
#'
#' \item{position}{[integer] The sorting key. Default position is 0.}
#'
#' \item{prefix}{[character] Command line prefix to add before the
#' value.}
#'
#' \item{separate}{[logical] If true (default) then the prefix and
#' value must be added as separate command line arguments; if false,
#' prefix and value must be concatenated into a single command line
#' argument.}
#'
#' \item{itemSeparator}{[character] Join the array elements into a
#' single string with the elements separated by by itemSeparator.}
#'
#' \item{valueFrom}{[characterOrExpression] If valueFrom is a constant
#' string value, use this as the value and apply the binding rules
#' above. If valueFrom is an expression, evaluate the expression to
#' yield the actual value to use to build the command line and apply
#' the binding rules above. If the inputBinding is associated with an
#' input parameter, the "context" of the expression will be the value
#' of the input parameter. When a binding is part of the
#' CommandLineTool.arguments field, the valueFrom field is required.
#' }
#'}
#'
#' @section CommandOutputParameter:
#' \describe{
#'
#' \item{glob}{[characterORExpression] Find files relative to the
#' output directory, using POSIX glob(3) pathname matching. If
#' provided an array, match all patterns in the array. If provided an
#' expression, the expression must return a string or an array of
#' strings, which will then be evaluated as a glob pattern. Only files
#' which actually exist will be matched and returned.}
#'
#' \item{outputEval}{[Expression] Evaluate an expression to generate
#' the output value. If glob was specified, the script context will be
#' an array containing any files that were matched. Additionally, if
#' loadContents is true, the file objects will include up to the first
#' 64 KiB of file contents in the contents field.}
#' Following fields inherited from \code{Binding}
#'
#' \item{loadContents}{ [logical] Only applies when type is File. Read
#' up to the first 64 KiB of text from the file and place it in the
#' "contents" field of the file object for manipulation by
#' expressions.}
#'
#' \item{secondaryFiles}{Only applies when type is File. Describes
#' files that must be included alongside the primary file. If the
#' value is Expression, the context of the expression is the input or
#' output File parameter to which this binding applies. Where the
#' value is a string, it specifies that the following pattern should
#' be applied to the primary file: If string begins with one or more
#' caret characters, for each caret, remove the last file extension
#' from the path (the last period . and all following characters). If
#' there are no file extensions, the path is unchanged.  Append the
#' remainder of the string to the end of the file path.}
#' 
#' 
#' }
#'
#' @rdname shorthand-cwl
#' @name CLB
#' @aliases CLB argslist COB IPList OPList input output InPar OutPar
#'
#'
#' @export CLB argslist COB IPList OPList input output InPar OutPar
#' @examples
#' ipl <- IPList(
#'     input(id = "bam",
#'           type = "File",
#'           label = "Bam file",
#'           description = "Input bam file",
#'           position = 1L,
#'           separate = TRUE),
#'     input(id = "level",
#'           type = "Integer",
#'           label = "Compression Level",
#'           description = "Set compression level, from 0 (uncompressed) to 9 (best)",
#'           position = 2L),
#'     input(id = "prefix",
#'           type = "String",
#'           label = "Prefix",
#'           description = "Write temporary files to PREFIX.nnnn.bam",
#'           position = 3L)
#' )
CLB <- CommandLineBinding
argslist <- CCBList
COB <- CommandOutputBinding
IPList <- InputParameterList
OPList <- OutputParameterList
InPar <- InputParameter
OutPar <- OutputParameter
input <- function(id = "", type = "", label = "",
                  description = "", streamable = FALSE,
                  default = "", required = FALSE, ...){
    
    type <- deType(type)
    
    if(!required && length(type) == 1){
        type = c("null", type)
    }

    InputParameter(id = id, type = type, label = label,
                   description = description,
                   streamable = streamable,
                   default = default,
                   inputBinding = CLB(...)
    )
}


output <- function(type = "", label = "", description = "",
                   streamable = FALSE, default = "",
                   id = "",  ...){
    type <- deType(type)
    CommandOutputParameter(id = id, type = type, label = label,
                           description = description,
                           streamable = streamable,
                           default = default,
                           outputBinding = COB(...))
}

