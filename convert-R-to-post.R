### This script is for taking R files to Jekyll blog posts

# While in the project directory, run KnitPost on file you'd like to post


# Site address
myjekyllsite = c('https://rberger997.github.io/')

KnitPost <- function(input, base.url = myjekyllsite) {
  require(knitr)
  spin(input, knit = T, format = 'Rmd', report = F)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("img/", sub(".R$", "", basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
}

KnitPost('2018-07-18-R-to-Jekyll.R')


# Results are a .md file and images in the folder labeled img/ in the directory

# To post on Jekyll, drag the .md file into posts folder, image folder into the img folder, and push to github




## In progress: make a function that automatically copies files to folders
## Problem is need to copy entire image folder
## Would need to do a dir.create > file.copy everything to new dir

JekyllPost <- function(input){
  # Where the files are going on my computer (blog local directory)
  postdir <- '~/Desktop/My files/blog/rberger997.github.io/_posts/'
  imagedir <- '~/Desktop/My files/blog/rberger997.github.io/img/'
  # Make copies of the files
  file.copy(paste0(input,'.md'), postdir)
}
file.copy()

JekyllPost('2018-07-18-R-to-Jekyll')