NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
library(data.table)
library(ggplot2)
setDT(NEI)
setDT(SCC)

f <- as.numeric(SCC$EI.Sector) %in% c(13, 18, 23)
coal <- SCC[ f , ]
coal <- merge(NEI, coal, by="SCC")
m <- aggregate( Emissions~year, coal, sum)
m$Emissions <- m$Emissions / 1000

barplot(m$Emissions, names.arg = m$year, las=1, col="red", main="Thousands of tons of PM2.5 emitted per year\nrelated to coal combustion\nin all of the USA")
options(scipen=1)