--triggere ddl


CREATE TRIGGER PreventTableDropping
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    DECLARE @TableName NVARCHAR(128);
    SET @TableName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(128)');

    IF @TableName IN ('Pacienti', 'Medici', 'Programari', 'Tratamente', 'Facturi', 'Servicii', 'DetaliiFacturi', 'Plati')
    BEGIN
        PRINT 'Dropping tables in this database is not allowed.';
        ROLLBACK;
    END
END;


CREATE TRIGGER PreventTableAltering
ON DATABASE
FOR ALTER_TABLE
AS
BEGIN
    DECLARE @TableName NVARCHAR(128);
    SET @TableName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(128)');

    IF @TableName IN ('Pacienti', 'Medici', 'Programari', 'Tratamente', 'Facturi', 'Servicii', 'DetaliiFacturi', 'Plati')
    BEGIN
        PRINT 'Altering tables in this database is not allowed.';
        ROLLBACK;
    END
END;



CREATE TRIGGER LogSchemaChanges
ON DATABASE
FOR CREATE_SCHEMA, ALTER_SCHEMA, DROP_SCHEMA
AS
BEGIN
    DECLARE @SchemaName NVARCHAR(128);
    SET @SchemaName = EVENTDATA().value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(128)');
    
    INSERT INTO clinica_stomatologica.SchemaChangeLog (SchemaName, ChangeType, ChangeDateTime)
    VALUES (@SchemaName, EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'), GETDATE());
END;


CREATE TRIGGER LogDatabaseRoleChanges
ON ALL SERVER
FOR CREATE_ROLE, ALTER_ROLE, DROP_ROLE
AS
BEGIN
    DECLARE @RoleName NVARCHAR(128);
    SET @RoleName = EVENTDATA().value('(/EVENT_INSTANCE/RoleName)[1]', 'NVARCHAR(128)');
    
    INSERT INTO clinica_stomatologica.RoleChangeLog (RoleName, ChangeType, ChangeDateTime)
    VALUES (@RoleName, EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'), GETDATE());
END;

