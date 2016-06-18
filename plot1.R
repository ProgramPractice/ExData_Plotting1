# Loading the full data, removing the data with question marks
load_data <- function() {
  filename <- "household_power_consumption.txt"
  df <- read.table(filename,
                   header=TRUE,
                   sep=";",
                   colClasses=c("character", "character", rep("numeric",7)),
                   na="?")
  
  # convert date and time variables
  df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
  df$Date <- as.Date(df$Date, "%d/%m/%Y")
  
  # Filter the query for the dates 2007-02-01 and 2007-02-02
  dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
  df <- subset(df, Date %in% dates)
  
  return(df)
}

graph1 <- function(data=NULL) {
    if(is.null(data))
        data <- load_data()
    
    png("plot1.png", width=480, height=480)
    
    hist(data$Global_active_power,
         main="Global Active Power",
         xlab="Global Active Power (kilowatts)",
         ylab="Frequency",
         col="red")
    
    # shuts down the specified (by default the current) device
    dev.off()
}

graph1()

# Another method to copy graph to png file
#dev.copy(png, file="plot1.png", width=480, height=480)

# Output the file path of the png file
cat("Plot1.png has been saved in", getwd())

