#' Add alpha diversities into phyloseq metadata
#'
#' This function takes a phyloseq object, passes it throuh the `estimate_richness` function in `phyloseq` and returns the phyloseq object containing alpha diversity estimates as "alpha_[diversity_name]"
#'
#' @param physeq a `phyloseq` object
#' @param raref_depth the number of minimum reads to rarefy by
#' @param measures the alpha diversity measures, as implemented by the `phyloseq::estimate_richness` function
#' @param merge_by the name of the variable to merge the datasets by (basically the unique sample identifies)
#' @param verbose if `TRUE`, will tell you what it is doing, in particular in the rarefaction process
#'
#' @return a `phyloseq` object with the alpha diversity estimates added to the metadata
#' @export
#'
#' @examples
#'
#' data(GlobalPatterns)
#' alpha_diversity_into_phy_metadata(GlobalPatterns,
#'      raref_depth = 5000,
#'      measures = c("Shannon", "Simpson"),
#'      verbose = TRUE)
#'

alpha_diversity_into_phy_metadata <- function(physeq,
                                              raref_depth,
                                              measures,
                                              verbose = FALSE
                                              ){
  library(magrittr)
  # get the estimates
  tmp <- rarefy_even_depth(physeq, raref_depth, verbose = FALSE) %>%
    estimate_richness(measures = measures)
  # put alpha in front of variables for ease of subsetting and variable calling in the metadata
  colnames(tmp) <- paste0("alpha_", colnames(tmp))

  # remove standard error Chao1
  if("Chao1" %in% measures){
    tmp[["alpha_se.chao1"]] <- NULL
  }
  # get variable names to merge
  alpha_df <- tibble::rownames_to_column(tmp, "IDs")

  # create metadata to merge
  new_meta <- merge(microbiome::meta(physeq) %>% rownames_to_column("IDs"),
                    alpha_df,
                    by = "IDs", all.x = TRUE, sort = FALSE) %>%
    column_to_rownames("IDs")

  physeq_final <- phy_substitute_metadata(physeq, new_meta)
  physeq_final@sam_data$merge_by <- NULL

  return(physeq_final)
}
