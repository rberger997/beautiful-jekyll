---
layout: post
title: "DSPA650 Chapter 4 Assignment"
subtitle: "MOOC Section"
author: "Ryan Berger"
date: "July 3, 2018"
output:
   html_document:
     toc: true
     highlight: default
     keep_md: true
 preserve_yaml: true
---



## 1. How is Matrix multiplication defined?
**Validate that $(A_{k,n} \times B_{n,m})^T=(B^T_{m,n})×(A^T_{n,k})$ using both - first principles 
math as well as using internal R funcitons.**
<br><br>
Multiplication of matrices can either be elementwise or matrix multiplication
depending on the dimensions of the matrices. Elementwise can only be done 
if the dimensions of the matrices are the same. Matrix multiplication can only
be done if there are n columns of the first matrix and n rows of the second.
<br><br>
Let's set up two matrices, A and B, with dimensions $2 \times 2$ and $2 \times 3$.


{% highlight r %}
A <- matrix(1:4, nrow = 2)
B <- matrix(5:10, nrow = 2)
# Check dimensions
dim(A);dim(B)
{% endhighlight %}



{% highlight text %}
## [1] 2 2
{% endhighlight %}



{% highlight text %}
## [1] 2 3
{% endhighlight %}

The way matrix multiplication works is by multiplying row terms of the first
matrix by column terms of the second and adding them up.
Lets calculate those manually for A and B.


{% highlight r %}
# Row 1 of the product matrix
r1 <- c(sum(A[1,]*B[,1]), sum(A[1,]*B[,2]),sum(A[1,]*B[,3]))
# Row 2 of the product matrix
r2 <- c(sum(A[2,]*B[,1]),sum(A[2,]*B[,2]),sum(A[2,]*B[,3]))
{% endhighlight %}

The product matrix becomes:


{% highlight r %}
C <- rbind(r1,r2)
C
{% endhighlight %}



{% highlight text %}
##    [,1] [,2] [,3]
## r1   23   31   39
## r2   34   46   58
{% endhighlight %}

If we transpose that matrix we get $(A_{k,n} \times B_{n,m})^T$ from the 
original equation:


{% highlight r %}
t(C)
{% endhighlight %}



{% highlight text %}
##      r1 r2
## [1,] 23 34
## [2,] 31 46
## [3,] 39 58
{% endhighlight %}

Let's verify that it's equal to $(B^T_{m,n})×(A^T_{n,k})$. To do this we'll
transpose A and B first and then run the same operations:


{% highlight r %}
# Transpose matrices
X <- t(A)
Y <- t(B)
dim(X);dim(Y)
{% endhighlight %}



{% highlight text %}
## [1] 2 2
{% endhighlight %}



{% highlight text %}
## [1] 3 2
{% endhighlight %}



{% highlight r %}
# Will multiply Y x X now. Product matrix has 3 rows
r1 <- c(sum(Y[1,]*X[,1]), sum(Y[1,]*X[,2]))
r2 <- c(sum(Y[2,]*X[,1]), sum(Y[2,]*X[,2]))
r3 <- c(sum(Y[3,]*X[,1]), sum(Y[3,]*X[,2]))

Z <- rbind(r1,r2,r3)
Z
{% endhighlight %}



{% highlight text %}
##    [,1] [,2]
## r1   23   34
## r2   31   46
## r3   39   58
{% endhighlight %}

When we compare this to the transposed product matrix C we see that they are equal:


{% highlight r %}
Z ; t(C)
{% endhighlight %}



{% highlight text %}
##    [,1] [,2]
## r1   23   34
## r2   31   46
## r3   39   58
{% endhighlight %}



{% highlight text %}
##      r1 r2
## [1,] 23 34
## [2,] 31 46
## [3,] 39 58
{% endhighlight %}



{% highlight r %}
Z == t(C)
{% endhighlight %}



{% highlight text %}
##    [,1] [,2]
## r1 TRUE TRUE
## r2 TRUE TRUE
## r3 TRUE TRUE
{% endhighlight %}

