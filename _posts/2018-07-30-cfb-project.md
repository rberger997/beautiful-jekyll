---
layout: post
title: "Signing of the stars - How much does recruiting matter in college football?"
subtitle:"A data exploration"
author: "Ryan Berger"
date: "2018-07-31"
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
When it comes to the best recruiting data for college football, there is no substitute for the [247Sports composite rating](https://247sports.com/Season/2019-Football/CompositeTeamRankings/). This rating system generates composite player ratings for roughly 4000 high school football players every year and creates team ratings using a weighted Gaussian distribution formula of the individual player composites. I've compiled the team class ratings for the last 10 years and will use these to quantify the recruiting talent brought in by each team.
<br><br>
I've also gathered the win/loss data for each team over the last decade by web scraping the [football outsiders advanced NCAA stats page](https://www.footballoutsiders.com/stats/ncaa) (source file [here](**insert_github_link**).





```
## For news about 'ggpmisc', please, see https://www.r4photobiology.info/
```

```
## For on-line documentation see https://docs.r4photobiology.info/ggpmisc/
```

```
## Loading required package: lattice
```

```
## Loading required package: survival
```

```
## Loading required package: Formula
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     src, summarize
```

```
## The following object is masked from 'package:rvest':
## 
##     html
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, units
```

```
## Warning in file(file, "rt"): cannot open file 'data/
## recruiting_data_long.csv': No such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```
## Warning in file(file, "rt"): cannot open file 'data/sp_data.csv': No such
## file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```
## Error in filter_impl(.data, quo): Evaluation error: object 'Year' not found.
```

```
## Warning in file(file, "rt"): cannot open file 'data/cfb_postseason.csv': No
## such file or directory
```

```
## Error in file(file, "rt"): cannot open the connection
```

```
## Error in select(sp, c(Team, W, L, Year)): object 'sp' not found
```

```
## Error in UseMethod("inner_join"): no applicable method for 'inner_join' applied to an object of class "NULL"
```

```
## Error in table(is.na(cfb)): object 'cfb' not found
```

```
## Error in eval(expr, envir, enclos): object 'cfb' not found
```

```
## Error in left_join(cfb, post, by = Cs(Team, Year)): object 'cfb' not found
```

```
## Error in cfb[is.na(cfb)] <- 0: object 'cfb' not found
```

```
## Error in eval(lhs, parent, parent): object 'cfb' not found
```

```
## Error in eval(lhs, parent, parent): object 'avgs' not found
```

```
## Warning: New theme missing the following elements: panel.grid, plot.tag,
## plot.tag.position
```

```
## Error in ggplot(data = avgs, aes(x = Avg.rec, y = Avg.W)): object 'avgs' not found
```

```
## Error in knitr::kable(avgs): object 'avgs' not found
```

```
## Error in filter(cfb, title_game == 1): object 'cfb' not found
```

```
## Error in 1:nrow(title): argument of length 0
```

```
## Error in UseMethod("filter_"): no applicable method for 'filter_' applied to an object of class "NULL"
```

```
## Error in UseMethod("filter_"): no applicable method for 'filter_' applied to an object of class "NULL"
```

```
## Error in cbind(champs, runnerup): object 'champs' not found
```

```
## Error in eval(expr, envir, enclos): object 'final' not found
```

```
## Error in colnames(final)[c(2, 5)] <- c("Champion", "Runner up"): object 'final' not found
```

```
## Error in eval(expr, envir, enclos): object 'final' not found
```

```
## Error in knitr::kable(final): object 'final' not found
```

```
## Error in mean(final$Avg.rank): object 'final' not found
```

```
## Error in mean(final$Avg.rank.1): object 'final' not found
```

```
## Error in mean(final$Avg.rec): object 'final' not found
```

```
## Error in mean(final$Avg.rec.1): object 'final' not found
```

```
## Error in UseMethod("filter_"): no applicable method for 'filter_' applied to an object of class "NULL"
```



