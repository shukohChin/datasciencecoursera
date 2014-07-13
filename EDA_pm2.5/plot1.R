# assume the zip file and R script to be in the working directory
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
sumEmission <- aggregate(NEI$Emissions ~ NEI$year, FUN = "sum")
colnames(sumEmission) <- c("year", "totEmission")
# open graphic device
png(file = "plot1.png", width = 480, height = 480)
options(scipen = 8)
with(sumEmission, {
  bp <- barplot(totEmission, main = "Q1", col = c("lightblue", "mistyrose", "lavender", "lightgreen"), names.arg=c("1999","2002","2005","2008"), xlab = "Year", ylab = "Total PM2.5 emission from all sources")
  text(bp, 0, round(totEmission), cex = 1, pos = 3)
  lines(totEmission, type = "l", col = "red", lwd = 2)
})
# close graphic device
dev.off()