
#'---
#' layout: post
#' title: "Converting R files to Jekyll posts"
#' author: "Ryan Berger"
#' date: "July 18, 2018"
#' output: 
#'   html_document:
#'     keep_md: true
#' preserve_yaml: true
#' ---


#' This is a test method of writing an R script and using knitr to post to this Jekyll site. Here are the steps involved:
#' 1. Write up R script, e.g. file.R, with a YAML header
#' 2. When finished with script, open 'convert-R-to-post.R' from local blog directory.
#' 3. Run KnitPost(file.R)
#' 4. Copy file.md to local blog/_posts/ folder
#' 5. Copy img folder to local blog/img/ folder
#' 6. Push to github
#' <br><br>
#' 
#' Following these steps should allow for converting R files into full blog posts with ease. Let's take a look at an example of some data:

a <- matrix(1:12, nrow = 3)
a

data(mtcars)

library(ggplot2)
ggplot(mtcars, aes(x=hp, y=mpg))+ 
  geom_point() +
  ggtitle('MPG as a function of horsepower - MTCars') +
  theme_bw()

boxplot(mtcars$cyl, mtcars$mpg,
        main = 'testplot2')


#+ post-entry, include=F
# source('~/Desktop/My files/blog/rberger997.github.io/src/convert-R-to-post.R')
# KnitPost('2018-07-18-R-to-Jekyll.R')
# Post.to.blog('2018-07-18-R-to-Jekyll.R')
