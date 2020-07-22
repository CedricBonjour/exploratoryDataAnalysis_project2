NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
library(data.table)
library(ggplot2)
setDT(NEI)
setDT(SCC)


baltimoreFIPS <- 24510

f <- as.numeric(SCC$EI.Sector) %in% 49:52
mv <- SCC[ f , ]
mv <- merge(NEI, mv, by="SCC")
setDT(mv)
mvBalt <- mv[fips==baltimoreFIPS,  ]


  
m <- aggregate( Emissions~year, mvBalt, sum)
barplot(m$Emissions, names.arg = m$year, las=1, col="red", main="Tons of PM2.5 emitted per year\nrelated to motor vehicles\nin Baltimore City, Maryland")
options(scipen=1)