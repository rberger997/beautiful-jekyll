#'---
#' layout: post
#' title: "Signing of the stars - How much does recruiting matter in college football?"
#' author: "Ryan Berger"
#' date: "`r Sys.Date()`"
#' output: 
#'   html_document:
#'     theme: spacelab	
#'     highlight: tango	
#'     keep_md: true
#' preserve_yaml: true
#' ---


#+ libraries, echo=F, message=F, warning=F
library(dplyr)
library(ggplot2)
library(ggpmisc)
library(ggrepel)
library(ggthemr)
library(here)
library(Hmisc)
library(knitr)


# Set figure height/width
opts_chunk$set(fig.width = 12, fig.height = 8)


#+ source_script, echo=F, message=F, warning=F
# Load recruiting data, SP+ dataset, and postseason data
rec <- read.csv(file = here('/data/recruiting_data_long.csv')) %>% 
  select(-X)
sp <- read.csv(file = here('data/sp_data.csv'))
post <- read.csv(file = here('data/cfb_postseason.csv'))


#### data_processing
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


# Get win/loss data from SP+ data
wl <- select(sp, c(Team, W, L,Year)) 

# Combine win/loss with recruiting data
cfb <- inner_join(rec, wl, by = Cs(Team, Year))

# Check for missing data
# table(is.na(cfb))

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
            playoff_apps = sum(playoff),
            title_games = sum(title_game),
            Nat_champ = sum(natl_champ)) %>% 
  as.data.frame() %>% 
  arrange(-Avg.rec)

# Round averages
avgs[,2:6] <- avgs[,2:6] %>% 
  round(., 1)



# Recruiting plot
ggthemr(palette = 'fresh')
rec_plot <- ggplot(data = avgs, aes(x=Avg.rec, y=Avg.W))+
  geom_point(aes(size = Nat_champ))+
  xlab('Average recruiting score \n(247 Composite)')+
  ylab('Average wins per season')+
  labs(title = 'NCAA Football Wins vs Recruting Score',
       subtitle = '2008-2017')+
  geom_smooth(method = 'lm', col ='red')+
  geom_text_repel(data = subset(avgs, Avg.W >= 10), aes(label = Team), size=5)+
  geom_text(data = subset(avgs, Team %in% c('Virginia', 'Arizona')), aes(label = Team), size=5)+
  stat_poly_eq(formula = avgs$Avg.W ~ avgs$Avg.rec, 
               aes(label = paste(..eq.label.., 
                                 ..rr.label.., 
                                 sep = "~~~")), parse = TRUE,
               label.x = 275,
               label.y = 2.5) +
  theme(axis.text=element_text(size=18),
        plot.title = element_text(size=24,face = 'bold'),
        plot.subtitle = element_text(size = 18),
       axis.title=element_text(size = 20,face="bold"))


# ggthemr_reset()


# Table of recruiting results by team
rec_by_team_table <- kable(avgs)



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
champ_game_table <- kable(final, 
                          caption = 'College Football Championship Game (2008-2017)')



# Average rank and recruting score of winners/losers
champ_avg_rank <- mean(final$Avg.rank)
runnerup_avg_rank <- mean(final$Avg.rank.1)

champ_avg_rec <- mean(final$Avg.rec)
runnerup_avg_rec <- mean(final$Avg.rec.1)



# 2018 teams that fit averages for title game participants
contenders_2018_table <- filter(rec, Year %in% 2015:2018) %>% 
  group_by(Team) %>% 
  summarise(Avg.rec = round(mean(value),1),
            Avg.rank = round(mean(rank),1)) %>% 
  arrange(-Avg.rec) %>% 
  filter(Avg.rec > 260 & Avg.rank < 11 ) %>% 
  kable(., caption = '2018 Championship Contenders')


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



#+ writeup

#' With the start of a new college football season just a few weeks away, I've been thinking about a question I've heard for many years in one form or another: how much does recruiting matter? Like it or not, football recruiting has turned into a big business that public universities are pouring millions of dollars into. Even casual fans have probably noticed that recently there's been a lot of attention paid to football recruiting on TV, websites, blogs, message boards, and social media but is it really important for on field success? Does grabbing the headlines on signing day in February lead to taking home the hardware in December and January? 
#' 
#' 
#' The dominance of Nick Saban's Alabama teams on both the recruiting trail and the gridiron over the last decade suggests the answer to these questions is yes, but I want to go a step further and investigate the data for all 129 teams in division I to see its full effects. Using recruiting data and team records from the last ten years, let's take a look at how much recruiting matters in college football.
#' <br><br>
#' 
#' ## The data
#' ### Recruiting
#' When it comes to the best recruiting data for college football, there is no substitute for [247Sports](https://247sports.com/Season/2019-Football/CompositeTeamRankings/). Their rating system generates composite player ratings for roughly 4000 high school football players every year and creates class ratings for each team using a weighted Gaussian distribution formula of the individual player composites (Translation: 247Sports takes recruiting pretty seriously). Let's take a look at the distribution of every recruiting class rating over the last 10 seasons:

