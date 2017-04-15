library(ggplot2)

#if (file.exists("summarySCC_PM25.rds")) {
if ("summarySCC_PM25.rds" %in% dir() == TRUE) {
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
}

#if (file.exists("Source_Classification_Code.rds")) {
if ("Source_Classification_Code.rds" %in% dir() == TRUE) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

baltimore<-subset(NEI, fips == "24510")
baltimoreData <- aggregate(Emissions ~ year + type, baltimore, sum)

png('plot3.png', width=600, height=480)

graph <- ggplot(baltimoreData, aes(factor(year), Emissions, fill=type)) + guides(fill=FALSE)
graph <- graph + facet_grid(. ~ type) + geom_bar(stat="identity")
graph <- graph +
  xlab("year") +
  ylab("PM2.5 Total Emissions") +
  ggtitle("Total Emissions from all sources in Baltimore City")

print(graph)
dev.off()

#line example
subsetNEI <- NEI[NEI$fips=="24510", ]
aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)
png("plot3.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')