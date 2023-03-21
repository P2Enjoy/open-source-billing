#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /osb/tmp/pids/server.pid

# Prepare the environment
gem install bundler --no-document
yarn install
rails assets:clobber
# rails webpacker:install
rails webpacker:compile
rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"