<br><br>
Now let's do the same using built-in R functions. Calculate $A \times B$:


{% highlight r %}
A %*% B
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3]
## [1,]   23   31   39
## [2,]   34   46   58
{% endhighlight %}

Let's compare both sides of the equation $(A_{k,n} \times B_{n,m})^T=
(B^T_{m,n})×(A^T_{n,k})$ to verify that they are equal:


{% highlight r %}
t(A %*% B) ; t(B) %*% t(A)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2]
## [1,]   23   34
## [2,]   31   46
## [3,]   39   58
{% endhighlight %}



{% highlight text %}
##      [,1] [,2]
## [1,]   23   34
## [2,]   31   46
## [3,]   39   58
{% endhighlight %}



{% highlight r %}
t(A %*% B) == t(B) %*% t(A)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2]
## [1,] TRUE TRUE
## [2,] TRUE TRUE
## [3,] TRUE TRUE
{% endhighlight %}

## 2. Scalar vs. matrix multiplication
**Demonstrate the differences between the scalar multiplication and 
matrix multiplication (\*) for numbers, vectors, and matrices (second order
tensors).** <br>

Let's make a number, vector and matrix:


{% highlight r %}
num <- 10
vec <- seq(1:10)
mat <- matrix(1:12, nrow = 3)
{% endhighlight %}

To show how scalar multiplication affects each we'll multiply them by 2:


{% highlight r %}
num*2 ; vec*2 ; mat*2
{% endhighlight %}



{% highlight text %}
## [1] 20
{% endhighlight %}



{% highlight text %}
##  [1]  2  4  6  8 10 12 14 16 18 20
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    2    8   14   20
## [2,]    4   10   16   22
## [3,]    6   12   18   24
{% endhighlight %}

Scalar multiplication of a vector and matrix:


{% highlight r %}
vec*mat
{% endhighlight %}



{% highlight text %}
## Warning in vec * mat: longer object length is not a multiple of shorter
## object length
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]    1   16   49  100
## [2,]    4   25   64   11
## [3,]    9   36   81   24
{% endhighlight %}

Doing this multiplies values of the vector with elements in the matrix by
going down each column. In this case the length of the vector or dimensions 
of the matrix don't matter, it will continue until it reaches the end of the 
vector or matrix. Compare that to matrix multiplication:


{% highlight r %}
vec %*% mat
{% endhighlight %}



{% highlight text %}
## Error in vec %*% mat: non-conformable arguments
{% endhighlight %}

For matrix multiplication the vector length must match either the number of 
rows (n) or columns (m) of the matrix. The order of terms must also match up
like so:  $A_{n,m} \times v_m$  or  $v_n \times A_{n,m}$  or  $A_{n,m}^T \times 
v_n$. 



{% highlight r %}
dim(mat)
{% endhighlight %}



{% highlight text %}
## [1] 3 4
{% endhighlight %}



{% highlight r %}
# rename matrix with dimensions 
A3.4 <- mat 

# Create vectors with lengths matching dimensions
vec4 <- seq(1:4)
vec3 <- seq(1:3)

A3.4 %*% vec4
{% endhighlight %}



{% highlight text %}
##      [,1]
## [1,]   70
## [2,]   80
## [3,]   90
{% endhighlight %}



{% highlight r %}
vec3 %*% A3.4
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]   14   32   50   68
{% endhighlight %}



{% highlight r %}
t(A3.4) %*% vec3
{% endhighlight %}



{% highlight text %}
##      [,1]
## [1,]   14
## [2,]   32
## [3,]   50
## [4,]   68
{% endhighlight %}

## 3. Matrix equations
**Write a simple matrix solver $(b = Ax,$ i.e., $x = A^-1b)$ and validate its
accuracy using the `R` command `solve(A,b)`. Then, solve this system of 
equations:
$$
\begin{align*}	
2a - b + 2c &= 5 \\
-1 - 2b + c &= 3 \\
a + b - c &= 2
\end{align*}	
$$
**
To solve $b = Ax$ for x, you must calculate the inverse of A and multiply
that by b. We'll set up a simple function to perform this calculation:


{% highlight r %}
matrix_solver <- function(A, b){
  A.inv <- solve(A)
  return(A.inv %*% b)
}
{% endhighlight %}

To test the function let's make up a diagonal matrix of $m \times m$ dimensions and 
vector length m:


{% highlight r %}
A <- diag(11:20)
b <- rnorm(10)
{% endhighlight %}

Test the matrix solver and validate with the built-in `solve` function:


{% highlight r %}
matrix_solver(A, b) ; solve(A, b)
{% endhighlight %}



{% highlight text %}
##               [,1]
##  [1,]  0.055770103
##  [2,]  0.078548589
##  [3,]  0.105501747
##  [4,] -0.001732595
##  [5,] -0.043521613
##  [6,]  0.017122505
##  [7,]  0.108764890
##  [8,] -0.122310272
##  [9,] -0.081823561
## [10,]  0.035805688
{% endhighlight %}



{% highlight text %}
##  [1]  0.055770103  0.078548589  0.105501747 -0.001732595 -0.043521613
##  [6]  0.017122505  0.108764890 -0.122310272 -0.081823561  0.035805688
{% endhighlight %}

Now let's use this to solve the system of equations:
$$
\begin{align*}	
2a - b + 2c &= 5 \\
-1 - 2b + c &= 3 \\
a + b - c &= 2
\end{align*}	
$$
First let's convert a,b,and c to a matrix A:


{% highlight r %}
a <- c(2,-1,1)
b <- c(-1,-2,1)
c <- c(2,1,-1)
# Combine columns into a matrix
A <- cbind(a,b) %>% 
  cbind(c)
A
{% endhighlight %}



{% highlight text %}
##       a  b  c
## [1,]  2 -1  2
## [2,] -1 -2  1
## [3,]  1  1 -1
{% endhighlight %}

Next we'll make a vector b from the terms on the other side of the equation:


{% highlight r %}
b <- c(5,3,2)
{% endhighlight %}

We can now solve A for x using the `solve` function:


{% highlight r %}
solve(A, b)
{% endhighlight %}



{% highlight text %}
##    a    b    c 
##  3.5 -5.0 -3.5
{% endhighlight %}



{% highlight r %}
matrix_solver(A,b)
{% endhighlight %}



{% highlight text %}
##   [,1]
## a  3.5
## b -5.0
## c -3.5
{% endhighlight %}

## 4. Least square estimation
**Use the SOCR Knee Pain dataset, extract the `RB = Right-Back` locations $(x,y)$. 
Fit in a linear model for vertical location $(y)$ in terms of the horizontal 
location $(x)$. Display the linear model on top of the scatter plot of the 
paired data. Comment on the model you obtain.** <br><br>
First let's load the SOCR knee pain dataset:


{% highlight r %}
library(rvest)
wiki_url <- read_html('http://wiki.socr.umich.edu/index.php/SOCR_Data_KneePainData_041409')
kneepain <- html_table(html_nodes(wiki_url, 'table')[[2]])
head(kneepain)
{% endhighlight %}



{% highlight text %}
##    x   Y View
## 1 11  73   RF
## 2 20  88   RF
## 3 19  73   RF
## 4 15  65   RF
## 5 21  57   RF
## 6 26 101   RF
{% endhighlight %}

From this dataset we'll take horizontal location (x) and vertical location (y)
and convert them into two matrices. The x matrix will be a two column matrix
consisting of 1 in column 1 and x in column 2. Y matrix is a one column 
matrix of y values.


{% highlight r %}
# Make matrices
X <- cbind(1, kneepain$x)
Y <- kneepain$Y
head(X) ; head(Y)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2]
## [1,]    1   11
## [2,]    1   20
## [3,]    1   19
## [4,]    1   15
## [5,]    1   21
## [6,]    1   26
{% endhighlight %}



