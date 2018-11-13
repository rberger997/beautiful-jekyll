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

Matthew Stafford has been the starting quarterback in Detroit since 2009 and hasn't led the Lions to much success despite being among the league leaders in passing statistics over that time. This disparity has led to Stafford's reputation among Lions fans as a guy who doesn't play well in close games but pads his statistics by accumulating passing yards and touchdowns when his team is getting blown out and opposing defenses are playing conservatively. Because of this reputation, fans and local media in Detroit have even given him the nickname "Stat Padford." The question, however, is to ask if this is a fair assessment of Matthew Stafford. Does Stafford's passing in late game blowouts inflate his overall numbers? Using NFL play by play data from 2009-2017 (the span of Staffords NFL career), we'll look to find answers to the following questions:

- Does Stafford perform better in garbage time?
- Do garbage time statistics inflate Stafford's overall passer rating?
- Are Stafford's passing yards and touchdown totals made up of mostly garbage time stats?

As a lifelong Lions fan who has watched virtually every game of Stafford's career and heard this narrative countless times, I wanted to find the answers to these questions using data and see if the Stat Padford nickname holds true (full disclosure: I believe that it's true).



## Defining garbage time 
To begin addressing these questions, we first have to lay out a definition of what exactly is "garbage time" for an NFL game. This is a situation in a game where one team has a big lead and is very likely to win and the general strategy changes for both teams. While there has been some [discussion](https://www.profootballfocus.com/news/defining-garbage-time) over how to define garbage time previously, for this example we'll use the following criteria:

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



## Final notes
For Lions fans frustrated with Stafford (including myself) it's time to accept Matthew Stafford for what he is: a slightly above average quarterback. Despite piling up tons of passing yards, he's been middle of the pack in terms of passer rating during his career. One thing we can say, however, is that Stafford is not a garbage time hero that inflates his statistics during blowout games. Going back to our original questions:

- Does Stafford perform better in garbage time? **Not really**
- Do garbage time statistics inflate Stafford's overall passer rating? **No**
- Are Stafford's passing yards and touchdown totals made up of mostly garbage time stats? **No**

RIP Stat Padford.