#+ rec_hist, echo=F
hist(rec$value,
     col='gray',
     main = 'NCAA football team recruiting class ratings \n 2008-2017',
     xlab = '247Sports composite team score')

#' The recruiting class ratings look like a normal distribution (slightly right-skewed) with the center around 150. For the analysis, I've calculated the average class ratings for all division I teams for the last 10 years and will use these to quantify the amount of talent potential that each team has brought in.
#'
#'
#' ### Wins
#' Since football is above all a win/loss business, it seemed like a natural choice to use wins per year as the metric for team success. This doesn't take into account strength of schedule differences between teams or Power 5 conferences vs. Group of 5 conferences but should be sufficient for a first look. I gathered the win/loss data for each team from 2008 to 2017 by writing a [script](link) to scrape the data from [football outsiders](https://www.footballoutsiders.com/stats/ncaa). The distribution of annual win totals is as follows:

#+ Wins_histogram, echo=F
wins_hist <- hist(sp$W,
                  col='slategray',
                  main = 'NCAA football team win totals \n 2008-2017',
                  xlab = 'Wins')

#' <br><br>
#' 
#' 
#' ## Average recruiting by NCAA teams (2008-2017)
#+ table1, echo=F
rec_by_team_table

#' Looking at the table, it's pretty clear that the schools with higher recruiting class averages at the top of the table have a lot more success than those further down. Alabama is the clear leader in both recruiting and wins as they averaged 12.5(!) wins per year on an average recruiting rating of 303.7. This has led to a decade of dominance as the Crimson Tide have appeared in all four College Football Playoffs, six national championship games, and have taken home the trophy as national champs five times.
#' 
#' 
#' Looking at the table more broadly, the average wins per year typically decreases as you move down. We can see this by looking at the average annual win totals for descending groups of 25 schools:
#' 
#' * 1-25: `r round(mean(avgs[1:25,'Avg.W']),2)`
#' * 26-50: `r round(mean(avgs[26:50,'Avg.W']),2)` 
#' * 51-75: `r round(mean(avgs[51:75,'Avg.W']),2)` 
#' * 76-100: `r round(mean(avgs[76:100,'Avg.W']),2)` 
#' * 101-129: `r round(mean(avgs[101:129,'Avg.W']),2)`
#'
#' This trend suggests there's a linear relationship between wins and recruiting. We can visualize this by plotting the two together and assess how strong the relationship is across all the data by adding a linear regression trendline. <br><br>

#+ plot1, echo=F
rec_plot

#'<br><br>
#' From the plot we can clearly see the trend we observed in the table: there is a positive linear relationship that supports the idea that better recruiting leads to more wins (as we would expect). Additionally, by using a linear model we can quantify the effect that recruiting has on winning over the course of 10 seasons: the coefficient of determination (${R^2}$) is 0.38, meaning that recruiting accounts for 38% of the variance in win totals. When you consider the number of factors that determine the outcome of a football season (coaching, strategy, injuries, etc.), 38% seems like a significant amount of influence. At the same time, it tells us that recruiting isn't everything; there is still a lot of work to be done off the recruiting trail to be successful.
#'
#'
#' It also appears from the plot that for schools with recruiting scores under 250, and especially those under 200, there is a lot of variability in win totals. In this range, there is a lot of scatter above and below the trendline and teams with very similar recruiting profiles can have drastically different win totals. Take for example Wisconsin, Arizona, and Virginia. All three schools have averaged a 247 recruiting score of 186 with the Badgers averaging 10 wins per year, Arizona 7, and UVA 4.3. These differences illustrate how mid-level recruiting can lead to variable on field results and hints toward the importance of coaching and player development in building a strong team and winning games.
#' 
#' 
#' ## Elite teams come from elite recruiting
#' While the middle class of recruiting offers mixed results, there is one thing that is very clear from the data: the very best teams in college football are built on a foundation of elite recruting. Looking at the plot, schools that average recruiting classes above 250 on the 247 composite score are typically the ones that win national championships. This is the recruiting range where perennial powers Alabama, Ohio State, Florida State, and Oklahoma typically reside.
#' 
#' 
#' We can take this a step further and focus in on all the teams that have made it to the championship game but instead of looking at their 10 year averages, let's look at how well they recruited in the four years leading up to that championship game appearance. We can then use this data to build a recruiting profile of what championship caliber teams generally look like to assess current and future teams.

#+ table2, echo=F
champ_game_table


