/*
	Presentation: Get a Lever and Pick Any Turtle
	Slide: 25 - What about exclusions?
	Script: 
*/
USE LeversAndTurtles
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBHealth].[SmallVarcharColumns]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [DBHealth].[SmallVarcharColumns]
GO

CREATE PROCEDURE DBHealth.SmallVarcharColumns
AS
BEGIN
	SELECT OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID) AS [Procedure], QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME) AS TableName, QUOTENAME(c.COLUMN_NAME) AS ColumnName, 'Small varchar column: ' + c.DATA_TYPE + '(' + CAST(c.CHARACTER_MAXIMUM_LENGTH as varchar(50)) + ')' AS Problem
	FROM INFORMATION_SCHEMA.COLUMNS AS c
	INNER JOIN DBHealth.MonitoredSchemas AS ms
		ON ms.SchemaName = c.TABLE_SCHEMA
	LEFT JOIN DBMeta.Properties AS cp
		ON cp.FullObjectName = QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME) + '.' + QUOTENAME(c.COLUMN_NAME)
		AND cp.PropertyName = 'DBHealth.SmallVarcharColumns'
	WHERE c.DATA_TYPE IN ('varchar', 'nvarchar')
		AND c.CHARACTER_MAXIMUM_LENGTH <= 2
		AND ISNULL(cp.PropertyValue, '') <> 'EXCLUDE'
END
GO

EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'MS_Description', 'Health check for small varchar columns which should be char'
GO
EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'HEALTH_CHECK_PROC', 'TRUE'
GO
EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'HEALTH_CHECK_SET', 'TABLE DESIGN'
GO
EXEC DBMeta.AddXP 'DBHealth.SmallVarcharColumns', 'SUBSYSTEM', 'HEALTH'
GO

IF EXISTS (SELECT * FROM DBMeta.Properties WHERE FullObjectName = '[Demo].[Demo3].[Gender]' AND PropertyName = 'DBHealth.SmallVarcharColumns')
	EXEC DBMeta.DropXP 'Demo.Demo3.Gender', 'DBHealth.SmallVarcharColumns'
GO

EXEC DBHealth.SmallVarcharColumns
GO

EXEC DBMeta.AddXP 'Demo.Demo3.Gender', 'DBHealth.SmallVarcharColumns', 'EXCLUDE'
GO

EXEC DBHealth.SmallVarcharColumns
GO

USE master
GO
