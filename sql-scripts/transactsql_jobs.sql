--job-uri transact sql


--backup database
USE [msdb];
GO

EXEC msdb.dbo.sp_add_job
    @job_name = N'LogDatabaseSizeJob',
    @enabled = 1,
    @notify_level_eventlog = 2;

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'LogDatabaseSizeJob',
    @step_name = N'LogDatabaseSizeStep',
    @subsystem = N'TSQL',
    @command = N'INSERT INTO [DatabaseSizeLog] (LogDate, DatabaseSizeMB) VALUES (GETDATE(), (SELECT SUM(size) FROM sys.master_files WHERE DB_NAME(database_id) = ''clinica_stomatologica''))',
    @on_success_action = 1;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'LogDatabaseSizeSchedule',
    @freq_type = 4,  -- Daily
    @freq_interval = 1,  -- Every day
    @active_start_time = 040000;  -- 04:00 AM

EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'LogDatabaseSizeJob',
    @schedule_name = N'LogDatabaseSizeSchedule';

GO


--backup transaction logs 

USE [msdb];
GO

EXEC msdb.dbo.sp_add_job
    @job_name = N'BackupTransactionLogsJob',
    @enabled = 1,
    @notify_level_eventlog = 2;

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'BackupTransactionLogsJob',
    @step_name = N'BackupTransactionLogsStep',
    @subsystem = N'TSQL',
    @command = N'BACKUP LOG clinica_stomatologica TO DISK = ''D:\MATERIALE AN 4 SEM 1\ABD\proiect\Fazakas_Edina_Proiect_P1\LogBackup2.trn''',
    @on_success_action = 1;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'BackupTransactionLogsSchedule',
    @freq_type = 4,  -- Daily
    @freq_interval = 1,  -- Every day
    @active_start_time = 050000;  -- 05:00 AM

EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'BackupTransactionLogsJob',
    @schedule_name = N'BackupTransactionLogsSchedule';

GO


--update employee salaries job

USE [msdb];
GO

EXEC msdb.dbo.sp_add_job
    @job_name = N'UpdateEmployeeSalariesJob',
    @enabled = 1,
    @notify_level_eventlog = 2;

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'UpdateEmployeeSalariesJob',
    @step_name = N'UpdateEmployeeSalariesStep',
    @subsystem = N'TSQL',
    @command = N'UPDATE Medici SET Salariu = Salariu * 1.1 WHERE Specializare = ''Dentist''',
    @on_success_action = 1;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'UpdateEmployeeSalariesSchedule',
    @freq_type = 4,  -- Daily
    @freq_interval = 1,  -- Every day
    @active_start_time = 070000;  -- 07:00 AM

EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'UpdateEmployeeSalariesJob',
    @schedule_name = N'UpdateEmployeeSalariesSchedule';

GO


--weekly backup 

USE [msdb];
GO

EXEC msdb.dbo.sp_add_job
    @job_name = N'WeeklyBackupJob',
    @enabled = 1,
    @notify_level_eventlog = 2;

EXEC msdb.dbo.sp_add_jobstep
    @job_name = N'WeeklyBackupJob',
    @step_name = N'WeeklyBackupStep',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE clinica_stomatologica TO DISK = ''C:\Backup\WeeklyBackup.bak''',
    @on_success_action = 1;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name = N'WeeklyBackupSchedule',
    @freq_type = 8,  -- Weekly
    @freq_interval = 1,  -- Every Sunday
    @freq_recurrence_factor = 1, -- Corrected factor
    @active_start_time = 020000;  -- 02:00 AM

EXEC msdb.dbo.sp_attach_schedule
    @job_name = N'WeeklyBackupJob',
    @schedule_name = N'WeeklyBackupSchedule';

GO



