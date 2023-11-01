#!/bin/bash -l
set -e
echo "Trying to set commit status for ${REPO}/commit/${SHA}"
echo "Source status: ${SOURCE_STATUS}"
echo "Docs status: ${DOCS_STATUS}"
Rscript -e "commitstatus::gh_app_set_commit_status('${REPO}','${SHA}','${BUILDLOG}','${UNIVERSE}','${DEPLOYED_PACKAGES}', '${SOURCE_STATUS}', '${DOCS_STATUS}', '${OSTYPE}')"
echo "Action complete!"
