library(stringr)
library(dplyr)
library(readr)
library(purrr)

# Return the scrabble score for a single letter
# Letter values taken from https://scrabblewizard.com/scrabble-tile-distribution/
get_letter_value <- function(x){
  if(x %in% c('a', 'e', 'i', 'l', 'n', 'o', 'r', 's', 't', 'u'))
    return(1L) #L's indicate values are integers
  else if(x %in% c('d', 'g'))
    return(2L)
  else if(x %in% c('b', 'p', 'c', 'm'))
    return(3L)
  else if(x %in% c('f', 'h', 'v', 'w', 'y'))
    return(4L)
  else if(x %in% c('k'))
    return(5L)
  else if(x %in% c('j', 'x'))
    return(8L)
  else if(x %in% c('q', 'z'))
    return(10L)
  else
    return(NA)
}

# Calculate the scrabble score for a whole word
calculate_scrabble_score <- function(word){
  word %>%
    str_split("") %>% # Split into letters
    `[[`(1) %>% # Remove list structure
    str_to_lower %>%
    map_int(get_letter_value) %>%
    sum
}

# build a tibble of scores
scrabble_score <- tibble(Words = readLines("words.txt")) %>%
  filter(
    startsWith(Words, "a") # limit to words starting with 'a' to limit run time
  ) %>%
  rowwise %>%
  mutate(
    Score = Words %>% calculate_scrabble_score
  )

# Save results
write_csv(scrabble_score, "scrabble_scores.csv")

# Filter by word length and extract vector of scores
Score <- scrabble_score %>%
  filter(nchar(Words) < 10) %>%
  `[[`("Score")

# Calculate frequency scores
scrabble_freq <- table(Score)

# Save results
write.table(
  scrabble_freq, "scrabble_freq.csv",
  sep = ",", row.names = FALSE, quote = FALSE
)
