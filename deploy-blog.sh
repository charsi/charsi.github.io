#!/bin/bash -e
cd ./blog-src
hexo clean
hexo generate
hexo deploy
