#my_path_dir = "C:/Users/natac/OneDrive/Pulpit/PhD_project/bibtex_trial"
library(bib2df)
library(plyr)
library(tidyverse)
library(dplyr)
library(bibliometrix)


my_dir <- choose.dir(default = "", caption = "Select folder")
setwd(my_dir)
#setwd(my_path_dir)
iee_fix <- function(iee_file){
  tx  <- readLines(iee_file)
  tx2  <- gsub(pattern = "}, title", replace = "}, \ntitle", x = tx)
  writeLines(tx2, con=iee_file)
}

iee_files <- list.files(my_dir, pattern="^[iee]")

lapply(iee_files, function(x){
  iee_fix(x)
})


conversion <- function(some_file) {
  my_set <- convert2df(some_file, dbsource="wos", format="bibtex")
  my_set$file_source <- some_file
  keeps <- c("TI", "AB", "AU", "DI", "PY", "SO", "file_source")
  dtbs = my_set[keeps]
  return(dtbs)
}

file_bib <- list.files(my_dir, pattern = "*.bib")
final_dtbs = lapply(file_bib, function(x){
  conversion(x)
  
})

df = do.call("rbind", final_dtbs)
df$relatable <- NA
df %>% group_by(TI) %>% mutate(sources = paste0(file_source, collapse="/")
)-> out
keeps <- c("TI", "AB", "AU", "DI", "PY", "SO", "sources", "relatable")
out = out[keeps]
names(out)[names(out) == "TI"] <- "Title"
names(out)[names(out) == "AB"] <- "Abstract"
names(out)[names(out) == "AU"] <- "Authors"
names(out)[names(out) == "DI"] <- "DOI"
names(out)[names(out) == "PY"] <- "Year"
names(out)[names(out) == "SO"] <- "Publication name"
out_data <- out[!duplicated(out$Title), ]

trial <- convert2df("acm.bib", dbsource="wos", format="bibtex")
write.csv(out_data, "merged.csv", row.names=FALSE)
