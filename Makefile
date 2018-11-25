all: report.html

# Removes all intermediate files except words.txt, which I have to download often otherwise
clean:
	rm -f scrabble_scores.csv scrabble_freq.csv histogram.png report.md

# By adding a phony dependency I can add commands onto it
clean-full: clean
	rm -f words.txt report.html

report.html: report.Rmd histogram.png scrabble_score.csv
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: scrabble_freq.csv 
	Rscript -e 'library(ggplot2); qplot(Score, Freq, data=read.csv("$<")) + theme_classic(); ggsave("$@")'
	rm Rplots.pdf

# You can have multiple targets per line!
scrabble_score.csv scrabble_freq.csv: scrabble.R words.txt
	Rscript $<

# Since I don't have a local copy, I need to download words.txt every time
words.txt:
	curl -L https://svnweb.freebsd.org/base/head/share/dict/web2?view=co > words.txt
