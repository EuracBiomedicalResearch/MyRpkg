#' Adds a set of metadata variables to the metadata of a phyloseq object. Make sure `rownames` contain the same names. Row ordering is taken care of internally
#'
#' @param physeq A `phyloseq` object
#' @param df A `data.frame` object, with rownames matching `sample_names` of the `phyloseq` object
#' @param by A `character` containing the variable to merge the two `sample_data` by.
#'
#' @export
#'
#' @example
#' data(GlobalPatterns)
#' df_test <- data.frame(variable_new = rnorm(n = nsamples(GlobalPatterns), mean = 2, sd = 0.8))
#' rownames(df) <- samples_names(GlobalPatterns)
#' phy_add_metadata_variables(physeq=GlobalPatterns,
#'                            df = df_test)
phy_add_metadata_variables <- function(physeq, df){

  if(any(!(sample_names(physeq) %in% rownames(df)))){stop("not all sample names if the phyloseq object are in the df rownames")}

  df <- rownames_to_column(df, "IDs")

  new_meta <- microbiome::meta(physeq) %>%
    rownames_to_column("IDs") %>%
    merge(., df, by = "IDs", sort = FALSE, all.x = TRUE) %>%
    column_to_rownames("IDs")

  return(phy_substitute_metadata(physeq, new_meta))
}
