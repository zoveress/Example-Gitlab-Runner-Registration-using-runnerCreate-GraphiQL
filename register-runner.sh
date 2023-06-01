#!/usr/bin/bash
export PRIVATE_TOKEN="Replace with your Personal Access Tokens" 
# Go to Settings -> General and copy the numeric value from "Project ID".
export PROJECT_ID="Replace with your Project ID" 
export TAGLIST="yourtag" 
export RUN_UNTAGGED="true"
export LOCKED="true"
# Change this is to your own hosted gitlab URL if you use gitlab.com leave the value set.
export GITLAB_URL="https://gitlab.com" 
export TOKEN=$(curl "$GITLAB_URL/api/graphql" --header "Authorization: Bearer $PRIVATE_TOKEN" --header "Content-Type: application/json" --request POST --data-binary '{"query": "mutation { runnerCreate( input: {projectId: \"gid://gitlab/Project/'$PROJECT_ID'\", runnerType: PROJECT_TYPE, tagList: \"'$TAGLIST'\", runUntagged: '$RUN_UNTAGGED', locked: '$LOCKED'} ) { errors runner { ephemeralAuthenticationToken } } }"}' |jq '.data.runnerCreate.runner.ephemeralAuthenticationToken' | tr -d '"')
sudo gitlab-runner register --non-interactive --url $GITLAB_URL --token $TOKEN --executor shell