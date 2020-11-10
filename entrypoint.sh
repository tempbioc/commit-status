#!/bin/bash -l
set -e
echo "Trying to set commit status for ${1}@${2} to ${3}"
Rscript -e "commitstatus::gh_app_set_commit_status('${1}','${2}','${3}','${4}','${5}','${6}')"
echo "Action complete!"
