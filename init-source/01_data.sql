SET datestyle = 'German, DMY';

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
(1, 3, 'Niiranen', 'Ulla', 'Nordstr. 113', '2500', 'Biel', '1', NULL, '2011-01-11', '2011-03-31', NULL),
(2, 3, 'Wendel', 'Otto', 'Sigriststr. 9', '4500', 'Solothurn', '1', NULL, '2010-01-01', '2014-11-30', NULL),
(3, 2, 'Meyer', 'Dominik', 'Rainstr. 13', '4528', 'Zuchwil', '0', NULL, '2011-01-01', NULL, NULL),
(4, 2, 'Meyer', 'Petra', 'Rainstr. 13', '4528', 'Zuchwil', '1', NULL, '2009-02-15', NULL, NULL),
(5, 6, 'Tamburino', 'Mario', 'Solothurnstr. 96', '2540', 'Grenchen', '1', NULL, '2012-05-21', NULL, 4),
(6, 5, 'Degger', 'Benji', 'Sportstr. 2', '2500', 'Biel', '1', NULL, '2012-05-21', NULL, 4),
(7, 5, 'Luder', 'Kevin', 'Forstweg 14', '2545', 'Zuchwil', '1', 'Klauskoch', '2012-05-01', NULL, 4),
(8, 5, 'Frei', 'Barbara', 'Gartenstr. 1', '2543', 'Grenchen', '1', NULL, '2012-06-01', NULL, NULL),
(9, 5, 'Huber', 'Felix', 'Eichmatt 7', '2545', 'Selzach', '1', NULL, '2013-03-15', NULL, NULL),
(10, 6, 'Cadola', 'Leo', 'Sportstr. 2', '4500', 'Solothurn', '1', NULL, '2013-10-01', NULL, NULL),
(11, 4, 'Bart', 'Sabine','Bernstr. 15', '2543', 'Grenchen', '1', NULL, '2014-07-12', NULL, 10),
(12, 2, 'Gruber', 'Romy', 'Gladbachl 3', '2545', 'Selzach', '0', NULL, '2009-11-29', NULL, NULL);

-- Werte für Tabelle: Funktion
INSERT INTO Funktion (FunkID, Bezeichner) VALUES
(1, 'Präsidium'),
(2, 'Vizepräsidium'),
(3, 'Kasse'),
(4, 'Beisitz'),
(5, 'PR');

-- Werte für Tabelle: Funktionsbesetzung
INSERT INTO Funktionsbesetzung (PersID, FunkID, Antritt, Ruecktritt) VALUES
(1, 1, '2007-01-11', '2010-03-31'),
(2, 1, '2010-04-01', '2013-03-31'),
(12, 1, '2010-04-01', '2011-03-31'),
(3, 1, '2014-04-01', NULL),
(4, 1, '2014-04-01', NULL),
(5, 1, '2014-04-01', NULL),
(6, 2, '2014-04-01', '2029-04-30'),
(12, 2, '2014-04-01', '2014-03-31'),
(8, 3, '2014-08-04', NULL),
(9, 3, '2013-04-01', NULL);

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
INSERT INTO Anlass (AnlaID, Bezeichner, Ort, Datum, Kosten, OrgID) VALUES
(1, 'GV', 'Solothurn', '2013-03-31', 200,2),
(2, 'Vorstandssitzung', 'Grenchen', '2014-01-17', 150,12),
(3, 'GV', 'Bettlach', '2013-03-30', 200,6),
(4, 'Klauskoch', 'Bettlach', '2014-12-06', 150,11);

-- Werte für Tabelle: Teilnehmer
INSERT INTO Teilnehmer (PersID, AnlaID) VALUES
(3, 1),
(4, 1),
(5, 2),
(12, 3);

-- Werte für Tabelle: Spende
INSERT INTO Spende (SpenID, AnlaID, Bezeichner, Datum, Betrag) VALUES
(1, 1, 'Apero', '2015-02-02', 720),
(2, 3, 'Defrittilligung', '2015-03-05', 550),
(3, 2, 'Getränke', '2015-11-03', 300),
(4, 4, 'Plakate', '2015-04-13', 750);