{% highlight text %}
## [1]  73  88  73  65  57 101
{% endhighlight %}

Next we'll use the matrices to solve the equation:  $\boldsymbol{\hat{\beta}}
 = (\mathbf{X}^\top \mathbf{X})^{-1} \mathbf{X}^\top \mathbf{Y}$ for $\boldsymbol{\hat{\beta}}$


{% highlight r %}
bhat <- solve(t(X) %*% X) %*% t(X) %*% Y
bhat
{% endhighlight %}



{% highlight text %}
##              [,1]
## [1,] 215.97643818
## [2,]  -0.02592205
{% endhighlight %}

Now we can use bhat to calculate fitted values of y for values of x.


{% highlight r %}
newx <- seq(min(X), max(X), len = 100)
X <- cbind(1, newx)
yfit <- X %*% bhat

# Plot results
plot(kneepain$x, kneepain$Y)
lines(newx, yfit, col = 'red')
{% endhighlight %}

![center](https://rberger997.github.io/img/DSPA650_Chapter4_Rberger/unnamed-chunk-21-1.png)

The results of this model look to match the data visually. The fitted line 
appears to cross through the most dense section of data of points. 



## 5. Matrix manipulation
Create a matrix $A$ with elements `seq(1, 15, length = 6)` and argument 
`nrow = 3`, 


{% highlight r %}
A <- matrix(seq(1, 15, length = 6), nrow = 3)
A 
{% endhighlight %}



{% highlight text %}
##      [,1] [,2]
## [1,]  1.0  9.4
## [2,]  3.8 12.2
## [3,]  6.6 15.0
{% endhighlight %}

add a row to this matrix; 


{% highlight r %}
A <- rbind(A, c(2,4))
A
{% endhighlight %}



{% highlight text %}
##      [,1] [,2]
## [1,]  1.0  9.4
## [2,]  3.8 12.2
## [3,]  6.6 15.0
## [4,]  2.0  4.0
{% endhighlight %}

add two columns to $A$ to obtain a matrix $C_{4,4}$ 


{% highlight r %}
C <- cbind(A, matrix(seq(100,800, length = 8), nrow = 4))
C
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4]
## [1,]  1.0  9.4  100  500
## [2,]  3.8 12.2  200  600
## [3,]  6.6 15.0  300  700
## [4,]  2.0  4.0  400  800
{% endhighlight %}

then generate a diagonal matrix $D$ with $dim=4$ and elements rnorm(4).


{% highlight r %}
D <- diag(rnorm(4))
D
{% endhighlight %}



{% highlight text %}
##          [,1]      [,2]      [,3]       [,4]
## [1,] 2.443284 0.0000000 0.0000000  0.0000000
## [2,] 0.000000 0.3708222 0.0000000  0.0000000
## [3,] 0.000000 0.0000000 0.8405917  0.0000000
## [4,] 0.000000 0.0000000 0.0000000 -0.9321389
{% endhighlight %}

Apply element wise addition, subtraction, multiplication and division to $C$ 
and $D$; 


{% highlight r %}
C + D
{% endhighlight %}



{% highlight text %}
##          [,1]     [,2]     [,3]     [,4]
## [1,] 3.443284  9.40000 100.0000 500.0000
## [2,] 3.800000 12.57082 200.0000 600.0000
## [3,] 6.600000 15.00000 300.8406 700.0000
## [4,] 2.000000  4.00000 400.0000 799.0679
{% endhighlight %}



{% highlight r %}
D - C
{% endhighlight %}



{% highlight text %}
##           [,1]      [,2]      [,3]      [,4]
## [1,]  1.443284  -9.40000 -100.0000 -500.0000
## [2,] -3.800000 -11.82918 -200.0000 -600.0000
## [3,] -6.600000 -15.00000 -299.1594 -700.0000
## [4,] -2.000000  -4.00000 -400.0000 -800.9321
{% endhighlight %}



