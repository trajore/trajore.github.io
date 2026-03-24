#!/bin/sh
set -eu

cd /srv/jekyll

# Ignore any host-side Bundler config or stale lockfile from the bind mount.
mkdir -p "$BUNDLE_PATH" "$BUNDLE_APP_CONFIG"
rm -f Gemfile.lock

bundle config set path "$BUNDLE_PATH"
bundle install --jobs 4 --retry 3

exec bundle exec jekyll serve \
  --watch \
  --force_polling \
  --port 8080 \
  --host 0.0.0.0 \
  --livereload \
  --livereload-port 35729