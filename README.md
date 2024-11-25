# Schritt-für-Schritt-Anleitung zur Einrichtung von PostgreSQL in Docker mit vorhandenen SQL-Daten

Diese Anleitung zeigt, wie man ein Docker-Image für PostgreSQL erstellt, das SQL-Skripte enthält, um eine Datenbank und Daten einzurichten. Häufige Probleme, wie die Verwendung von Tablespaces in Docker, die Fehler verursachen können, werden ebenfalls behandelt.

## Voraussetzungen
- Docker installiert
- SQL-Skriptdateien zur Initialisierung der Datenbank und zum Einfügen von Daten
- Grundlegendes Verständnis von Docker und PostgreSQL

## Schritt 1: Verzeichnisstruktur erstellen
Erstelle ein Verzeichnis, um alle Dateien abzulegen:

```sh
mkdir postgres-docker
cd postgres-docker
```

Füge in diesem Verzeichnis Folgendes hinzu:
- Eine `Dockerfile` zur Erstellung des Docker-Images.
- Ein Verzeichnis `init-source/`, das alle SQL-Dateien enthält.

Verzeichnisstruktur:

```
postgres-docker/
├── Dockerfile
└── init-source/
    ├── 00_department.sql
    ├── 01_employees.sql
    ├── 02_department_data.sql
    └── 03_employee_data.sql
```

## Schritt 2: Dockerfile einrichten
Erstelle eine `Dockerfile` im Verzeichnis `postgres-docker`:

```Dockerfile
# Verwende das offizielle PostgreSQL-Image
FROM postgres:latest

# Setze Umgebungsvariablen (nach Bedarf anpassen)
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=postgreProjekt

# Kopiere die SQL-Skripte in das Initialisierungsverzeichnis
COPY init-source/*.sql /docker-entrypoint-initdb.d/
```

Dieses Dockerfile:
- Verwendet das offizielle PostgreSQL-Image.
- Setzt Umgebungsvariablen für die Datenbank, den Benutzer und das Passwort.
- Kopiert die SQL-Skripte in das Standard-Initialisierungsverzeichnis (`/docker-entrypoint-initdb.d/`). PostgreSQL führt diese Skripte während der Initialisierung automatisch aus.

## Schritt 3: Docker-Image erstellen

```sh
docker build -t postgres-with-data .
```

Führe diesen Befehl **im Verzeichnis aus, in dem sich die Dockerfile befindet** (`postgres-docker/`).

## Schritt 4: Docker-Container starten
Starte den Container mit folgendem Befehl:

```sh
docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=postgreProjekt -d postgres-with-data
```

**Erklärung**:
- `-p 5432:5432`: Mappt den PostgreSQL-Port auf den Host.
- `--name my_postgres`: Benennt den Container `my_postgres`.
- `-e POSTGRES_USER`, `-e POSTGRES_PASSWORD`, `-e POSTGRES_DB`: Setzt Umgebungsvariablen zur Laufzeit.
- `-d`: Führt den Container im Hintergrund aus.

## Schritt 5: Ausführung der SQL-Skripte überprüfen
Überprüfe, ob die SQL-Skripte korrekt ausgeführt wurden, indem du die Container-Logs überprüfst:

```sh
docker logs my_postgres
```

**Container entfernen und neu erstellen**:
   Falls die Initialisierung immer wieder fehlschlägt:
   ```sh
   docker rm -f my_postgres
   docker volume prune -f
   docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=adminpassword -e POSTGRES_DB=postgreProjekt -d postgres-with-data
   ```

## Schritt 6: Verbindung zur Datenbank herstellen
Sobald der Container läuft, kannst du dich mit der PostgreSQL-Instanz verbinden:

```sh
docker exec -it my_postgres psql -U admin -d postgreProjekt
```

Verwende die folgenden Standard-PostgreSQL-Befehle, um zu überprüfen, ob die Tabellen und Daten korrekt erstellt wurden:

```sql
\l  -- Alle Datenbanken auflisten
\c postgreProjekt  -- Mit der Datenbank verbinden
\dt -- Alle Tabellen auflisten
```
