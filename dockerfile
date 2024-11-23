# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Set environment variables (modify these as needed)
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=postgreProjekt

# Copy the initialization SQL scripts to the directory that PostgreSQL uses for initial setup
COPY init-source/*.sql /docker-entrypoint-initdb.d/
