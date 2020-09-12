#!/bin/sh
set -ex

go get -u github.com/hoffa/pt
pt -base-url https://nishil.in *.md posts/*.md blog/*.md
git add -u
git commit -m "Publish"
git push -u origin HEAD
