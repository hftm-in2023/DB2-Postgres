# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Copy the initialization SQL scripts to the directory that PostgreSQL uses for initial setup
COPY init-source/*.sql /docker-entrypoint-initdb.d/
RUN ls -l /docker-entrypoint-initdb.d/
