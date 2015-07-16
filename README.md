# rabix.R
R utilities for [rabix](https://www.rabix.org/)

# Install

```
source("http://bioconductor.org/biocLite.R") # installs BiocInstaller
useDevel() # specifies to use bioc-devel (3.2)
biocLite("devtools") # needed for the special use of biocLite() below
# replace username/repos below with your github username and repository name
biocLite("tengfei/rabix.R", build_vignettes=TRUE, dependencies=TRUE)
```
