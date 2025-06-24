#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

docker compose exec web rails generate devise User
