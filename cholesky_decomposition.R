# Cholesky decomposition

# Dimension
p <- 2


# S is a random "covariance matrix"
S <- crossprod(matrix(rnorm(p^2), p, p))


# For evolutionary algorithms we need to express our objects as vectors of numbers
# For S, we can do it by taking the upper triangle

S[upper.tri(S, diag = TRUE)]
S


# However, this can be dangerous as not all such vectors correspond to covariance matrices!
# For example, the following (for p = 2) is not a covariance matrix as it would give correlation > 1
b = c(1, 2, 1) ### this is the upper triangle of S in vector form

S <- matrix(c(1, 2, 2, 1), 2, 2)
diag(diag(S)^(-1/2))%*%S%*%diag(diag(S)^(-1/2))
# Correlation = 2 (!)


# This means that an evolutionary algorithms (which does not understand these "boundaries")
# can tell us that the optimal (deepest) object is something which is not even a covariance matrix



# A possible solution:
# Cholesky decomposition


p <- 3
S <- crossprod(matrix(rnorm(p^2), p, p))
S


# Every S can be written as t(U)%*%U where U is upper triangular produced by Cholesky decomposition
U <- chol(S)
U


t(U)%*%U
S


U[upper.tri(U, diag = TRUE)]



# Every such vector corresponds to a covariance matrix!
# We can "encode" the covariance matrices using the upper triangular part of their Cholesky decomposition.


# Sample of covariance matrices
# -> Cholesky decomposition -> a sample of vectors
# (Apply PCA to the sample vectors)
# Run the evolutionary algorithm on the sample of vectors
# ("Undo" PCA)
# -> transform the result back into a covariance matrix






# Some next steps:
# 1. Play with the above code and familiarize yourself with the Cholesky decomposition 
# 2. Write function that turn S into the upper triangular part of their Cholesky decomposition as a vector


Matrix_to_vector = function(CovMatrix){
  
  U <- chol(CovMatrix)
  U[upper.tri(U, diag = TRUE)]
  
}


v = Matrix_to_vector(S)


# 3. Write the corresponding inverse function



vector_to_matrix = function(Cholvec){
  
  z = matrix(0,dim(S)[1],dim(S)[1])
  z[upper.tri(z, diag = TRUE)] <- Cholvec
  return(t(z)%*%z)
}


vector_to_matrix(v)


quad <- function(a, b, c)
{
  a <- as.complex(a)
  answer <- c((-b + sqrt(b^2 - 4 * a * c)) / (2 * a),
              (-b - sqrt(b^2 - 4 * a * c)) / (2 * a))
  if(all(Im(answer) == 0)) answer <- Re(answer)
  if(answer[1] == answer[2]) return(answer[1])
  answer
}

quad(1,-1,-2*length(v))

dim = sqrt(2*length(v)+(1/4)) - 0.5

#
# 4. Because the "encoded" vectors can be very long, we could do PCA to reduced their dimension! Let's think how this could be done.







