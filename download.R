fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./project.zip", method = "curl")

dateDownloaded <- date()

unzip("project.zip")

