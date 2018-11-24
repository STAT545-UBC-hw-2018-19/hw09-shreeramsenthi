all: scrabble_score.csv

clean:
	rm -f scrabble_scores.csv scrabble_hist.csv

clean-full:
	rm -f words.txt scrabble_score.csv scrabble_hist.csv

scrabble_score.csv scrabble_hist.csv: scrabble.R words.txt
	Rscript $<

words.txt:
	curl -L https://svnweb.freebsd.org/base/head/share/dict/web2?view=co > words.txt
