"Foo bar tool
Usage:
  tool.py create [-abcdf FLOAT] [--longboolean --some-int INTEGER --string STR --some-array=<integer>... --enum=<enum> --other-enum=<enum>] new --file=<file> <arg-some_file> <arg_some-array>... [<arg-some-int> <arg-float-some> <arg-str-some>]
Arguments:
  <arg-some_file>                   arg FILE output [type: file] [default: file.txt]
  <arg-some-int>                    arg integer [type: integer]
  <arg-float-some>                  arg FLOAT [type: float]
  <arg-str-some>                    arg string [type: string]
                                    second line of string decription
  <arg_some-array>                  arg this is array of ints [type: int]
Options:
  -h --help                         show this help message and exit
  -v, --version                     show version and exit
  --file=<file>                     this is file
  -s STR --string=STR               this is string
  -i, --some-int INTEGER            this is int
                                    second line of description
  -f FLOAT                          this is float [default: 10.0]
  -b                                this is boolean
  --longboolean                     this is longboolean
  -a --longa                        this is short and long a bool
  -c                                this is short c bool
  -d                                this is short d bool
  --some-array=<integer>            this is list of int [default: 1 2 3]
                                    second description line
  --enum=<enum>                     this is enum [values: 10.1 11.1 12.1] [default: 10.1]
  --other-enum=<enum>               this is enum [default: 10] [values: 10 11 12]
" -> doc

library(docopt)
## docopt(doc, strict = TRUE)

'usage: runif.R [--n=<int> --min=<float> --max=<float> --seed=<float>]

options:
 --n=<int>        number of observations. If length(n) > 1, the length is taken to be the number required [default: 1].
 --min=<float>   lower limits of the distribution. Must be finite [default: 0].
 --max=<float>   upper limits of the distribution. Must be finite [default: 1].
 --seed=<float>  seed for set.seed() function [default: 1]' -> doc

## library(docopt)
## docopt(doc, strict = TRUE)
## docopt

## args <- str_c(args, collapse = " ")
## docopt:::printable_usage(doc)
## docopt:::parse_doc_options(doc)
## pot_options <- docopt:::parse_doc_options(doc)

## docopt:::OptionList
## docopt:::Option

## parse_args(args, pot_options)
##     usage <- printable_usage(doc, name)
##     pot_options <- parse_doc_options(doc)
##     pattern <- parse_pattern(formal_usage(usage), pot_options)
##     for (anyopt in pattern$flat("AnyOptions")) {
##         if (class(anyopt) == "AnyOptions") 
##             anyopt$children <- pot_options$options
##     }
##     args <- parse_args(args, pot_options)
##     extras(help, version, args, doc)
##     m <- pattern$fix()$match(args)
##     if (m$matched && length(m$left) == 0) {
##         cl <- sapply(m$collected, class)
##         options <- m$collected[cl == "Option"]
##         pot_arguments <- pattern$flat()
##         pot_arguments <- pot_arguments[sapply(pot_arguments, 
##             class) %in% c("Argument", "Command")]
##         arguments <- m$collected
##         arguments <- arguments[sapply(arguments, class) %in% 
##             c("Argument", "Command")]
##         dict <- list()
##         for (kv in c(pot_options$options, options, pot_arguments, 
##             arguments)) {
##             value <- kv$value
##             dict[kv$name()] <- list(value)
##         }
##         if (isTRUE(strip_names)) {
##             nms <- gsub("(^<)|(^\\-\\-?)|(>$)", "", names(dict))
##             dict[nms] <- dict
##         }
##         return(dict)
##     }
##     stop(paste(usage, collapse = "\n  "))
