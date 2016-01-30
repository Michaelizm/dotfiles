#!/bin/sh
cd "$REPO"
git stash
git svn fetch
git svn rebase
git stash apply
