---
layout: post
title: "Tracking golf handicaps using Google Sheets"
author: "Ryan Berger"
date: "2018-10-16"
bigimg:
output: 
  html_document:
    theme: spacelab	
    highlight: tango	
    keep_md: true
preserve_yaml: true
---

I have played golf for my entire life but for many years I never kept track of stats from round to round or had a USGA handicap index. This led to a problem when playing with my regular group of friends: we didn't know how to fairly play head to head or in team scrambles with our different skill levels. How many strokes do you get in an 18 hole round? What about if we play two man scrambles? 

Last year I decided to fix these problem by making a spreadsheet template for calculating handicap indeces using the USGA formulas. The end result is a very easy to use system where after every round you input the course rating, slope rating, and your score and your current handicap index is calculated. This can be used for a single player or you can duplicate the sheet and track multiple players in other tabs (my spreadsheet is shared between me and my friends and we keep all of our stats in one file). I also made tabs for calculating the number of strokes to give between players in a single round in both stroke play or two man scrambles.

# Player tracker
Here's a screenshot of my handicap tracker sheet. My current handicap is 13.2 shown in cell C1 and is calculated from the most recent 20 rounds of golf played (in my case rounds 2-21). Columns B-F are the input columns and everything else is calculated automatically. On the right side of the sheet you can see some additional stats including your average 18 hole score, average handicap differential, and your top 10 best rounds.

![center](https://rberger997.github.io/img/2018-10-16-golf-handicap-spreadsheet/golf_handicap_sheet.png)




# Strokes calculator
![center](https://rberger997.github.io/img/2018-10-16-golf-handicap-spreadsheet/stroke_calculator.png)

