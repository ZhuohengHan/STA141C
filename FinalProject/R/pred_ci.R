#' Confidence Intervals of Predictions
#'
#' @param data data.frame
#' @param newdata new data.frame
#' @param group_number number of groups to be devided
#' @param bootstrap_times number of bootstrap
#'
#' @return Confidence Intervals
#' @export
#'
#' @examples
#' \dontrun{
#' future::plan(future::multiprocess, workers = 4)
#' library(nycflights13)
#' x = flights$dep_delay
#' y = flights$arr_time
#' data = data.frame(x,y)
#' newdata = rbind(1,2)
#' group_number = 10
#' bootstrap_times = 10
#' pred_ci(data,newdata,group_number,bootstrap_times)
#' }

pred_ci <- function(data, newdata,group_number,bootstrap_times){
  set.seed(141)
  m <- group_number
  n <- nrow(data)
  group <- sample(seq_len(m), n, replace = TRUE)

  calc_pred<- function(subsample, freqs){
    as.matrix(stats::predict(stats::lm(y ~ ., weights = freqs, data = subsample),newdata))
  }

  each_boot <-function(i, subsample){
    freqs <- stats::rmultinom(1, n, rep(1, nrow(subsample)))
    calc_pred(subsample, freqs)
  }

  B <- bootstrap_times

  ci <- function(i) {
    ci_list <- furrr::future_map(seq_len(m), ~{
      purrr::map(seq_len(B), each_boot, subsample = data[group ==.,]) %>%
        lapply(function(x) x[i,]) %>% unlist %>% quantile(c(0.025,0.975))
    })
    return(purrr::reduce(ci_list, `+`)/length(ci_list))
  }
  print(furrr::future_map(seq_len(nrow(newdata)), ~ci(.)))
}
