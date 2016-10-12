##
## This script tests the functionality of testCacheMatrix
##  - test matrix is created
##  - it's inverse is computed and printed for reference
##  - makeCacheMatrix() is called to create object using test matrix
##  - a get() object call is performed to check if test matrix is returned
##  - a getInverse() call is performed to check if inverse is computed correctly
##  - another getInverse() call is performed to check if inverse is now returned from cache

testmatrix <- matrix(1:4,2,2)
message('This is your input matrix')
print(testmatrix)
message('This is your reference output for the inverse matrix')
print(solve(testmatrix))
message('')
message('a <- Calling makeCacheMatrix(testmatrix)...')
junk <- capture.output(a <- makeCacheMatrix(testmatrix))
message('')
message('Retrieve the stored matrix using a$get()')
print(a$get())
message('call cacheSolve(a)...it should print the inverse with no reference to caching .....')
print(cacheSolve(a))
message('call cacheSolve(a)...it should print it is recalling cached inverse....')
print(cacheSolve(a)) 