#' Focusing on the title game shows just how important recruiting is in bringing home a national championship; in the last 10 years, the team with the higher recruiting average has won 8 of 10 titles. Additionally, only two teams won a championship with an average class rating under 250 -- 2009 Alabama and 2010 Auburn. For these two teams it's notable to point out that (1) both had the Heisman trophy winner on their team (Mark Ingram, Cam Newton) and (2) both got a bit lucky with regards to their title game opponent -- Texas QB and Heisman finalist Colt McCoy got injured on the first drive against Alabama and the 2010 Oregon team that faced Auburn took the field with by far the lowest recruiting class average (206.7) of any championship game participant over the last 10 years. The overall message is clear: to win a national championship you need elite recruiting classes or else you'll *really* need some things to go your way.
#' 
#' 
#' ## Looking ahead: championship contenders for 2018
#' So far this analysis has been looking back at results from the last 10 years but what do these data tell us about the upcoming season? Specifically, which teams have the recruiting profile to make the championship game or win it? To adress these questions let's use the data in the table to define what a champion and runner-up typically looks like over the 4 years leading up to their title run: 
#' 
#' * Champion:
#'     + Avg recruiting class score: **`r champ_avg_rec`**
#'     + Avg national class rank: **`r champ_avg_rank`**
#' * Runner-up:
#'     + Avg recruiting class score: **`r runnerup_avg_rec`**
#'     + Avg national class rank: **`r runnerup_avg_rank`**
#'     
#' Past results tell us that a team needs to have a four year recruiting average of 260 to make the championship game and 275 to win it. Looking ahead to the 2018 season, let's see which teams are national title contenders by these criteria.
#'
#'
#+ contenders, echo=F
contenders_2018_table

#' <br><br>
#' Out of 129 division I teams, only 8 have the general makeup of a champion for this year. Alabama once again leads the way with the highest recruiting average, but the margin is very close between the Tide, Ohio State, and Georgia in the top three. 
#' 
#' This recruiting profile is by no means a predictive model but it still tends to agree with the general consensus on who the top contenders are for this season. As of this writing, the Vegas odds for these teams to win the championship are:
#' 
#'  * Alabama 2-1
#'  * Clemson 9-2
#'  * Ohio State 8-1
#'  * Georgia 10-1 
#'  * Auburn 33-1
#'  * Florida State 50-1
#'  * USC 66-1
#'  * LSU 66-1
#' 
#' (Gamblers note: Judging from their odds and recruiting profiles, it looks like Auburn, Florida State, USC, and LSU are good value bets for 2018.)
#' 
#' 
#' 
#' ## Final Thoughts
#' The takeaway points from this analysis should be as follows:
#' 
#' * In general, better recruiting leads to more wins.
#' * Mid-level recruiting leads to large variations in win totals.
#' * Recruiting success is critical in winning national championships 
#'     + To contend for championships, you generally need top 10 recruiting classes.
#'     + To win championsips, you generally need top 6 recruiting classes.
#'     
#'
#' An important thing to keep in mind is that these results are based on a relatively small sample size (10 seasons) and by nature ignore a lot of important factors that are involved in team success.
#' 
#' Also, while the recruting profiles give insight into what a champion contender typically looks like, I like to think of them as more of a tool to set expectations rather than make predictions. In this mindset, fans of all eight teams identified as championship contenders should *expect* to be in the running for a title while fans of teams outside that list would be *very lucky* to see their team win a title. This idea of expectations based on recruiting is something I'll address further in a future post.
#' 
#' 
#' **This post was written in R. To see the full source, click [here](link)**




#+ post-entry, include=F
# source('~/Desktop/My files/blog/rberger997.github.io/src/convert-R-to-post.R')
# Post.to.blog('2018-07-30-cfb-project.R')

# rmarkdown::render(here('src/2018-07-30-cfb-project.R'))


#+ extra_intro, include=F
# With a new college football season just a few weeks away, fans across the country are filled with hope and optimism that 2018 is the year for their favorite school. "This is the year that we put it all together, beat our rivals, and make a run for the championship!" While this dream will come true for one team, the other 128 division I teams will be walking away with something other than the national championship trophy. In fact as we sit here today, the odds of winning the championship for all but a few teams are close to zero. But why?
# similar win totals can be obtained despite different levels of recruiting. The plot is labeled for all teams that averaged 10 or more wins per season over this time span and you'll notice how Wisconsin and Florida State have averaged similar win totals despite the Seminoles pulling in recruiting classes that are nearly 100 points better on the 247 composite score. Boise State also averaged more than 11 wins per season with lesser recruiting classes but played against weaker competition in the the WAC and Mountain West conferences than the other 10+ win teams faced.
# 

# Alabama has been by far the most dominant and successful team over the last decade with five national championships and an average of 12.5 games per year and have done so by outrecruiting the rest of college football by a wide margin.

# It's also noteworthy to point out that this correlation is pretty weak; the coefficient of determination (${R^2}$) is 0.38, meaning that recruiting only accounts for 38% of the variance in wins. This seems to makes sense considering there are a ton of other factors that determine the winners of 10 years worth of football games (coaching, strategy, injuries, etc.) and so it shouldn't be too surprising that recruiting isn't everything.

