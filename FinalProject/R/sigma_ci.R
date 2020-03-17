#' Confidence Intervals of Sigma
#'
#' @param data data.frame
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
#' group_number = 10
#' bootstrap_times = 10
#' sigma_ci(data,group_number,bootstrap_times)
#' }

sigma_ci <- function(data, group_number, bootstrap_times){
  set.seed(141)
  m <- group_number
  n <- nrow(data)
  group <- sample(seq_len(m), n, replace = TRUE)

  calc_sigma_blb <- function(subsample, freqs){
    fit <- stats::lm(y~., data = subsample, weights = freqs)
    y <- stats::model.extract(fit$model, "response")
    e <- stats::fitted(fit) - y
    w <- fit$weights
    sqrt(sum(w*e^2)/(sum(w)))
  }

  B <- bootstrap_times

  each_boot <-function(i, subsample){
    freqs <- stats::rmultinom(1, n, rep(1, nrow(subsample)))
    calc_sigma_blb(subsample, freqs)
  }

  ci_list <- furrr::future_map(seq_len(m), ~{
    purrr::map_dbl(seq_len(B), each_boot, subsample = data[group==.,]) %>%
      quantile(c(0.025,0.975))
  })
  purrr::reduce(ci_list, `+`)/length(ci_list)
}
