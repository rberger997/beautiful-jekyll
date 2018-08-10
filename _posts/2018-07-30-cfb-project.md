---
layout: post
title: "Signing of the stars: how much does recruiting matter in college football?"
author: "Ryan Berger"
date: "2018-08-08"
bigimg: /img/uga.JPG
output: 
  html_document:
    theme: spacelab	
    highlight: tango	
    keep_md: true
preserve_yaml: true
---






With the start of a new college football season just a few weeks away, I've been thinking about a question I've heard for many years in one form or another: how much does recruiting matter? Like it or not, football recruiting has turned into a big business that public universities across the country are pouring millions of dollars into. Even casual fans have probably noticed that recently there's been a lot of attention paid to football recruiting on TV, websites, blogs, message boards, and social media but is it really important for on field success? Does grabbing the headlines on signing day in February lead to taking home the hardware in December and January? 


The dominance of Nick Saban's Alabama teams on both the recruiting trail and the gridiron over the last decade suggests the answer to these questions is yes, but I want to go a step further and investigate the data for all 129 teams in division I to see its full effects. Using recruiting data and team records from the last ten years, let's take a look at how much recruiting matters in college football.
<br><br>

## The data
### Recruiting
When it comes to the best recruiting data for college football, there is no substitute for [247Sports](https://247sports.com/Season/2019-Football/CompositeTeamRankings/). Their rating system generates composite player ratings for roughly 4000 high school football players every year and creates class ratings for each team using a weighted Gaussian distribution formula of the individual player composites (Translation: 247Sports takes recruiting pretty seriously). Let's take a look at the distribution of every recruiting class rating over the last 10 seasons:

![center](https://rberger997.github.io/img/2018-07-30-cfb-project/rec_hist-1.png)

The recruiting class ratings look like a normal distribution (slightly right-skewed) with the center around 150. For the analysis, I've calculated the average class ratings for all division I teams for the last 10 years and will use these to quantify the amount of talent potential that each team has brought in.


### Wins
Since football is above all a win/loss business, it seemed like a natural choice to use wins per year as the metric for team success. This doesn't take into account strength of schedule differences between teams or Power 5 conferences vs. Group of 5 conferences but should be sufficient for a first look. I gathered the win/loss results for each team from 2008 to 2017 by [scraping](https://github.com/rberger997/rberger997.github.io/blob/master/posts-source-files/2018-07-30-cfb-project/web_scrape_sp_data.R) the data from [football outsiders](https://www.footballoutsiders.com/stats/ncaa). The distribution of annual win totals is as follows:

![center](https://rberger997.github.io/img/2018-07-30-cfb-project/Wins_histogram-1.png)

<br><br>
Putting these datasets together, let's look at the average recruiting class rating and wins per year for all 129 teams in division I football.

## Average recruiting by NCAA division I schools (2008-2017)


|Team                  | Avg.rec| Avg.rec_rank| Avg.W| Avg.L| playoff_apps| title_games| Nat_champ|
|:---------------------|-------:|------------:|-----:|-----:|------------:|-----------:|---------:|
|Alabama               |   303.7|          1.7|  12.5|   1.4|            4|           6|         5|
|Ohio State            |   282.0|          5.7|  11.2|   2.1|            2|           1|         1|
|USC                   |   281.9|          6.1|   9.4|   3.8|            0|           0|         0|
|Florida State         |   280.6|          5.6|  10.1|   3.3|            1|           1|         1|
|LSU                   |   277.3|          6.7|   9.5|   3.4|            0|           1|         0|
|Georgia               |   275.5|          7.3|   9.5|   3.9|            1|           1|         0|
|Florida               |   268.3|          9.3|   8.6|   4.3|            0|           1|         1|
|Texas                 |   267.1|          9.9|   7.8|   5.0|            0|           1|         0|
|Notre Dame            |   259.1|         11.3|   8.2|   4.6|            0|           1|         0|
|Auburn                |   259.1|         11.1|   8.2|   4.9|            0|           2|         1|
|Oklahoma              |   257.9|         11.4|  10.5|   2.8|            2|           1|         0|
|Michigan              |   252.3|         14.3|   7.4|   5.3|            0|           0|         0|
|Tennessee             |   247.7|         15.1|   6.2|   6.3|            0|           0|         0|
|Clemson               |   246.6|         16.2|  10.3|   3.3|            3|           2|         1|
|UCLA                  |   245.1|         16.9|   6.8|   6.1|            0|           0|         0|
|Texas A&M             |   244.6|         14.9|   7.7|   5.2|            0|           0|         0|
|Miami-FL              |   238.6|         18.0|   8.2|   4.8|            0|           0|         0|
|Oregon                |   231.3|         19.1|  10.0|   3.2|            1|           2|         0|
|Ole Miss              |   230.9|         21.3|   6.9|   5.6|            0|           0|         0|
|South Carolina        |   228.9|         21.3|   8.0|   4.9|            0|           0|         0|
|Stanford              |   224.6|         23.3|   9.8|   3.5|            0|           0|         0|
|Penn State            |   220.1|         25.1|   8.9|   4.0|            0|           0|         0|
|Arkansas              |   214.5|         26.4|   6.6|   6.0|            0|           0|         0|
|North Carolina        |   214.3|         27.4|   7.3|   5.5|            0|           0|         0|
|Nebraska              |   213.4|         27.5|   8.5|   4.7|            0|           0|         0|
|Washington            |   211.6|         28.7|   7.2|   5.8|            1|           0|         0|
|Virginia Tech         |   211.4|         27.6|   9.0|   4.4|            0|           0|         0|
|Mississippi State     |   209.5|         28.9|   7.3|   5.5|            0|           0|         0|
|Michigan State        |   208.5|         28.9|   9.3|   3.9|            1|           0|         0|
|Arizona State         |   202.6|         33.4|   6.7|   6.0|            0|           0|         0|
|Oklahoma State        |   200.8|         33.7|   9.6|   3.4|            0|           0|         0|
|California            |   200.2|         36.4|   5.5|   6.8|            0|           0|         0|
|Missouri              |   195.5|         37.0|   8.0|   5.0|            0|           0|         0|
|Pittsburgh            |   193.6|         38.2|   7.2|   5.6|            0|           0|         0|
|West Virginia         |   192.2|         38.3|   8.0|   4.9|            0|           0|         0|
|NC State              |   191.9|         41.5|   7.8|   5.2|            0|           0|         0|
|Maryland              |   191.6|         39.1|   5.2|   7.3|            0|           0|         0|
|Kentucky              |   191.1|         39.2|   5.3|   7.2|            0|           0|         0|
|Baylor                |   190.7|         38.9|   7.2|   5.4|            0|           0|         0|
|TCU                   |   190.5|         40.9|   9.8|   3.2|            0|           0|         0|
|Louisville            |   189.0|         40.6|   8.0|   4.8|            0|           0|         0|
|Virginia              |   186.7|         43.9|   4.3|   7.9|            0|           0|         0|
|Texas Tech            |   186.5|         42.7|   7.1|   5.6|            0|           0|         0|
|Wisconsin             |   186.4|         42.7|  10.0|   3.4|            0|           0|         0|
|Arizona               |   186.1|         42.9|   7.0|   5.9|            0|           0|         0|
|Rutgers               |   184.5|         44.4|   6.4|   6.2|            0|           0|         0|
|Utah                  |   182.9|         45.2|   8.6|   4.2|            0|           0|         0|
|Iowa                  |   179.1|         48.9|   8.2|   4.8|            0|           0|         0|
|Illinois              |   177.6|         50.3|   4.4|   7.9|            0|           0|         0|
|Oregon State          |   175.4|         51.2|   5.3|   7.1|            0|           0|         0|
|Georgia Tech          |   175.1|         51.0|   7.3|   5.4|            0|           0|         0|
|Colorado              |   173.4|         54.2|   4.1|   8.2|            0|           0|         0|
|Minnesota             |   173.2|         53.1|   6.1|   6.6|            0|           0|         0|
|Vanderbilt            |   170.6|         53.6|   5.1|   7.2|            0|           0|         0|
|South Florida         |   168.3|         57.6|   6.6|   5.8|            0|           0|         0|
|Northwestern          |   166.8|         56.7|   7.7|   5.1|            0|           0|         0|
|Washington State      |   166.7|         56.0|   4.7|   7.8|            0|           0|         0|
|BYU                   |   165.6|         57.7|   8.4|   4.6|            0|           0|         0|
|Kansas                |   165.3|         57.8|   2.8|   9.3|            0|           0|         0|
|Duke                  |   164.9|         58.3|   5.8|   6.7|            0|           0|         0|
|Indiana               |   164.8|         58.3|   4.3|   7.9|            0|           0|         0|
|Kansas State          |   161.1|         61.2|   7.9|   4.9|            0|           0|         0|
|Boston College        |   160.9|         61.5|   6.1|   6.7|            0|           0|         0|
|Iowa State            |   160.7|         61.4|   4.5|   7.9|            0|           0|         0|
|Syracuse              |   158.3|         63.6|   5.0|   7.3|            0|           0|         0|
|Cincinnati            |   158.2|         64.3|   7.9|   4.8|            0|           0|         0|
|Purdue                |   157.3|         64.3|   4.2|   8.1|            0|           0|         0|
|Wake Forest           |   156.6|         64.1|   4.8|   7.2|            0|           0|         0|
|Houston               |   154.7|         66.5|   8.6|   4.4|            0|           0|         0|
|Central Florida       |   154.5|         66.0|   7.8|   5.1|            0|           0|         0|
|Boise State           |   153.1|         68.3|  11.1|   2.2|            0|           0|         0|
|Marshall              |   148.4|         70.1|   7.1|   5.6|            0|           0|         0|
|SMU                   |   143.4|         72.9|   5.1|   7.5|            0|           0|         0|
|Memphis               |   141.3|         74.4|   5.5|   7.0|            0|           0|         0|
|San Diego State       |   138.4|         77.2|   8.0|   5.0|            0|           0|         0|
|Southern Miss         |   136.8|         74.7|   6.2|   6.7|            0|           0|         0|
|East Carolina         |   134.3|         80.9|   6.6|   6.2|            0|           0|         0|
|Georgia Southern      |   130.5|         88.8|   6.2|   6.0|            0|           0|         0|
|Toledo                |   130.2|         83.4|   8.0|   4.7|            0|           0|         0|
|Tulsa                 |   129.4|         84.1|   6.7|   5.9|            0|           0|         0|
|Temple                |   127.6|         84.2|   7.0|   5.6|            0|           0|         0|
|Connecticut           |   127.2|         86.7|   5.1|   7.3|            0|           0|         0|
|Western Michigan      |   125.9|         86.8|   6.7|   5.9|            0|           0|         0|
|Fresno State          |   122.5|         83.3|   6.6|   6.4|            0|           0|         0|
|Tulane                |   122.1|         90.1|   3.5|   8.7|            0|           0|         0|
|Colorado State        |   121.7|         89.6|   5.9|   6.8|            0|           0|         0|
|Old Dominion          |   121.6|        101.5|   6.5|   5.8|            0|           0|         0|
|Miami-OH              |   121.0|         97.2|   4.0|   8.2|            0|           0|         0|
|Florida International |   116.4|         90.8|   4.8|   7.5|            0|           0|         0|
|Massachusetts         |   116.2|        103.4|   2.6|   9.4|            0|           0|         0|
|Texas State           |   115.7|        100.5|   4.0|   8.0|            0|           0|         0|
|Troy                  |   115.5|         90.8|   7.1|   5.4|            0|           0|         0|
|Hawaii                |   115.4|         90.2|   4.9|   8.0|            0|           0|         0|
|Louisiana Tech        |   114.9|         91.0|   7.3|   5.5|            0|           0|         0|
|Appalachian State     |   114.8|        105.2|   9.2|   3.5|            0|           0|         0|
|Florida Atlantic      |   112.8|         89.8|   4.2|   8.0|            0|           0|         0|
|Middle Tennessee      |   111.7|         91.8|   6.8|   5.8|            0|           0|         0|
|Nevada                |   110.0|         96.0|   6.8|   6.0|            0|           0|         0|
|Western Kentucky      |   110.0|         98.4|   7.6|   5.2|            0|           0|         0|
|New Mexico            |   109.2|         96.1|   3.7|   8.6|            0|           0|         0|
|Arkansas State        |   108.7|         96.1|   7.1|   5.3|            0|           0|         0|
|South Alabama         |   108.2|        104.5|   4.8|   7.7|            0|           0|         0|
|Bowling Green         |   106.8|         98.4|   6.2|   6.6|            0|           0|         0|
|UTSA                  |   106.1|        106.2|   5.3|   6.3|            0|           0|         0|
|UNLV                  |   106.0|        100.3|   3.7|   8.7|            0|           0|         0|
|Central Michigan      |   105.3|        100.4|   6.7|   6.1|            0|           0|         0|
|UL-Lafayette          |   104.7|        101.7|   6.6|   5.9|            0|           0|         0|
|Georgia State         |   104.6|        111.8|   4.2|   8.0|            0|           0|         0|
|Rice                  |   103.9|        101.7|   5.4|   7.1|            0|           0|         0|
|UAB                   |   103.8|         98.2|   4.4|   7.8|            0|           0|         0|
|North Texas           |   103.4|        100.6|   4.3|   8.1|            0|           0|         0|
|Charlotte             |   102.5|        117.3|   2.3|   9.7|            0|           0|         0|
|Ball State            |   102.1|        102.6|   6.1|   6.3|            0|           0|         0|
|Northern Illinois     |   100.8|        101.9|   9.1|   4.4|            0|           0|         0|
|Utah State            |    99.7|        103.7|   6.3|   6.5|            0|           0|         0|
|Wyoming               |    98.9|        105.8|   5.3|   7.2|            0|           0|         0|
|Ohio                  |    98.5|        104.0|   7.7|   5.3|            0|           0|         0|
|Kent State            |    96.9|        105.7|   4.6|   7.6|            0|           0|         0|
|San Jose State        |    94.5|        100.6|   4.6|   7.8|            0|           0|         0|
|UL-Monroe             |    91.9|        108.9|   4.7|   7.5|            0|           0|         0|
|Eastern Michigan      |    91.1|        112.5|   3.1|   9.0|            0|           0|         0|
|Buffalo               |    88.2|        111.6|   4.8|   7.4|            0|           0|         0|
|New Mexico State      |    87.6|        113.8|   3.1|   9.2|            0|           0|         0|
|Air Force             |    87.6|        109.2|   7.3|   5.6|            0|           0|         0|
|Akron                 |    86.4|        113.3|   4.1|   8.1|            0|           0|         0|
|Idaho                 |    84.4|        114.6|   3.7|   8.5|            0|           0|         0|
|Navy                  |    82.0|        107.6|   8.4|   4.7|            0|           0|         0|
|UTEP                  |    82.0|        116.4|   3.7|   8.4|            0|           0|         0|
|Army                  |    76.2|        117.7|   4.5|   7.8|            0|           0|         0|

Looking at the table, it's pretty clear that the schools with higher recruiting class averages at the top of the table have a lot more success than those further down. Alabama is the clear leader in both recruiting and wins as they averaged 12.5(!) wins per year on an average recruiting rating of 303.7. This has led to a decade of dominance as the Crimson Tide have appeared in all four College Football Playoffs, six national championship games, and have taken home the trophy as national champs five times.

Additionally, 11 of the top 12 teams in recruiting average have played in at least one championship game during this time. The one exception, USC, has been in a coaching carousel for several years as a result of its failure to meet these expectations.


Looking more broadly, the average wins per year typically decreases as you move down the table. We can see this by looking at the average annual win totals for descending groups of 25 schools:

* 1-25: 8.72
* 26-50: 7.3 
* 51-75: 6.26 
* 76-100: 5.92 
* 101-129: 5.24

This trend suggests there's a linear relationship between wins and recruiting. We can visualize this by plotting the two together and assess how strong the relationship is across all the data by adding a linear regression trendline. <br><br>

![center](https://rberger997.github.io/img/2018-07-30-cfb-project/plot1-1.png)

<br>
From the plot we can clearly see the trend we observed in the table: there is a positive linear relationship that supports the idea that better recruiting leads to more wins (as we would expect). Additionally, by using a linear model we can quantify the effect that recruiting has on winning over the course of 10 seasons: the coefficient of determination (R<sup>2</sup>) is 0.38, meaning that recruiting accounts for 38% of the variance in win totals. When you consider the number of factors that determine the outcomes of 10 football seasons (coaching, strategy, injuries, etc.), 38% seems like a significant amount of influence. At the same time, it tells us that recruiting isn't everything; there is still a lot of work to be done off the recruiting trail to be successful.


It also appears from the plot that for schools with recruiting scores under 250, and especially those under 200, there is a lot of variability in win totals. In this range, there is a lot of scatter above and below the trendline and teams with very similar recruiting profiles have generated drastically different win totals. Take for example Wisconsin, Arizona, and Virginia. All three schools have averaged a 247Sports recruiting score of 186 with the Badgers averaging 10 wins per year, Arizona 7, and UVA 4.3. These differences illustrate how mid-level recruiting can lead to variable on field results and hints toward the importance of coaching and player development for teams that don't have top-end athletes.


## Elite teams are built from elite recruits
While the middle class of recruiting offers mixed results, there is one thing that is very clear from the data: the very best teams in college football are built on a foundation of elite recruting. Looking at the plot, schools that average recruiting classes above 250 on the 247Sports composite score are the ones that win national championships. This is the recruiting range where perennial powers Alabama, Ohio State, Florida State, and Oklahoma typically reside.


We can take this a step further and focus in on all the teams that have made it to the championship game but instead of looking at their 10 year averages, let's look at how well they recruited in the four years leading up to that championship game appearance. We can then use this data to build a recruiting profile of what championship caliber teams generally look like to assess current and future teams.


| Year|Champion      | Avg.rec| Avg.rank|Runner up  | Avg.rec.1| Avg.rank.1| Difference|
|----:|:-------------|-------:|--------:|:----------|---------:|----------:|----------:|
| 2008|Florida       |   274.2|      5.2|Oklahoma   |     258.6|        8.2|       15.6|
| 2009|Alabama       |   244.8|     10.8|Texas      |     260.6|        7.6|      -15.8|
| 2010|Auburn        |   235.7|     14.8|Oregon     |     206.7|       24.8|       29.0|
| 2011|Alabama       |   276.8|      4.8|LSU        |     272.6|        6.8|        4.2|
| 2012|Alabama       |   293.0|      2.4|Notre Dame |     256.2|       11.8|       36.8|
| 2013|Florida State |   278.5|      5.6|Auburn     |     259.7|       11.0|       18.8|
| 2014|Ohio State    |   278.5|      6.4|Oregon     |     241.6|       15.6|       36.9|
| 2015|Alabama       |   311.3|      1.0|Clemson    |     256.5|       13.2|       54.8|
| 2016|Clemson       |   257.0|     13.4|Alabama    |     311.9|        1.0|      -54.9|
| 2017|Alabama       |   314.4|      1.0|Georgia    |     279.0|        7.2|       35.4|

Focusing on the title game shows just how important recruiting is in bringing home a title; in the last ten championship games, the team with the higher recruiting average has won *8 of 10 times*. Additionally, only two teams won a championship with an average class rating under 250 -- 2009 Alabama and 2010 Auburn. For these two teams it's notable to point out that (1) both had the Heisman trophy winner on their team (Mark Ingram, Cam Newton) and (2) both got a bit lucky with regards to their title game opponent -- Texas QB and Heisman finalist Colt McCoy got injured on the first drive against Alabama and the 2010 Oregon team that faced Auburn took the field with by far the lowest recruiting class average (206.7) of any championship game participant over the last 10 years. The overall message is clear: to win a national championship you need elite recruiting classes or you *really* need some things to go your way.


## Looking ahead: championship contenders for 2018
So far we've been looking back at results from the last 10 years but what do these data tell us about the upcoming season? Specifically, which teams have the recruiting profile to make the championship game or win it? To adress these questions let's use the data from title game participants to define what a champion and runner-up typically looks like over the 4 years leading up to their title run: 

* Champion:
    + Avg recruiting class score: **276.42**
    + Avg national class rank: **6.54**
* Runner-up:
    + Avg recruiting class score: **260.34**
    + Avg national class rank: **10.72**
    
Past results tell us that a team typically needs to have a four year recruiting average of 260 to make the championship game and 275 to win it. Looking ahead to the 2018 season, let's see which teams are national title contenders by these criteria.




|Team          | Avg.rec| Avg.rank|
|:-------------|-------:|--------:|
|Alabama       |   304.7|      2.2|
|Ohio State    |   298.7|      3.8|
|Georgia       |   296.1|      4.2|
|USC           |   291.9|      5.0|
|Florida State |   284.5|      5.5|
|LSU           |   279.0|      8.0|
|Auburn        |   268.2|      9.5|
|Clemson       |   267.7|     10.8|

<br>
Out of 129 division I teams, only 8 have the general recruiting profile of a champion for this year. Alabama once again leads the way with the highest recruiting average, but the margin is very close between the Tide, Ohio State, and Georgia in the top three. 

This recruiting profile is by no means a predictive model but it still tends to agree with the general consensus on who the top contenders are for this season. As of this writing, the Vegas odds for these teams to win the championship are:

 * Alabama 2-1
 * Clemson 9-2
 * Ohio State 8-1
 * Georgia 10-1 
 * Auburn 33-1
 * Florida State 50-1
 * USC 66-1
 * LSU 66-1

(Gamblers note: judging strictly from their odds and recruiting profiles, Auburn, Florida State, USC, and LSU look like good value bets for 2018.)



## Final Thoughts
The takeaway points from this analysis should be as follows:

* **In general, better recruiting leads to more wins.**
* **Mid-level recruiting leads to mixed results with regards to win totals.**
* **Elite recruiting is critical in competing for national championships.** 
    + **To contend for championships, you generally need four years of top 10 recruiting classes.**
    + **To win championships, you generally need four years of top 6 recruiting classes.**
    

An important thing to keep in mind is that these results are based on a relatively small sample size (10 seasons) and ignore a lot of important factors that are involved in team success.

Also, while the recruting profiles give insight into what a champion contender typically looks like, I like to think of them as more of a tool to set expectations rather than make predictions. In this mindset, fans of all eight teams identified as championship contenders should *expect* to make a run at the title while fans of teams outside that list would be *very lucky* to see their team make the championship game. This idea of expectations based on recruiting is something I'll address further in a future post.

<br> 
**This post was written in R. To see the full source, click [here](https://github.com/rberger997/rberger997.github.io/blob/master/posts-source-files/2018-07-30-cfb-project/2018-07-30-cfb-project.R)**




