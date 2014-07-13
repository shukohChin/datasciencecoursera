# assume the zip file and R script to be in the working directory
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# assume "coal combustion-related" to grep "Coal" from EI.Sector
coalSCC <- SCC[grep("Coal", SCC$EI.Sector), ]
emission <- subset(NEI, NEI$SCC %in% coalSCC$SCC)
ccEmission <- aggregate(emission$Emissions ~ emission$year, FUN = "sum")
colnames(ccEmission) <- c("year", "Emission")
# open graphic device
png(file = "plot4.png", width = 480, height = 480)
options(scipen = 8)
with(ccEmission, {
  bp <- barplot(Emission, main = "Q4", col = c("lightblue", "mistyrose", "lavender", "lightgreen"), names.arg=c("1999","2002","2005","2008"), xlab = "Year", ylab = "Total PM2.5 emission from coal combustion-related")
  text(bp, 0, round(Emission), cex = 1, pos = 3)
  lines(Emission, type = "l", col = "red", lwd = 2)
})
# close graphic device
dev.off()