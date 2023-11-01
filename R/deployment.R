#' Set Deployment Status
#'
#' Sets the deployment status in the monorepo
#'
#' @export
#' @param universe name of the universe where packages were deployed to
#' @param package name of the package to be deployed
#' @param ref hash of the commit to update
#' @param buildlog link to the build logs
#' @param source_status string with result of building source pkg including vignettes
update_deployment_status <- function(universe, package, ref, buildlog, source_status){
  deployment <- gh::gh('POST /repos/r-universe/{universe}/deployments',
                universe = universe, environment = package, ref = ref,
                description = sprintf('Deploying to https://%s.r-universe.dev/%s', universe, package),
                production_environment = TRUE, auto_merge = FALSE,
                task = 'deploy', required_contexts = vector())

  state <- ifelse(identical(source_status, 'failure'),  'failure', 'success')
  gh::gh('POST /repos/r-universe/{universe}/deployments/{deployment_id}/statuses',
                 universe = universe, deployment_id = deployment$id, state = state,
                 log_url = buildlog, description = 'Deployment to r-universe was successful!')
}
