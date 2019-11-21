SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[INQUIRY](
[Id] [uniqueidentifier] NOT NULL,
[create_date] [datetime] NOT NULL,
[client_id] [uniqueidentifier] NULL,
[department_address] [nvarchar](255) NULL,
[amout] [decimal](10, 2) NULL,
[UAN] [nvarchar](10) NULL,
[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[INQUIRY] ADD  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[INQUIRY] ADD  DEFAULT (getdate()) FOR [create_date]
GO

ALTER TABLE [dbo].[INQUIRY] ADD  DEFAULT ((0)) FOR [status]
GO

--Хранимая процедура добавляет запис в таблицу

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ADD_INQUIRY]
@client_id uniqueidentifier,
@department_address  NVARCHAR(255),
@amout DECIMAL(10,2),
@UAN NVARCHAR(10),
@status INT,
@Id uniqueidentifier OUTPUT
AS
BEGIN
SET @Id = NEWID()
INSERT INTO dbo.INQUIRY(id, client_id, department_address, amout, UAN, status)  VALUES(@Id, @client_id, @department_address, @amout, @UAN, @status)
END
GO

--Хранимая процедура возвращает запись по request_id

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GET_INQUIRY]
@Id uniqueidentifier
AS
SELECT * FROM [dbo].[INQUIRY] WHERE ID = @Id
GO

--Хранимая процедура возвращает список по client_id, department_address

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GET_INQUIRIES]
@client_id uniqueidentifier,
@department_address NVARCHAR(255)
AS
SELECT * FROM [dbo].[INQUIRY] WHERE client_id = @client_id AND department_address = @department_address;
GO

--Скрипт создания индекса
CREATE NONCLUSTERED INDEX [ClientDepartmentIndex] ON [dbo].[INQUIRY]
(
[client_id] ASC,
[department_address] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
