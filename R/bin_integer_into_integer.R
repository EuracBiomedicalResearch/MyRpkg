
#' Bin an integer/numeric variable
#'
#' @param A `numeric` vector
#' @param multiples An `integer` or `numeric` vector to bin `x` with
#' @param include_highest Do you want to include upper or lower values in the bin? eg: if `multiples = 5` include_highest --> $value \leqslant 5$, otherwise $value \l 5$
#'
#' @return
#' @export
#'
#' @examples
#' data(mtcars)
#' bin_integer_into_integer(mtcars$mpg, multiples = 10, include_highest= TRUE)
#' bin_integer_into_integer(mtcars$mpg, multiples = 10, include_highest= FALSE)
#'
bin_integer_into_integer <- function(x, multiples, include_highest = TRUE){
  brks <- seq(0, max(x)+multiples, multiples) # divided by 7 and a very small value, to include
  x_fact <- as.character(cut(x, breaks = brks)) %>%
    strsplit(split = "\\(|\\]") %>% sapply("[", 2) %>%
    strsplit(split = ",", fixed = TRUE) %>% sapply("[", 2) %>%
    as.numeric()
  x_fact_divided <- x_fact/multiples

  return(x_fact_divided)
}
