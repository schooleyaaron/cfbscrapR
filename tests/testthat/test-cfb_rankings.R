context("CFB Poll Rankings")

x <- cfb_rankings(year = 2019, week=12)

y <- cfb_rankings(year = 2018, week = 14)

z <- cfb_rankings(year = 2013, season_type = 'postseason')

cols <- c("season", "season_type","week","poll","rank",
          "school", "conference", "first_place_votes", "points")

first_team_AP_13 <- z %>% 
  filter(.data$poll == 'AP Top 25' & .data$rank == 1) %>% 
  select(.data$school)

first_team_coaches_13 <- z %>% 
  filter(.data$poll == 'Coaches Poll' & .data$rank == 1) %>% 
  select(.data$school)

test_that("CFB Poll Rankings", {
  expect_equal(colnames(x), cols)
  expect_equal(colnames(y), cols)
  expect_equal(colnames(z), cols)
  expect_equivalent(first_team_AP_13, "Florida State")
  expect_equivalent(first_team_coaches_13, "Florida State")
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
  expect_s3_class(z, "data.frame")

})