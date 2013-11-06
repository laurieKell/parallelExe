#' Sets up an executable file in subdirectory  
#'
#' @description Creates subdirectory with an executable file.
#' @return a list of directories where the output files can be found
#' @export
#' @examples
#' \dontrun{set("mfcl")}
if (!isGeneric("set"))  setGeneric('set',   function(x,...)     standardGeneric('set'))


#' Runs an executable file in subdirectory  
#'
#' @description Creates subdirectory with an executable file and runs it.
#' @return a list of directories where the output files can be found
#' @export
#' @examples
#' \dontrun{exe("mfcl")}
if (!isGeneric("exe"))  setGeneric('exe',   function(x,...)     standardGeneric('exe'))
