#!/bin/bash -e
commit_message="$1"
git add .
git commit -m "$commit_message"
git push origin master
cd ./blog-src
hexo clean
hexo generate
hexo deploy