
#' report number of points in each categorical variable on the x axis
#'
#' @param mapping as in ggplot2
#' @param data as in ggplot2
#' @param geom as in ggplot2
#' @param position as in ggplot2
#' @param inherit.aes as in ggplot2
#' @param show.legend as in ggplot2
#' @param na.rm as in ggplot2
#' @param ... as in ggplot2
#'
#' @return
#' @export
#'
#' @examples
#'
#' data(mtcars)
#'
#' ggplot(mtcars, aes(factor(cyl), y = mpg))+
#' geom_boxplot()+
#' stat_n_lowest_point()
#'
stat_n_lowest_point <- function(mapping = NULL, data = NULL, geom = "text",
                                position = "identity", inherit.aes = TRUE, show.legend = NA,
                                na.rm = FALSE, ...) {
  ggplot2::layer(stat = StatN, mapping = mapping, data = data, geom = geom,
                 position = position, inherit.aes = inherit.aes, show.legend = show.legend,
                 params = list(na.rm = na.rm, ...))
}
