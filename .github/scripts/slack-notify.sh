#!/bin/bash

# ===== Parameters =====
TYPE=$1
STATUS=$2
PROJECT=$3
BRANCH=$4
RUN_URL=$5
ENVIRONMENT=$6
URL=$7

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

# Include Live URL
if [ -n "$URL" ]; then
  MESSAGE="$MESSAGE
🌐 Live: <$URL|Open Website>"
fi

# Include Environment
if [ -n "$ENVIRONMENT" ]; then
  MESSAGE="$MESSAGE
Environment: $ENVIRONMENT"
fi

# Include Workflow URL (clickable)
MESSAGE="$MESSAGE
Run: <$RUN_URL|View Workflow>"

# ===== Send to Slack =====
curl -X POST -H 'Content-type: application/json' \
--data "{\"text\":\"$MESSAGE\"}" \
$SLACK_WEBHOOK_URL
