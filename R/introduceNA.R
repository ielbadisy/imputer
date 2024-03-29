#' Introduce missing values
#'
#' @param x dataset with NA
#' @param p proportion of NA
#' @param seed seed value
#'
#' @return value
#' @export
#'
#' @examples
#' irisNA <- introduceNA(iris, 0.2)
#' mean(is.na(iris))

introduceNA <- function(x, p = 0.2, seed = 123) {
  
  stopifnot(p >= 0, p <= 1, is.atomic(x) || is.data.frame(x))
  
  set.seed(seed)  
  
  generate_na_vec <- function(z, p) {
    
  n <- length(z) 
  
  z[sample(n, floor(p * n))] <- NA
  z
  } 
  
  # vector or matrix
  if (is.atomic(x)) return(generate_na_vec(x, p))
  
  # data frame
  
  v <- if (is.null(names(p))) names(x) else intersect(names(p), names(x))
  x[, v] <- Map(generate_na_vec, x[, v, drop = FALSE], p)
  x
  
  }



