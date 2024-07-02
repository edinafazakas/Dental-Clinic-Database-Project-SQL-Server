--triggere dml

CREATE TRIGGER UpdateTotalPret
ON Tratamente
AFTER INSERT
AS
BEGIN
    UPDATE Facturi
    SET TotalPret = TotalPret + (SELECT Cost FROM INSERTED)
    WHERE ProgramareID = (SELECT ProgramareID FROM INSERTED);
END;

CREATE TRIGGER UpdateTotalPretOnUpdate
ON Tratamente
AFTER UPDATE
AS
BEGIN
    UPDATE Facturi
    SET TotalPret = TotalPret - (SELECT Cost FROM DELETED) + (SELECT Cost FROM INSERTED)
    WHERE ProgramareID = (SELECT ProgramareID FROM INSERTED);
END;


CREATE TRIGGER UpdateTotalPretOnDelete
ON Tratamente
AFTER DELETE
AS
BEGIN
    UPDATE Facturi
    SET TotalPret = TotalPret - (SELECT Cost FROM DELETED)
    WHERE ProgramareID = (SELECT ProgramareID FROM DELETED);
END;


CREATE TRIGGER PreventPacientDelete
ON Pacienti
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM deleted d INNER JOIN Programari p ON d.PacientID = p.PacientID)
    BEGIN
        PRINT 'Cannot delete Pacient records associated with Programari.';
    END
    ELSE
    BEGIN
        DELETE FROM Pacienti
        WHERE PacientID IN (SELECT PacientID FROM deleted);
    END
END;

CREATE TRIGGER UpdateAverageCostOnTratament
ON Tratamente
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Medici
    SET AverageTratamentCost = (
        SELECT AVG(Cost)
        FROM Tratamente
        WHERE MedicID = Medici.MedicID
    )
    WHERE MedicID IN (SELECT MedicID FROM INSERTED);
END;




ALTER TABLE Medici
ADD AverageTratamentCost DECIMAL(10, 2) NULL;



