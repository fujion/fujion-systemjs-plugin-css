#!/usr/bin/env bash
if [[ "$TRAVIS_BRANCH" = 'master' ]] || [[ "$TRAVIS_BRANCH" =~ ^[0-9]+\.[0-9]+\.x$ ]] && [[ "$TRAVIS_PULL_REQUEST" == 'false' ]]; then
  openssl aes-256-cbc -K $encrypted_7a2f7a7da08d_key -iv $encrypted_7a2f7a7da08d_iv -in travis/codesigning.asc.enc -out travis/codesigning.asc -d
  gpg --fast-import travis/codesigning.asc
  mvn -V -B -s travis/settings.xml clean deploy -P sign -DskipTests
else
  echo "Branch $TRAVIS_BRANCH not eligible for deployment."
fi