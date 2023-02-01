library(tidyverse)
library(lubridate)
library(readr)
library(readxl)
library(syuzhet)


setwd("/Users/cn/Desktop/Dissertation/mandm/")

read_csv('data/all_articles.csv') %>% head %>% print

dat <- read_csv('data/all_articles.csv')
Encoding(dat$article) <- "latin1"

methods <- c("syuzhet", "bing", "afinn", "nrc")

sent_dat <- dat
    
for (i in seq_along(methods)) {
    print(methods[i])
    sent_dat$temp <- get_sentiment(sent_dat$article,
                                   method = methods[i],
                                   language = "spanish")
    col_name <- paste0("sent_", methods[i])
    colnames(sent_dat)[colnames(sent_dat) == 'temp'] <- paste0("sent_", methods[i])
}

sent <- sent_dat %>%
    mutate(department = toupper(department),
           date = as.Date(date),
           month = as.integer(month(ymd(date))),
           year = as.integer(year(ymd(date))),
           year_month = as.numeric(ifelse(month < 10,
                               paste0(year, ".0", month),
                               paste0(year, ".", month)))) %>%
           group_by(department, year_month) %>%
           summarize(year = max(year),
                     month = max(month),
                     sent_syuzhet = mean(sent_syuzhet),
                     sent_bing = mean(sent_bing),
                     sent_afinn = mean(sent_afinn),
                     sent_nrc = mean(sent_nrc))
summary(sent)

# Data from Colombian government
hom22 <- read_xls("data/col_gov/homicidios_7.xls", skip = 9) %>% 
    select(DEPARTAMENTO, FECHA, CANTIDAD)# %>% 
   # head()

hom21 <- read_xls("data/col_gov/homicidios_1.xls", skip = 9) %>% 
    select(DEPARTAMENTO, FECHA, CANTIDAD) #%>% 
   # head()

hom20 <- read_xls("data/col_gov/homicidios_2020.xls", skip = 9) %>% 
    mutate(FECHA = `FECHA HECHO`) %>%
    select(DEPARTAMENTO, FECHA, CANTIDAD) #%>% 
   # head()

hom19 <- read_xlsx("data/col_gov/homicidios_2019_3.xlsx", skip = 9) %>% 
    mutate(FECHA = `FECHA HECHO`) %>%
    select(DEPARTAMENTO, FECHA, CANTIDAD)

hom18 <- read_xlsx("data/col_gov/homicidios_2018_1.xlsx", skip = 9) %>% 
    mutate(FECHA = `FECHA HECHO`) %>%
    select(DEPARTAMENTO, FECHA, CANTIDAD) 

hom17 <- read_xlsx("data/col_gov/homicidios_2017_2.xlsx", skip = 9) %>% 
    mutate(FECHA = `FECHA HECHO`) %>%
    select(DEPARTAMENTO, FECHA, CANTIDAD)

hom16 <- read_xlsx("data/col_gov/homicidios_2016_2.xlsx", skip = 9) %>% 
    mutate(FECHA = `FECHA HECHO`) %>%
    select(DEPARTAMENTO, FECHA, CANTIDAD)

hom15 <- read_xlsx("data/col_gov/homicidios_2015_2.xlsx", skip = 9) %>% 
    mutate(FECHA = `FECHA HECHO`) %>%
    select(DEPARTAMENTO, FECHA, CANTIDAD)

hom14 <- read_xlsx("data/col_gov/homicidios_2014_2.xlsx", skip = 9) %>% 
    mutate(FECHA = `FECHA HECHO`) %>%
    select(DEPARTAMENTO, FECHA, CANTIDAD)

all_hom_df <- rbind(hom22, hom21, hom20, hom19, hom18, hom17, hom16, hom15,
    hom14) %>%
    filter(!is.na(FECHA)) %>%
    rename(department = DEPARTAMENTO,
           date = FECHA,
           homicides = CANTIDAD) %>%
    mutate(month = month(ymd(date)),
           year =  year(ymd(date)),
           year_month = as.numeric(ifelse(month < 10,
                               paste0(year, ".0", month),
                               paste0(year, ".", month)))) %>%
    group_by(department, year_month) %>%
    summarize(homicides = sum(homicides),
              month = max(as.integer(month)),
              year = max(as.integer(year)))
summary(all_hom_df)
rm(list=ls(pattern="hom[1-9]+"))

full_df <- full_join(sent, all_hom_df)
# economic data
# https://totoro.banrep.gov.co/analytics/saw.dll?Portal

# GPD https://data.imf.org/regular.aspx?key=61545852
