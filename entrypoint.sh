#!/bin/sh

# Set default values for SQL_HOST and SQL_PORT if not provided
SQL_HOST=${SQL_HOST:-kotenet_db}
SQL_PORT=${SQL_PORT:-5432}
DATABASE=${DATABASE:-postgres}

if [ "$DATABASE" = "postgres" ]; then
    echo "Waiting for PostgreSQL at $SQL_HOST:$SQL_PORT..."

    # Print out the SQL_HOST and SQL_PORT for debugging
    echo "SQL_HOST: $SQL_HOST"
    echo "SQL_PORT: $SQL_PORT"

    # Wait until PostgreSQL is available
    while ! nc -z -w 1 "$SQL_HOST" "$SQL_PORT"; do
      echo "Waiting for PostgreSQL..."
      sleep 1
    done

    echo "PostgreSQL started"
fi

# Run database migrations
python manage.py flush --no-input
python manage.py migrate

# Execute the command passed to the entrypoint
exec "$@"