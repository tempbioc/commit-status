#' Set Commit Status
#'
#' Sets the commit status on a commit from a GitHub App.
#' Requires `GH_APP_ID` and `GH_APP_KEY` environment variables.
#'
#' @export
#' @param repo full repo name for example "ropensci/magick"
#' @param sha hash of the commit to update
#' @param url link to the build logs
#' @param deployed_packages string with deployed artifacts
gh_app_set_commit_status <- function(repo, sha, url, deployed_packages){
  repo <- sub("https?://github.com/", "", repo)
  token <- gh::gh_app_token(repo)
  endpoint <- sprintf('/repos/%s/statuses/%s', repo, sha)
  context <- 'r-universe/deploy'
  description <- 'Deploying to R-universe package server'
  state <- if(grepl('pending', deployed_packages)){
    'pending'
  } else if(grepl("windows-release", deployed_packages) && grepl("macos-release", deployed_packages)){
    'success'
  } else {
    'failure'
  }
  gh::gh(endpoint, .method = 'POST', .token = token, state = state,
         target_url = url, context = context, description = description)
}
