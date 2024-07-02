--constrangeri

USE clinica_stomatologica;

ALTER TABLE Pacienti
ADD CONSTRAINT UQ_Pacienti_Email
UNIQUE (Email);

ALTER TABLE Medici
ADD CONSTRAINT UQ_Medici_Email
UNIQUE (Email);

ALTER TABLE Programari
ADD CONSTRAINT CHK_DurataProgramare_Pozitiva
CHECK (DurataProgramare > 0);

ALTER TABLE Tratamente
ADD CONSTRAINT CHK_CostTratament_Pozitiv
CHECK (Cost > 0);


ALTER TABLE DetaliiFacturi
ADD CONSTRAINT CHK_Cantitate_Pozitiva
CHECK (Cantitate > 0);


ALTER TABLE Programari
ADD CONSTRAINT CHK_TipServiciu_Valid
CHECK (TipServiciu IN ('Consultatie', 'Tratament', 'Altele'));


ALTER TABLE Facturi
ADD CONSTRAINT CHK_StatusPlata_Valid
CHECK (StatusPlata IN ('Neplatita', 'Partial', 'Platita'));
