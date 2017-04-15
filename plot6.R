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
losangeles<-subset(NEI, fips == "06037" & type == "ON-ROAD")

baltimoreData <- aggregate(Emissions ~ year, baltimore, sum)
baltimoreData$loc<-"Baltimore City"
losangelesData <- aggregate(Emissions ~ year, losangeles, sum)
losangelesData$loc<-"Los Angeles County"

combinedData <- as.data.frame(rbind(baltimoreData, losangelesData))

png('plot6.png', width=600, height=480)

graph <- ggplot(combinedData, aes(factor(year), Emissions, fill=year)) + guides(fill=FALSE)
graph <- graph + facet_grid(. ~ loc) + geom_bar(stat="identity")
graph <- graph +
  xlab("year") +
  ylab("PM2.5 Total Emissions") +
  ggtitle("Total Emissions from motor vehicle sources in Baltimore City and Los Angeles County")

print(graph)
dev.off()