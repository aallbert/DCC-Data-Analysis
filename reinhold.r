source("utils/map_data.r")

data.raw <- read.table(
  "./data/drug_consumption.csv",
  sep = ",",
  header = TRUE,
  stringsAsFactors = FALSE
)

data.mapped <- map_drug_data(data.raw)

