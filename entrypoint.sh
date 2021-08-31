#!/bin/bash -l
set -e
echo "Trying to set commit status for ${1}/commit/${2}"
echo "Source status: ${6}"
echo "Docs status: ${7}"
Rscript -e "commitstatus::gh_app_set_commit_status('${1}','${2}','${3}','${4}','${5}', '${6}', ${7}')"
echo "Action complete!"
