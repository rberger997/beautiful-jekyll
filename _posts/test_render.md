**Title test** This is a test of making an R script and using
rmarkdown::render() to convert it to a markdown document that can be
easily uploaded to a blog page. Lets add some data to test how it works.

    a <- matrix(1:12, nrow = 3)
    a

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    4    7   10
    ## [2,]    2    5    8   11
    ## [3,]    3    6    9   12

    data(mtcars)
    plot(mtcars$mpg ~ mtcars$hp)
    abline(lm(mtcars$mpg ~ mtcars$hp), col = 'red')

![](test_render_files/figure-markdown_strict/unnamed-chunk-1-1.png)
