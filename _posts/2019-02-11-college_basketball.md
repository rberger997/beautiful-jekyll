---
layout: post
title: "Predicting college basketball winners with machine learning"
subtitle: 
author: "Ryan Berger"
date: "2019-02-11"
output: 
  html_document:
    theme: spacelab	
    highlight: tango	
    keep_md: true
preserve_yaml: true
---

After doing some machine learning projects using public datasets in the past I decided I needed a new challenge on a project I would make from scratch: building a predictive model for college basketball games. The end goal that I wanted to accomplish with this project was to use machine learning algorithms and advanced analytics metrics to determine **(1)** which team will win every basketball game between NCAA division I teams, **(2)** projected final scores for each team, and **(3)** have a system where the daily predictions would automatically be displayed in an interactive Tableau visualization.

After trying out a few different algorithms (linear regression, k-nearest neighbors, neural network), the best performance was achieved by treating each game as a binary classification using logistic regression (will the home team win the game: Yes or No?) where the correct winning team was predicted 72% of the time. The model was trained using game results from every game from the last 5 years (26,000+ games) using adjusted offensive and defensive efficiency ratings from [Bart Torvik](http://www.barttorvik.com/#)) from the day the game was played as predictors. 

For the current season the model is performing as expected; as of February 11 the winning team is being predicted with an accuracy rate of 72.3% rate in over 3,700 games. Here are the predictions for todays games:

<iframe src="https://public.tableau.com/views/college_basketball_predictions/Dashboard1?:embed=y&:display_count=yes&:showVizHome=no&:embed=true" width="90%" height="1000"></iframe>


The challenges of this project were primarily in data wrangling and cleaning. Oh and web scraping, lots and lots of web scraping. 

Past game results and future schedules were scraped from [college baskeball reference](https://www.sports-reference.com/cbb/) using the `rvest` package in R by looping over every date of every season from 2014-2018 (26,000+ games). Similarly, to provide analytics metrics for each team from [BartTorvik.com](http://www.barttorvik.com/#) on the day the game was played required scraping and cleaning analytics data for 353 teams on every date from 2014-2018 (250,000+ team ratings were scraped!).

To see the source code for this project, check out my [Github repository](https://github.com/rberger997/college_basketball_predictions). 
