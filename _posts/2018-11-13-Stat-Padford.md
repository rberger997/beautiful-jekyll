---
layout: post
title: "Matt Stafford or Stat Padford?"
subtitle: "Analysis of Lions QB play in garbage time"
author: "Ryan Berger"
date: "2018-11-13"
bigimg: /img/2018-11-13-Stat-Padford/lions.jpg
output: 
  html_document:
    theme: spacelab	
    highlight: tango	
    keep_md: true
preserve_yaml: true
---

Matthew Stafford has been the starting quarterback in Detroit since 2009 and hasn't led the Lions to much success despite being among the league leaders in passing statistics over that time. This disparity has led to Stafford's reputation among Lions fans as a guy who doesn't play well in close games but pads his statistics by accumulating passing yards and touchdowns when his team is getting blown out and opposing defenses are playing conservatively. Because of this reputation, fans and local media in Detroit have even given him the nickname "Stat Padford." The question, however, is to ask if this is a fair assessment of Matthew Stafford. Does Stafford's passing in late game blowouts inflate his overall numbers? Using NFL play-by-play data, we'll look to find answers to the following questions:

- Does Stafford perform better in garbage time?
- Do garbage time statistics inflate Stafford's overall passer rating?
- Are Stafford's passing yards and touchdown totals made up of mostly garbage time stats?

As a lifelong Lions fan who has watched virtually every game of Stafford's career and heard this narrative countless times, I wanted to find the answers to these questions using data and see if the Stat Padford nickname holds true (full disclosure: I believe that it's true).



