-- PostgreSQL equivalent of the given Oracle SQL

-- Containers (PDB) are an Oracle-specific concept. In PostgreSQL, there is no equivalent needed.

-- Creating "Anlass" table
CREATE TABLE vereinuser.anlass (
  anlaid      SERIAL PRIMARY KEY,
  bezeichner  VARCHAR(20) NOT NULL,
  ort         VARCHAR(20),
  datum       TIMESTAMP NOT NULL,
  kosten      NUMERIC(8, 2),
  orgid       INTEGER NOT NULL,
  CONSTRAINT chk_kosten CHECK (kosten IS NULL OR kosten >= 0)
);

-- Creating "Funktion" table
CREATE TABLE vereinuser.funktion (
  funkid      SERIAL PRIMARY KEY,
  bezeichner  VARCHAR(20) NOT NULL
);

-- Creating "Funktionsbesetzung" table
CREATE TABLE vereinuser.funktionsbesetzung (
  antritt     TIMESTAMP NOT NULL,
  ruecktritt  TIMESTAMP,
  funkid      INTEGER NOT NULL,
  persid      INTEGER NOT NULL,
  PRIMARY KEY (funkid, persid, antritt),
  CONSTRAINT chk_ruecktritt CHECK (antritt <= ruecktritt OR ruecktritt IS NULL)
);

-- Creating "Person" table
CREATE TABLE vereinuser.person (
  persid       SERIAL PRIMARY KEY,
  name         VARCHAR(20) NOT NULL,
  vorname      VARCHAR(15) NOT NULL,
  strasse_nr   VARCHAR(20) NOT NULL,
  plz          CHAR(4) NOT NULL,
  ort          VARCHAR(20) NOT NULL,
  bezahlt      CHAR(1) NOT NULL,
  bemerkungen  VARCHAR(25),
  eintritt     TIMESTAMP,
  austritt     TIMESTAMP,
  statid       INTEGER NOT NULL,
  mentorid     INTEGER,
  CONSTRAINT chk_austritt CHECK ((eintritt <= austritt OR austritt IS NULL) OR (eintritt IS NULL AND austritt IS NULL))
);

-- Creating "Spende" table
CREATE TABLE vereinuser.spende (
  spenid      SERIAL NOT NULL,
  bezeichner  VARCHAR(20),
  datum       TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
  betrag      NUMERIC(8, 2) NOT NULL,
  sponid      INTEGER NOT NULL,
  anlaid      INTEGER,
  PRIMARY KEY (spenid, sponid)
);

-- Creating "Sponsor" table
CREATE TABLE vereinuser.sponsor (
  sponid       SERIAL PRIMARY KEY,
  name         VARCHAR(20) NOT NULL,
  strasse_nr   VARCHAR(20) NOT NULL,
  plz          CHAR(4) NOT NULL,
  ort          VARCHAR(20) NOT NULL,
  spendentotal NUMERIC(8, 2) NOT NULL
);

-- Creating "Sponsorenkontakt" table
CREATE TABLE vereinuser.sponsorenkontakt (
  persid INTEGER NOT NULL,
  sponid INTEGER NOT NULL,
  PRIMARY KEY (persid, sponid)
);

-- Creating "Status" table
CREATE TABLE vereinuser.status (
  statid      SERIAL PRIMARY KEY,
  bezeichner  VARCHAR(20) NOT NULL,
  beitrag     INTEGER,
  CONSTRAINT chk_beitrag_status CHECK (beitrag IS NULL OR beitrag >= 0)
);

-- Creating "Teilnehmer" table
CREATE TABLE vereinuser.teilnehmer (
  persid INTEGER NOT NULL,
  anlaid INTEGER NOT NULL,
  PRIMARY KEY (persid, anlaid)
);

-- Adding foreign key constraints
ALTER TABLE vereinuser.anlass
  ADD CONSTRAINT anlass_person_fk FOREIGN KEY (orgid) REFERENCES vereinuser.person (persid);

ALTER TABLE vereinuser.sponsorenkontakt
  ADD CONSTRAINT fk_sponk_person FOREIGN KEY (persid) REFERENCES vereinuser.person (persid),
  ADD CONSTRAINT fk_sponk_sponsor FOREIGN KEY (sponid) REFERENCES vereinuser.sponsor (sponid);

ALTER TABLE vereinuser.teilnehmer
  ADD CONSTRAINT fk_teiln_anlass FOREIGN KEY (anlaid) REFERENCES vereinuser.anlass (anlaid),
  ADD CONSTRAINT fk_teiln_person FOREIGN KEY (persid) REFERENCES vereinuser.person (persid);

ALTER TABLE vereinuser.funktionsbesetzung
  ADD CONSTRAINT funktionsbesetzung_funktion_fk FOREIGN KEY (funkid) REFERENCES vereinuser.funktion (funkid),
  ADD CONSTRAINT funktionsbesetzung_person_fk FOREIGN KEY (persid) REFERENCES vereinuser.person (persid);

ALTER TABLE vereinuser.person
  ADD CONSTRAINT person_person_fk FOREIGN KEY (mentorid) REFERENCES vereinuser.person (persid),
  ADD CONSTRAINT person_status_fk FOREIGN KEY (statid) REFERENCES vereinuser.status (statid);

ALTER TABLE vereinuser.spende
  ADD CONSTRAINT spende_anlass_fk FOREIGN KEY (anlaid) REFERENCES vereinuser.anlass (anlaid),
  ADD CONSTRAINT spende_sponsor_fk FOREIGN KEY (sponid) REFERENCES vereinuser.sponsor (sponid);
