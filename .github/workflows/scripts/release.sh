#!/bin/bash

set -x
set -e

release_type=${1}

version=$(./scripts/version.py get)
version_file=VERSION

commit=${GITHUB_COMMIT:-$(git rev-parse HEAD)}
branch=${ALLOWED_RELEASE_BRANCH:-master}

if ! git branch -a --contains "${commit}" | grep -e "^[* ]*remotes/origin/${branch}\$"
then
  echo -e "###\n### Not on ${branch}. Only ${branch} commits can be released.\n###"
  exit 1
else
  echo -e "###\n### Releasing of ${commit} on ${branch}\n###"
fi