NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
library(data.table)
setDT(NEI)
setDT(SCC)
m <- aggregate( Emissions~year, NEI, sum)
m$Emissions <- m$Emissions / 1000000
barplot(m$Emissions, names.arg = m$year, las=1, col="red", main="Millions of tons of PM2.5 emitted per year\nin all of the USA")
options(scipen=1)