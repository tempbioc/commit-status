#' Set Commit Status
#'
#' Sets the commit status on a commit from a GitHub App.
#' Requires `GH_APP_ID` and `GH_APP_KEY` environment variables.
#'
#' @export
#' @param repo full repo name for example "ropensci/magick"
#' @param sha hash of the commit to update
#' @param state one of 'pending', 'success', 'error', 'failure'
#' @param url link to the build logs
#' @param context which build this is for example "universe/docs"
#' @param description more information about this build
gh_app_set_commit_status <- function(repo, sha, state, url, context, description){
  repo <- sub("https?://github.com/", "", repo)
  stopifnot(state %in% c('error', 'failure', 'pending', 'success'))
  token <- gh::gh_app_token(repo)
  endpoint <- sprintf('/repos/%s/statuses/%s', repo, sha)
  gh::gh(endpoint, .method = 'POST', .token = token, state = state,
         target_url = url, context = context, description = description)
}
