#!/bin/bash

if [ "$1" = "apply" ]; then
  docker compose exec web bundle exec ridgepole --apply -c config/database.yml -f db/Schemafile -E development
elif [ "$1" = "diff" ]; then
  docker compose exec web bundle exec ridgepole --diff config/database.yml db/Schemafile -E development
elif [ "$1" = "export" ]; then
  docker compose exec web bundle exec ridgepole --export -c config/database.yml --output db/Schemafile -E development
else
  echo 'Pass the environment name ("apply" or "diff" or "export")'
fi
