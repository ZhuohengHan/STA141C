#' Confidence Intervals of Coefficients
#'
#' @param data data.frame
#' @param group_number number of groups to be devided
#' @param bootstrap_times number of bootstrap
#'
#' @return Confidence Intervals
#' @export
#'
#' @examples
#' library(nycflights13)
#' x = flights$dep_delay
#' y = flights$arr_time
#' data = data.frame(x,y)
#' group_number = 10
#' bootstrap_times = 10
#' coef_ci(data, group_number, bootstrap_times)

coef_ci <-function(data, group_number, bootstrap_times){
  set.seed(141)
  n <- nrow(data)
  m <- group_number

  group <- sample(seq_len(m), n, replace = TRUE)

  calc_beta <- function(subsample, freqs) {
    as.matrix(summary(stats::lm(y ~ ., weights = freqs, data = subsample))$coef[,1])
  }

  each_boot <- function(i, subsample) {
    freqs <- stats::rmultinom(1, n, rep(1, nrow(subsample)))
    calc_beta(subsample, freqs)
  }

  B <- bootstrap_times
  future::plan(future::multiprocess, workers = 8)

  ci <- function(i) {
    ci_list <- furrr::future_map(seq_len(m), ~{
      purrr::map(seq_len(B), each_boot, subsample = data[group ==.,]) %>%
        lapply(function(x) x[i,]) %>% unlist %>% quantile(c(0.025,0.975))
    })
    return(purrr::reduce(ci_list, `+`)/length(ci_list))
  }
  print(furrr::future_map(seq_len(ncol(data)), ~ci(.)))
}
