NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
library(data.table)
library(ggplot2)
setDT(NEI)
setDT(SCC)


baltimoreFIPS <- "24510"
laFIPS <- "06037"

f <- as.numeric(SCC$EI.Sector) %in% 49:52
mv <- SCC[ f , ]
mv <- merge(NEI, mv, by="SCC")
setDT(mv)
mvBalt <- mv[fips==baltimoreFIPS, ]
mvLA <- mv[fips==laFIPS, ]
balt <- aggregate( Emissions~year, mvBalt, sum)
LA <- aggregate( Emissions~year, mvLA, sum)

m<- merge(balt,LA , by="year")
names(m)<- c("Year", "Emissions.Baltimore", "Emissions.LA")
m <- transpose(m, make.names = 1)#, keep.names = "city", make.names = 1)
x<- as.matrix(m, rownames=T)
rownames(x) <- c("Baltimore", "LA")

barplot(x, col = c("lightblue", "mistyrose"),
    legend = rownames(x), beside = TRUE,
    args.legend = list(x = "topleft", bty = "n", inset=c(-0.07, -0.02)),
    main  = "Tons of PM2.5 emitted per year\nrelated to motor vehicles\n  Los Angeles & Baltimore City comparison" )