{% highlight r %}
C * D
{% endhighlight %}



{% highlight text %}
##          [,1]     [,2]     [,3]      [,4]
## [1,] 2.443284 0.000000   0.0000    0.0000
## [2,] 0.000000 4.524031   0.0000    0.0000
## [3,] 0.000000 0.000000 252.1775    0.0000
## [4,] 0.000000 0.000000   0.0000 -745.7111
{% endhighlight %}



{% highlight r %}
D / C
{% endhighlight %}



{% highlight text %}
##          [,1]       [,2]        [,3]         [,4]
## [1,] 2.443284 0.00000000 0.000000000  0.000000000
## [2,] 0.000000 0.03039526 0.000000000  0.000000000
## [3,] 0.000000 0.00000000 0.002801972  0.000000000
## [4,] 0.000000 0.00000000 0.000000000 -0.001165174
{% endhighlight %}

apply matrix multiplication to $D$ and $C$; 


{% highlight r %}
D %*% C
{% endhighlight %}



{% highlight text %}
##           [,1]      [,2]       [,3]      [,4]
## [1,]  2.443284 22.966874  244.32845 1221.6422
## [2,]  1.409124  4.524031   74.16445  222.4933
## [3,]  5.547906 12.608876  252.17752  588.4142
## [4,] -1.864278 -3.728555 -372.85555 -745.7111
{% endhighlight %}

obtain the inverse of $C$ and compare it with a call to `ginv`. <br><br>


{% highlight r %}
solve(C)
{% endhighlight %}



{% highlight text %}
## Error in solve.default(C): system is computationally singular: reciprocal condition number = 4.44091e-20
{% endhighlight %}



{% highlight r %}
ginv(C)
{% endhighlight %}



{% highlight text %}
## Error in ginv(C): could not find function "ginv"
{% endhighlight %}

## 6. Matrix Transpose
**Validate the multiplicative transpose formula 
((Ak,n⋅Bn,m)T=(Bn,m)T⋅(Ak,n)T), both using math notation, as well as using
 R calls, e.g., you can try A = matrix(1:6,nrow=3), 
 B = matrix(2:7, nrow = 2).**<br><br> 


{% highlight r %}
A <- matrix(1:6, nrow = 3)
B <- matrix(2:7, nrow = 2)
{% endhighlight %}

Let's multiply these matrices manually. First the left side of the equation:


{% highlight r %}
C <- NULL
# Multiply A x B
for(i in 1:3){
  r <- c(sum(A[i,]*B[,1]), sum(A[i,]*B[,2]), sum(A[i,]*B[,3])) 
  C <- rbind(C, r)
}
t(C)
{% endhighlight %}



{% highlight text %}
##       r  r  r
## [1,] 14 19 24
## [2,] 24 33 42
## [3,] 34 47 60
{% endhighlight %}

Now let's do the same for the right side:


{% highlight r %}
tA <- t(A)
tB <- t(B)

D <- NULL
dim(tA) ; dim(tB)
{% endhighlight %}



{% highlight text %}
## [1] 2 3
{% endhighlight %}



{% highlight text %}
## [1] 3 2
{% endhighlight %}



{% highlight r %}
# Multiply tB x tA
for(i in 1:3){
    r <- c(sum(tB[i,]*tA[,1]), sum(tB[i,]*tA[,2]), sum(tB[i,]*tA[,3])) 
    D <- rbind(D, r)
}
{% endhighlight %}

When we compare both approaches the results are equal:


{% highlight r %}
t(C) ; D
{% endhighlight %}



{% highlight text %}
##       r  r  r
## [1,] 14 19 24
## [2,] 24 33 42
## [3,] 34 47 60
{% endhighlight %}



{% highlight text %}
##   [,1] [,2] [,3]
## r   14   19   24
## r   24   33   42
## r   34   47   60
{% endhighlight %}



