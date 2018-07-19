### This script is for taking R files to Jekyll blog posts

# While in the project directory, run KnitPost on file you'd like to post



KnitPost <- function(input, base.url = myjekyllsite) {
  # Site address
  myjekyllsite = c('https://rberger997.github.io/')
  
  # 
  require(knitr)
  spin(input, knit = T, format = 'Rmd', report = F)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("img/", sub(".R$", "", basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
}


# KnitPost('2018-07-18-R-to-Jekyll.R')


# The output is a .md file and img folder in the working directory

# To post on Jekyll, the .md file needs to go into the blog '_posts' folder, img folder into the blog img folder, and push to github.


# Function to copy the output files to local blog folders
# Will copy the .md file to blog '_posts' folder, img folder to blog 'img' folder

Post.to.blog <- function(input){
  # Where the files are going on my computer (blog local directory)
  postdir <- '~/Desktop/My files/blog/rberger997.github.io/_posts/'
  imagedir <- '~/Desktop/My files/blog/rberger997.github.io/img/'
  
  input <- gsub('.R$', '',input)    # Remove .R from input
  # Make copy of markdown file in '_posts' folder of blog directory
  file.copy(paste0(input,'.md'), postdir, recursive = T, overwrite = T)
  file.rename(from = paste0(postdir, input, '.md'), 
              to = paste0(postdir,Sys.Date(),'-', input, '.md'))
  # Make copy of img folder and move to 'img' folder of blog directory
  newimg <- paste0(imagedir, input, '/')
  dir.create(path = newimg)
  imgfiles <- list.files(path = paste0('img/',input), full.names = T)
  file.copy(imgfiles, newimg, recursive = T, overwrite = T)
  print(paste(input, 'Posted'))
}



# Add this block to the bottom of your .R blog post file:

#+ post-entry, include=F
# source('~/Desktop/My files/blog/rberger997.github.io/src/convert-R-to-post.R')
# KnitPost('2018-07-18-R-to-Jekyll.R')
# Post.to.blog('2018-07-18-R-to-Jekyll.R')

