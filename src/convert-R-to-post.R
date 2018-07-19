#------------------
### This script is for taking R files to Jekyll blog posts
#
# inspired by https://www.r-bloggers.com/creating-jekyll-blog-posts-from-r/
#
# Instructions:
# 1. Save this script and update myjekyllsite, postdir, and imagedir
# 2. While in the project directory,  source this script
# 3. Run KnitPost('file-i-want-to-post.R')
# 4. Run Post.to.blog('file-i-want-to-post.R')
# 5. Push changes to github
# 6. Check blog to make sure it posted
#------------------


## Update these sections for your own site:
# Site address
myjekyllsite <-  c('https://rberger997.github.io/')

# Where the files are going on my computer (blog local directory)
postdir <- '~/Desktop/My files/blog/rberger997.github.io/_posts/'
imagedir <- '~/Desktop/My files/blog/rberger997.github.io/img/'




# Function for making .md file from .R file for posting on jekyll:
KnitPost <- function(input, base.url = myjekyllsite) {
  require(knitr)
  spin(input, knit = T, format = 'Rmd', report = F)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("img/", sub(".R$", "", basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
  file.remove(paste0(sub('.R$','',input), '.txt')) # delete .txt file
}


# The output is a .md file and img folder in the working directory

# To post on Jekyll, the .md file needs to go into the blog '_posts' folder, img folder into the blog img folder, and push to github.


# Function to copy the output files to local blog folders
# Will copy the .md file to blog '_posts' folder, img folder to blog 'img' folder

Post.to.blog <- function(file.R){
  input <- gsub('.R$', '',file.R)    # Remove .R from input
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
  # Delete files created in wd for posting (.md, .txt, img/)
  file.remove(paste0(input, '.md'))
  unlink('img/', recursive = T)
}

# Add this block to the bottom of your .R blog post file:

#+ post-entry, include=F
# source('~/Desktop/My files/blog/rberger997.github.io/src/convert-R-to-post.R')
# KnitPost('2018-07-18-R-to-Jekyll.R')
# Post.to.blog('2018-07-18-R-to-Jekyll.R')