## Defining garbage time 
To begin addressing these questions, we first have to lay out a definition of what exactly is "garbage time" for an NFL game. This is a situation in a game where one team has a big lead and is very likely to win and the general strategy changes for both teams. While there has been some [discussion](https://www.profootballfocus.com/news/defining-garbage-time) over how to define garbage time previously, for this analysis we'll use the following criteria:

- Team is trailing by at least 21 at any point in the game OR
- Team is trailing by at least 14 in the second half

In both of these cases we would expect the trailing team to pass the ball much more often and the leading team defense to play more conservatively than they would in a close game.



## Play-by-play data
For this analysis we'll use the [detailed NFL play-by-play dataset](https://www.kaggle.com/maxhorowitz/nflplaybyplay2009to2016) compiled by Ron Yurko, Sam Ventura, and Max Horowitz of the Carnegie Mellon Sports Analytics Club. This dataset gives detailed information on over 350,000 NFL plays from 2009-2017 that we can use to filter by game situations.

Filtering out the pass plays with Matthew Stafford at QB shows 4868 plays from 2009-2017. We can use the play-by-play features of this dataset to split these passing plays based on our garbage time criteria and compare how efficient Stafford is during garbage time vs non-garbage time using the [NFL passer rating formula](https://en.wikipedia.org/wiki/Passer_rating).

Looking at all passes from 2009-2017, Stafford had a passer rating of 88.2. Given this, we would expect that his passer rating is much higher in garbage time plays compared to non-garbage time if he really is stat padding. Let's see what the data says.



## Matthew Stafford: non-stat padder

![center](https://rberger997.github.io/img/2018-11-13-Stat-Padford/stafford_table1.png)

From the numbers it looks like Stafford's reputation for stat-padding is misleading. His QB rating is almost identical in both garbage time (88.8) and non-garbage time (88.1) situations so the notion that his passer rating is being inflated by garbage time statistics is untrue.

Looking at the totals shows that garbage time attempts make up only about 10% of all Stafford's passes, meaning that 90% of his passes occur when games are competitive. The other myth we can put to rest is that a sizable portion of Stafford's total passing yardage is accumulated during garbage time as it only accounts for 10% of his total. Furthermore, Stafford's yards per attempt and touchdown rate are very similar in both situations and suggests that, despite all the narratives, he is statistically the same QB in competitive games and blowouts.



## Stafford situational passing stats
Now that we've killed off the myth of Stat Padford, let's take a closer look at Stafford's passer rating in other game situations to get a deeper breakdown of his performance. We'll compare his numbers to league average over the same time span for reference.

![center](https://rberger997.github.io/img/2018-11-13-Stat-Padford/stafford_table2.png)

Observations from situational passing stats:

- Stafford is 4.3 points above NFL average in overall passer rating.
- He's been most efficient and above league average in the 1st and 3rd quarters and when the game is tied.
- He's been much worse on 4th down passing compared to the NFL average.
- In all other situations examined, Stafford has been within a few points of the NFL average.



## Final notes on Stafford
For Lions fans frustrated with Stafford (including myself) it's time to accept Matthew Stafford for what he is: a slightly above average quarterback. Despite piling up tons of passing yards, he's been middle of the pack by passer rating during his career. One thing we can say, however, is that Stafford is not a garbage time hero that inflates his statistics during blowout games. Going back to our original questions:

- Does Stafford perform better in garbage time? **No, he's the same**
- Do garbage time statistics inflate Stafford's overall passer rating? **No**
- Are Stafford's passing yards and touchdown totals made up of mostly garbage time stats? **No, it's about 10%**

RIP Stat Padford.

## Which NFL QBs pad their stats in garbage time?
If Stafford isn't piling up stats in garbage time then who is? We can use the same approach to look at all QBs from 2009-2017 and to quantify it we'll use what I call the Garbage Time Boost - the difference between a QBs overall passer rating and their non-garbage time rating. For example, a QB with an overall rating of 90 but a non-garbage time rating of 88 would have a Garbage Time Boost of 2 points, meaning his overall rating is elevated 2 points due to his garbage time statistics.

![center](https://rberger997.github.io/img/2018-11-13-Stat-Padford/stafford_histogram.png)

There are 336 quarterbacks in our dataset, but looking at a histogram of total passing attempts it's clear that the majority of these players have very few attempts. These are mostly backups and guys who started a handful of games. To limit our study to QBs that played a significant amount, we'll set a minimum of 1500 passing attempts to get the number of QBs down to 33, approximately one per team.



## Blake Bortles is the king of garbage time

![center](https://rberger997.github.io/img/2018-11-13-Stat-Padford/stafford_table3.png)

Looking at the table of results shows a clear winner for the award for biggest stat padder: Blake Bortles! Bortles' overall passer rating is boosted 3.7(!) points due to his garbage time statistics and is nearly triple the amount of the next highest by Andrew Luck (1.3). Additionally, *about a quarter of Bortles' passing yards and touchdowns have been gained while his team is getting blown out*. Compared to the rest of the NFL Bortles has been an outlier, but it hasn't hurt him financially as he's taken his garbage stats to the bank to the tune of a $54 million contract extension that was [questioned by many](http://www.espn.com/nfl/story/_/id/22590179/what-made-blake-bortles-extension-questionable-why-jacksonville-jaguars-all-nfl-2018) at the time.

Surprisingly, while working on this I discovered that Michael Salfino at FiveThirtyEight did a [similar analysis](https://fivethirtyeight.com/features/blake-bortles-is-the-tom-brady-of-nfl-garbage-time/) in 2017 where he named Blake Bortles "The Tom Brady of garbage time" after looking at the same stats with a different methodology. Taken together, two independent approaches have now confirmed Blake Bortles' as the ruler of garbage time. 

All hail the King.

## Other observations
- For the most part, garbage time statistics make very little impact on QB ratings and stat totals.
- The percentage of attempts during garbage time vary significantly between QBs of good teams (T. Brady 2.8%) and bad teams (J. Freeman 27.9%).
- More QBs have lowered their overall passer rating during garbage time (C. Kaepernick, J. Freeman, K. Cousins) than improved it.




*[Link to full code notebook at Kaggle.com](https://www.kaggle.com/rberger997/matt-stafford-or-stat-padford?scriptVersionId=7357779)*
