# Schritt-für-Schritt-Anleitung zur Einrichtung von PostgreSQL in Docker mit vorhandenen SQL-Daten

Diese Anleitung zeigt Ihnen, wie Sie ein Docker-Image für PostgreSQL erstellen, das SQL-Skripte enthält, um eine Datenbank und Daten einzurichten. Wir werden auch häufige Probleme behandeln, wie z.B. die Vermeidung der Verwendung von Tablespaces in Docker, die unnötige Fehler verursachen können.

## Voraussetzungen
- Docker auf Ihrem System installiert
- SQL-Skriptdateien zur Initialisierung der Datenbank und zum Einfügen von Daten
- Grundlegendes Verständnis von Docker und PostgreSQL

## Schritt 1: Verzeichnisstruktur erstellen
Erstellen Sie ein Verzeichnis, in dem alle Dateien abgelegt werden:

```sh
mkdir postgres-docker
cd postgres-docker
```

Fügen Sie in diesem Verzeichnis Folgendes hinzu:
- Eine `Dockerfile` zur Erstellung des Docker-Images.
- Ein Verzeichnis `init-scripts/`, das alle Ihre SQL-Dateien enthält.

Verzeichnisstruktur:

```
postgres-docker/
├── Dockerfile
└── init-scripts/
    ├── 01_setup_users.sql
    ├── 02_emp-dept_tables.sql
    ├── 03_emp-dept_data.sql
    ├── 04_verein_tables.sql
    └── 05_verein_data.sql
```

Stellen Sie sicher, dass jede SQL-Datei gültige Befehle für PostgreSQL enthält und vermeiden Sie unnötige Komplexität, wie z.B. die Erstellung von Tablespaces in Docker.

## Schritt 2: Dockerfile einrichten
Erstellen Sie eine `Dockerfile` im Verzeichnis `postgres-docker`:

```Dockerfile
# Verwenden Sie das offizielle PostgreSQL-Image
FROM postgres:latest

# Setzen Sie Umgebungsvariablen (nach Bedarf anpassen)
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=adminpassword
ENV POSTGRES_DB=postgreProjekt

# Kopieren Sie die SQL-Skripte in das Initialisierungsverzeichnis
COPY init-scripts/*.sql /docker-entrypoint-initdb.d/
```

Diese Dockerfile:
- Verwendet das offizielle PostgreSQL-Image.
- Setzt Umgebungsvariablen für die Datenbank, den Benutzer und das Passwort.
- Kopiert die SQL-Skripte in das Standard-Initialisierungsverzeichnis (`/docker-entrypoint-initdb.d/`). PostgreSQL führt diese Skripte während der Initialisierung automatisch aus.

**Hinweis**: Vermeiden Sie es, Passwörter in der Dockerfile abzulegen. Verwenden Sie stattdessen in Produktionsumgebungen Umgebungsvariablen oder Docker-Secrets.

## Schritt 3: Entfernen von Tablespace-Referenzen
Bearbeiten Sie `01_setup_users.sql`, um alle Zeilen zu entfernen, die sich auf Tablespaces beziehen, z.B.:

```sql
-- CREATE TABLESPACE emp_tablespace LOCATION '/var/lib/postgresql/data/emp_tablespace';
-- GRANT ALL PRIVILEGES ON TABLESPACE emp_tablespace TO scott;
```

Dies verhindert Fehler, die auftreten, wenn Tablespace-Verzeichnisse nicht existieren, insbesondere in einer Docker-Umgebung.

## Schritt 4: Docker-Image neu erstellen
Erstellen Sie Ihr Docker-Image neu, um sicherzustellen, dass die Änderungen angewendet wurden:

```sh
docker build -t postgres-with-data .
```

Stellen Sie sicher, dass Sie diesen Befehl **im Verzeichnis ausführen, in dem sich die Dockerfile befindet** (`postgres-docker/`).

## Schritt 5: Docker-Container starten
Starten Sie nun den Container mit folgendem Befehl:

```sh
docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=adminpassword -e POSTGRES_DB=postgreProjekt -d postgres-with-data
```

**Erklärung**:
- `-p 5432:5432`: Mappt den PostgreSQL-Port auf den Host.
- `--name my_postgres`: Benennt den Container `my_postgres`.
- `-e POSTGRES_USER`, `-e POSTGRES_PASSWORD`, `-e POSTGRES_DB`: Setzt Umgebungsvariablen zur Laufzeit.
- `-d`: Führt den Container im Hintergrund aus (detached mode).

## Schritt 6: Ausführung der SQL-Skripte überprüfen
Überprüfen Sie, ob die SQL-Skripte korrekt ausgeführt wurden, indem Sie die Container-Logs überprüfen:

```sh
docker logs my_postgres
```

Suchen Sie in den Logs nach Fehlern, insbesondere im Zusammenhang mit der Skriptausführung. Häufige Probleme sind ungültige SQL-Befehle oder fehlende Referenzen.

Wenn alles korrekt funktioniert, sollten Sie Meldungen sehen, die darauf hinweisen, dass die Datenbank und die Tabellen erfolgreich erstellt wurden.

## Schritt 7: Fehlerbehebung
Wenn weiterhin Probleme auftreten:

1. **Laufende Container überprüfen**:
   ```sh
   docker ps
   ```
   Stellen Sie sicher, dass Ihr Container `my_postgres` läuft. Wenn er nicht aufgelistet ist, ist er möglicherweise nicht gestartet.

2. **Gestoppte Container überprüfen**:
   ```sh
   docker ps -a
   ```
   Wenn Ihr Container aufgelistet ist, aber beendet wurde, können Sie die Logs für weitere Details überprüfen:
   ```sh
   docker logs my_postgres
   ```

3. **Container entfernen und neu erstellen**:
   Wenn die Initialisierung immer wieder fehlschlägt:
   ```sh
   docker rm -f my_postgres
   docker volume prune -f
   docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=adminpassword -e POSTGRES_DB=postgreProjekt -d postgres-with-data
   ```

## Schritt 8: Verbindung zur Datenbank herstellen
Sobald der Container läuft, können Sie sich mit der PostgreSQL-Instanz verbinden:

```sh
docker exec -it my_postgres psql -U admin -d postgreProjekt
```

Von hier aus können Sie Standard-PostgreSQL-Befehle verwenden, um zu überprüfen, ob die Tabellen und Daten korrekt erstellt wurden:

```sql
\l  -- Alle Datenbanken auflisten
\c postgreProjekt  -- Mit Ihrer Datenbank verbinden
\dt -- Alle Tabellen auflisten
```

## Fazit
Wenn Sie diese Schritte befolgen, sollten Sie einen Docker-Container haben, der PostgreSQL mit Ihren vordefinierten Daten aus den Initialisierungsskripten ausführt. Vermeiden Sie die Verwendung von Tablespace-Einstellungen, die in einer Docker-Umgebung unpraktisch sind, und stellen Sie sicher, dass alle Referenzen entfernt oder vereinfacht wurden.

### Zusammenfassung
- **Dateien vorbereiten**: SQL-Skripte organisieren und eine Dockerfile erstellen.
- **SQL-Skripte bearbeiten**: Problematische Referenzen wie Tablespaces entfernen.
- **Neu bauen und starten**: Docker-Image bauen und Container erstellen.
- **Verifizieren**: Logs überprüfen und bei Bedarf Fehler beheben.