################################################################
#
#      Web scraping current SP+ data from footballoutsiders.com
#
#                          By Ryan Berger
#                            7-26-18
#
#      Purpose: Scrape the most recent SP+ data, convert into a  
#               dataframe, and save as a csv file.
#     
#      Adapted from David Radcliffe (https://rpubs.com/Radcliffe/superbowl)
################################################################

library(rvest)
library(stringr)
library(tidyr)
library(magrittr)

# Scrape multi year data

sp_full <- NULL
years <- 2005:2017

for(year in years){
## Scrape the data using rvest
# Set url for site to scrape
url <- paste0('http://www.footballoutsiders.com/stats/ncaa', year)

# Extract the table using html_table
sp_table <- html_nodes(read_html(url), 'table')
sp <- html_table(sp_table,header = TRUE)[[1]]

# Select only the first 10 columns. ** Columns change in older versions of site
sp <- sp[,1:10]

# Add year column
sp$Year <- year

sp_full <- rbind(sp_full, sp)

# Monitor progress
print(paste(year, 'done'))
}

head(sp_full)

## Clean up the data:
# Remove the extra column titles in the chart. These show up every 26 rows
sp_full <- filter(sp_full, Team != 'Team')


# 3 columns have same title (Rk). Change the names of the rank columns to prevent error 
colnames(sp_full)[c(6,8,10)] <- c('sp rank', 'off rank','def rank')

# Separate wins and losses into their own columns
sp_full <- separate(sp_full, 
                    Rec., 
                    c('W','L'),
                    sep = '-',
                    remove = TRUE)

#Remove % sign from percentile
sp_full$`S&P+(Percentile)` <- sub('%', 
                                  '', 
                                  sp_full$`S&P+(Percentile)`)

# Separate 2nd order wins and differential
# Rename column first
colnames(sp_full)[4] <- 'second_order_w'
sp_full <- separate(sp_full, 
                    second_order_w, 
                    c('second_order_w','Differential'),
                    sep = ' ', 
                    remove = TRUE)


# Remove parentheses from differential column
sp_full$Differential <- sub(pattern = '\\(', 
                            replacement = '', 
                            x=sp_full$Differential)

sp_full$Differential <- sub(pattern = '\\)', 
                            replacement = '', 
                            x=sp_full$Differential)

# Make all columns except team name numeric data instead of character
sp_full[,2:12] <- lapply(sp_full[,2:12], as.numeric)


str(sp_full)



# Save output
write.csv(sp_full, file = '../data/sp_data.csv', row.names = F)


# Clean up
rm(list = ls())

sp_full$`Off. S&P+`


# Normalize SP+ data
# Want to normalize data on a 0-100 scale where 100 is the average SP+ margin for
# the best team over the full history of SP+ and 0 is the worst team
# Need to find the average max and min by year

margins <- NULL
for(i in 2005:2017){
  temp <- filter(sp_full, Year == i)
  # Overall margin
  maxsp <- c(Max_margin = max(temp$`S&P+(Margin)`))
  minsp <- c(Min_margin = min(temp$`S&P+(Margin)`))
  
  # Offense margin
  offmax <- c(Max_offense = max(temp$`Off. S&P+`))
  offmin <- c(Min_offense = min(temp$`Off. S&P+`))
  
  # Defense margin
  defmax <- c(Max_defense = max(temp$`Def. S&P+`))
  defmin <- c(Min_defense = min(temp$`Def. S&P+`))
  
  # Combine together
  yeardf <- c(i, maxsp, minsp, offmax, offmin, defmax, defmin)
  margins <- rbind(margins, yeardf) %>% 
    as.data.frame()

}
margins

# Set up max and min for overall, offense, and defense
max1 <- mean(margins$Max_margin)
min1 <- mean(margins$Min_margin)

omax1 <- mean(margins$Max_offense)
omin1 <- mean(margins$Min_offense)

dmax1 <- mean(margins$Max_defense)
dmin1 <- mean(margins$Min_defense)

# Create normalized columns
str(sp_full)
sp_normalized <- sp_full
# Overall rating normalized
sp_normalized$margin_norm <- round(100*(sp_normalized$`S&P+(Margin)` - min1)/(max1 - min1),1)

# Offense rating normalized
sp_normalized$off_norm <- round(100*(sp_normalized$`Off. S&P+` - omin1)/(omax1 - omin1), 1)  
# Defense rating normalized
sp_normalized$def_norm <- round(100-100*(sp_normalized$`Def. S&P+` - dmin1)/(dmax1 - dmin1), 1)


# Save normalized data
write.csv(sp_normalized, file = '../data/sp_data_norm.csv', row.names = F)
