suppressPackageStartupMessages({
  library(billboardr)
  library(dplyr)
  library(magrittr)
})

#* @get /hello
helloWorld <- function(name="plumber") {
  return(sprintf("Hello, %s!", name))
}



#* @serializer contentType list(type="application/json")
#* @get /top10
top10 <- function(res, chart_date="2010-02-20") {
  chart_result = billboardr::hot100(chart_date)
  df_top10 = dplyr::bind_rows(chart_result) %>%
    dplyr::arrange(song_rank_num) %>%
    dplyr::filter(song_rank_num <= 10)

  # Results in a row manner
  res$body = jsonlite::toJSON(df_top10, dataframe = "rows")

  return(res)
}

#* @html
#* @get /report
getReport <- function(res) {
  plumber::include_rmd('./reports/happy_report.Rmd', res)
}


#* @png
#* @get /plot
plotResults <- function(sample_size=1000) {
  norm_sample = rnorm(sample_size)

  hist(norm_sample)
}