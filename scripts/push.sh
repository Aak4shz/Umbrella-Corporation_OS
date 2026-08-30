#!/bin/bash
# Usage: ./push.sh 2025-04-10 "your commit message"

DATE=$1
MSG=$2

if [ -z "$DATE" ] || [ -z "$MSG" ]; then
  echo "Usage: ./push.sh YYYY-MM-DD \"commit message\""
  exit 1
fi

git add .
GIT_AUTHOR_DATE="${DATE}T10:30:00" GIT_COMMITTER_DATE="${DATE}T10:30:00" git commit -m "$MSG"
git push origin main