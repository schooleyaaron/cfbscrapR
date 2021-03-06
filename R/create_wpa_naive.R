#' Add Win Probability Added (WPA) calculations to Play-by-Play DataFrame
#' This is only for D1 football
#'
#' Extracts raw game by game data.
#' @param df (\emph{data.frame} required): Clean Play-by-Play data.frame with Expected Points Added (EPA) calculations
#' @param wp_model (\emph{model} default cfbscrapR:wp_model): Win Probability (WP) Model
#' @details Requires the following columns to be present in the input data frame.
#' @return The original `df` with the following columns appended to it:
#' \describe{
#' \item{wp_before}{}
#' \item{def_wp_before}{}
#' \item{home_wp_before}{}
#' \item{away_wp_before}{}
#' \item{lead_wp_before}{}
#' \item{lead2_wp_before}{}
#' \item{wpa_base}{}
#' \item{wpa_base_nxt}{}
#' \item{wpa_base_ind}{}
#' \item{wpa_base_nxt_ind}{}
#' \item{wpa_change}{}
#' \item{wpa_change_nxt}{}
#' \item{wpa_change_ind}{}
#' \item{wpa_change_nxt_ind}{}
#' \item{wpa}{}
#' \item{wp_after}{}
#' \item{def_wp_after}{}
#' \item{home_wp_after}{}
#' \item{away_wp_after}{}
#' }
#' @keywords internal
#' @import dplyr
#' @import tidyr
#' @importFrom mgcv "bam"
#' @export
#'

create_wpa_naive <- function(df, wp_model = cfbscrapR:::wp_model) {
  col_nec = c(
    "ExpScoreDiff",
    "TimeSecsRem",
    "half",
    "Under_two",
    "off_timeouts_rem_before",
    "def_timeouts_rem_before"
  )
  if (!all(col_nec %in% colnames(df))) {
    df = df %>% 
      dplyr::mutate(
        adj_TimeSecsRem = ifelse(.data$half == 1, 1800 + .data$TimeSecsRem, .data$TimeSecsRem),
        turnover_vec_lag = dplyr::lag(.data$turnover_vec, 1),
        def_td_play_lag = dplyr::lag(.data$def_td_play, 1),
        play_after_turnover = ifelse(.data$turnover_vec_lag == 1 & .data$def_td_play_lag != 1, 1, 0),
        receives_2H_kickoff = ifelse(.data$game_play_number == 1 & .data$kickoff_play == 1 & 
                                       .data$offense_play == .data$home, 1, 
                                     ifelse(.data$game_play_number == 1 & .data$kickoff_play == 1 &
                                              .data$offense_play == .data$away,0,NA)),
        score_diff = .data$offense_score - .data$defense_score,
        lag_score_diff = lag(.data$score_diff, 1),
        lag_score_diff = ifelse(.data$game_play_number == 1, 0, .data$lag_score_diff),
        offense_play_lag = dplyr::lag(.data$offense_play, 1),
        offense_play_lag = ifelse(.data$game_play_number == 1, .data$offense_play, .data$offense_play_lag),
        offense_play_lead = dplyr::lead(.data$offense_play, 1),
        offense_play_lead2 = dplyr::lead(.data$offense_play, 2),
        lead_kickoff_play = dplyr::lead(.data$kickoff_play,1),
        score_pts = ifelse(.data$offense_play_lag == .data$offense_play,
                           (.data$score_diff - .data$lag_score_diff),
                           (.data$score_diff + .data$lag_score_diff)),
        score_diff_start = ifelse(.data$offense_play_lag == .data$offense_play,
                                  .data$lag_score_diff,
                                  -1*.data$lag_score_diff)) %>% 
      tidyr::fill(.data$receives_2H_kickoff) %>% 
      dplyr::mutate(
        offense_receives_2H_kickoff = case_when(
          .data$offense_play == .data$home & .data$receives_2H_kickoff == 1 ~ 1,
          .data$offense_play == .data$away & .data$receives_2H_kickoff == 0 ~ 1,
          TRUE ~ 0),
        EPA = .data$ep_after - .data$ep_before,
        def_EPA = -1*.data$EPA,
        home_EPA = ifelse(.data$offense_play == .data$home, .data$EPA, -1*.data$EPA),
        away_EPA = -1*.data$home_EPA,
        ExpScoreDiff = .data$score_diff_start + .data$ep_before,
        half = as.factor(.data$half),
        ExpScoreDiff_Time_Ratio = .data$ExpScoreDiff/(.data$adj_TimeSecsRem + 1)
    )
  }

  df = df %>% 
    dplyr::arrange(.data$game_id, .data$new_id)
  
  Off_Win_Prob = as.vector(predict(wp_model, newdata = df, type = "response"))
  df$wp_before = Off_Win_Prob

  g_ids = sort(unique(df$game_id))
  df2 = purrr::map_dfr(g_ids,
                       function(x) {
                         df %>%
                           dplyr::filter(.data$game_id == x) %>%
                           wpa_calcs_naive()
                       })
  return(df2)
}

