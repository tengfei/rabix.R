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
                        if(.v %in% c(1L, 0L)){
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
#' @field context [character] by default:
#' "https://github.com/common-workflow-language/common-workflow-language/blob/draft-1/specification/tool-description.md"
#' @field owner [list] a list of owner names. 
#' @field contributor [list] a list of contributor names.
#' 
#' @export RabixTool
#' @exportClass RabixTool
RabixTool <-
    setRefClass("RabixTool",
                contains = "CommandLineTool",
                fields = list(context = "character",
                    owner = "list",
                    contributor = "list"),
                methods = list(
                    initialize = function(...,
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

                        if(is.null(requirements)){
                            requirements <<-
                                ProcessRequirementList(
                                    list(DockerRequirement(
                                        dockerImageId = dockerImageId,
                                        dockerPull = dockerPull,
                                        dockerLoad = dockerLoad,
                                        dockerFile = dockerFile,
                                        dockerOutputDirectory = dockerOut),
                                         CpuRequirement(value = as.integer(cpu)),
                                         MemRequirement(value = as.integer(mem))))
                        }
                        context <<- context
                        owner <<- owner
                        contributor <<- contributor
                        callSuper(...)
                    }
                ))

## override toJSON and to YAML
RabixTool$methods(toList = function(...){
    res <- callSuper(...)
    names(res)[which(names(res) == "context")] <- "@context"
    res
})




