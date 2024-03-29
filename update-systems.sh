#!/usr/bin/env bash

[[ -z $ZUNKA_SITE_PATH ]] && printf "error: ZUNKA_SITE_PATH enviorment not defined.\n" >&2 && exit 1 
[[ -z $GS ]] && printf "error: GS enviorment not defined.\n" >&2 && exit 1 
[[ -z $ZUNKAPATH ]] && printf "error: ZUNKAPATH enviorment not defined.\n" >&2 && exit 1 

ZUNKA_SITE_PATH=~/code/temp/zunka

echo :: Fetching zunka site...
git fetch
STYLE_FILES_CHANGED=`git diff --name-only master...origin/master | grep "*.styl"`
SECRET_FILES_CHANGED=`git diff --name-only master...origin/master | grep "*.secret"`
FILES_CHANGED=`git diff --name-only master...origin/master`
# Merge.
if [[ ! -z $FILES_CHANGED ]]; then
    echo :: Merging zunka site...
    # git merge
fi

# Compile style files.
if [[ ! -z $STYLE_FILES_CHANGED ]]; then
    echo :: Compile style files...
    # ./bin/compile_styl
fi

# Reveal secret files.
if [[ ! -z $SECRET_FILES_CHANGED ]]; then
    echo :: Revealing secret files...
    # git secret reveal
fi

# Set zunka site to be restarted.
if [[ ! -z $FILES_CHANGED ]]; then
    echo :: Signaling to restart zunka_site...
    # echo true > $ZUNKAPATH/restart-zunka-site
fi

# Upgrade zunkasrv.
# $GS/zunkasrv/bin/update-all.sh
