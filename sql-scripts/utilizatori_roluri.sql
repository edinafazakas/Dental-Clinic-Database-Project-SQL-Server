USE clinica_stomatologica;

CREATE ROLE RolPacient;
CREATE ROLE RolMedic;
CREATE ROLE RolAdministrator;

GRANT SELECT ON OBJECT::Pacienti TO RolPacient;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Programari TO RolPacient;

GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Medici TO RolAdministrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Programari TO RolAdministrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Tratamente TO RolAdministrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Facturi TO RolAdministrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Servicii TO RolAdministrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::DetaliiFacturi TO RolAdministrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Plati TO RolAdministrator;

GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Medici TO RolMedic;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Programari TO RolMedic;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Tratamente TO RolMedic;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::Servicii TO RolMedic;

CREATE USER pacient1 WITH PASSWORD = 'ParolaPacient';
ALTER ROLE RolPacient ADD MEMBER pacient1;

CREATE USER medic1 WITH PASSWORD = 'ParolaMedic';
ALTER ROLE RolMedic ADD MEMBER medic1;

CREATE USER admin1 WITH PASSWORD = 'ParolaAdmin';
ALTER ROLE RolAdministrator ADD MEMBER admin1;

CREATE LOGIN pacient2 WITH PASSWORD = '123';
	USE clinica_stomatologica;
	CREATE USER pacient1 FOR LOGIN pacient1;
	GRANT SELECT ON SCHEMA::dbo TO pacient1;

CREATE LOGIN medic2 WITH PASSWORD = '123';
	USE clinica_stomatologica;
	CREATE USER medic1 FOR LOGIN medic1;
	GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO medic1;

EXECUTE AS USER = 'pacient2';
	USE clinica_stomatologica;
	SELECT * FROM Pacienti; 
	INSERT INTO Pacienti(PacientID, Nume, Prenume, DataNasterii, Adresa, Email, Telefon)
	VALUES (7, 'Popescu', 'Ana', '1990-05-15', 'Strada Pacientului 1', 'ana.popescu@email.com', '1234567890');
REVERT;
