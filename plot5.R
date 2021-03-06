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

baltimore<-subset(NEI, fips == "24510" & type == "ON-ROAD")
baltimoreData <- aggregate(Emissions ~ year, baltimore, sum)

png('plot5.png', width=480, height=480)

graph <- ggplot(baltimoreData, aes(factor(year), Emissions))
graph <- graph + geom_bar(stat="identity")
graph <- graph +
  xlab("year") +
  ylab("PM2.5 Total Emissions") +
  ggtitle("Total Emissions from motor vehicle sources in Baltimore City")

print(graph)
dev.off()