{% highlight r %}
t(C) == D
{% endhighlight %}



{% highlight text %}
##         r    r    r
## [1,] TRUE TRUE TRUE
## [2,] TRUE TRUE TRUE
## [3,] TRUE TRUE TRUE
{% endhighlight %}

We can quickly show this using built-in R functions:


{% highlight r %}
t(A%*%B)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3]
## [1,]   14   19   24
## [2,]   24   33   42
## [3,]   34   47   60
{% endhighlight %}



{% highlight r %}
t(B) %*% t(A)
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3]
## [1,]   14   19   24
## [2,]   24   33   42
## [3,]   34   47   60
{% endhighlight %}



{% highlight r %}
all.equal(t(A%*%B),t(B) %*% t(A))
{% endhighlight %}



{% highlight text %}
## [1] TRUE
{% endhighlight %}

## 7. Sample statistics
**Use the SOCR Data Iris Sepal Petal Classes and extract the rows of `setosa` 
flowers. Compute the sample mean and variance of each variables; then 
calculate sample covariance and correlation between sepal width and sepal 
height.** <br><br> 


{% highlight r %}
# Load data
data(iris)
str(iris)
{% endhighlight %}



{% highlight text %}
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
{% endhighlight %}



{% highlight r %}
# Select setosa flowers
setosa <- filter(iris, Species == 'setosa')
head(setosa)
{% endhighlight %}



{% highlight text %}
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
{% endhighlight %}

Will use matrices to calculate the mean and variance of each variable. We'll
do so using the equation $\frac{1}{n}\mathbf{A}^\top Y$ where $\mathbf{A}$
is a $1 \times n$ matrix and $Y$ is the variable we're calculating:


{% highlight r %}
# Start with sepal.length
Y <- setosa[,1]

# Set up n and matrix A
n <- length(Y)
A <- matrix(rep(1, n))

# Calculate mean
1/n*(t(A)) %*% Y
{% endhighlight %}



{% highlight text %}
##       [,1]
## [1,] 5.006
{% endhighlight %}



{% highlight r %}
# Verify using mean function
mean(setosa$Sepal.Length)
{% endhighlight %}



{% highlight text %}
## [1] 5.006
{% endhighlight %}

Let's iterate over all the columns of setosa flowers to calculate the mean:


{% highlight r %}
for(i in 1:4){
  Y <- setosa[,i]
  n <- length(Y)
  A <- matrix(rep(1, n))
  result <- 1/n*(t(A)) %*% Y
  print(paste(colnames(setosa[i]), 'mean:',result))
}
{% endhighlight %}



{% highlight text %}
## [1] "Sepal.Length mean: 5.006"
## [1] "Sepal.Width mean: 3.428"
## [1] "Petal.Length mean: 1.462"
## [1] "Petal.Width mean: 0.246"
{% endhighlight %}

To calculate the variance we'll use the equation: 
$\frac{1}{n-1} \mathbf{Y'}^\top\mathbf{Y'}$


{% highlight r %}
# Iterate over all columns
for(i in 1:4){
  Y <- setosa[,i]
  n <- length(Y)
  Y1 <- Y - mean(Y)
  result <- crossprod(Y1)/(n-1)
  print(paste(colnames(setosa[i]), 'variance:', result))
}
{% endhighlight %}



{% highlight text %}
## [1] "Sepal.Length variance: 0.124248979591837"
## [1] "Sepal.Width variance: 0.143689795918367"
## [1] "Petal.Length variance: 0.0301591836734694"
## [1] "Petal.Width variance: 0.0111061224489796"
{% endhighlight %}



{% highlight r %}
for(i in 1:4){
print(var(setosa[,i]))
}
{% endhighlight %}



{% highlight text %}
## [1] 0.124249
## [1] 0.1436898
## [1] 0.03015918
## [1] 0.01110612
{% endhighlight %}

Calculate covariance using the formula  
$\Sigma=\frac{1}{n-1}(X-\bar{X})^T(X-\bar{X})$


