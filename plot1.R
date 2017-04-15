#if (file.exists("summarySCC_PM25.rds")) {
if ("summarySCC_PM25.rds" %in% dir() == TRUE) {
    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
}

#if (file.exists("Source_Classification_Code.rds")) {
if ("Source_Classification_Code.rds" %in% dir() == TRUE) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

#This works but does stress the computer somewhat
#barplotData <- aggregate(Emissions ~ year, NEI, sum)

# separate by year to avoid long computations that hang R console
y1999<-sum(subset(NEI, year==1999)$Emissions)
y2002<-sum(subset(NEI, year==2002)$Emissions)
y2005<-sum(subset(NEI, year==2005)$Emissions)
y2008<-sum(subset(NEI, year==2008)$Emissions)

Emissions<-c(y1999,y2002,y2005,y2008)
year<-c(1999,2002,2005,2008)
barplotData = data.frame(year, Emissions)

png('plot1.png', width=480, height=480)

barplot(height=barplotData$Emissions,
        names.arg=barplotData$year,
		xlab="Year",
		ylab="PM2.5 Total Emissions",
		main="PM2.5 Total Emissions by Year")

dev.off()