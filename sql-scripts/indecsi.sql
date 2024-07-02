CREATE UNIQUE INDEX idx_unique_programare_id ON Programari (ProgramareID);

CREATE UNIQUE INDEX idx_unique_nume_prenume_pacienti ON Pacienti (Nume, Prenume);

CREATE CLUSTERED INDEX idx_clustered_nume_prenume_medici ON Medici (Nume, Prenume);

CREATE INDEX idx_medic_pacient_id_tratamente ON Tratamente (MedicID, PacientID);
