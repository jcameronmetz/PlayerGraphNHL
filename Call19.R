
#### SET FOLDER TO MATCH DESKTOP DESTINATION
# path to folder that holds multiple .csv files


folder <- "/Users/cmetz.GTSCPA/Desktop/Perfect Hockey Files/20182019/"     
file_list <- list.files(path=folder, pattern="*.csv") # create list of all .csv files in folder
file_list

# read in each .csv file in file_list and create a data frame with the same name as the .csv file
for (i in 1:length(file_list)){
  assign(file_list[i], 
         read.csv(paste(folder, file_list[i], sep=''))
  )}

library(ggplot2)
library(tidyverse)
library(stringr)
library(dplyr)
library(tibble)
library(tidyr)

five19 <- five19.csv
pp19 <- pp19.csv
ixgf<-ixgf.csv


rm(five19.csv, pp19.csv, ixgf.csv)