#' WPA Calcs
#'
#' Extracts raw game by game data.
#' @param df (\emph{data.frame} required): Clean Play-by-Play data.frame with Expected Points Added (EPA) calculations
#' @keywords internal
#' @import dplyr
#' @import tidyr
#' @export
#' 
wpa_calcs_naive <- function(df) {

  df2 = df %>% 
   dplyr::mutate(
      def_wp_before = 1 - .data$wp_before,
      home_wp_before = if_else(.data$offense_play == .data$home,
                        .data$wp_before, 
                        .data$def_wp_before),
      away_wp_before = if_else(.data$offense_play != .data$home,
                        .data$wp_before, 
                        .data$def_wp_before)) %>%
   dplyr::mutate(
     lead_wp_before = dplyr::lead(.data$wp_before, 1),
     lead2_wp_before = dplyr::lead(.data$wp_before, 2),
     # base wpa
     wpa_base = .data$lead_wp_before - .data$wp_before,
     wpa_base_nxt = .data$lead2_wp_before - .data$wp_before,
     wpa_base_ind = ifelse(.data$offense_play == .data$offense_play_lead, 1, 0),
     wpa_base_nxt_ind = ifelse(.data$offense_play == .data$offense_play_lead2, 1, 0),
     # account for turnover
     wpa_change = (1 - .data$lead_wp_before) - .data$wp_before,
     wpa_change_nxt = (1 - .data$lead2_wp_before) - .data$wp_before,
     wpa_change_ind = ifelse(.data$offense_play != .data$offense_play_lead, 1, 0),
     wpa_change_nxt_ind = ifelse(.data$offense_play != .data$offense_play_lead2, 1, 0),
     wpa = ifelse(.data$end_of_half == 1, 0, 
                  ifelse(.data$wpa_change_ind == 1, 
                         .data$wpa_change, 
                         .data$wpa_base)),
     wp_after = .data$wp_before + .data$wpa,
     def_wp_after = 1 - .data$wp_after,
     home_wp_after = ifelse(.data$offense_play == .data$home,
                            .data$home_wp_before + .data$wpa,
                            .data$home_wp_before - .data$wpa),
     away_wp_after = ifelse(.data$offense_play != .data$home,
                            .data$away_wp_before + .data$wpa,
                            .data$away_wp_before - .data$wpa),
      wp_before = round(.data$wp_before, 7),
      def_wp_before = round(.data$def_wp_before, 7),
      home_wp_before = round(.data$home_wp_before, 7),
      away_wp_before = round(.data$away_wp_before, 7),
      lead_wp_before = round(.data$lead_wp_before, 7),
      lead2_wp_before = round(.data$lead2_wp_before, 7),
      wpa_base = round(.data$wpa_base, 7),
      wpa_base_nxt = round(.data$wpa_base_nxt, 7),
      wpa_change = round(.data$wpa_change, 7),
      wpa_change_nxt = round(.data$wpa_change_nxt, 7),
      wpa = round(.data$wpa, 7),
      wp_after = round(.data$wp_after, 7),
      def_wp_after = round(.data$def_wp_after, 7),
      home_wp_after = round(.data$home_wp_after, 7),
      away_wp_after = round(.data$away_wp_after, 7)
    )
  return(df2)
}
