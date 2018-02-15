suppressPackageStartupMessages({
  library(plumber)
})

server = plumber::plumb('plumber/endpoints.R')

server$run(host="127.0.0.1", port=8080, swagger=TRUE, debug=TRUE)
