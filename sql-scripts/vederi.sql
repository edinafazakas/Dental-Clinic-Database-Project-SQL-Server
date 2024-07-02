--vederi

CREATE VIEW V_DetaliiFactura AS
SELECT
    f.FacturaID,
    f.TotalPret,
    f.DataFacturare,
    f.StatusPlata,
    s.Denumire AS NumeServiciu,
    df.Cantitate,
    s.Cost AS CostServiciu
FROM Facturi f
JOIN DetaliiFacturi df ON f.FacturaID = df.FacturaID
JOIN Servicii s ON df.ServiciuID = s.ServiciuID;

SELECT * FROM V_DetaliiFactura;




CREATE VIEW V_Tratamente AS
SELECT 
    T.TratamentID,
    T.DataTratament,
    T.Descriere,
    T.Cost,
    Pa.Nume AS NumePacient,
    Pa.Prenume AS PrenumePacient,
    M.Nume AS NumeMedic,
    M.Prenume AS PrenumeMedic
FROM Tratamente T
JOIN Pacienti Pa ON T.PacientID = Pa.PacientID
JOIN Medici M ON T.MedicID = M.MedicID;

SELECT * FROM V_Tratamente;




CREATE VIEW V_TotalPlatiPacient AS
SELECT 
    Pa.PacientID,
    Pa.Nume AS NumePacient,
    Pa.Prenume AS PrenumePacient,
    SUM(Pl.SumaPlatita) AS TotalPlati
FROM Pacienti Pa
LEFT JOIN Programari P ON Pa.PacientID = P.PacientID
LEFT JOIN Facturi F ON P.ProgramareID = F.ProgramareID
LEFT JOIN Plati Pl ON F.FacturaID = Pl.FacturaID
GROUP BY Pa.PacientID, Pa.Nume, Pa.Prenume;

SELECT * FROM V_TotalPlatiPacient;




CREATE VIEW V_MediciCuNumarProgramari AS
SELECT 
    M.MedicID,
    M.Nume AS NumeMedic,
    M.Prenume AS PrenumeMedic,
    M.Specializare,
    COUNT(P.ProgramareID) AS NumarProgramari
FROM Medici M
LEFT JOIN Programari P ON M.MedicID = P.MedicID
GROUP BY M.MedicID, M.Nume, M.Prenume, M.Specializare;

SELECT * FROM V_MediciCuNumarProgramari;





CREATE VIEW V_PacientiFaraProgramari AS
SELECT 
    Pa.PacientID,
    Pa.Nume AS NumePacient,
    Pa.Prenume AS PrenumePacient
FROM Pacienti Pa
LEFT JOIN Programari P ON Pa.PacientID = P.PacientID
WHERE P.PacientID IS NULL;

SELECT * FROM V_PacientiFaraProgramari;



CREATE VIEW V_ProgramariNeplatite AS
SELECT 
    P.ProgramareID,
    P.DataProgramare,
    P.DurataProgramare,
    P.TipServiciu,
    P.Observatii,
    Pa.Nume AS NumePacient,
    Pa.Prenume AS PrenumePacient,
    M.Nume AS NumeMedic,
    M.Prenume AS PrenumeMedic,
    F.FacturaID,
    F.TotalPret,
    F.StatusPlata
FROM Programari P
JOIN Pacienti Pa ON P.PacientID = Pa.PacientID
JOIN Medici M ON P.MedicID = M.MedicID
JOIN Facturi F ON P.ProgramareID = F.ProgramareID
WHERE F.StatusPlata = 'Neplatita';

SELECT * FROM V_ProgramariNeplatite;