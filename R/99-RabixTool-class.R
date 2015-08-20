#' Rabix specifc Requirements
#'
#' Extends ProcessRequirements. CpuRequirement and MemRequirement to
#' setup CPU and Memory requiremnts.
#'
#' @field value [Integer] for CPU default is 1L, if 0L, use all
#' CPU. For mem, default is 1000L. Note: for CPU, 0L means
#' multi-tread, and non-zero value will be converted to 1L, which
#' means single thread.
#'
#' @rdname requirements
#'
#' @export CpuRequirement
#' @exportClass CpuRequirement
#' @aliases CpuRequirement CpuRequirement-class
#' @examples
#' CpuRequirement(value = 1L)
CpuRequirement <-
    setRefClass("CpuRequirement", contains = "ProcessRequirement",
                fields = list(
                    value = "integer"
                ),
                methods = list(
                    initialize = function(..., value = 1L,
                        class = "CpuRequirement"){
                        class <<- class
                        stopifnot(is.numeric(value))
                        .v <- as.integer(value)
                        if(!.v %in% c(1L, 0L)){
                            warning("For now, CPU value must be 0L (multi-treads) or 1L (single-thread)")
                            if(.v > 0){
                                message("Convert CPU value ", .v, " to", 1L)
                                .v <- 1L
                            }
                        }
                        value <<- .v
                        callSuper(...)
                    }
                ))



#' @rdname requirements
#' @aliases MemRequirement MemRequirement-class
#' @export MemRequirement
#' @exportClass MemRequirement
#' @examples
#' MemRequirement(value = 2000L)
MemRequirement <-
    setRefClass("MemRequirement", contains = "ProcessRequirement",
                fields = list(
                    value = "integer"
                ),
                methods = list(
                    initialize = function(..., value = 1000L,
                                          class = "MemRequirement"){
                        value <<- as.integer(value)
                        class <<- class
                        callSuper(...)
                    }
                ))



#' Rabix CommandLineTool Class
#'
#' Rabix subclass for CommandLineTool used by rabix.org or sbg
#' platform. \code{RabixTool} class extends \code{CommandLineTool}
#' with more fields.
#'
#' 
#' @field context [character] by default:
#' "https://github.com/common-workflow-language/common-workflow-language/blob/draft-1/specification/tool-description.md"
#' @field owner [list] a list of owner names. 
#' @field contributor [list] a list of contributor names.
#'
#' @section other fields:
#' \describe{
#' \item{\code{cpu}}{cpu 0 or 1, for any value >1 will be converted to 1L, passed to CpuRequirement}
#' \item{\code{mem}}{Positive integer. Passed to MemRequirement.}
#' \item{\code{dockerPull}}{[character] Get a Docker image using
#' docker pull}
#' 
#' \item{\code{dockerLoad}}{[character] Specify a HTTP URL from which
#' to download a Docker image using docker load.}
#' 
#' \item{\code{dockerFile}}{[character] Supply the contents of a
#' Dockerfile which will be build using docker build.}
#' 
#' \item{\code{dockerImageId}}{[character] The image id that will be
#' used for docker run. May be a human-readable image name or the
#' image identifier hash. May be skipped if dockerPull is specified,
#' in which case the dockerPull image id will be used.}
#' 
#' \item{\code{dockerOutputDirectory}}{ [character] Set the designated
#' output directory to a specific location inside the Docker
#' container.}}
#' 
#' @import methods
#' @import cwl
#' @importFrom docopt docopt
#' @export RabixTool
#' @exportClass RabixTool
#' @examples
#' ipl <- IPList(
#'     InPar(id = "bam",
#'           type = "File",
#'           label = "Bam file",
#'           description = "Input bam file",
#'           position = 1L,
#'           separate = TRUE),
#'     InPar(id = "level",
#'           type = "Integer",
#'           label = "Compression Level",
#'           description = "Set compression level, from 0 (uncompressed) to 9 (best)",
#'           position = 2L),
#'     InPar(id = "prefix",
#'           type = "String",
#'           label = "Prefix",
#'           description = "Write temporary files to PREFIX.nnnn.bam",
#'           position = 3L)
#' )
#' opl <- OPList(OutPar(
#'         id = "sorted",
#'         type = "File",
#'         glob = "*.bam"    
#' ))
#' rbx <- RabixTool(id = "samtools-sort",
#'                 label = "Samtools sort subcommand",
#'                 description = "Samtools sort: sort bam into sorted bam : )",
#'                 dockerPull = "tengfei/samtools:v1.2",
#'                 cpu = 2, mem = 202,
#'                 baseCommand = "samtools sort",
#'                 arguments = "out.bam",
#'                 inputs = ipl,
#'                  outputs = opl)
#' rbx$toJSON()
#' rbx$toJSON(pretty = TRUE)
RabixTool <-
    setRefClass("RabixTool",
                contains = "CommandLineTool",
                fields = list(context = "character",
                    owner = "list",
                    contributor = "list"),
                methods = list(
                    initialize = function(...,
                        inputs = NULL,
                        outputs = NULL,
                        cpu = 1L, mem = 1000L,                        
                        dockerImageId = "",
                        dockerPull = "",
                        dockerLoad = "",
                        dockerFile = "",
                        dockerOut = "",
                        requirements = NULL,
                        context = "https://github.com/common-workflow-language/common-workflow-language/blob/draft-1/specification/tool-description.md",
                        owner = list(),
                        contributor = list()){

                        

                        stopifnot(is.numeric(cpu))
                        .v <- as.integer(cpu)
                        if(!.v %in% c(1L, 0L)){
                            warning("For now, CPU value must be 0L (multi-treads) or 1L (single-thread)")
                            if(.v > 0){
                                message("Convert CPU value ", .v, " to", 1L)
                                .v <- 1L
                            }
                        }
                        

                        if(is.null(requirements)){
                            requirements <<-
                                ProcessRequirementList(
                                    list(DockerRequirement(
                                        dockerImageId = dockerImageId,
                                        dockerPull = dockerPull,
                                        dockerLoad = dockerLoad,
                                        dockerFile = dockerFile,
                                        dockerOutputDirectory = dockerOut),
                                         CpuRequirement(value = .v),
                                         MemRequirement(value = as.integer(mem))))
                        }
                        context <<- context
                        owner <<- owner
                        contributor <<- contributor

                        ## inputs
                        stopifnot(is(inputs, "InputParameterList") ||
                                  (is.list(inputs) &&
                                       all(sapply(inputs, is, "InputParameter"))))
                        
                        if(is.list(inputs) &&
                           all(sapply(inputs, is, "InputParameter"))){
                            inputs <<- IPList(inputs)
                        }
R
                        if(is(inputs, "InputParameterList")){
                            inputs <<- inputs
                        }

                        ## outputs
                        stopifnot(is(outputs, "OutputParameterList") ||
                                  (is.list(outputs) &&
                                       all(sapply(outputs, is, "OutputParameter"))))
                        
                        if(is.list(outputs) &&
                           all(sapply(outputs, is, "OutputParameter"))){
                            outputs <<- OPList(outputs)
                        }

                        if(is(outputs, "OutputParameterList")){
                            
                        }
                        
                        
                        callSuper(...)
                    }
                ))

## override toJSON and to YAML
RabixTool$methods(toList = function(...){
    res <- callSuper(...)
    names(res)[which(names(res) == "context")] <- "@context"
    res
})




