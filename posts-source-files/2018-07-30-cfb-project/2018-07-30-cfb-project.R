#'---
#' layout: post
#' title: "Signing of the stars - How much does recruiting matter in college football?"
#' subtitle:"A data exploration"
#' author: "Ryan Berger"
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document:
#'     theme: spacelab	
#'     highlight: tango	
#'     keep_md: true
#' preserve_yaml: true
#' ---



#+ Outline, include=F
# Outline of this post:
# Question: How much does recruting matter in college football?
# - Plot of Wins vs recruiting score 
#   - Shows that recruiting leads to winning
# - Table of postseason results
#   - Shows that results come from elite recruiting
# - Table of champions/runner ups (narrow down on champions)
#   - Shows that to make the title game takes elite recruting
# - Table of 2018 teams
#   - Show the teams that fit the title game profile of last 10 years




#' 
#' With the start of a new college football season just a few weeks away, I've been thinking about a question I've heard for many years in one form or another: how much does recruiting matter? Recently there's been a lot of attention paid to football recruiting on TV, websites, blogs, message boards, and social media but is it really important? Does grabbing the headlines on signing day in February lead to a team taking home the hardware in December and January? 
#' 
#' <br><br>
#' The short answer to these questions is yes, recruiting is important for team success on a national level, but I want to go a step further and investigate the data to quantify its effects. Using recruiting data and team records from the last ten years, let's take a look at how much recruiting matters.
#' <br><br>
#' 
#' ## The data
#' When it comes to the best recruiting data for college football, there is no substitute for the [247Sports composite rating](https://247sports.com/Season/2019-Football/CompositeTeamRankings/). This rating system generates composite player ratings for roughly 4000 high school football players every year and creates team ratings using a weighted Gaussian distribution formula of the individual player composites. I've compiled the team class ratings for the last 10 years and will use these to quantify the recruiting talent brought in by each team.
#' <br><br>
#' I've also gathered the win/loss data for each team over the last decade by web scraping the [football outsiders advanced NCAA stats page](https://www.footballoutsiders.com/stats/ncaa) (source file [here](**insert_github_link**).
#' 
#' 
#' 





#+ libraries, echo=F
library(dplyr)
library(ggplot2)
library(ggpmisc)
library(ggrepel)
library(ggthemr)
library(here)
library(Hmisc)
library(knitr)



#+ load_data, echo=F
# Load recruiting data and SP+ dataset
rec <- read.csv(file = 'data/recruiting_data_long.csv') %>% 
  select(-X)
sp <- read.csv(file = 'data/sp_data.csv')


# Add class rank to recruiting data
newrec <- NULL
for(year in 2002:2018){
  temp <- filter(rec, Year == year) %>% 
    arrange(-value)
  temp$rank <- 1:nrow(temp)
  newrec <- rbind(newrec, temp)
  rm(temp)
}
rec <- newrec


# Load postseason data
post <- read.csv(file = 'data/cfb_postseason.csv')

# Get win/loss data from SP+ data
wl <- select(sp, c(Team, W, L,Year)) 

# Combine win/loss with recruiting data
cfb <- inner_join(rec, wl, by = Cs(Team, Year))

# Check for missing data
table(is.na(cfb))
# Remove missing data
cfb <- cfb[complete.cases(cfb),]
# Join with postseason data
cfb <- left_join(cfb, post, by = Cs(Team, Year))
cfb[is.na(cfb)] <- 0

# Get average W/L, recruiting, and SP+ for each team for last 10 years
avgs <- cfb %>% 
  filter(Year >= 2008) %>% 
  group_by(Team) %>% 
  summarise(Avg.rec = mean(value),
            Avg.rec_rank = mean(rank),
            Avg.W = mean(W), 
            Avg.L = mean(L),
            Nat_champ = sum(natl_champ),
            title_games = sum(title_game),
            playoff_apps = sum(playoff)) %>% 
  as.data.frame() %>% 
  arrange(-Avg.rec)



# Round averages
avgs[,2:6] <- avgs[,2:6] %>% 
  round(., 1)


ggthemr(palette = 'fresh')


ggplot(data = avgs, aes(x=Avg.rec, y=Avg.W))+
  geom_point()+
  xlab('Average recruiting score \n(247 Composite)')+
  ylab('Average wins per season')+
  labs(title = 'NCAA Football Wins vs Recruting Score',
       subtitle = '2008-2017')+
  geom_smooth(method = 'lm', col ='red')+
  geom_text_repel(data = subset(avgs, Avg.W >= 10), aes(label = Team))+
  stat_poly_eq(formula = avgs$Avg.W ~ avgs$Avg.rec, 
               aes(label = paste(..eq.label.., 
                                 ..rr.label.., 
                                 sep = "~~~")), parse = TRUE,
               label.x = 275,
               label.y = 2.5)



# library(plotly)
# ggplotly(p=ggplot2::last_plot(), originalData = T, dynamicTicks = F)

ggthemr_reset()


#+ table1, echo=F
# Table of results
knitr::kable(avgs)


#+ dataprep2, echo=F
# Generate a table that shows the title game winner/loser 
# Calculate average recruiting class/rank over 4 years leading up to title game
title <- filter(cfb, title_game == 1) %>% 
  arrange(natl_champ | year)

titlegame <- NULL
for(i in 1:nrow(title)){
  team <- title[i, 'Team']
  year.hi <- title[i, 'Year']
  year.lo <- year.hi - 4
  temp <- filter(cfb, Team == team & Year %in% year.lo:year.hi) %>% 
    summarise(Year = year.hi,
              Team = team,
              Avg.rec = round(mean(value), 1),
              Avg.rank = round(mean(rank), 1))
  temp$Result <- title[i, "natl_champ"]
  
  titlegame <- rbind(titlegame, temp)
}

# Separate champs/runner ups
champs <- filter(titlegame, Result == 1)
runnerup <- filter(titlegame, Result == 0)

# Combine champs/runner ups into columns
final <- cbind(champs, runnerup)
final <- final[,-c(5:6,10)]
colnames(final)[c(2,5)] <- c('Champion', 'Runner up')

# Calculate recruiting difference between winner and loser
final$Difference <- final$Avg.rec - final$Avg.rec.1


# Championship game table
knitr::kable(final)

mean(final$Avg.rank)
mean(final$Avg.rank.1)

mean(final$Avg.rec)
mean(final$Avg.rec.1)


# 2018 teams that fit averages for title game participants
filter(rec, Year %in% 2015:2018) %>% 
  group_by(Team) %>% 
  summarise(Avg.rec = round(mean(value),1),
            Avg.rank = round(mean(rank),1)) %>% 
  arrange(-Avg.rec) %>% 
  filter(Avg.rec > 260 & Avg.rank < 11 ) %>% 
  knitr::kable()


#+ post-entry, include=F
# source('~/Desktop/My files/blog/rberger997.github.io/src/convert-R-to-post.R')
# Post.to.blog('2018-07-30-cfb-project.R')




#+ extra_intro, include=F
# With a new college football season just a few weeks away, fans across the country are filled with hope and optimism that 2018 is the year for their favorite school. "This is the year that we put it all together, beat our rivals, and make a run for the championship!" While this dream will come true for one team, the other 128 division I teams will be walking away with something other than the national championship trophy. In fact as we sit here today, the odds of winning the championship for all but a few teams are close to zero. But why?