# Schritt-für-Schritt-Anleitung zur Einrichtung von PostgreSQL in Docker mit vorhandenen SQL-Daten

Diese Anleitung zeigt, wie man ein Docker-Image für PostgreSQL erstellt, das SQL-Skripte enthält, um eine Datenbank und Daten einzurichten.

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
    ├── 00_tables.sql
    └── 01_data.sql
```

## Schritt 2: Dockerfile einrichten
Erstelle ein `Dockerfile` im Verzeichnis `postgres-docker`:

```Dockerfile
# Verwende das offizielle PostgreSQL-Image
FROM postgres:latest

# Kopiere die SQL-Skripte in das Initialisierungsverzeichnis
COPY init-source/*.sql /docker-entrypoint-initdb.d/
```

Dieses Dockerfile:
- Verwendet das offizielle PostgreSQL-Image.
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

Beim starten des Containers wird ein Volumen erstellt, wo die Daten beinhaltet. Wird dieses nicht explizit gelöscht, wie weiter unten dokumentiert, so bleiben diese Daten erhalten auch wenn der Container gelöscht wird. 

## Schritt 5: Ausführung der SQL-Skripte überprüfen
Überprüfe, ob die SQL-Skripte korrekt ausgeführt wurden, indem du die Container-Logs überprüfst:

```sh
docker logs my_postgres
```

**Container entfernen und neu erstellen**:
   Falls die Initialisierung immer wieder fehlschlägt (inkludiert das Volume mit den Daten):
   ```sh
   docker rm -f my_postgres
   docker volume prune -f
   docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=postgreProjekt -d postgres-with-data
   ```
   oder
   ```sh
   docker build --no-cache -t postgres-with-data .
   ```
   um den Container ohne Cache zu builden

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

## Verbindung zur PostgreSQL-Datenbank mit DBeaver

Diese Anleitung zeigt, wie du dich mit DBeaver mit der PostgreSQL-Datenbank verbindest, die im Docker-Container läuft.

---

### Schritt 1: DBeaver öffnen und neue Verbindung erstellen
1. Öffne DBeaver.
2. Klicke auf **File > New > DBeaver >Database Connection** oder auf das Datenbank-Symbol in der oberen Menüleiste.
3. Wähle **PostgreSQL** aus der Liste der unterstützten Datenbanken und klicke auf **Next**.

---

### Schritt 2: Verbindungseinstellungen konfigurieren
Fülle die Felder wie folgt aus:

- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `postgreProjekt` (Name der Datenbank, die du im Docker-Container erstellt hast)
- **Authentication**:
  - **Username**: `admin` (wie im `docker run` Befehl definiert)
  - **Password**: `admin` (wie im `docker run` Befehl definiert)
- **Save password**: Aktivieren, um das Passwort zu speichern.

---

### Schritt 3: Verbindung testen
1. Klicke unten links auf **Test Connection**, um die Verbindung zu überprüfen.
2. Wenn die Verbindung erfolgreich ist, klicke auf **OK**, um die Verbindung zu speichern.

---

### Schritt 4: Datenbank verwenden
Sobald die Verbindung hergestellt ist:
1. Navigiere in der linken Baumansicht zu deiner Datenbank (`postgreProjekt`).
2. Öffne den SQL-Editor, um Abfragen auszuführen, z. B.:
  - **Alle Datenbanken auflisten**:
     ```sql
     SELECT datname FROM pg_database;
     ```

   - **Alle Tabellen in der aktuellen Datenbank anzeigen**:
     ```sql
     SELECT table_name 
     FROM information_schema.tables 
     WHERE table_schema = 'public';
     ```

   - **Daten einer bestimmten Tabelle anzeigen**:
     ```sql
     SELECT * FROM <table_name>;
     ```

Ersetze `<table_name>` durch den Namen der Tabelle, die du abfragen möchtest.

### Unterschiede zwischen PostgreSQL und Oracle

1. **Datentypen:**
   - **PostgreSQL:** Verwendet SQL-Standard-Datentypen wie `SERIAL` und `TEXT`.
   - **Oracle:** Nutzt eigene Typen wie `VARCHAR2` und `NUMBER`.

2. **Constraint-Syntax:**
   - **PostgreSQL:** Einfachere Syntax, die stärker auf SQL-Standards basiert.
   - **Oracle:** Umfassende `CHECK`-Constraints und eigene Implementierungen für Fremdschlüssel.

3. **Komplexität der Datenstruktur:**
   - **PostgreSQL:** Geeignet für einfache bis mittlere Anwendungsfälle mit einer flachen Datenhierarchie.
   - **Oracle:** Optimiert für große, komplexe Datenbanken mit hohem Bedarf an Integritätsprüfungen und detaillierten Geschäftsregeln.

4. **Anwendungsbereiche:**
   - **PostgreSQL:** Für einfache bis mittlere Projekte, die SQL-Standardkonformität benötigen.
   - **Oracle:** Für große, komplexe Geschäftsmodelle mit umfangreichen Datenbankanforderungen und Integritätsprüfungen.

---
