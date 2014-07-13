# assume the zip file and R script to be in the working directory
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BaltiEmi <- subset(NEI, NEI$fips == "24510")
emission <- aggregate(BaltiEmi$Emissions ~ BaltiEmi$year, FUN = "sum")
colnames(emission) <- c("year", "BaltiEmission")
# open graphic device
png(file = "plot2.png", width = 480, height = 480)
options(scipen = 8)
with(emission, {
  bp <- barplot(BaltiEmission, main = "Q2", col = c("lightblue", "mistyrose", "lavender", "lightgreen"), names.arg=c("1999","2002","2005","2008"), xlab = "Year", ylab = "Total PM2.5 emission in Baltimore City")
  text(bp, 0, round(BaltiEmission), cex = 1, pos = 3)
  lines(BaltiEmission, type = "l", col = "red", lwd = 2)
})
# close graphic device
dev.off()