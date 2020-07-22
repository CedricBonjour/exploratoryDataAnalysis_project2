NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
library(data.table)
setDT(NEI)
setDT(SCC)

baltimoreFIPS <- 24510

sub <- NEI[fips==baltimoreFIPS,  ]

m <- aggregate( Emissions~year, sub, sum)
m$Emissions <- m$Emissions / 1000
barplot(m$Emissions, names.arg = m$year, las=1, col="green", main="Thousands of tons of PM2.5 emitted per year\nin Baltimore City, Maryland")
options(scipen=1)