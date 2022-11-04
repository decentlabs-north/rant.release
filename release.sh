#!/bin/bash
HOST=1k.fyi
rm -rf ./docs \
  && mkdir ./docs \
  && git submodule init src/ \
  && git submodule update -r src/ \
  && git submodule foreach 'git pull' \
  && cd src \
  && yarn && yarn test && yarn build \
  && REV=$(git rev-parse --short HEAD) \
  && cd .. \
  && cp -r src/pub/* docs/ \
  && echo "$HOST" > docs/CNAME \
  && touch docs/.nojekyll \
  && git add . \
  && git commit -am "automated release $REV" \
  && git push \
  && echo "done $REV"


