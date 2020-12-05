#!/bin/sh
set -ex

go get -u github.com/hoffa/pt
pt -base-url 'https://nishil.in' -highlight 'monokai' *.md posts/*.md blog/*.md blog/*/*.md projects/*.md
git add -u
git commit -m "Publish"
git push -u origin HEAD

