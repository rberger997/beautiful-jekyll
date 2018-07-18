### This script is for taking R markdown files to Jekyll blog


# Convert R file to Rmarkdown
inputfile <- '2018-07-18-test_render2.R'
knitr::spin(inputfile, knit = T, format = 'Rmd', report = F)




# Site address
myjekyllsite = c('https://rberger997.github.io/')

KnitPost <- function(input, base.url = myjekyllsite) {
  require(knitr)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("figs/", sub(".Rmd$", "", basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
}

KnitPost(paste0(inputfile, 'md'))

paste0('2018-07-18-test_render.R', 'md')

?spin
