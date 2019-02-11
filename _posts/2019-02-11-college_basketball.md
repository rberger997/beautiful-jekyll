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

After doing some machine learning projects using public datasets in the past I decided I needed a new challenge on a project I would make from scratch: building a predictive model for college basketball games. The end goal that I wanted to accomplish with this project was to use machine learning algorithms and advanced analytics metrics to determine which team will win every basketball game between NCAA division I teams and have a system where the daily predictions would automatically be displayed in an interactive Tableau visualization.

In the end I was able to build a model by treating each game as a binary classification (will the home team win the game: Yes or No?) using logistic regression that predicts winners at ~72% accuracy. The model was trained using game results and daily team analytics metrics from every game from the last 5 years (26,000+ games, 250,000+ daily team metrics) and has picked winners at a 72.3% rate in over 3,700 games for the 2019 season as of February 11.


Here are the predictions for todays games:

<iframe src="https://public.tableau.com/views/college_basketball_predictions/Dashboard1?:embed=y&:display_count=yes&:showVizHome=no&:embed=true" width="90%" height="1000"></iframe>


