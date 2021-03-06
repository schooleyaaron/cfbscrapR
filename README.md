
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Travis-CI:
build-status](https://travis-ci.com/saiemgilani/cfbscrapR.svg?token=BxsozfUD3VCvCzzJpdFf&branch=master)
[![Twitter
Follow](https://img.shields.io/twitter/follow/cfbscrapR?style=social)](https://twitter.com/cfbscrapR)
<!-- badges: end -->

# cfbscrapR

![cfbscrapr-tile-1-300.png](https://raw.githubusercontent.com/saiemgilani/cfbscrapR/master/man/figures/cfbscrapr-tile-1-300.png)

A scraping and aggregating package using the CollegeFootballData API

`cfbscrapR` is an R package for working with CFB data. It is an R API
wrapper around <https://collegefootballdata.com/>. It provides users the
capability to retrieve data from a plethora of endpoints and supplement
that data with additional information (Expected Points Added/Win
Probability added).

**Note:** The API ingests data from ESPN as well as other sources. For
details on those source, please go the website linked above. Sometimes
there are inconsistencies in the underlying data itself. Please report
issues here or to <https://collegefootballdata.com/>.

## Installation

You can install `cfbscrapR` from
[GitHub](https://github.com/saiemgilani/cfbscrapR) with:

``` r
# Then can install using the devtools package from either of the following:
devtools::install_github(repo = "saiemgilani/cfbscrapR")
# or the following (these are the exact same packages):
devtools::install_github(repo = "meysubb/cfbscrapR")
```

## Documentation

For more information on the package and function reference, please see
the `cfbscrapR`
[documentation](https://saiemgilani.github.io/cfbscrapR/).

## Expected Points and Win Probability models

If you would like to learn more about the Expected Points and Win
Probability models, please refer to the `cfbscrapR`
[tutorials](https://saiemgilani.github.io/cfbscrapR/articles/index.html)
or for the code repository where the models are built, [click
here](https://github.com/meysubb/cfbscrapR-MISC)

#### Expected Points model calibration plots

![ep\_fg\_cv\_loso\_calibration\_results.png](https://i.imgur.com/bOE4VOU.png)

#### Win Probability model calibration plots

![wp\_cv\_loso\_calibration\_results.png](https://i.imgur.com/4YgfphC.png)

# cfbscrapR 1.0.22

  - ~~Fix conference parameters to match API (moved to abbreviation
    format).~~ Removed assertions for now, so users should be able to
    access conference data without issue, assuming the input argument is
    correct. May fortune favor your selection.

  - Add mgcv (\>= v1.8.32) dependency and update WP model accordingly.
    Note on WPA: Kickoffs are problematic and our calculation algorithm
    does not appear to accomplishing what it needs to. We are working on
    this, aiming for a quick next version update centered around this.

  - Following play type renamings and merging:
    
      - Pass Interception Return –\> Interception Return
      - Pass Interception –\> Interception Return
      - Pass Interception Return Touchdown –\> Interception Return
        Touchdown
      - Sack Touchdown –\> Fumble Recovery (Opponent) Touchdown
      - Punt Touchdown \~ Punt Return Touchdown.

  - Update `rush_vec` and `pass_vec` regex definitions to be more
    precise on pulling rushing plays.

  - Update definition of play\_type definition for cleaning “Fumble
    Recovery (Opponent)” play types to actually distinguish between
    touchdowns and non-scoring opponent fumble recoveries (prior
    definition was combining the touchdowns into the non-scoring play
    type)

  - Reduce the reach of the non-explicit rushing/passing touchdowns to
    be more careful about merging labels.

  - Similarly, separated punt touchdowns into a specific type of
    offensive score where the punting team recovers a fumble and scores,
    all other `punt touchdowns` prior to this were punt return
    touchdowns. There is a specific Jalen Reagor (TCU) play where he
    pulls a Greg Reid and fumbles on the punt return only to recover the
    fumble and run it in for a 73 yard TD that is explicitly fixed.

  - Add the following columns:
    
      - kickoff\_onside
      - kickoff\_fair\_catch
      - kickoff\_downed
      - punt\_fair\_catch
      - punt\_downed
      - sack
      - int
      - int\_td
      - completion
      - pass\_attempt
      - target
      - pass\_td
      - rush\_td
      - safety

  - add some return skeleton docs

  - add column `drive_start_yardline` to the remove cols

  - add parsing for kickoff safetys accounting for sign change

  - Added [Jared Lee](https://twitter.com/JaredDLee)’s [animated win
    probability plot
    vignette](https://saiemgilani.github.io/cfbscrapR/articles/Animated_WP_Plotting.html)
    to the package documentation page

![Result](https://raw.githubusercontent.com/saiemgilani/cfbscrapR/master/man/figures/animated_wp.gif)

  - Contains important `add_player_cols()` function useful to parse
    existing play-by-play datasets and pull passer/rusher/receiver/etc.
    player names.

  - Added [Michael Egle](https://twitter.com/deceptivespeed_)’s [4th
    down tendency plot
    vignette](https://saiemgilani.github.io/cfbscrapR/articles/fourth_down_plot_tutorial.html)
    to the package documentation page

## cfbscrapR v1.0.2

  - Remove the
    [`add_betting_columns()`](https://saiemgilani.github.io/cfbscrapR/reference/add_betting_cols.html)
    function and the current betting win probability model from the
    [`cfb_pbp_data()`](https://saiemgilani.github.io/cfbscrapR/reference/cfb_pbp_data.html)
    function.
  - Added
    [`cfb_ratings_fpi()`](https://saiemgilani.github.io/cfbscrapR/reference/cfb_ratings_fpi.html)
    function from @sabinanalytics’s fork of the repository
  - Added the
    [`cfb_metrics_espn_wp()`](https://saiemgilani.github.io/cfbscrapR/reference/cfb_metrics_espn_wp.html)
    function, courtesy of @mrcaseb
  - Add
    [tests](https://github.com/saiemgilani/cfbscrapR/tree/master/tests/testthat)
    for a majority of the functions. This is the biggest behind the
    scenes change that will translate to more reliable functions.
  - Rename several function outputs from **camelCase to under\_score**
    for consistency. Please adjust your scripts accordingly, apologies
    for the inconvenience.
  - Remove `drives` parameter from
    [`cfb_pbp_data()`](https://saiemgilani.github.io/cfbscrapR/reference/cfb_pbp_data.html)
    function. For accessing drives information, please switch to the
    [`cfb_drives()`](https://saiemgilani.github.io/cfbscrapR/reference/cfb_drives.html)
    function.

#### Fix downs turnovers and several other discrepancies in EPA computations.

![EPA\_YardsGained\_cfbscrapR.png](https://i.imgur.com/Bw6VO90.png)

![EPA\_YardsGained\_cfbscrapR2.png](https://i.imgur.com/VYX12pZ.png)

### Fix majority of issues with win probability added.

![WPA\_YardsGained\_cfbscrapR.png](https://i.imgur.com/OFHTh9Y.jpg)

![WPA\_YardsGained\_cfbscrapR2.png](https://i.imgur.com/84zh9VY.jpg) -
For more complete summary of changes, see [Pull
Request](https://github.com/saiemgilani/cfbscrapR/pull/5#issue-478275691)
