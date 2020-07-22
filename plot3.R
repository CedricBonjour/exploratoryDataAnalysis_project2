NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
library(data.table)
library(ggplot2)
setDT(NEI)
setDT(SCC)

baltimoreFIPS <- 24510

sub <- NEI[fips==baltimoreFIPS,  ]

m <- aggregate( Emissions~year+type, sub, sum)

setDT(m)

n <- dcast(m, year~type, value.var="Emissions")
names(n) <- gsub("-", ".", names(n))

pallet <- c("NON.ROAD" = "darkgreen", "ON.ROAD" = "orange", "NONPOINT" = "steelblue", "POINT" = "red")


ggplot(n, aes(x=year)) +
  geom_line(aes(y = NON.ROAD, color="NON.ROAD") , size = 1.5)+
  geom_line(aes(y = ON.ROAD , color="ON.ROAD"),size = 1.5)+
  geom_line(aes(y = NONPOINT , color="NONPOINT" ),size = 1.5)+
  geom_line(aes(y = POINT , color = "POINT") ,size = 1.5) +
  labs(x = "Year", y = "Tons of emissions", color = "Legend") +
  scale_color_manual(values = pallet)+
  ggtitle("Amounts of PM2.5 emitted per year\nclassified by type\nin Baltimore City, Maryland")

