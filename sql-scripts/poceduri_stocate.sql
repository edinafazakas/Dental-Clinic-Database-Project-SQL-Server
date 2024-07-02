--proceduri stocate
USE clinica_stomatologica;

CREATE PROCEDURE InsertPacient
	@PacientID INT,
    @Nume VARCHAR(50),
    @Prenume VARCHAR(50),
    @DataNasterii DATE,
    @Adresa VARCHAR(100),
    @Email VARCHAR(50),
    @Telefon VARCHAR(20)
AS
BEGIN
    INSERT INTO Pacienti (PacientID, Nume, Prenume, DataNasterii, Adresa, Email, Telefon)
    VALUES (@PacientID, @Nume, @Prenume, @DataNasterii, @Adresa, @Email, @Telefon);
END;


EXEC InsertPacient
	@PacientID = '7',
    @Nume = 'Popa',
    @Prenume = 'Alex',
    @DataNasterii = '1992-03-25',
    @Adresa = 'Strada Florilor 22',
    @Email = 'alex.popa@email.com',
    @Telefon = '5551234567';



CREATE PROCEDURE UpdateMedic
    @MedicID INT,
    @Nume VARCHAR(50),
    @Prenume VARCHAR(50),
    @Specializare VARCHAR(50),
    @Email VARCHAR(50),
    @Telefon VARCHAR(20)
AS
BEGIN
    UPDATE Medici
    SET Nume = @Nume, Prenume = @Prenume, Specializare = @Specializare, Email = @Email, Telefon = @Telefon
    WHERE MedicID = @MedicID;
END;


EXEC UpdateMedic
	@MedicID = '2',
    @Nume = 'Slavescu',
    @Prenume = 'Maria',
    @Specializare = 'Ortodontie',
    @Email = 'maria.ortodont@email.com', 
    @Telefon = '11111'



CREATE PROCEDURE DeleteProgramare
    @ProgramareID INT
AS
BEGIN
    DELETE FROM Programari
    WHERE ProgramareID = @ProgramareID;
END;

EXEC DeleteProgramare
    @ProgramareID = '1'



CREATE PROCEDURE DeletePacient
    @PacientID INT
AS
BEGIN
    DELETE FROM Pacienti
    WHERE PacientID = @PacientID;
END;


CREATE PROCEDURE GetPacientByID
    @PacientID INT
AS
BEGIN
    SELECT *
    FROM Pacienti
    WHERE PacientID = @PacientID;
END;



CREATE PROCEDURE GetAllPacienti
AS
BEGIN
    SELECT *
    FROM Pacienti;
END;



    
