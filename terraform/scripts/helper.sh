#!/bin/bash
# Helper functions

# Extract value by key from file
function extract_value() {
  key=$1
  filename=$2
  grep "^$key" $filename | cut -d '"' -f2
}