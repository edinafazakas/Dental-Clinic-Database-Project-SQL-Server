--strategii de backup/restore


--full backup
BACKUP DATABASE clinica_stomatologica TO DISK = 'D:\MATERIALE AN 4 SEM 1\ABD\proiect\Fazakas_Edina_Proiect_P1\FullBackup.bak';

--transactional log backup
BACKUP LOG clinica_stomatologica TO DISK = 'D:\MATERIALE AN 4 SEM 1\ABD\proiect\Fazakas_Edina_Proiect_P1\LogBackup1.trn';

--full restore
RESTORE DATABASE clinica_stomatologica FROM DISK = 'D:\MATERIALE AN 4 SEM 1\ABD\proiect\Fazakas_Edina_Proiect_P1\FullBackup.bak' WITH REPLACE;

--file restore
RESTORE DATABASE clinica_stomatologica FILE = 'Pacienti' FROM DISK = 'D:\MATERIALE AN 4 SEM 1\ABD\proiect\Fazakas_Edina_Proiect_P1\FullBackup.bak' WITH RECOVERY;
