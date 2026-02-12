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
     ylab = "Stage height (ft)", main="Fisheating Creek")

#peace river
peace <- floods %>%
  filter(siteID == 2295637)
plot(peace$dateF, peace$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)", main="Peace River")

#Santa Fe
sf <- floods %>%
  filter(siteID == 2322500)
plot(sf$dateF, sf$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)", main="Santa Fe")

#WITHLACOOCHEE RIVER
w <- floods %>%
  filter(siteID == 2312000)
plot(w$dateF, w$gheight.ft, type="b", pch=19, xlab="Date",
     ylab = "Stage height (ft)", main="Withlacoochee River")


#Question 2
#FISHEATING CREEK AT PALMDALE: "2017-09-11 03:00:00 EDT"
#Peace River: 2017-09-08 00:00:00 EDT
# WITHLACOOCHEE RIVER: 2017-09-11 08:15:00 EDT
#Action Times
fish_action <- fisheating %>%
  filter(gheight.ft >= action.ft) %>%
  filter(dateF == min(dateF))
print(fish_action$dateF)
#2017-09-08 EDT
peace_action <- peace %>%
  filter(gheight.ft >= action.ft) %>%
  filter(dateF == min(dateF))
print(peace_action$dateF)
#2017-09-08 EDT
sf_action <- sf %>%
  filter(gheight.ft >= action.ft) %>%
  filter(dateF == min(dateF))
#None
w_action <- w %>%
  filter(gheight.ft >= action.ft) %>%
  filter(dateF == min(dateF))
print(w_action$dateF)
#2017-09-10 20:00:00 EDT
#Moderate Times
fish_moderate <- fisheating %>%
  filter(gheight.ft >= moderate.ft) %>%
  filter(dateF == min(dateF))
print(fish_moderate$dateF)
#2017-09-11 14:45:00 EDT
peace_moderate <- peace %>%
  filter(gheight.ft >= moderate.ft) %>%
  filter(dateF == min(dateF))
print(peace_moderate$dateF)
#"2017-09-10 18:00:00 EDT"
sf_moderate <- sf %>%
  filter(gheight.ft >= moderate.ft) %>%
  filter(dateF == min(dateF))
#None
w_moderate <- w %>%
  filter(gheight.ft >= moderate.ft) %>%
  filter(dateF == min(dateF))
print(w_moderate$dateF)
#2017-09-12 08:00:00 EDT

#Major
major <- floods %>%
  group_by(siteID) %>%
  filter(gheight.ft >= major.ft) %>%
  filter(dateF == min(dateF))
print(major$dateF)
#Fisheating: 2017-09-12 02:00:00 EDT
#PEace:2017-09-10 22:00:00 EDT"
#W:2017-09-16 20:00:00 EDT
#Question 3
most_major <- floods %>% #filter floods
  group_by(names) %>% # group by name
  filter(gheight.ft >= major.ft) #observations with height more than or equal to the major flood height

most_major$names[which.max(most_major$gheight.ft-most_major$major.ft)]
print(max(most_major$gheight.ft-most_major$major.ft))
#Peace River

#Question 4












