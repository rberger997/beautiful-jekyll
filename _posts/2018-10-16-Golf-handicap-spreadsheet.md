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

I've played golf for virtually my entire life but for many years I didn't keep track of stats from round to round or had a USGA handicap index. This led to a problem when playing with my regular group of friends: we didn't know how to fairly play head to head or in team scrambles with our different skill levels. How many strokes do you get in an 18 hole round? What about if we play two man scrambles? 

Last year I decided to fix these problem by making a spreadsheet template for calculating handicap indeces using the USGA formulas. The end result is a very easy to use system where after every round you input the course rating, slope rating, and your score and your current handicap index is calculated. This can be used for a single player or you can duplicate the sheet and track multiple players in other tabs (my spreadsheet is shared between me and my friends and we keep all of our stats in one shared file). I also made tabs for calculating the number of strokes to give between players in a single round in both stroke play or two man scrambles.

## Link to the spreadsheet
To use this spreadsheet, follow [this link](https://docs.google.com/spreadsheets/d/1Eav4Wl_VDD_fktpc4U00SQ70c-6ASHjavbH5ke3PGi0/edit?usp=sharing) where you'll see a view only version of the sheet. To get a copy for yourself, click `File`, `Make a copy` and you should have an editable version copied to your personal Google Drive.

## Player tracker
Here's a screenshot of my handicap tracker sheet. My current handicap is 13.2 shown in cell C1 and is calculated from the most recent 20 rounds of golf played (in my case rounds 4-23). Columns B-F are the input columns and everything else is calculated automatically. The only tricky part of adding data to the sheet is calculating your adjusted score, which is based on the [USGA equitable stroke control](https://www.usga.org/HandicapFAQ/handicap_answer.asp?FAQidx=9) system. Column J shows your net score for the round which tells you how well you performed against your handicap. The handicap differential for each round is shown in column K and these are the values used to calculate your overall index. Column L shows your running handicap index after every round. On the right side of the sheet you can see some additional stats including your average 18 hole score, average handicap differential, and your top 10 best rounds.

![center](https://rberger997.github.io/img/2018-10-16-golf-handicap-spreadsheet/golf_handicap_sheet.png)


## Strokes calculator
To calculate strokes for each player in a given round, you can use the stroke play calculator sheet. To use it you simply input the course slope rating and handicap indices for each player in the group. The sheet will automatically calculate each player's course handicap and how many strokes each player should receive from the best player, who gets zero.

From this example you can see that I'm the top player in the group and so I'm giving 12, 16, and 5 strokes to Fry, Trev, and Russ respectively.

![center](https://rberger997.github.io/img/2018-10-16-golf-handicap-spreadsheet/stroke_calculator.png)


## Final thoughts
This spreadsheet has made it really easy to track the stats for me and my golf crew and enabled us to set up some fair wagers during our rounds. It was a fun project to work on and a good way to streamline a data analysis problem using an automated template. Thanks for reading, if you have comments or suggestions on this sheet let me know at rberger997@gmail.com.
