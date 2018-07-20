---
layout: post
title: "Converting R files to Jekyll posts"
subtitle: "From .R to posted in 30 seconds"
author: "Ryan Berger"
date: "July 19, 2018"
output: 
  html_document:
    keep_md: true
preserve_yaml: true
---
I'm an R user and I have a confession to make: I really don't like working in R markdown documents. I've gotten so used to working with .R files in the RStudio console that R markdown seems cumbersome to use with all the code blocks separated from the markdown text. Not to mention I hate, **hate**, seeing plots and outputs show up in the text editor and not in the console or plots panel (maybe there's an option to fix that but I'm still out on R markdown). <br>

Now typically there's no problem with using .R scripts except for when it comes to posting the work on a Jekyll blog via github pages. I'm new at using these pages but from everything I've read it looks like this system plays nicely with Rmarkdown, which I dislike, but not so much with .R files. I could write in .R files, convert to .Rmd files, then post them but that seems like a waste of effort. Overall I wanted to find a way to:
- Do my analysis and writeup in a .R file
- Convert the .R file into a .md file
- Copy these files to my blogs local directory
- Push the changes to Github
- See the page on my Jekyll site
<br>

This took some time to figure out but I've come up with a solution that seems to work well. After getting some inspiration and borrowing some code from an [R-bloggers article](https://www.r-bloggers.com/creating-jekyll-blog-posts-from-r/), I've written a function that takes in a .R file and preps everything for a blog post; you just push your results to Github and you're done. Here is the script:



{% highlight r %}
### This script is for converting R files to Jekyll blog posts
# Instructions:
# 1. Save this script and update myjekyllsite, postdir, and imagedir
# 2. While in the project directory,  source this script
# 4. Run Post.to.blog('2018-07-19-file-i-want-to-post.R')
# 5. Push changes to github
# 6. Check blog to make sure it posted
{% endhighlight %}

{% highlight r %}
Post.to.blog <- function(input, base.url = myjekyllsite) {
  #-------------
  ## CHANGE THIS TO YOUR SITE URL ##
   myjekyllsite <-  c('https://YourName.github.io/')
  ## CHANGE THESE DIRECTORIES TO YOUR LOCAL BLOG DIRECTORIES ##
   postdir <- '~/Desktop/My files/blog/YourName.github.io/_posts/'
   imagedir <- '~/Desktop/My files/blog/YourName.github.io/img/'
  #-------------
  
  ## Spin with knitr ##
  require(knitr)
  spin(input, knit = T, format = 'Rmd', report = F)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("img/",sub(".R$", "",basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
  file.remove(paste0(sub('.R$','.txt',input))) # delete .txt file
  
  ## Move files into blog post directory ##
  
  # Remove .R from input
  input <- gsub('.R$', '',input)    
  # Make copy of markdown file in '_posts' folder of blog directory
  file.copy(paste0(input,'.md'), postdir, recursive = T, overwrite = T)
  # Make copy of img folder and move to 'img' folder of blog directory
  newimg <- paste0(imagedir,input, '/')
  dir.create(path = newimg)
  imgfiles <- list.files(path = paste0('img/',input), full.names = T)
  file.copy(imgfiles, newimg, recursive = T, overwrite = T)
  print(paste(input, 'Posted'))
  # Delete files created in wd for posting (.md, .txt, img/)
  file.remove(paste0(input, '.md'))
  unlink('img/', recursive = T)
}
{% endhighlight %}

Copy this function and save into an R file (mine is 'convert-R-to-post.R'). Note that you'll need to update the `myjekyllsite`,`postdir`, and `imgdir` to your own site URL and local directories for posts and images. The .R file that you want to post will also need to have the appropriate YAML header to be recognized by Jekyll. An example header used for this post is as follows (with #' instead of #):


{% highlight r %}
# layout: post
# title: "Converting R files to Jekyll posts"
# author: "Ryan Berger"
# date: "July 18, 2018"
# output: 
#   html_document:
#     keep_md: true
# preserve_yaml: true
# ---
{% endhighlight %}

<br>
When you are ready to make a post to your blog simply run `source('convert-R-to-post.R'` and `Post.to.blog('2018-07-19-file-i-want-to-post.R')`. The .md file sohuld automatically go to your `postdir` folder and images go to your `img` folder. Push this to Github and everything should post on your Jekyll github page. (**Note: filenames should have format of 'YYYY-MM-DD-filename.R' to work effectively with the Jekyll post format).
<br><br>
I just started using this today and it works great for me but it will need to be tested for reproducibility. Also I'm new at making Jekyll blogs so this may not be the most efficient way to accomplish this. I can say, however, that it works; this post was written entirely in a .R file and was quickly posted using the script. Let's take a look at some example data just to make sure that R outputs and plots are showing up correctly:


{% highlight r %}
a <- matrix(1:12, nrow = 3)
a*2
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    2    8   14   20
## [2,]    4   10   16   22
## [3,]    6   12   18   24
{% endhighlight %}



{% highlight r %}
# Test a plot
data(mtcars)
library(ggplot2)
ggplot(mtcars, aes(x=hp, y=mpg, col=wt))+ 
  geom_point() +
  ggtitle('MPG as a function of horsepower - MTCars')
{% endhighlight %}

![center](https://rberger997.github.io/img/2018-07-19-R-to-Jekyll/unnamed-chunk-4-1.png)

{% highlight r %}
# test boxplot
boxplot(mtcars$cyl, mtcars$mpg,
        main = 'testplot2',
        col = c('red', 'blue'))
{% endhighlight %}

![center](https://rberger997.github.io/img/2018-07-19-R-to-Jekyll/unnamed-chunk-4-2.png)

*This post was written entirely in a .R file. To see the full source, click [here](https://github.com/rberger997/rberger997.github.io/blob/master/posts-in-progress/2018-07-19-R-to-Jekyll.R)*



