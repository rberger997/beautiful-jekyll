---
layout: post
title: "Signing of the stars - How much does recruiting matter in college football?"
author: "Ryan Berger"
date: "2018-08-01"
output: 
  html_document:
    theme: spacelab	
    highlight: tango	
    keep_md: true
preserve_yaml: true
---




With the start of a new college football season just a few weeks away, I've been thinking about a question I've heard for many years in one form or another: how much does recruiting matter? Recently there's been a lot of attention paid to football recruiting on TV, websites, blogs, message boards, and social media but is it really important? Does grabbing the headlines on signing day in February lead to a team taking home the hardware in December and January? 
<br><br>
The short answer to these questions is yes, recruiting is important for team success on a national level, but I want to go a step further and investigate the data to quantify its effects. Using recruiting data and team records from the last ten years, let's take a look at how much recruiting matters.
<br><br>

## The data
When it comes to the best recruiting data for college football, there is no substitute for [247Sports](https://247sports.com/Season/2019-Football/CompositeTeamRankings/). Their rating system generates composite player ratings for roughly 4000 high school football players every year and creates team ratings using a weighted Gaussian distribution formula of the individual player composites. I've compiled the team class ratings for the last 10 years and will use these to quantify the recruiting talent brought in by each team.


I've also gathered the win/loss data for each team over the last decade by web scraping the [football outsiders advanced NCAA stats page](https://www.footballoutsiders.com/stats/ncaa) (source file [here](**insert_github_link**).






{% highlight text %}
## Warning: Column `Team` joining factors with different levels, coercing to
## character vector
{% endhighlight %}



{% highlight text %}
## 
## FALSE  TRUE 
##  9433    17
{% endhighlight %}



{% highlight text %}
## Warning: Column `Team` joining character vector and factor, coercing into
## character vector
{% endhighlight %}



{% highlight text %}
## Warning: New theme missing the following elements: panel.grid, plot.tag,
## plot.tag.position
{% endhighlight %}

![center](https://rberger997.github.io/img/2018-07-30-cfb-project/load_data-1.png)

|Team                  | Avg.rec| Avg.rec_rank| Avg.W| Avg.L| Nat_champ| title_games| playoff_apps|
|:---------------------|-------:|------------:|-----:|-----:|---------:|-----------:|------------:|
|Alabama               |   303.7|          1.7|  12.5|   1.4|         5|           6|            4|
|Ohio State            |   282.0|          5.7|  11.2|   2.1|         1|           1|            2|
|USC                   |   281.9|          6.1|   9.4|   3.8|         0|           0|            0|
|Florida State         |   280.6|          5.6|  10.1|   3.3|         1|           1|            1|
|LSU                   |   277.3|          6.7|   9.5|   3.4|         0|           1|            0|
|Georgia               |   275.5|          7.3|   9.5|   3.9|         0|           1|            1|
|Florida               |   268.3|          9.3|   8.6|   4.3|         1|           1|            0|
|Texas                 |   267.1|          9.9|   7.8|   5.0|         0|           1|            0|
|Notre Dame            |   259.1|         11.3|   8.2|   4.6|         0|           1|            0|
|Auburn                |   259.1|         11.1|   8.2|   4.9|         1|           2|            0|
|Oklahoma              |   257.9|         11.4|  10.5|   2.8|         0|           1|            2|
|Michigan              |   252.3|         14.3|   7.4|   5.3|         0|           0|            0|
|Tennessee             |   247.7|         15.1|   6.2|   6.3|         0|           0|            0|
|Clemson               |   246.6|         16.2|  10.3|   3.3|         1|           2|            3|
|UCLA                  |   245.1|         16.9|   6.8|   6.1|         0|           0|            0|
|Texas A&M             |   244.6|         14.9|   7.7|   5.2|         0|           0|            0|
|Miami-FL              |   238.6|         18.0|   8.2|   4.8|         0|           0|            0|
|Oregon                |   231.3|         19.1|  10.0|   3.2|         0|           2|            1|
|Ole Miss              |   230.9|         21.3|   6.9|   5.6|         0|           0|            0|
|South Carolina        |   228.9|         21.3|   8.0|   4.9|         0|           0|            0|
|Stanford              |   224.6|         23.3|   9.8|   3.5|         0|           0|            0|
|Penn State            |   220.1|         25.1|   8.9|   4.0|         0|           0|            0|
|Arkansas              |   214.5|         26.4|   6.6|   6.0|         0|           0|            0|
|North Carolina        |   214.3|         27.4|   7.3|   5.5|         0|           0|            0|
|Nebraska              |   213.4|         27.5|   8.5|   4.7|         0|           0|            0|
|Washington            |   211.6|         28.7|   7.2|   5.8|         0|           0|            1|
|Virginia Tech         |   211.4|         27.6|   9.0|   4.4|         0|           0|            0|
|Mississippi State     |   209.5|         28.9|   7.3|   5.5|         0|           0|            0|
|Michigan State        |   208.5|         28.9|   9.3|   3.9|         0|           0|            1|
|Arizona State         |   202.6|         33.4|   6.7|   6.0|         0|           0|            0|
|Oklahoma State        |   200.8|         33.7|   9.6|   3.4|         0|           0|            0|
|California            |   200.2|         36.4|   5.5|   6.8|         0|           0|            0|
|Missouri              |   195.5|         37.0|   8.0|   5.0|         0|           0|            0|
|Pittsburgh            |   193.6|         38.2|   7.2|   5.6|         0|           0|            0|
|West Virginia         |   192.2|         38.3|   8.0|   4.9|         0|           0|            0|
|NC State              |   191.9|         41.5|   7.8|   5.2|         0|           0|            0|
|Maryland              |   191.6|         39.1|   5.2|   7.3|         0|           0|            0|
|Kentucky              |   191.1|         39.2|   5.3|   7.2|         0|           0|            0|
|Baylor                |   190.7|         38.9|   7.2|   5.4|         0|           0|            0|
|TCU                   |   190.5|         40.9|   9.8|   3.2|         0|           0|            0|
|Louisville            |   189.0|         40.6|   8.0|   4.8|         0|           0|            0|
|Virginia              |   186.7|         43.9|   4.3|   7.9|         0|           0|            0|
|Texas Tech            |   186.5|         42.7|   7.1|   5.6|         0|           0|            0|
|Wisconsin             |   186.4|         42.7|  10.0|   3.4|         0|           0|            0|
|Arizona               |   186.1|         42.9|   7.0|   5.9|         0|           0|            0|
|Rutgers               |   184.5|         44.4|   6.4|   6.2|         0|           0|            0|
|Utah                  |   182.9|         45.2|   8.6|   4.2|         0|           0|            0|
|Iowa                  |   179.1|         48.9|   8.2|   4.8|         0|           0|            0|
|Illinois              |   177.6|         50.3|   4.4|   7.9|         0|           0|            0|
|Oregon State          |   175.4|         51.2|   5.3|   7.1|         0|           0|            0|
|Georgia Tech          |   175.1|         51.0|   7.3|   5.4|         0|           0|            0|
|Colorado              |   173.4|         54.2|   4.1|   8.2|         0|           0|            0|
|Minnesota             |   173.2|         53.1|   6.1|   6.6|         0|           0|            0|
|Vanderbilt            |   170.6|         53.6|   5.1|   7.2|         0|           0|            0|
|South Florida         |   168.3|         57.6|   6.6|   5.8|         0|           0|            0|
|Northwestern          |   166.8|         56.7|   7.7|   5.1|         0|           0|            0|
|Washington State      |   166.7|         56.0|   4.7|   7.8|         0|           0|            0|
|BYU                   |   165.6|         57.7|   8.4|   4.6|         0|           0|            0|
|Kansas                |   165.3|         57.8|   2.8|   9.3|         0|           0|            0|
|Duke                  |   164.9|         58.3|   5.8|   6.7|         0|           0|            0|
|Indiana               |   164.8|         58.3|   4.3|   7.9|         0|           0|            0|
|Kansas State          |   161.1|         61.2|   7.9|   4.9|         0|           0|            0|
|Boston College        |   160.9|         61.5|   6.1|   6.7|         0|           0|            0|
|Iowa State            |   160.7|         61.4|   4.5|   7.9|         0|           0|            0|
|Syracuse              |   158.3|         63.6|   5.0|   7.3|         0|           0|            0|
|Cincinnati            |   158.2|         64.3|   7.9|   4.8|         0|           0|            0|
|Purdue                |   157.3|         64.3|   4.2|   8.1|         0|           0|            0|
|Wake Forest           |   156.6|         64.1|   4.8|   7.2|         0|           0|            0|
|Houston               |   154.7|         66.5|   8.6|   4.4|         0|           0|            0|
|Central Florida       |   154.5|         66.0|   7.8|   5.1|         0|           0|            0|
|Boise State           |   153.1|         68.3|  11.1|   2.2|         0|           0|            0|
|Marshall              |   148.4|         70.1|   7.1|   5.6|         0|           0|            0|
|SMU                   |   143.4|         72.9|   5.1|   7.5|         0|           0|            0|
|Memphis               |   141.3|         74.4|   5.5|   7.0|         0|           0|            0|
|San Diego State       |   138.4|         77.2|   8.0|   5.0|         0|           0|            0|
|Southern Miss         |   136.8|         74.7|   6.2|   6.7|         0|           0|            0|
|East Carolina         |   134.3|         80.9|   6.6|   6.2|         0|           0|            0|
|Georgia Southern      |   130.5|         88.8|   6.2|   6.0|         0|           0|            0|
|Toledo                |   130.2|         83.4|   8.0|   4.7|         0|           0|            0|
|Tulsa                 |   129.4|         84.1|   6.7|   5.9|         0|           0|            0|
|Temple                |   127.6|         84.2|   7.0|   5.6|         0|           0|            0|
|Connecticut           |   127.2|         86.7|   5.1|   7.3|         0|           0|            0|
|Western Michigan      |   125.9|         86.8|   6.7|   5.9|         0|           0|            0|
|Fresno State          |   122.5|         83.3|   6.6|   6.4|         0|           0|            0|
|Tulane                |   122.1|         90.1|   3.5|   8.7|         0|           0|            0|
|Colorado State        |   121.7|         89.6|   5.9|   6.8|         0|           0|            0|
|Old Dominion          |   121.6|        101.5|   6.5|   5.8|         0|           0|            0|
|Miami-OH              |   121.0|         97.2|   4.0|   8.2|         0|           0|            0|
|Florida International |   116.4|         90.8|   4.8|   7.5|         0|           0|            0|
|Massachusetts         |   116.2|        103.4|   2.6|   9.4|         0|           0|            0|
|Texas State           |   115.7|        100.5|   4.0|   8.0|         0|           0|            0|
|Troy                  |   115.5|         90.8|   7.1|   5.4|         0|           0|            0|
|Hawaii                |   115.4|         90.2|   4.9|   8.0|         0|           0|            0|
|Louisiana Tech        |   114.9|         91.0|   7.3|   5.5|         0|           0|            0|
|Appalachian State     |   114.8|        105.2|   9.2|   3.5|         0|           0|            0|
|Florida Atlantic      |   112.8|         89.8|   4.2|   8.0|         0|           0|            0|
|Middle Tennessee      |   111.7|         91.8|   6.8|   5.8|         0|           0|            0|
|Nevada                |   110.0|         96.0|   6.8|   6.0|         0|           0|            0|
|Western Kentucky      |   110.0|         98.4|   7.6|   5.2|         0|           0|            0|
|New Mexico            |   109.2|         96.1|   3.7|   8.6|         0|           0|            0|
|Arkansas State        |   108.7|         96.1|   7.1|   5.3|         0|           0|            0|
|South Alabama         |   108.2|        104.5|   4.8|   7.7|         0|           0|            0|
|Bowling Green         |   106.8|         98.4|   6.2|   6.6|         0|           0|            0|
|UTSA                  |   106.1|        106.2|   5.3|   6.3|         0|           0|            0|
|UNLV                  |   106.0|        100.3|   3.7|   8.7|         0|           0|            0|
|Central Michigan      |   105.3|        100.4|   6.7|   6.1|         0|           0|            0|
|UL-Lafayette          |   104.7|        101.7|   6.6|   5.9|         0|           0|            0|
|Georgia State         |   104.6|        111.8|   4.2|   8.0|         0|           0|            0|
|Rice                  |   103.9|        101.7|   5.4|   7.1|         0|           0|            0|
|UAB                   |   103.8|         98.2|   4.4|   7.8|         0|           0|            0|
|North Texas           |   103.4|        100.6|   4.3|   8.1|         0|           0|            0|
|Charlotte             |   102.5|        117.3|   2.3|   9.7|         0|           0|            0|
|Ball State            |   102.1|        102.6|   6.1|   6.3|         0|           0|            0|
|Northern Illinois     |   100.8|        101.9|   9.1|   4.4|         0|           0|            0|
|Utah State            |    99.7|        103.7|   6.3|   6.5|         0|           0|            0|
|Wyoming               |    98.9|        105.8|   5.3|   7.2|         0|           0|            0|
|Ohio                  |    98.5|        104.0|   7.7|   5.3|         0|           0|            0|
|Kent State            |    96.9|        105.7|   4.6|   7.6|         0|           0|            0|
|San Jose State        |    94.5|        100.6|   4.6|   7.8|         0|           0|            0|
|UL-Monroe             |    91.9|        108.9|   4.7|   7.5|         0|           0|            0|
|Eastern Michigan      |    91.1|        112.5|   3.1|   9.0|         0|           0|            0|
|Buffalo               |    88.2|        111.6|   4.8|   7.4|         0|           0|            0|
|New Mexico State      |    87.6|        113.8|   3.1|   9.2|         0|           0|            0|
|Air Force             |    87.6|        109.2|   7.3|   5.6|         0|           0|            0|
|Akron                 |    86.4|        113.3|   4.1|   8.1|         0|           0|            0|
|Idaho                 |    84.4|        114.6|   3.7|   8.5|         0|           0|            0|
|Navy                  |    82.0|        107.6|   8.4|   4.7|         0|           0|            0|
|UTEP                  |    82.0|        116.4|   3.7|   8.4|         0|           0|            0|
|Army                  |    76.2|        117.7|   4.5|   7.8|         0|           0|            0|

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



{% highlight text %}
## [1] 6.54
{% endhighlight %}



{% highlight text %}
## [1] 10.72
{% endhighlight %}



{% highlight text %}
## [1] 276.42
{% endhighlight %}



{% highlight text %}
## [1] 260.34
{% endhighlight %}



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



