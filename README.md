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

Stelle sicher, dass jede SQL-Datei gültige Befehle für PostgreSQL enthält und vermeide unnötige Komplexität, wie die Erstellung von Tablespaces in Docker.

## Schritt 2: Dockerfile einrichten
Erstelle eine `Dockerfile` im Verzeichnis `postgres-docker`:

```Dockerfile
# Verwende das offizielle PostgreSQL-Image
FROM postgres:latest

# Setze Umgebungsvariablen (nach Bedarf anpassen)
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=adminpassword
ENV POSTGRES_DB=postgreProjekt

# Kopiere die SQL-Skripte in das Initialisierungsverzeichnis
COPY init-source/*.sql /docker-entrypoint-initdb.d/
```

Diese Dockerfile:
- Verwendet das offizielle PostgreSQL-Image.
- Setzt Umgebungsvariablen für die Datenbank, den Benutzer und das Passwort.
- Kopiert die SQL-Skripte in das Standard-Initialisierungsverzeichnis (`/docker-entrypoint-initdb.d/`). PostgreSQL führt diese Skripte während der Initialisierung automatisch aus.

**Hinweis**: Passwörter sollten nicht in der Dockerfile abgelegt werden. Verwende stattdessen in Produktionsumgebungen Umgebungsvariablen oder Docker-Secrets.

## Schritt 3: Entfernen von Tablespace-Referenzen
Bearbeite `00_department.sql` oder andere SQL-Dateien, um alle Zeilen zu entfernen, die sich auf Tablespaces beziehen, z.B.:

```sql
-- CREATE TABLESPACE emp_tablespace LOCATION '/var/lib/postgresql/data/emp_tablespace';
-- GRANT ALL PRIVILEGES ON TABLESPACE emp_tablespace TO user;
```

Das verhindert Fehler, die auftreten, wenn Tablespace-Verzeichnisse nicht existieren, insbesondere in einer Docker-Umgebung.

## Schritt 4: Docker-Image neu erstellen
Erstelle das Docker-Image neu, um sicherzustellen, dass die Änderungen übernommen wurden:

```sh
docker build -t postgres-with-data .
```

Führe diesen Befehl **im Verzeichnis aus, in dem sich die Dockerfile befindet** (`postgres-docker/`).

## Schritt 5: Docker-Container starten
Starte den Container mit folgendem Befehl:

```sh
docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=adminpassword -e POSTGRES_DB=postgreProjekt -d postgres-with-data
```

**Erklärung**:
- `-p 5432:5432`: Mappt den PostgreSQL-Port auf den Host.
- `--name my_postgres`: Benennt den Container `my_postgres`.
- `-e POSTGRES_USER`, `-e POSTGRES_PASSWORD`, `-e POSTGRES_DB`: Setzt Umgebungsvariablen zur Laufzeit.
- `-d`: Führt den Container im Hintergrund aus.

## Schritt 6: Ausführung der SQL-Skripte überprüfen
Überprüfe, ob die SQL-Skripte korrekt ausgeführt wurden, indem du die Container-Logs überprüfst:

```sh
docker logs my_postgres
```

Suche in den Logs nach Fehlern, insbesondere im Zusammenhang mit der Skriptausführung. Häufige Probleme sind ungültige SQL-Befehle oder fehlende Referenzen.

Wenn alles korrekt funktioniert, sollten Meldungen erscheinen, die darauf hinweisen, dass die Datenbank und die Tabellen erfolgreich erstellt wurden.

## Schritt 7: Fehlerbehebung
Falls weiterhin Probleme auftreten:

1. **Laufende Container überprüfen**:
   ```sh
   docker ps
   ```
   Stelle sicher, dass dein Container `my_postgres` läuft. Wenn er nicht aufgelistet ist, ist er möglicherweise nicht gestartet.

2. **Gestoppte Container überprüfen**:
   ```sh
   docker ps -a
   ```
   Falls der Container aufgelistet ist, aber beendet wurde, überprüfe die Logs für weitere Details:
   ```sh
   docker logs my_postgres
   ```

3. **Container entfernen und neu erstellen**:
   Falls die Initialisierung immer wieder fehlschlägt:
   ```sh
   docker rm -f my_postgres
   docker volume prune -f
   docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=adminpassword -e POSTGRES_DB=postgreProjekt -d postgres-with-data
   ```

## Schritt 8: Verbindung zur Datenbank herstellen
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

## Fazit
Wenn diese Schritte befolgt werden, sollte ein Docker-Container laufen, der PostgreSQL mit den vorkonfigurierten Daten aus den Initialisierungsskripten enthält. Vermeide Tablespace-Einstellungen, die in einer Docker-Umgebung unpraktisch sind, und stelle sicher, dass alle Referenzen entfernt oder vereinfacht wurden.

### Zusammenfassung
- **Dateien vorbereiten**: SQL-Skripte organisieren und eine Dockerfile erstellen.
- **SQL-Skripte bearbeiten**: Problematische Referenzen wie Tablespaces entfernen.
- **Neu bauen und starten**: Docker-Image bauen und Container erstellen.
- **Verifizieren**: Logs überprüfen und bei Bedarf Fehler beheben.

Diese Anleitung sollte helfen, PostgreSQL erfolgreich in Docker mit vorkonfigurierten Daten einzurichten.