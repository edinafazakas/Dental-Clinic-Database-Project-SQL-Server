--cursoare 

-- cursor pentru a afisa informatii despre pacienti

DECLARE @PacientID INT, @Nume VARCHAR(50),
@Prenume VARCHAR(50), @DataNasterii DATE, @Adresa VARCHAR(100),
@Email VARCHAR(50), @Telefon VARCHAR(20);

DECLARE PacientiCursor CURSOR FOR
SELECT PacientID, Nume, Prenume, DataNasterii, Adresa, Email, Telefon
FROM Pacienti;
OPEN PacientiCursor;

FETCH NEXT FROM PacientiCursor INTO @PacientID, @Nume, 
@Prenume, @DataNasterii, @Adresa, @Email, @Telefon;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'PacientID: ' + CAST(@PacientID AS VARCHAR(10)) + ', Nume: ' + 
	@Nume + ', Prenume: ' + @Prenume;
    FETCH NEXT FROM PacientiCursor INTO @PacientID, @Nume, @Prenume, @DataNasterii, @Adresa, @Email, @Telefon;
END

CLOSE PacientiCursor;
DEALLOCATE PacientiCursor;



--cursor pentru a apdata costuri de tratamente - le marim cu 10%

DECLARE @TratamentID INT, @Cost DECIMAL(10, 2);

DECLARE TratamenteCursor CURSOR FOR
SELECT TratamentID, Cost
FROM Tratamente;
OPEN TratamenteCursor;

FETCH NEXT FROM TratamenteCursor INTO @TratamentID, @Cost;
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Tratamente
    SET Cost = @Cost * 1.1 
    WHERE TratamentID = @TratamentID;
    FETCH NEXT FROM TratamenteCursor INTO @TratamentID, @Cost;
END
CLOSE TratamenteCursor;
DEALLOCATE TratamenteCursor;




--cursor pentru a afisa informatii despre medici

DECLARE @MedicID INT, @Nume VARCHAR(50), @Prenume VARCHAR(50), 
@Specializare VARCHAR(50), @Email VARCHAR(50), @Telefon VARCHAR(20);

DECLARE MediciCursor CURSOR FOR
SELECT MedicID, Nume, Prenume, Specializare, Email, Telefon
FROM Medici;
OPEN MediciCursor;

FETCH NEXT FROM MediciCursor INTO @MedicID, @Nume, @Prenume, 
@Specializare, @Email, @Telefon;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'MedicID: ' + CAST(@MedicID AS VARCHAR(10)) + ', Nume: ' + @Nume 
	+ ', Prenume: ' + @Prenume;
    FETCH NEXT FROM MediciCursor INTO @MedicID, @Nume, @Prenume,
	@Specializare, @Email, @Telefon;
END
CLOSE MediciCursor;
DEALLOCATE MediciCursor;


--cursor pentru a apdata facturi bazate pe totalpret

DECLARE @FacturaID INT, @TotalPret DECIMAL(10, 2), @StatusPlata VARCHAR(20);

DECLARE FacturiCursor CURSOR FOR
SELECT FacturaID, TotalPret
FROM Facturi;
OPEN FacturiCursor;

FETCH NEXT FROM FacturiCursor INTO @FacturaID, @TotalPret;
WHILE @@FETCH_STATUS = 0
BEGIN
IF @TotalPret > 0
        SET @StatusPlata = 'Platita';
    ELSE
        SET @StatusPlata = 'Neplatita';

    UPDATE Facturi
    SET StatusPlata = @StatusPlata
    WHERE FacturaID = @FacturaID;
    FETCH NEXT FROM FacturiCursor INTO @FacturaID, @TotalPret;
END
CLOSE FacturiCursor;
DEALLOCATE FacturiCursor;




--cursor pentru a afisa costul total de tratament pentru fiecare pacient

DECLARE @PacientID INT, @TotalCost DECIMAL(10, 2);

DECLARE PacientiCursor CURSOR FOR
SELECT PacientID
FROM Pacienti;
OPEN PacientiCursor;

FETCH NEXT FROM PacientiCursor INTO @PacientID;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @TotalCost = 0;
    SELECT @TotalCost = SUM(Cost)
    FROM Tratamente
    WHERE PacientID = @PacientID;
    PRINT 'Total Cost of Tratamente for PacientID ' + 
	CAST(@PacientID AS VARCHAR(10)) + ': ' + CAST(@TotalCost AS VARCHAR(20));

    FETCH NEXT FROM PacientiCursor INTO @PacientID;
END
CLOSE PacientiCursor;
DEALLOCATE PacientiCursor;

