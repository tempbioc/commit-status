#' Set Commit Status
#'
#' Sets the commit status on a commit from a GitHub App.
#' Requires `GH_APP_ID` and `GH_APP_KEY` environment variables.
#'
#' @export
#' @param repo full repo name for example "ropensci/magick"
#' @param sha hash of the commit to update
#' @param url link to the build logs
#' @param universe name of the universe where packages were deployed to
#' @param deployed_packages string with deployed artifacts
#' @param source_status string with result of building source pkg including vignettes
gh_app_set_commit_status <- function(repo, sha, url, universe, deployed_packages, source_status = NULL){
  repo <- sub("https?://github.com/", "", repo)
  repo <- sub("\\.git$", "", repo)
  token <- ghapps::gh_app_token(app_id = '87942', repo)
  endpoint <- sprintf('/repos/%s/statuses/%s', repo, sha)
  context <- sprintf('r-universe/%s/%s/deploy', universe, basename(repo))
  description <- 'Deploy binaries to R-universe package server'
  state <- if(grepl('pending', deployed_packages)){
    'pending'
  } else if(grepl("windows-release", deployed_packages) && grepl("macos-release", deployed_packages) && !identical(source_status, 'failure')){
    'success'
  } else {
    'failure'
  }
  if(state == 'success'){
    url <- sprintf('https://%s.r-universe.dev', universe)
  }
  gh::gh(endpoint, .method = 'POST', .token = token, state = state,
         target_url = url, context = context, description = description)
}
