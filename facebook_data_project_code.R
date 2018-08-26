rm(list = ls())

setwd("C:\\Users\\Samwet\\Documents\\R\\Facebook Data Project")

library(rjson)

friend_list <- fromJSON(file = "friends.json")


friend_names <- matrix(1:546,546,1)
friend_timestamp <- matrix(1:546,546,1)

for (i in 1:546){

  friend_names[i] <- friend_list$friends[[i]]$name
  friend_timestamp[i] <- friend_list$friends[[i]]$timestamp
  
}

friends_data <- data.frame(cbind(friend_names,friend_timestamp))
names(friends_data) <- c("Name","Timestamp")
View(friends_data)


friends_data$Timestamp <- as.numeric(as.character(friends_data$Timestamp))

friends_data$Date_With_Time <- as.POSIXct(friends_data$Timestamp, origin = "1970-1-1")
friends_data$Date <- as.Date(friends_data$Date_With_Time)
friends_data$Number_Of_Friends <- 546:1

plot(friends_data$Date,friends_data$Number_Of_Friends)

library(ggplot2)

gph <- ggplot(friends_data, aes(x = Date, y = Number_Of_Friends)) + geom_point(color="dodgerblue") + 
labs(title = "Facebook Friends Growth With Time", y ="Number of Friends", x = "Time",
caption = "Credits: R Studio & Samwet Dutta") + theme_light()
gph
