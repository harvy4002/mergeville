#!/bin/bash

# extract_knowledge.sh
# Evaluates and ranks documentation files based on relevance to provided tags.
# Usage: ./extract_knowledge.sh <comma-separated-tags-and-topics>

if [ -z "$1" ]; then
  echo "Usage: $0 <comma-separated-tags-and-topics>"
  exit 1
fi

TAGS="$1"
DIRS=".memory/decisions .memory/knowledge .memory/assumptions .memory/specs .memory/bugs"

EXISTING_DIRS=""
for d in $DIRS; do
  if [ -d "$d" ]; then
    EXISTING_DIRS="$EXISTING_DIRS $d"
  fi
done

if [ -z "$EXISTING_DIRS" ]; then
  echo "No .memory directories found."
  exit 0
fi

find $EXISTING_DIRS -type f -name "*.md" 2>/dev/null | awk -v tags_str="$TAGS" '
BEGIN {
    split(tolower(tags_str), tag_arr, ",")
    for (i in tag_arr) {
        sub(/^[ \t]+/, "", tag_arr[i])
        sub(/[ \t]+$/, "", tag_arr[i])
        if (tag_arr[i] != "") {
            search_tags[tag_arr[i]] = 1
        }
    }
}
{
    file = $0
    score = 0
    match_count = 0
    in_frontmatter = 0
    frontmatter = ""
    status = ""
    
    while ((getline line < file) > 0) {
        if (line ~ /^---[ \t]*$/) {
            in_frontmatter++
            if (in_frontmatter == 2) {
                break
            }
            continue
        }
        if (in_frontmatter == 1) {
            frontmatter = frontmatter "\n" tolower(line)
            if (tolower(line) ~ /^status:/) {
                status = tolower(line)
                sub(/^status:[ \t]*/, "", status)
                gsub(/["\047\r]/, "", status)
            }
        }
    }
    close(file)
    
    if (in_frontmatter > 0) {
        for (t in search_tags) {
            regex = "(^|[^a-zA-Z0-9_])" t "([^a-zA-Z0-9_]|$)"
            if (frontmatter ~ regex) {
                score += 2
                match_count++
            }
        }
        
        if (match_count == 0) {
            score -= 1
        }
        
        if (status ~ /deprecated|rejected|obsolete/) {
            score -= 5
        } else if (status ~ /accepted|active|approved/) {
            score += 1
        }
        
        if (score >= 0) {
            print score "\t" file
        }
    }
}' | sort -k1,1nr | head -n 20 | awk -F'\t' '{print "- " $2 " (Score: " $1 ")"}'
