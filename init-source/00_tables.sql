-- Tabelle: Status
CREATE TABLE Status (
    StatID INTEGER PRIMARY KEY,
    Bezeichner VARCHAR(20) NOT NULL,
    Beitrag NUMERIC(5,2)
);

-- Tabelle: Person
CREATE TABLE Person (
    PersID INTEGER PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Vorname VARCHAR(15) NOT NULL,
    Strasse_Nr VARCHAR(20),
    PLZ CHAR(4),
    Ort VARCHAR(20),
    bezahlt CHAR(1),
    Bemerkungen VARCHAR(255),
    Eintritt DATE NOT NULL,
    Austritt DATE,
    StatID INTEGER,
    MentorID INTEGER,
    FOREIGN KEY (StatID) REFERENCES Status (StatID),
    FOREIGN KEY (MentorID) REFERENCES Person (PersID)
);

-- Tabelle: Funktion
CREATE TABLE Funktion (
    FunkID INTEGER PRIMARY KEY,
    Bezeichner VARCHAR(20) NOT NULL
);

-- Tabelle: Funktionsbesetzung
CREATE TABLE Funktionsbesetzung (
    Antritt DATE NOT NULL,
    Ruecktritt DATE,
    FunkID INTEGER,
    PersID INTEGER,
    PRIMARY KEY (FunkID, PersID),
    FOREIGN KEY (FunkID) REFERENCES Funktion (FunkID),
    FOREIGN KEY (PersID) REFERENCES Person (PersID)
);

-- Tabelle: Sponsor
CREATE TABLE Sponsor (
    SponID INTEGER PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Strasse_Nr VARCHAR(20),
    PLZ CHAR(4),
    Ort VARCHAR(20),
    Spendentotal NUMERIC(8,2)
);

-- Tabelle: Sponsorenkontakt
CREATE TABLE Sponsorenkontakt (
    PersID INTEGER,
    SponID INTEGER,
    PRIMARY KEY (PersID, SponID),
    FOREIGN KEY (PersID) REFERENCES Person (PersID),
    FOREIGN KEY (SponID) REFERENCES Sponsor (SponID)
);

-- Tabelle: Anlass
CREATE TABLE Anlass (
    AnlaID INTEGER PRIMARY KEY,
    Bezeichner VARCHAR(20) NOT NULL,
    Ort VARCHAR(20),
    Datum DATE,
    Kosten NUMERIC(8,2),
    OrgID INTEGER
);

-- Tabelle: Teilnehmer
CREATE TABLE Teilnehmer (
    PersID INTEGER,
    AnlaID INTEGER,
    PRIMARY KEY (PersID, AnlaID),
    FOREIGN KEY (PersID) REFERENCES Person (PersID),
    FOREIGN KEY (AnlaID) REFERENCES Anlass (AnlaID)
);

-- Tabelle: Spende
CREATE TABLE Spende (
    SpenID INTEGER PRIMARY KEY,
    Bezeichner VARCHAR(20),
    Datum DATE,
    Betrag NUMERIC(8,2),
    SponID INTEGER,
    AnlaID INTEGER,
    FOREIGN KEY (SponID) REFERENCES Sponsor (SponID),
    FOREIGN KEY (AnlaID) REFERENCES Anlass (AnlaID)
);
