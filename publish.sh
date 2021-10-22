#!/bin/sh
set -ex

go get -u github.com/hoffa/pt@2ef8c2c7441fa755f991b809a83c66d82480ab81
pt -base-url 'https://nishil.in' -highlight 'monokai' *.md posts/*.md blog/*.md blog/*/*.md projects/*.md
git add -u
git commit -m "Publish"
git push -u origin HEAD

