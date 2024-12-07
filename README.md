
# 🚀 Schritt-für-Schritt-Anleitung zur Einrichtung von PostgreSQL in Docker mit vorhandenen SQL-Daten

Diese Anleitung zeigt, wie man ein Docker-Image für PostgreSQL erstellt, das SQL-Skripte enthält, um eine Datenbank und Daten einzurichten.

## 📋 Voraussetzungen

- 🐋 Docker installiert
- 📄 SQL-Skriptdateien zur Initialisierung der Datenbank und zum Einfügen von Daten
- 📚 Grundlegendes Verständnis von Docker und PostgreSQL

---

## 📂 Schritt 1: Verzeichnisstruktur erstellen

Erstelle ein Verzeichnis, um alle benötigten Dateien abzulegen:

```sh
mkdir postgres-docker
cd postgres-docker
```

Füge folgende Dateien und Verzeichnisse hinzu:

```
postgres-docker/
├── Dockerfile
└── init-source/
    ├── 00_tables.sql
    └── 01_data.sql
```

---

## 🛠️ Schritt 2: Dockerfile einrichten

Erstelle eine Datei `Dockerfile` im Verzeichnis `postgres-docker` mit folgendem Inhalt:

```Dockerfile
# Verwende das offizielle PostgreSQL-Image
FROM postgres:latest

# Kopiere die SQL-Skripte in das Initialisierungsverzeichnis
COPY init-source/*.sql /docker-entrypoint-initdb.d/
```

**Dieses Dockerfile:**
- Verwendet das offizielle PostgreSQL-Image.
- Kopiert die SQL-Skripte in das Standard-Initialisierungsverzeichnis (`/docker-entrypoint-initdb.d/`). PostgreSQL führt diese Skripte während der Initialisierung automatisch aus.

---

## 🏗️ Schritt 3: Docker-Image erstellen

Baue das Docker-Image mit folgendem Befehl:

```sh
docker build -t postgres-with-data .
```

Falls du den Build-Cache umgehen möchtest, verwende stattdessen:

```sh
docker build --no-cache -t postgres-with-data .
```

⚠️ **Hinweis:** Stelle sicher, dass du dich im Verzeichnis `postgres-docker/` befindest.

---

## 🚢 Schritt 4: Docker-Container starten

Starte den Container:

```sh
docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=postgreProjekt -d postgres-with-data
```

**Erklärung:**
- `-p 5432:5432`: Mappt den PostgreSQL-Port auf den Host.
- `--name my_postgres`: Benennt den Container.
- `-e POSTGRES_USER`, `-e POSTGRES_PASSWORD`, `-e POSTGRES_DB`: Setzt Benutzer, Passwort und Datenbanknamen.
- `-d`: Führt den Container im Hintergrund aus.

Beim Starten des Containers wird ein Volumen erstellt, das die Daten speichert. Wird dieses nicht explizit gelöscht (siehe Schritt 5), bleiben die Daten erhalten, auch wenn der Container gelöscht wird.

---

## ✅ Schritt 5: Initialisierung überprüfen

Prüfe die Container-Logs:

```sh
docker logs my_postgres
```

Falls die Initialisierung fehlschlägt, entferne den Container und das Volume und erstelle sie neu:

```sh
docker rm -f my_postgres
docker volume prune -f
docker run -p 5432:5432 --name my_postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=postgreProjekt -d postgres-with-data
```

---

## 🔗 Schritt 6: Verbindung zur Datenbank herstellen

Verwende den folgenden Befehl, um dich mit der PostgreSQL-Datenbank zu verbinden:

```sh
docker exec -it my_postgres psql -U admin -d postgreProjekt
```

Prüfe die Datenbankinhalte mit PostgreSQL-Befehlen:

```sql
\l           -- Listet alle Datenbanken auf
\c postgreProjekt -- Verbindet mit der Datenbank
\dt          -- Zeigt alle Tabellen
```

---

## 🌐 Verbindung zur Datenbank mit DBeaver

### Schritt 1: DBeaver öffnen und neue Verbindung erstellen
1. Öffne DBeaver.
2. Gehe zu **File > New > Database Connection**.
3. Wähle **PostgreSQL** und klicke auf **Next**.

### Schritt 2: Verbindungseinstellungen konfigurieren
- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `postgreProjekt`
- **Username**: `admin`
- **Password**: `admin`

Klicke auf **Test Connection**, um die Verbindung zu überprüfen. Wenn die Verbindung erfolgreich ist, klicke auf **OK**, um sie zu speichern.

### Schritt 3: Datenbank verwenden
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

---

## ⚔️ Unterschiede zwischen PostgreSQL und Oracle

| Kriterium               | PostgreSQL                                                                                   | Oracle                                                                                   |
|-------------------------|---------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| **Datentypen**          | Moderne Typen wie `JSONB`, `ARRAY`, `UUID`                                                  | Proprietäre Typen wie `VARCHAR2`, `NUMBER`                                              |
| **Constraint-Syntax**   | Flexibel, SQL-Standardkonform                                                               | Umfangreiche Features für grosse, komplexe Tabellen                                      |
| **Komplexität**         | Gut geeignet für einfache bis mittlere Strukturen, horizontal skalierbar                    | Starke vertikale Skalierung, optimiert für grosse Unternehmensdatenbanken                |
| **Anwendungsbereiche**  | Ideal für Startups, Cloud-Umgebungen, Open-Source-Projekte                                  | Perfekt für grosse Unternehmen, Hochverfügbarkeit und komplexe Geschäftsmodelle          |

---

## 🏁 Fazit

- **PostgreSQL**: Modern, flexibel, kosteneffizient. Perfekt für Startups und Cloud-Umgebungen.
- **Oracle**: Leistungsstark, aber teuer. Entwickelt für Grossunternehmen mit hohen Anforderungen.

---
