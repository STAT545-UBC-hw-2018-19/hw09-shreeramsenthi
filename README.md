# Stat547 Assignment 4: Package Development

This is my submission for assignment 4 of the 2018 iteration of the Stat547 course at UBC.

In the last assignment in Stat545 we explored uses of the `shiny` package to build and deploy a simple interactive website to explore a dataset. In this assignment we will be practising automation through the use of GNU `make` and `Makefile`'s.

Specifically, we will be starting with the base [`make` activity](https://github.com/STAT545-UBC/make-activity) provided by [Jenny Bryan](https://github.com/jennybc). From there, we were tasked with adding an R script and an Rmd file that are used to produce an output and tying it into the `make` pipeline.

I chose to make an R script that creates a csv file outlining how many points each word is worth in Scrabble, as well as a csv file of the frequency data. Since the run times were getting too large, I restricted my analyses to words that are not proper nouns and begin with "a". My Rmd script produces a pdf file that summarizes these results. In addition to this, I removed the Rscript, Rmd, and intermediate files provided by Jenny.

You can find my Makefile [here]() and my final report output [here]().
