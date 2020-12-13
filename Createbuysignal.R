#install packages
  
library(quantmod)
library(tidyverse)

#pull down data from yahoo finance

amzn <- getSymbols("AMZN", auto.assign = F) 

#extract adjusted close data

amzn_cl <- amzn$AMZN.Close

#remove scientific notation

options(scipen = 9999)

#calculate daily % change

daily_change <- amzn_cl/stats::lag(amzn_cl, k = 1) -1
head(daily_change, 20)

#histogram of the daily return

hist(daily_change, 100, col = "darkgreen")

#choosing an easy signal filter

buy_signal <- .05

#create a for loop
signal <- c(NULL)

for(i in 2:length(amzn_cl)) {
  if(daily_change[i] > buy_signal) {
    signal[i] <- 1
   } else 
     signal[i] <- 0
}

head(signal,40)

#combine signal data to dates

signal <- reclass(signal, amzn_cl)

#create a graph with buy signal

chartSeries(amzn_cl,
            type = "l",
            subset = "2015-01::2020-01",
            theme = chartTheme("white"))
addTA(signal, type = "S", col = "red")
  
  
  
  
  
  
  



