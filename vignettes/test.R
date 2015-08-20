library(rabix)

## tool: samtools view -bS
samtools_view <- Tool(id = "samtools-view",
                      label = "samtools-view",
                      description = "convert sam to bam",
                      dockerPull = "tengfei/samtools:v1.2",
                      baseCommand = "samtools -bS",
                      inputs = list(input(
                          id = "#sam",
                          type = "File",
                          label = "sam file",
                          description = "Sam fiels to be convted to bam"
                      )),
                      outputs = list(
                          id = "#bam",
                          type = "File",
                          glob = "*.bam"
                      ))

## tool: samtools sort
## bam --> sorted bam


ipl <- list(input(id = "#bam",
                  type = "File",
                  label = "Bam file",
                  description = "Input bam file"),
            input(id = "#level",
                  type = "Integer",
                  label = "Compression Level",
                  description = "Set compression level,\
             from 0 (uncompressed) to 9 (best)"),
            input(id = "#prefix",
                   type = "String",
                   label = "Prefix",
                   description = "Write temporary files to PREFIX.nnnn.bam"))

opl <- list(output(
        id = "sorted",
        type = "File",
        glob = "*.bam"    
))



samtools_sort <- RabixTool(id = "samtools-sort",
                           label = "Samtools sort subcommand",
                           description = "Sort bam into sorted bam", 
                           dockerPull = "tengfei/samtools:v1.2",
                           cpu = 0, mem = 1024,
                           baseCommand = "samtools sort",
                           arguments = "sorted.bam",
                           inputs = ipl,
                           outputs = opl)


## method 1: simple connection, single input/ouput perfect matching if
## you want to do in R this is the simple way, for any complex
## construction, please use the graphical user interface which is much
## easier.

## connected by file, if no unique match, try match id automatically,
## but give warnings otherwise give up

Flow <- step1 + step2 + step3

## or?

Flow <- step1 > step2 > step3

step2:output['param1'] + step3:input['param2']


ipl[[1]]
## method 2: automatic matching


## method 3: manual matching

## TODO
## visualize the diagram
## parser for docopt without python parser
## parser help 

