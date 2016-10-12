## 
## This Coursera R Programming Course assignment from Week3 requires implementation of Matrix Inversion
## using Lexical Scoping rules. Lexical Scoping allows creation of complicated user objects along with
## using variables for attributes and specifying the associated get/set functions for processing the
## attributes.
##
## In this assignment a Matrix object is created and it's inverse is stored as one of it's properties.
## Since the inverse is a time-consuming process, it is computed ONLY IF/WHEN REQUIRED. Once computed,
## It is cached so that it may be retrieved quickly
##
## There are two functions: 
##   1. makeCacheMatrix is called by users to create a matrix object with a NULL inverse and some 
##      get/set functions to access the attribute or (re)set the matrix.
##
##   2. cacheSolve is called by users to retrieve the inverse of the matrix object created by (1).
##      If a inverse is available, the cached value is returned. Else it is created by this function
##      and the inverse value is updated using the appropriate setter function (set_inverse)


######################################################################################################
##  Function makeCacheMatrix(x): creates an R object that stores the matrix and its inverse
##    and provides get/set methods to retrieve the inverse and the object
##    
##    Input: 
##    x: a fully-defined matrix provided by the caller
##
##    Returns: A list of 4 functions that works on the object
##    set: allows the caller to reset the matrix object
##    get: returns the matrix x stored by the object
##    get_inverse: returns the inverse matrix. May be NULL or may be computed previously
##    set_inverse: updates the inverse value of the matrix
#######################################################################################################
makeCacheMatrix <- function(x = matrix()) {
     inverse_x <- NULL          # stores the inverse matrix. Not computed when object created.
     
     # create function to (re)set matrix object to a different value
     set <- function(newmatrix) {
          x <<- newmatrix        # Lexical scoping carries the value forever  
          inverse_x <<- NULL     # Lexical scoping carries the value forever
     }
     
     # create function to return the matrix object
     get <- function() x         

     # create function to set the inverse of the matrix object
     setInverse <- function(inverse) inverse_x <<- inverse   # Lexical scoping
     
     # create function to retrieve the matrix stored by the object
     getInverse <- function() inverse_x
     
     # returnlist of 4 functions -> 4 operations possible on this special matrix object
     list(set = set, get = get,
          setInverse = setInverse,
          getInverse = getInverse)
}


######################################################################################################
##  Function cacheSolve(x): Returns inverse of matrix x. Since computing the inverse is time-consuming
##    it first checks if an inverse has been computed earlier. If so, then it just retrieves the
##    inverse and returns the values. If not, it computes the inverse, updates the object with the
##    newly-computed inverse, and also returns the inverse.
##    
##    Input: 
##    x: a fully-defined matrix provided by the caller
##
##    Returns: inverse of the matrix object
##
##    ASSUMPTION: the input matrix is invertible. Some matrices are not. A check is not performed.
##
#######################################################################################################
cacheSolve <- function(x, ...) {
     
     ## check if an inverse already exists, else compute one
     temp_inverse <- x$getInverse()
     if (! is.null(temp_inverse)) {
          message("getting cached inverse")
     }
     else {
          temp_inverse <- solve(x$get())
          x$setInverse(temp_inverse)
     }
     return(temp_inverse)
}

# source("testCacheSolve.R") to test the function
#
# or....just run the following on console
#
#
#testmatrix <- matrix(1:4,2,2)
#message('This is your input matrix')
#print(testmatrix)
#message('This is your reference output for the inverse matrix')
#print(solve(testmatrix))
#message('')
#message('a <- Calling makeCacheMatrix(testmatrix)...')
#junk <- capture.output(a <- makeCacheMatrix(testmatrix))
#message('')
#message('Retrieve the stored matrix using a$get()')
#print(a$get())
#message('call cacheSolve(a)...it should print the inverse with no reference to caching .....')
#print(cacheSolve(a))
#message('call cacheSolve(a)...it should print it is recalling cached inverse....')
#print(cacheSolve(a)) 
#




