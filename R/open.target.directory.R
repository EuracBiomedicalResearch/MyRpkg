#' Open file/plot directory
#'
#' Given a PATH, either ending with "/" or a file name, this function opens a window to show you that directory.
#'
#' @param element_path The path, written unix-style. it has to be absolute, either from the root, or from the std. home ("~/")
#' @return A window opened on your file browsing element ("Finder" or "Explorer")
#' @export
#'
#' @examples
#' # in Unix (Linux or Mac)
#' open.target.directory("/home/user/Documents/my_superImportantDoc.txt")
#' # in Windows
#' open.target.directory("C:/Users/user/Documents/my_superImportantDoc.txt")
#'
#'
open.target.directory <- function(element_path){

  if (.Platform$OS.type == "windows"){
    if(!(str_sub(plot_path, start = nchar(plot_path), end = nchar(plot_path)) == "/")){ # if the directory name given ends with "/", then we can play with it without manipulation, otherwise, we need to do some managing
      s <- strsplit(plot_path, "/")[[1]]
      s_sub <- s[1:length(s)-1]
      plot_path_windows <- paste(s_sub, collapse = "\\") %>% paste("\\", sep = "")
    } else{ # if it ends with "/", just translate the "/" character
      plot_path_windows <- gsub(pattern = "/", replacement = "\\\\", x = plot_path)
    }

    shell.exec(plot_path_windows)
  } else{ # if it is not windows
    if(!(str_sub(plot_path, start = nchar(plot_path), end = nchar(plot_path)) == "/")){
      s <- strsplit(plot_path, "/")[[1]]
      s_sub <- s[1:length(s)-1]
      plot_path_unix <- paste(s_sub, collapse = "/") %>% paste("/", sep = "")
      system(paste(Sys.getenv("R_BROWSER"), plot_path_unix))
    } else{
      system(paste(Sys.getenv("R_BROWSER"), plot_path))
    }

  }
}
