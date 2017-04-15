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
baltimoreData <- aggregate(Emissions ~ year, baltimore, sum)

png('plot2.png', width=480, height=480)

barplot(height=baltimoreData$Emissions,
        names.arg=baltimoreData$year,
		xlab="Year",
		ylab="PM2.5 Total Emissions",
		main="PM2.5 Baltimore Total Emissions by Year")

dev.off()