
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cfbpointsR

A scraping and aggregating package using the CollegeFootballData API

`cfbpointsR` is an R package for working with CFB data. It is an R API
wrapper around <https://collegefootballdata.com/>. It provides users the
capability to get a plethora of endpoints, and supplement that data with
additional information (Expected Points Added/Win Probability added).

**Note:** The API ingests data from ESPN as well as other sources. For
details on those source, please go the website linked above. Sometimes
there are inconsitences in the underlying data itself. Please report
issues here or to <https://collegefootballdata.com/>.

## Installation

You can install `cfbpointsR` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("saiemgilani/cfbpointsR")
```

<!-- badges: start -->
![Lifecycle:stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

![Travis-CI:
build-status](https://travis-ci.com/saiemgilani/cfbpointsR.svg?token=BxsozfUD3VCvCzzJpdFf&branch=master)
<!-- badges: end -->

The goal of cfbpointsR is to …

## Installation

You can install the released version of cfbpointsR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("cfbpointsR")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("saiemgilani/cfbpointsR")
```

Games Data Functions Functions exported by cfbpointsR sourced from games
endpoint of the CollegeFootballData API

`cfb_game_info()` - Get results information from games

`cfb_game_records()` - Get Team records by year

`cfb_game_team_stats()` - Get Team Statistics by Game

`cfb_game_player_stats()` - Get results information from games

`cfb_game_box_advanced()` - Get game advanced box score information

`cfb_game_media()` - Get Game media information (TV, radio, etc)

`cfb_betting_lines()` - Get Betting information from games

Drives Data Function Functions exported by cfbpointsR sourced from
drives endpoint of the CollegeFootballData API

`cfb_drives()` - Get results information from games

Plays Data Functions Functions exported by cfbpointsR sourced from plays
endpoint of the CollegeFootballData API

`cfb_pbp_data()` - Extract CFB (D-I) Play by Play Data - For plays

`cfb_play_types()` - College Football Mapping for Play Types

`cfb_play_type_df` - College Football Mapping for Play Types

`cfb_play_stats_player()` - Gets player info associated by play

`cfb_play_stats_types()` - College Football Mapping for Play Stats Types

Teams Functions Functions exported by cfbpointsR sourced from the teams
endpoint of the CollegeFootballData API

`cfb_team_info()` - Team Info Lookup Lists all teams in conference or
all D-I teams if conference is left NULL Current support only for D-I

`cfb_team_matchup()` - Get matchup history between two teams.

`cfb_team_roster()` - Team Roster Get a teams full roster by year. If
year not selected, API defaults to most recent year (2019 as of 6/23/20)

`cfb_team_talent()` - Get composite team talent rankings for all teams
in a given year

Players Functions Functions exported by cfbpointsR sourced from the
teams endpoint of the CollegeFootballData API

`cfb_player_info()` - Player Information Search

`cfb_player_usage()` - Player Information Search

`cfb_player_returning()` - Player Information Search

Stats Functions Functions exported by cfbpointsR sourced from the
conferences endpoint of the CollegeFootballData API

`cfb_stats_categories()` - College Football Mapping for Stats Categories

`cfb_stats_season_team()` - Get Season Statistics by Team

`cfb_stats_game_advanced()` - Get Game Advanced Stats

`cfb_stats_season_advanced()` - Get Season Advanced Statistics by Team

Conference Functions Functions exported by cfbpointsR sourced from the
conferences endpoint of the CollegeFootballData API

`cfb_conferences()` - CFB Conference Information

`cfb_conf_types_df` - College Football Conference

Rankings and Ratings Functions Functions exported by cfbpointsR sourced
from the rankings and ratings endpoints of the CollegeFootballData API

`cfb_rankings()` - Gets Historical CFB poll rankings at a specific week

`cfb_ratings_sp()` - Get S\&P+ historical rating data

`cfb_ratings_sp_conference()` - Get conference-level S\&P+ historical
rating data

`cfb_ratings_srs()` - Get SRS historical rating data

Recruiting functions Functions exported by cfbpointsR sourced from the
rankings and ratings endpoints of the CollegeFootballData API

`cfb_recruiting_player()` - CFB Recruiting Gets CFB recruiting
information for a single year with filters available for team, recruit
type, state and position.

`cfb_recruiting_team()` - CFB Recruiting Information - Team Rankings

`cfb_recruiting_position()` - CFB Recruiting Information - Position
Groups

Metrics Functions Functions exported by cfbpointsR sourced from the
Predicted Points Added (PPA) endpoints of the CollegeFootballData API

`cfb_metrics_ppa_predicted()` - Calculate Predicted Points using Down
and Distance

`cfb_metrics_ppa_teams()` - Get team averages for Predicted Points Added
(PPA)

`cfb_metrics_ppa_games()` - Get team game averages for Predicted Points
Added (PPA)

`cfb_metrics_ppa_players_season()` - Get player season averages for
Predicted Points Added (PPA)

`cfb_metrics_ppa_players_games()` - Get player game averages for
Predicted Points Added (PPA)

`cfb_metrics_wp()` - Get win probability chart data from API

`cfb_metrics_wp_pregame()` - Get Pre-game Win Probability Data from API

School Functions Functions exported by cfbpointsR sourced from venues
and coaches endpoints of the CollegeFootballData API

`cfb_venues()` - CFB Venue Information

`cfb_coaches()` - Coach Information Search

Plotting Functions Plotting play-by-play sequences and game win
probability charts

Internals Internal functions and helpers

`add_timeout_cols()` - Add Timeout columns This is only for DI-FBS
football

`clean_drive_info()` - Clean Drive Information Cleans CFB (D-I)
Drive-By-Drive Data to create `pts_drive` column

`clean_pbp_dat()` - Clean Play-by-Play data Cleans Play-by-Play data
pulled from the API’s raw game data

`create_epa()` - Create EPA Adds Expected Points calculations to
Play-by-Play data.frame

`create_wpa()` - Add Win Probability Added (WPA) calculations to
Play-by-Play DataFrame This is only for D1 football

`epa_fg_probs()` - Performs Field Goal adjustments for Expected Points
model calculations

`prep_epa_df_before()` - Prep for EPA calculations at the start of the
play This is only for D1 football

`prep_epa_df_after()` - Creates the post-play inputs for the Expected
Points model to predict on for each game

`check_internet()` - Utilities and Helpers for package
