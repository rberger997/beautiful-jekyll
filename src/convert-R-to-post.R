#------------------
### This script is for taking R files to Jekyll blog posts
#
# inspired by https://www.r-bloggers.com/creating-jekyll-blog-posts-from-r/
#
# Instructions:
# 1. Save this script and update myjekyllsite, postdir, and imagedir
# 2. Move to directory of the script you'd like to post
# 3. Source this script
# 4. Pick a name for the project (new folders will be named this on blog source)
# 5. Run Post.to.blog('file-i-want-to-post.R', projectid = 'name_of_proj')
# 6. Push changes to github
# 7. Check blog to make sure it posted
#------------------


Post.to.blog <- function(input, base.url = myjekyllsite, projectid) {
  #-------------
  ## CHANGE THIS TO YOUR SITE URL ##
  myjekyllsite <-  c('https://rberger997.github.io/')
  ## CHANGE THESE DIRECTORIES TO YOUR LOCAL BLOG DIRECTORIES ##
  postdir <- '~/Desktop/My files/blog/rberger997.github.io/_posts/'
  imagedir <- '~/Desktop/My files/blog/rberger997.github.io/img/'
  sourcedir <- '~/Desktop/My files/blog/rberger997.github.io/posts-source-files/'
  #-------------
  
  ## Spin with knitr ##
  require(knitr)
  spin(input, knit = T, format = 'Rmd', report = F)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("img/",projectid, "/")
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
  newimg <- paste0(imagedir,projectid, '/')
  dir.create(path = newimg)
  imgfiles <- list.files(path = paste0('img/',projectid,'/'), full.names = T)
  file.copy(imgfiles, newimg, recursive = T, overwrite = T)
  # Delete files created in wd for posting (.md, .txt, img/)
  file.remove(paste0(input, '.md'))
  unlink('img/', recursive = T)
  
  ## Create copy of .R file in posts-source-files folder
  newsource <- paste0(sourcedir, projectid)
  dir.create(path = newsource)
  file.copy(paste0(input, '.R'), newsource, recursive = T, overwrite = T)
  
  # Finished message
  print(paste(input, 'Posted'))
}


# Add this block to the bottom of your .R blog post file:

#+ post-entry, include=F
# source('~/Desktop/My files/blog/rberger997.github.io/src/convert-R-to-post.R')
# Post.to.blog('2018-07-18-R-to-Jekyll.R')