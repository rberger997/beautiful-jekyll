---
layout: post
title: "new test"
author: "Ryan"
date: "July 18, 2018"
output: 
  html_document:
    keep_md: true
preserve_yaml: true
---
**Title test**
This is a test of making an R script and using rmarkdown::render() to convert it to a markdown document that can be easily uploaded to a blog page. Lets add some data to test how it works.




{% highlight r %}
a <- matrix(1:12, nrow = 3)
a
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    1    4    7   10
## [2,]    2    5    8   11
## [3,]    3    6    9   12
{% endhighlight %}



{% highlight r %}
data(mtcars)

library(ggplot2)
ggplot(mtcars, aes(x=hp, y=mpg))+ 
  geom_point()
{% endhighlight %}

![center](https://rberger997.github.io/figs/2018-07-18-test_render/unnamed-chunk-1-1.png)

