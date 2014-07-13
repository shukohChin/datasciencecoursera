# assume the zip file and R script to be in the working directory
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BLNEI <- subset(NEI, NEI$fips == "24510" | NEI$fips == "06037")
# assume "motor vehicle sources" to grep "Mobile.*On-Road" from EI.Sector
vehicleSCC <- SCC[grep("Mobile.*On-Road", SCC$EI.Sector), ]
vehicleNEI <- subset(BLNEI, BLNEI$SCC %in% vehicleSCC$SCC)
emission <- aggregate(vehicleNEI$Emissions ~ vehicleNEI$year + vehicleNEI$fips, FUN = "sum")
colnames(emission) <- c("year", "fips", "Emission")
emission$fips[emission$fips == "24510"] <- "Baltimore City, Maryland"
emission$fips[emission$fips == "06037"] <- "Los Angeles County, California"
# open graphic device
png(file = "plot6.png", width = 640, height = 480)
options(scipen = 8)
g <- ggplot(emission, aes(year, Emission))
p <- g + geom_point() + facet_grid(. ~ fips) + geom_smooth(method = "lm") + theme_bw() + labs(title = "Q6") + labs(x = "year", y = "emission")
print(p)
# close graphic device
dev.off()