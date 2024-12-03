-- Werte für Tabelle: Status
INSERT INTO Status (StatID, Bezeichner, Beitrag) VALUES
(1, 'Junior', 0),
(2, 'Aktiv', 50),
(3, 'Ehemalig', NULL),
(4, 'Passiv', 30),
(5, 'Helfer', NULL),
(6, 'Extern', NULL);

-- Werte für Tabelle: Person
INSERT INTO Person (PersID, StatID, Name, Vorname, Strasse_Nr, PLZ, Ort, bezahlt, Bemerkungen, Eintritt, Austritt, MentorID) VALUES
(1, 3, 'Niiranen', 'Ulla', 'Nordstr. 113', '2500', 'Biel', '1', NULL, '11.01.11', '31.03.11', NULL),
(2, 3, 'Wendel', 'Otto', 'Sigriststr. 9', '4500', 'Solothurn', '1', NULL, '01.01.10', '31.11.14', NULL),
(3, 2, 'Meyer', 'Dominik', 'Rainstr. 13', '4528', 'Zuchwil', '0', NULL, '01.01.11', NULL, NULL),
(4, 2, 'Meyer', 'Petra', 'Rainstr. 13', '4528', 'Zuchwil', '1', NULL, '15.02.09', NULL, NULL),
(5, 6, 'Tamburino', 'Mario', 'Solothurnstr. 96', '2540', 'Grenchen', '1', NULL, '21.05.12', NULL, 4),
(6, 5, 'Degger', 'Benji', 'Sportstr. 2', '2500', 'Biel', '1', NULL, '21.05.12', NULL, 4),
(7, 5, 'Luder', 'Kevin', 'Forstweg 14', '2545', 'Zuchwil', '1', 'Klauskoch', 'NULL', NULL, 4),
(8, 5, 'Frei', 'Barbara', 'Gartenstr. 1', '2543', 'Grenchen', '1', NULL, NULL, NULL, NULL),
(9, 5, 'Huber', 'Felix', 'Eichmatt 7', '2545', 'Selzach', '1', NULL, NULL, NULL, NULL),
(10, 6, 'Cadola', 'Leo', 'Sportstr. 2', '4500', 'Solothurn', '1', NULL, '01.10.13', NULL, NULL),
(11, 4, 'Bart', 'Sabine', 'Bernstr. 15', '2543', 'Grenchen', '1', NULL, '12.07.14', NULL, 10),
(12, 2, 'Gruber', 'Romy', 'Gladbachl 3', '2545', 'Selzach', '0', NULL, '29.11.09', NULL, NULL);

-- Werte für Tabelle: Funktion
INSERT INTO Funktion (FunkID, Bezeichner) VALUES
(1, 'Präsidium'),
(2, 'Vizepräsidium'),
(3, 'Kasse'),
(4, 'Beisitz'),
(5, 'PR');

-- Werte für Tabelle: Funktionsbesetzung
INSERT INTO Funktionsbesetzung (PersID, FunkID, Antritt, Ruecktritt) VALUES
(1, 1, '11.01.07', '31.03.10'),
(2, 1, '01.04.10', '31.03.13'),
(12, 1, '01.04.10', '31.03.11'),
(3, 1, '01.04.14', NULL),
(4, 1, '01.04.14', NULL),
(5, 1, '01.04.14', NULL),
(6, 2, '01.04.14', '30.04.29'),
(12, 2, '01.04.14', '31.03.14'),
(8, 3, '08.04.14', NULL),
(9, 3, '01.04.13', NULL);

-- Werte für Tabelle: Sponsor
INSERT INTO Sponsor (SponID, Name, Strasse_Nr, PLZ, Ort, Spendentotal) VALUES
(1, 'Hasler AG', 'Zelgweg 9', '2540', 'Grenchen', 1270),
(2, 'Pauker Druck', 'Solothurnstr. 19', '2540', 'Bettlach', 2750),
(3, 'Meyer Toni', 'Rothstr. 22', '4500', 'Solothurn', 750);

-- Werte für Tabelle: Sponsorenkontakt
INSERT INTO Sponsorenkontakt (PersID, SponID) VALUES
(1, 1),
(3, 2),
(5, 3),
(4, 2);

-- Werte für Tabelle: Anlass
INSERT INTO Anlass (AnlaID, OrgID, Bezeichner, Ort, Datum, Kosten) VALUES
(1, 2, 'GV', 'Solothurn', '31.03.13', 200),
(2, 12, 'Vorstandssitzung', 'Grenchen', '17.01.14', 150),
(3, 6, 'GV', 'Bettlach', '30.03.13', 200),
(4, 11, 'Klauskoch', 'Bettlach', '06.12.14', 150);

-- Werte für Tabelle: Teilnehmer
INSERT INTO Teilnehmer (PersID, AnlaID) VALUES
(3, 1),
(4, 1),
(5, 2),
(12, 3);

-- Werte für Tabelle: Spende
INSERT INTO Spende (SpenID, AnlaID, Bezeichner, Datum, Betrag) VALUES
(1, 5, 'Apero', '02.02.15', 720),
(2, 3, 'Defrittilligung', '05.03.15', 550),
(3, 2, 'Getränke', '11.03.15', 300),
(4, 4, 'Plakate', '13.04.15', 750);
