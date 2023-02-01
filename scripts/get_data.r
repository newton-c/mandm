library(tidyverse)
library(readr)

setwd("/Users/cn/Desktop/Dissertation/mandm/")

read_csv('data/all_articles.csv') %>% head %>% print

dat <- read_csv('data/all_articles.csv')
Encoding(dat$article) <- "latin1"

library(syuzhet)

test_sent <- dat$article[1]
print(test_sent)

get_sentiment(test_sent, method = "nrc", language = "spanish")