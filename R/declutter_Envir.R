#' Delete temporary or test objects in `ls()`
#'
#' This function deletes all items (object, function, ...) containing either 'tmp' or 'test' in the name. Also, if the name is only 1 letter long, it will be deleted
#'
#' @param extra_rules defines extra patterns to delete (eg: extra_rules = c("temp","delete"))
#'
#' @export
#'
#' @example
#' declutter_Envir(extra_rules = c("papaya", "attempt"))

declutter_Envir <- function(extra_rules = NULL){
  all_rules.t0 <- paste("tmp", extra_rules, "test", sep = "|")

  obj_to_del <- grep(all_rules.t0, ls(envir = parent.frame(1)), value = TRUE)
  obj_to_del_grep <- obj_to_del[2:length(obj_to_del)]

  obj_to_del_final <- c(obj_to_del_grep,
                        ls(envir = parent.frame(1))[nchar(ls(envir = parent.frame(1))) ==1]
                        )

  rm(list = obj_to_del_final, envir = parent.frame(1))
  objs.t1 <- ls(envir = parent.frame(1))
  cat("elements removed:\n")
  return(objs.t0[!(objs.t0 %in% objs.t1)])
}
