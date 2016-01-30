#!/bin/bash
cd "$REPO"
git stash
git svn dcommit
git stash apply