{% highlight r %}
# Make matrix with setosa length/width columns
X <- setosa[,1:4] %>% 
  as.matrix()

dim(X)
{% endhighlight %}



{% highlight text %}
## [1] 50  4
{% endhighlight %}

X is a $50 \times 4$ matrix. Need to calculate column means for $\bar{X}$:


{% highlight r %}
xrow <- nrow(X)
vecx <- matrix(rep(1/xrow, xrow), ncol = xrow)
xbar <- vecx%*%X
{% endhighlight %}

Use $\bar{X}$ to make a matrix the same dimensions as $X$:


{% highlight r %}
xbar <- matrix(rep(xbar, each = xrow), ncol = ncol(X))
dim(xbar) ; dim(X)
{% endhighlight %}



{% highlight text %}
## [1] 50  4
{% endhighlight %}



{% highlight text %}
## [1] 50  4
{% endhighlight %}

Now we can plug each value into the equation:


{% highlight r %}
1/(nrow(X) - 1)*t((X - xbar)) %*% (X - xbar)
{% endhighlight %}



{% highlight text %}
##              Sepal.Length Sepal.Width Petal.Length Petal.Width
## Sepal.Length   0.12424898 0.099216327  0.016355102 0.010330612
## Sepal.Width    0.09921633 0.143689796  0.011697959 0.009297959
## Petal.Length   0.01635510 0.011697959  0.030159184 0.006069388
## Petal.Width    0.01033061 0.009297959  0.006069388 0.011106122
{% endhighlight %}

Compare to covariance calculated using the R function `cov`:


{% highlight r %}
cov(X)
{% endhighlight %}



{% highlight text %}
##              Sepal.Length Sepal.Width Petal.Length Petal.Width
## Sepal.Length   0.12424898 0.099216327  0.016355102 0.010330612
## Sepal.Width    0.09921633 0.143689796  0.011697959 0.009297959
## Petal.Length   0.01635510 0.011697959  0.030159184 0.006069388
## Petal.Width    0.01033061 0.009297959  0.006069388 0.011106122
{% endhighlight %}

## 8. Eigenvalues and Eigenvectors
**Generate a random matrix with `A = matrix(rnorm(9,0,1),nrow = 3)`, compute
 the eigenvalues and eigenvectors for A. Then try to solve this equation 
 $det(A−λI)=0$, where $λ$ is a vector of length 3. Compare $λ$ and the
  eigenvalues you computed above.** <br><br> 


{% highlight r %}
# Generate random matrix
set.seed(2010)
A <- matrix(rnorm(9,0,1), nrow = 3); A
{% endhighlight %}



{% highlight text %}
##              [,1]       [,2]       [,3]
## [1,] -0.537472741  0.2140099 -0.5398347
## [2,] -0.005191135 -0.2012531 -1.5206369
## [3,]  1.005671811  1.4474303  0.6527805
{% endhighlight %}



{% highlight r %}
# Get eigenvalues and eigenvectors for A
eigen(A)
{% endhighlight %}



{% highlight text %}
## eigen() decomposition
## $values
## [1]  0.2474495+1.611581i  0.2474495-1.611581i -0.5808444+0.000000i
## 
## $vectors
##                       [,1]                  [,2]          [,3]
## [1,]  0.0363587-0.2457158i  0.0363587+0.2457158i -0.8617014+0i
## [2,]  0.1754785-0.6274139i  0.1754785+0.6274139i  0.4916098+0i
## [3,] -0.7168409+0.0000000i -0.7168409+0.0000000i  0.1256605+0i
{% endhighlight %}

Solve the equation $det(A−λI)=0$, where $λ$ is a vector of length 3 


{% highlight r %}
lam <- eigen(A)$values
det(A - lam * diag(3))
{% endhighlight %}



{% highlight text %}
## Error in determinant.matrix(x, logarithm = TRUE, ...): 'determinant' not currently defined for complex matrices
{% endhighlight %}



