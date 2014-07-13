# assume the zip file and R script to be in the working directory
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BaltiNEI <- subset(NEI, NEI$fips == "24510")
# assume "motor vehicle sources" to grep "Mobile.*On-Road" from EI.Sector
vehicleSCC <- SCC[grep("Mobile.*On-Road", SCC$EI.Sector), ]
vehicleNEI <- subset(BaltiNEI, BaltiNEI$SCC %in% vehicleSCC$SCC)
emission <- aggregate(vehicleNEI$Emissions ~ vehicleNEI$year, FUN = "sum")
colnames(emission) <- c("year", "Emission")
# open graphic device
png(file = "plot5.png", width = 480, height = 480)
options(scipen = 8)
with(emission, {
  bp <- barplot(Emission, main = "Q5", col = c("lightblue", "mistyrose", "lavender", "lightgreen"), names.arg=c("1999","2002","2005","2008"), xlab = "Year", ylab = "PM2.5 emission from motor vehicle sources")
  text(bp, 0, round(Emission), cex = 1, pos = 3)
  lines(Emission, type = "l", col = "red", lwd = 2)
})
# close graphic device
dev.off()