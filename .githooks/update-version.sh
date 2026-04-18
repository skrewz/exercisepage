#!/bin/bash
set -o errexit

# Check if docs/manifest.json is staged for commit
if git diff --cached --name-only | grep -q "docs/manifest.json"; then
    # Get current UTC timestamp with seconds
    NEW_VERSION=$(TZ=UTC date +%Y%m%d%H%M%S)
    
    # Update version in manifest.json using jq
    jq --arg v "$NEW_VERSION" '.version = $v' docs/manifest.json > /tmp/manifest.json.tmp && \
    mv /tmp/manifest.json.tmp docs/manifest.json
    
    # Stage the updated file
    git add docs/manifest.json
    
    echo "✓ Version updated to $NEW_VERSION"
fi
