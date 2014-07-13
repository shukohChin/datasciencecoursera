# assume the zip file and R script to be in the working directory
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BaltiEmi <- subset(NEI, NEI$fips == "24510")
emission <- aggregate(BaltiEmi$Emissions, by = list(BaltiEmi$year, BaltiEmi$type), FUN = "sum")
colnames(emission) <- c("year", "type", "BaltiEmission")
emission$type[emission$type == "NON-ROAD"] <- "nonroad"
emission$type[emission$type == "NONPOINT"] <- "nonpoint"
emission$type[emission$type == "ON-ROAD"] <- "onroad"
emission$type[emission$type == "POINT"] <- "point"
# open graphic device
png(file = "plot3.png", width = 640, height = 480)
options(scipen = 8)
library(ggplot2)
g <- ggplot(emission, aes(year, BaltiEmission))
p <- g + geom_point() + facet_grid(. ~ type) + geom_smooth(method = "lm") + theme_bw() + labs(title = "Q3") + labs(x = "year", y = "emission")
#print(qplot(year, BaltiEmission, data = emission, facets = . ~ type, geom = "line", method = "x"))
print(p)
# close graphic device
dev.off()