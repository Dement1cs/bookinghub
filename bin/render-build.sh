#!/usr/bin/env bash
set -o errexit

bundle install

# поставить JS зависимости (для jsbundling-rails)
if [ -f yarn.lock ]; then
  yarn install --frozen-lockfile
elif [ -f package-lock.json ]; then
  npm ci
elif [ -f bun.lockb ]; then
  bun install --frozen-lockfile
fi

bundle exec rails assets:precompile
bundle exec rails assets:clean

