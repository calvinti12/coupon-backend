#!/bin/bash
set -e

echo
echo "=> Platform: $PLATFORM"

if [ "$PLATFORM" = "SIDEKIQ" ]; then
  bundle exec sidekiq -C config/sidekiq.yml -e $RAILS_ENV
else
  echo
  echo "Database migration"
  bundle exec rake db:migrate
  echo
  echo "Seed data migration"
  bundle exec rake seed:migrate
  echo
  passenger start
fi
