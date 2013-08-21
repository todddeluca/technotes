

## R/Bioconductor Tutorials

http://manuals.bioinformatics.ucr.edu/home/R_BioCondManual#TOC-Matrices-and-Arrays

## R Packages


Hadley Wickam on developing R packages:
https://github.com/hadley/devtools/wiki


Karl Broman on how to use `devtools` to install R packages hosted on github.
http://kbroman.wordpress.com/2013/05/10/tutorials-on-gitgithub-and-gnu-make/?utm_source=feedly

> And for R folks, note that it's easy to install R packages that are hosted on
> github, using Hadley Wickham's devtools package. For example, to install Nacho
> Caballero's clickme package:
> 
>     install.packages("devtools")
>     library(devtools)
>     install_github("clickme", "nachocab")


## Microarray Analysis

A tutorial pdf, "An introduction to Microarray data analysis in using
Bioconductor", is located in the directory containing this README.

Relative Log Expression and other QC measures:
http://bioinformatics.knowledgeblog.org/2011/06/20/analysing-microarray-data-in-bioconductor/



## Personal R Packages

The article below points to a personal R package which might (or might not) be
a useful template for how to write a simple, small R package for distributing
code.

http://hilaryparker.com/2013/04/03/personal-r-packages/

I came across this R package (https://github.com/kbroman/broman) on GitHub, and it made me so excited that I
decided to write a post about it. It's a compilation by Karl Broman of various
R functions that he's found helpful to write throughout the years.

Wouldn't it be great if incoming graduate students in Biostatistics/Statistics
were taught to create a personal repository of functions like this? Not only is
it a great way to learn how to write an R package, but it also encourages good
coding techniques for newer students (since it encourages them to write
separate functions with documentation). It also allows for easy reproducibility
and collaboration both within the school and with the broader community. Case
in point — I wanted to use one of Karl's functions (which I found via his blog
which I found via Twitter), and all I had to do was run:

    install_github('broman','kbroman')
    library('broman')

(Note that install_github is a function in the devtools package. I would link
to the GitHub page for that package but somehow that seems circular.)

