removeP5andP7FromNames <- function(x) {
  str_remove_all(x, pattern = "P[57]")
}

createSuperSet <- function(x, y) {
  union(x, y)
}

returnCombinations <- function(x) {
  as_tibble(t(combn(x, m = 2)))
}

#' Checks if p5, p7 pair is present in input set
#'
#' @param reference.set list of two reference vectors with names P1, P5 of of available values of P1 and P5, respectively
#' @param pair.first first element of pair
#' @param pair.second second element of pair
#'
#' @return
#' @export
#'
#' @examples
validatePair <- function(pair.first, 
                         pair.second,
                         reference.set) {
  
  stopifnot(names(reference.set) == c("P5", "P7"))
  
  ((pair.first %in% reference.set$P5) & (pair.second %in% reference.set$P7)) |
    ((pair.first %in% reference.set$P7) & (pair.second %in% reference.set$P5)) # symmetrical case
}

removeNonPresentPairs <- function(pairs.table,
                                  reference.set) {
  pairs.table %>% 
    mutate(toleave = validatePair(V1, V2, reference.set = reference.set))
}


returnAllValidCombinations <- function(p5.names,
                                       p7.names) {
  
  super.set <- createSuperSet(p5.names,
                              p7.names)
  
  all.combinations <- returnCombinations(super.set)
  
  reference.set <- list(P5 = p5.names,
                        P7 = p7.names)
  
  out <- 
    removeNonPresentPairs(all.combinations,
                          reference.set)
  
  out %>% filter(toleave == TRUE) %>% select(-toleave)
}
