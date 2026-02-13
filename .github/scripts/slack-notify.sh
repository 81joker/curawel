#!/bin/bash

# ===== Parameters =====
TYPE=$1        # build | deploy
STATUS=$2      # success | failed
PROJECT=$3     # Project name
BRANCH=$4      # Branch name
RUN_URL=$5     # GitHub Actions run URL
ENVIRONMENT=$6 # Optional (prod, staging, etc)

# ===== Icons & Titles =====
if [ "$STATUS" = "success" ]; then
  ICON="✅"
  RESULT="Successful"
else
  ICON="❌"
  RESULT="Failed"
fi

TYPE_UPPER=$(echo "$TYPE" | tr '[:lower:]' '[:upper:]')

# ===== Message =====
MESSAGE="$ICON $TYPE_UPPER $RESULT
Project: $PROJECT
Branch: $BRANCH"

if [ -n "$ENVIRONMENT" ]; then
  MESSAGE="$MESSAGE
Environment: $ENVIRONMENT"
fi

MESSAGE="$MESSAGE
Run: $RUN_URL"

# ===== Send to Slack =====
curl -X POST -H 'Content-type: application/json' \
--data "{\"text\":\"$MESSAGE\"}" \
$SLACK_WEBHOOK_URL
