#!/bin/bash
#
# Tests for hello-go example container build.
set -e

cd hello-go

# Build hello-go image.
docker build -t hello-go .
docker run -d --name hello-go --rm -p 8180:8180 hello-go

# Test the response with curl.
if curl -s localhost:8180 | grep "Hello, you requested: /"; then
    echo "Received the correct response."
else
    echo "Did not receive the correct response."
    exit 1
fi
