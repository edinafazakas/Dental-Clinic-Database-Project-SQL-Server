--inserari in tabele

USE clinica_stomatologica;

INSERT INTO Pacienti (PacientID, Nume, Prenume, DataNasterii, Adresa, Email, Telefon)
VALUES
  (1, 'Popescu', 'Ana', '1990-05-15', 'Strada Pacientului 1', 'ana.popescu@email.com', '1234567890'),
  (2, 'Ionescu', 'Mihai', '1985-08-22', 'Strada Dintaritorului 5', 'mihai.ionescu@email.com', '9876543210'),
  (3, 'Marinescu', 'Ion', '1976-05-25', 'Strada Zero 4', 'marinescu.ion@email.com', '493549348'),
  (4, 'Martin', 'Petru', '1955-05-12', 'Strada Grigorescu 12', 'martin.petru@email.com', '287530335'),
  (5, 'Georgescu', 'Elena', '1980-12-03', 'Strada Soarelui 8', 'elena.georgescu@email.com', '7654321098'),
  (6, 'Stoica', 'Alexandru', '1995-06-20', 'Aleea Florilor 14', 'alex.stoica@email.com', '3210987654');


INSERT INTO Medici (MedicID, Nume, Prenume, Specializare, Email, Telefon)
VALUES
  (1, 'Dentistul', 'Andrei', 'Stomatologie Generala', 'andrei.dentist@email.com', '1112223344'),
  (2, 'Ortodontul', 'Maria', 'Ortodontie', 'maria.ortodont@email.com', '5556667788'),
  (3, 'Parodontologul', 'Ana', 'Parodontologie', 'ana.parodontolog@email.com', '3334445566'),
  (4, 'Prostodontul', 'George', 'Prostodontie', 'george.prostodont@email.com', '7778889999');


INSERT INTO Programari (ProgramareID, PacientID, MedicID, DataProgramare, DurataProgramare, TipServiciu, Observatii)
VALUES
  (1, 1, 1, '2023-01-10 09:00:00', 60, 'Consultatie', 'Necesita curatare dentara'),
  (2, 2, 2, '2023-01-15 14:30:00', 45, 'Ortodontie', 'Ajustare aparat dentar'),
  (3, 3, 3, '2023-02-05 11:00:00', 90, 'Tratament', 'Tratament parodontal'),
  (4, 4, 4, '2023-02-10 13:45:00', 60, 'Consultatie', 'Consultatie pentru proteza dentara');

INSERT INTO Tratamente (TratamentID, MedicID, PacientID, DataTratament, Descriere, Cost)
VALUES
  (1, 1, 1, '2023-01-10 10:00:00', 'Curatare dentara', 150.00),
  (2, 2, 2, '2023-01-15 15:30:00', 'Ajustare aparat dentar', 200.00),
  (3, 3, 3, '2023-02-05 12:30:00', 'Tratament parodontal', 300.00),
  (4, 4, 4, '2023-02-12 14:30:00', 'Consultatie pentru proteza dentara', 250.00);


INSERT INTO Facturi (FacturaID, ProgramareID, TotalPret, DataFacturare, StatusPlata)
VALUES
  (1, 1, 150.00, '2023-01-10 11:30:00', 'Neplatita'),
  (2, 2, 200.00, '2023-01-16 10:00:00', 'Neplatita'),
  (3, 3, 300.00, '2023-02-06 10:15:00', 'Neplatita'),
  (4, 4, 250.00, '2023-02-15 11:00:00', 'Neplatita');



INSERT INTO Servicii (ServiciuID, Denumire, Descriere, Cost)
VALUES
  (1, 'Consultatie', 'Consultatia initiala', 100.00),
  (2, 'Ortodontie', 'Servicii de ortodontie', 120.00);
  (3, 'Parodontologie', 'Servicii parodontale', 150.00),
  (4, 'Prostodontie', 'Servicii de prostodontie', 200.00);


INSERT INTO DetaliiFacturi (DetaliuID, FacturaID, ServiciuID, Cantitate)
VALUES
  (1, 1, 1, 1),
  (2, 2, 2, 1),
  (3, 3, 3, 2),
  (4, 4, 4, 1);

INSERT INTO Plati (PlataID, FacturaID, DataPlatii, SumaPlatita)
VALUES
  (1, 1, '2023-01-12 09:30:00', 150.00),
  (2, 2, '2023-01-18 11:45:00', 200.00),
  (3, 3, '2023-02-08 09:30:00', 300.00),
  (4, 4, '2023-02-17 12:45:00', 250.00);

