## Short hand
## Create InputParameterList
ipl <- IPList(
    InPar(id = "bam",
          type = "File",
          label = "Bam file",
          description = "Input bam file",
          position = 1L,
          separate = TRUE),
    InPar(id = "level",
          type = "Integer",
          label = "Compression Level",
          description = "Set compression level, from 0 (uncompressed) to 9 (best)",
          position = 2L),
    InPar(id = "prefix",
          type = "String",
          label = "Prefix",
          description = "Write temporary files to PREFIX.nnnn.bam",
          position = 3L)
)

## Create OutputParameterList
opl <- OPList(OutPar(
        id = "sorted",
        type = "File",
        glob = "*.bam"    
))

## Create RabixTool
rbx <- RabixTool(id = "samtools-sort",
                label = "Samtools sort subcommand",
                description = "Samtools sort: sort bam into sorted bam : )",
                cpu = 2, mem = 202,
                baseCommand = "samtools sort",
                arguments = "out.bam",
                inputs = ipl,
                outputs = opl)

## Output to JSON and paste it into rabix interface
rbx$toJSON()
rbx$toJSON(pretty = TRUE)

## Long form without shorhand
ipl <- InputParameterList(
    InputParameter(id = "bam",
                   type = "File",
                   label = "Bam file",
                   description = "Input bam file",
                   inputBinding = CommandLineBinding(
                       position = 1L,
                       separate = TRUE
                   )),
    InputParameter(id = "level",
                   type = "Integer",
                   label = "Compression Level",
                   description = "Set compression level, from 0 (uncompressed) to 9 (best)",
                   inputBinding = CommandLineBinding(
                       position = 2L
                   )),
    InputParameter(id = "prefix",
                   type = "String",
                   label = "Prefix",
                   description = "Write temporary files to PREFIX.nnnn.bam",
                   inputBinding = CommandLineBinding(
                       position = 3L
                   ))
)


opl <- OutputParameterList(
    CommandOutputParameter(
        id = "sorted",
        type = "File",
        outputBinding = CommandOutputBinding(
            glob = "*.bam"
        )
    )
)

