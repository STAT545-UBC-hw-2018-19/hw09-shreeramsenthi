all: scrabble_report.pdf report.html

# Removes all intermediate files except words.txt, which I have to download often otherwise
clean:
	rm -f scrabble_scores.csv scrabble_freq.csv scrabble_histogram.png scrabble_report.md histogram.tsv histogram.png report.md

# By adding a phony dependency I can add commands onto it
clean-full: clean
	rm -f words.txt scrabble_report.pdf report.html

# Two phony targets to easily make Jenny's stuff or my new things
scrabble: scrabble_report.pdf

jenny: report.html

# My main new additions
scrabble_report.pdf: scrabble_report.Rmd scrabble_histogram.png scrabble_score.csv scrabble_freq.csv
	Rscript -e 'rmarkdown::render("$<")'

scrabble_histogram.png: scrabble_freq.csv 
	Rscript -e 'library(ggplot2); qplot(Score, Freq, data=read.csv("$<")) + theme_classic(); ggsave("$@")'
	rm Rplots.pdf

# You can have multiple targets per line!
scrabble_score.csv scrabble_freq.csv: scrabble.R words.txt
	Rscript $<

# Since I don't have a local copy, I need to download words.txt every time
words.txt:
	curl -L https://svnweb.freebsd.org/base/head/share/dict/web2?view=co > words.txt

# From Jenny's Make file
report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<
