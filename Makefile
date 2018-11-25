all: report.html

clean:
	rm -f scrabble_scores.csv scrabble_freq.csv histogram.png report.md

clean-full: clean
	rm -f words.txt report.html

report.html: report.Rmd histogram.png scrabble_score.csv
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: scrabble_freq.csv
	Rscript -e 'library(ggplot2); qplot(Score, Freq, data=read.csv("$<")) + theme_classic(); ggsave("$@")'
	rm Rplots.pdf

scrabble_score.csv scrabble_freq.csv: scrabble.R words.txt
	Rscript $<

words.txt:
	curl -L https://svnweb.freebsd.org/base/head/share/dict/web2?view=co > words.txt
