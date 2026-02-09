library(dplyr)
library(lubridate)

streamH <- read.csv("/cloud/project/activtiy02/stream_gauge.csv")

siteInfo <- read.csv("/cloud/project/activtiy02/site_info.csv")
##In class Section
#Prompt 1:
left_j  <- left_join(streamH, siteInfo, by="siteID")
head(left_j)
right_j <- right_join(streamH, siteInfo, by="siteID")
head(right_j)
inner_j <- inner_join(streamH, siteInfo, by="siteID")
head(inner_j)
# join site info and stream heights into a new data frame floods
floods <- full_join(streamH, # left table
                    siteInfo, # right table
                    by="siteID") # common identifier
head(floods)
#For this dataset the type of join does not change the outcome of the table.

#Prompt 2:
floods$dateF <- ymd_hm(floods$datetime, tz="America/New_York")

#Prompt 3:
temp <- floods %>%
  group_by(siteID) %>%
  filter(gheight.ft >= flood.ft) %>%
  filter(dateF == min(dateF))
  
print(temp$dateF)
#FISHEATING CREEK AT PALMDALE: "2017-09-11 03:00:00 EDT"
#Peace River: 2017-09-08 00:00:00 EDT
# WITHLACOOCHEE RIVER: 2017-09-11 08:15:00 EDT


#HW Section
#Question 1

#Plotting each river data
#fish eating River
fisheating <- floods %>%
  filter(siteID == 2256500)
plot(fisheating$dateF, fisheating$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)")

#peace river
peace <- floods %>%
  filter(siteID == 2295637)
plot(peace$dateF, peace$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)")

#Santa Fe
sf <- floods %>%
  filter(siteID == 2322500)
plot(sf$dateF, sf$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)")

#WITHLACOOCHEE RIVER
w <- floods %>%
  filter(siteID == 2312000)
plot(w$dateF, w$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)")


#Question 2
#FISHEATING CREEK AT PALMDALE: "2017-09-11 03:00:00 EDT"
#Peace River: 2017-09-08 00:00:00 EDT
# WITHLACOOCHEE RIVER: 2017-09-11 08:15:00 EDT


#Question 3
most_major <- floods %>% #filter floods
  group_by(names) %>% # group by name
  filter(gheight.ft >= major.ft) #observations with height more than or equal to the major flood height

most_major$names[which.max(most_major$gheight.ft-most_major$major.ft)]
print(max(most_major$gheight.ft-most_major$major.ft))
#Peace River

#Question 4












