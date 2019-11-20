#!/bin/bash
#
# Tests for hello-go example.
set -e

cd hello-go/cmd/hello

# Run hello-go tests.
go test
