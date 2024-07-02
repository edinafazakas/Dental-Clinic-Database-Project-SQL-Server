--CREATE DATABASE clinica_stomatologica;

USE clinica_stomatologica;


CREATE TABLE Pacienti (
    PacientID INT PRIMARY KEY,
    Nume VARCHAR(50),
    Prenume VARCHAR(50),
    DataNasterii DATE,
    Adresa VARCHAR(100),
    Email VARCHAR(50),
    Telefon VARCHAR(20)
);

CREATE TABLE Medici (
    MedicID INT PRIMARY KEY,
    Nume VARCHAR(50),
    Prenume VARCHAR(50),
    Specializare VARCHAR(50),
    Email VARCHAR(50),
    Telefon VARCHAR(20)
);

CREATE TABLE Programari (
    ProgramareID INT PRIMARY KEY,
    PacientID INT,
    MedicID INT,
    DataProgramare DATETIME,
    DurataProgramare INT,
    TipServiciu VARCHAR(50),
    Observatii TEXT,
    FOREIGN KEY (PacientID) REFERENCES Pacienti(PacientID),
    FOREIGN KEY (MedicID) REFERENCES Medici(MedicID)
);

CREATE TABLE Tratamente (
    TratamentID INT PRIMARY KEY,
    MedicID INT,
    PacientID INT,
    DataTratament DATETIME,
    Descriere VARCHAR(255),
    Cost DECIMAL(10, 2),
    FOREIGN KEY (MedicID) REFERENCES Medici(MedicID),
    FOREIGN KEY (PacientID) REFERENCES Pacienti(PacientID)
);

CREATE TABLE Facturi (
    FacturaID INT PRIMARY KEY,
    ProgramareID INT,
    TotalPret DECIMAL(10, 2),
    DataFacturare DATETIME,
    StatusPlata VARCHAR(20),
    FOREIGN KEY (ProgramareID) REFERENCES Programari(ProgramareID)
);

CREATE TABLE Servicii (
    ServiciuID INT PRIMARY KEY,
    Denumire VARCHAR(50),
    Descriere TEXT,
    Cost DECIMAL(10, 2)
);

CREATE TABLE DetaliiFacturi (
    DetaliuID INT PRIMARY KEY,
    FacturaID INT,
    ServiciuID INT,
    Cantitate INT,
    FOREIGN KEY (FacturaID) REFERENCES Facturi(FacturaID),
    FOREIGN KEY (ServiciuID) REFERENCES Servicii(ServiciuID)
);

CREATE TABLE Plati (
    PlataID INT PRIMARY KEY,
    FacturaID INT,
    DataPlatii DATETIME,
    SumaPlatita DECIMAL(10, 2),
    FOREIGN KEY (FacturaID) REFERENCES Facturi(FacturaID)
);
