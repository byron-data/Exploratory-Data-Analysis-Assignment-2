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

#coal<-SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE), ]
combustion <- SCC[grep("Combustion",SCC$SCC.Level.One),]
coal <- combustion[grep("Coal",combustion$SCC.Level.Three, ignore.case=TRUE),]
USCoal <- NEI[NEI$SCC %in% coal$SCC,]

USCoalData <- aggregate(Emissions ~ year, USCoal, sum)

png('plot4.png', width=480, height=480)

graph <- ggplot(USCoalData, aes(factor(year), Emissions)) + geom_bar(stat="identity")
graph <- graph +
  xlab("year") +
  ylab("Coal Combustion Sources PM2.5 Total Emissions") +
  ggtitle("Total Coal Combustion Sources PM2.5 Emissions Across US")

print(graph)
dev.off()