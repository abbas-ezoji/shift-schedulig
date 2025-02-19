USE [master]
GO
/****** Object:  Database [Didgah_Timekeeper_DM]    Script Date: 2/12/2020 4:32:34 PM ******/
CREATE DATABASE [Didgah_Timekeeper_DM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Didgah_', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER2017\MSSQL\DATA\Didgah_.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Didgah__log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER2017\MSSQL\DATA\Didgah__log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Didgah_Timekeeper_DM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET ARITHABORT OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET RECOVERY FULL 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET  MULTI_USER 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Didgah_Timekeeper_DM', N'ON'
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET QUERY_STORE = OFF
GO
USE [Didgah_Timekeeper_DM]
GO
/****** Object:  User [CHARGOON\elias.rahmani]    Script Date: 2/12/2020 4:32:35 PM ******/
CREATE USER [CHARGOON\elias.rahmani] FOR LOGIN [CHARGOON\elias.rahmani] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [CHARGOON\elias.rahmani]
GO
/****** Object:  Schema [VW]    Script Date: 2/12/2020 4:32:35 PM ******/
CREATE SCHEMA [VW]
GO
USE [Didgah_Timekeeper_DM]
GO
/****** Object:  Sequence [dbo].[hibernate_sequence]    Script Date: 2/12/2020 4:32:35 PM ******/
CREATE SEQUENCE [dbo].[hibernate_sequence] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  UserDefinedFunction [dbo].[com_GetPersianDateVarchar]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[com_GetPersianDateVarchar](@IntToVar int) returns varchar(50)
AS
Begin
---------------------------
--DECLARE @IntToVar int = 1365
---------------------------
declare @Centuries int,@CenturiesVar varchar(50)
declare @Tens int,@TensVar Varchar(20),@OnesVarchar Varchar(10),@Ones INT

SET @Centuries = SUBSTRING(CAST(@IntToVar AS VARCHAR(5)),1,2)
SET @CenturiesVar = CASE WHEN @Centuries = 13 THEN 'هزار و سیصد'
						 WHEN @Centuries = 14 THEN 'هزار و چهارصد'
						 ELSE '' END
SET @Tens = SUBSTRING(CAST(@IntToVar AS VARCHAR(5)),3,2)
SET @Ones = SUBSTRING(CAST(@IntToVar AS VARCHAR(5)),4,1)
SET @OnesVarchar = CASE WHEN @Tens = 1 THEN 'یک'
						WHEN @Tens = 2 THEN 'دو'
						WHEN @Tens = 3 THEN 'سه'
						WHEN @Tens = 4 THEN 'چهار'
						WHEN @Tens = 5 THEN 'پنج'
						WHEN @Tens = 6 THEN 'شش'
						WHEN @Tens = 7 THEN 'هفت'
						WHEN @Tens = 8 THEN 'هشت'
						WHEN @Tens = 9 THEN 'نه'
						WHEN @Tens = 10 THEN 'ده'
						WHEN @Tens = 11 THEN 'یازده'
						WHEN @Tens = 12 THEN 'دوازده'
						WHEN @Tens = 13 THEN 'سیزده'
						WHEN @Tens = 14 THEN 'چهارده'
						WHEN @Tens = 15 THEN 'پانزده'
						WHEN @Tens = 15 THEN 'شانزده'
						WHEN @Tens = 17 THEN 'هفده'
						WHEN @Tens = 18 THEN 'هجده'
						WHEN @Tens = 19 THEN 'نوزده'
						ELSE CASE WHEN @Ones = 1 THEN 'یک'
								  WHEN @Ones = 2 THEN 'دو'
								  WHEN @Ones = 3 THEN 'سه'
								  WHEN @Ones = 4 THEN 'چهار'
								  WHEN @Ones = 5 THEN 'پنج' 
								  WHEN @Ones = 6 THEN 'شش'
								  WHEN @Ones = 7 THEN 'هفت'
								  WHEN @Ones = 8 THEN 'هشت'
								  WHEN @Ones = 9 THEN 'نه' 
								  ELSE '' END
						END
SET @Tens = SUBSTRING(CAST(@IntToVar AS VARCHAR(5)),3,1)
SET @TensVar = CASE	WHEN @Tens = 2 THEN 'بیست'
					WHEN @Tens = 3 THEN 'سی'
					WHEN @Tens = 4 THEN 'چهل'
					WHEN @Tens = 5 THEN 'پنجاه'
					WHEN @Tens = 6 THEN 'شصت'
					WHEN @Tens = 7 THEN 'هفتاد'
					WHEN @Tens = 8 THEN 'هشتاد'
					WHEN @Tens = 9 THEN 'نود'
					ELSE '' END
return @CenturiesVar + CASE WHEN @TensVar <> '' THEN ' و ' ELSE '' END + @TensVar + CASE WHEN @OnesVarchar <> '' THEN ' و ' ELSE '' END + @OnesVarchar
end
GO
/****** Object:  UserDefinedFunction [dbo].[com_udfGetChristianDate]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[com_udfGetChristianDate](@SolarDate varchar(10)) RETURNS smalldatetime AS BEGIN

	IF LEN(@SolarDate) = 8
		SET @SolarDate = '13' + @SolarDate

	DECLARE @SolarYear int, @SolarMonth int, @SolarDay int
	DECLARE @I int, @TempYear int, @Leap int, @DayOfYear int
	DECLARE @Result smalldatetime

	SET @SolarYear  = CAST(LEFT(@SolarDate, 4) AS int)
	SET @SolarMonth = CAST(RIGHT(LEFT(@SolarDate, 7), 2) AS int)
	SET @SolarDay   = CAST(RIGHT(@SolarDate, 2) AS int)

	IF @SolarMonth >= 7
		SET @DayOfYear = 31 * 6 + (@SolarMonth-7) * 30 + @SolarDay
	ELSE
		SET @DayOfYear = (@SolarMonth-1) * 31 + @SolarDay

	IF @SolarYear = 1278
		SET @Result = @DayOfYear-(31*6 + 3*30+11)
	ELSE BEGIN
		SET @Result = 365 - (31*6 + 3*30+11) + 1
		SET @I = 1279
		WHILE @I < @SolarYear BEGIN
			SET @TempYear = @I + 11
			SET @TempYear = @TempYear - ( @TempYear / 33) * 33

			IF  (@TempYear <> 32) and ( (@TempYear / 4) * 4 = @TempYear )
				SET @Leap = 1
			ELSE
				SET @Leap = 0

			IF @Leap = 1
				SET @Result = @Result + 366
			ELSE
				SET @Result = @Result + 365

			SET @I = @I + 1
		END

		SET @Result = @Result + @DayOfYear - 1 
	END

	RETURN @Result

END















GO
/****** Object:  UserDefinedFunction [dbo].[com_udfGetSolarDate]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[com_udfGetSolarDate](@EDate smalldatetime) RETURNS varchar(10) AS BEGIN

	DECLARE @FDate varchar(10)	
	DECLARE @EYear int, @EMon smallint, @EDay smallint, @ELeap bit, @EMonArray Char(12), @EDayOfYear int 
	DECLARE @FYear int, @FMon smallint, @FDay smallint, @FLeap bit, @FMonArray Char(12) 
	SELECT @FMonArray = Char(31) + Char(31) + Char(31) + Char(31) + Char(31) + Char(31) + Char(30) + Char(30) + Char(30) + Char(30) + Char(30) + Char(29) 
	SELECT @EMonArray = Char(31) + Char(28) + Char(31) + Char(30) + Char(31) + Char(30) + Char(31) + Char(31) + Char(30) + Char(31) + Char(30) + Char(31) 
	SELECT @EYear = Year(@EDate) 
	SELECT @EMon = Month(@EDate) 
	SELECT @EDay = Day(@EDate) 

	IF (@EYear %4) = 0 SELECT @ELeap = 1 ELSE SELECT @ELeap = 0 

	--------------------- Calc Day Of Year 
	DECLARE @Temp int, @Cnt int 
	SELECT @Cnt = @EMon-1 
	SELECT @Temp = 0 

	WHILE @Cnt<>0 BEGIN 
		IF (@Cnt = 2)AND(@ELeap = 1)
			SELECT @Temp = @Temp + 29 
		ELSE
			SELECT @Temp = @Temp + Ascii(Substring(@EMonArray, @Cnt, 1)) 
		SELECT @Cnt = @Cnt-1 
	END 
	SELECT @EDayOfYear = @Temp + @EDay 
	---------------------- Convert to Farsi 
	SELECT @Temp = @EDayOfYear-79 

	IF @Temp>0
		SELECT @FYear = @EYear-621 
	ELSE BEGIN 
		SELECT @FYear = @EYear-622 
		IF ((@FYear %4) = 3)
			SELECT @Temp = @Temp + 366
		ELSE
			SELECT @Temp = @Temp + 365 
	END

	IF (@FYear %4) = 3
		SELECT @FLeap = 1
	ELSE
		SELECT @FLeap = 0
	SELECT @Cnt = 1

	WHILE (@Temp<>0) AND (@Temp>Ascii(Substring(@FMonArray, @Cnt, 1))) 	BEGIN 
		IF @Cnt = 12 
			IF (@FLeap = 1)
				SELECT @Temp = @Temp-30
			ELSE
				SELECT @Temp = @Temp-29 
		ELSE
			SELECT @Temp = @Temp-Ascii(Substring(@FMonArray, @Cnt, 1)) 
		SELECT @Cnt = @Cnt + 1 
	END 

	IF @Temp<>0 BEGIN 
		SELECT @FMon = @Cnt 
		SELECT @FDay = @Temp 
	END ELSE BEGIN 
		SELECT @FMon = 12 
		SELECT @FDay = 30 
	END

	------- Some years has a one_day disposition and has to be corrected manually!!!
	IF @FYear IN (1301, 1302, 1303, 1304, 1305, 1306, 1307, 1310, 1311, 1314, 1315, 1318, 1319, 1322, 1323, 1326, 
								1327, 1330, 1331, 1334, 1335, 1338, 1339, 1343, 1347, 1351, 1355, 1359, 1363, 1367,	1371)
	BEGIN
		SET @FDay = @FDay - 1
		IF (@FDay = 0)
			BEGIN 
				IF @FMon > 1
					BEGIN
						SET @FMon = @FMon - 1
						SET @FDay = Ascii(Substring(@FMonArray,@FMon , 1)) 
					END	
				ELSE
					BEGIN 
						SET @FMon = 12
						SET @FYear = @FYear - 1
						
						IF (@FYear >= 1408 AND @FYear < 1441 AND (@FYear % 4) = 0) OR 
							 (@FYear >= 1375 AND @FYear < 1408 AND (@FYear % 4) = 3) OR 
							 (@FYear >= 1342 AND @FYear < 1375 AND (@FYear % 4) = 2) OR
							 (@FYear >= 1304 AND @FYear < 1342 AND (@FYear % 4) = 0) OR
							 (@FYear >= 1271 AND @FYear < 1304 AND (@FYear % 4) = 3)
							SET @FDay = 30
						ELSE
							SET @FDay = 29
					END
			END				
	END

	------------------ ALTER Output 
	DECLARE @YStr Char(4), @MStr char(2), @DStr Char(2) 
	SELECT @YStr = Convert(Char, @FYear) 
	IF @FMon<10 
		SELECT @MStr = '0' + Convert(Char,@FMon)
	ELSE
		SELECT @MStr = Convert(Char, @FMon) 
	IF @FDay<10 
		SELECT @DStr = '0' + Convert(Char,@FDay)
	ELSE
		SELECT @DStr = Convert(Char, @FDay) 
	SELECT @FDate = @YStr + '/' + @MStr + '/' + @DStr 
	------------------
	RETURN @FDate
END
GO
/****** Object:  UserDefinedFunction [dbo].[com_udfGetZeroPad]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[com_udfGetZeroPad]
(
	@InputString varchar(32), 
	@Lenght tinyint
) 
RETURNS varchar(32)
 AS
BEGIN
	DECLARE @ZeroString varchar(32)
	SET @ZeroString = '00000000000000000000000000000000'
	RETURN RIGHT(@ZeroString + @InputString, @Lenght)
END
GO
/****** Object:  UserDefinedFunction [dbo].[com_udfTimeAdd]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[com_udfTimeAdd] (@Time varchar(5), @Interval int)
RETURNS VARCHAR(5) AS
-------------------
--DECLARE @Time varchar(5) = '08:10'
--DECLARE @Interval int = 5
-------------------
BEGIN
	RETURN  [dbo].[com_udfGetZeroPad]((((CAST(SUBSTRING(@Time,1,2) AS INT)* 60) + CAST(SUBSTRING(@Time,4,2)AS INT)) + @Interval) / 60 , 2) + ':' +
			[dbo].[com_udfGetZeroPad]((((CAST(SUBSTRING(@Time,1,2) AS INT)* 60) + CAST(SUBSTRING(@Time,4,2)AS INT)) + @Interval) % 60 , 2)
END
GO
/****** Object:  Table [dbo].[Personnel]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personnel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PersonnelBaseId] [int] NOT NULL,
	[FullName] [nvarchar](500) NULL,
	[WorkSectionId] [int] NULL,
	[YearWorkingPeriod] [int] NULL,
	[RequirementWorkMins_esti] [int] NULL,
	[RequirementWorkMins_real] [int] NULL,
	[TypeId] [int] NULL,
	[EfficiencyRolePoint] [int] NULL,
	[DiffNorm] [float] NULL,
 CONSTRAINT [PK_Personnel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonnelRequest]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonnelRequest](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[WorkSectionId] [int] NULL,
	[PersonnelBaseId] [int] NULL,
	[YearWorkingPeriod] [int] NULL,
	[Day] [int] NULL,
	[ShiftTypeId] [int] NULL,
	[Value] [int] NULL,
 CONSTRAINT [PK_PersonnelRequest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shifts]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shifts](
	[id] [int] NOT NULL,
	[Code] [int] NULL,
	[Title] [nvarchar](500) NULL,
	[Length] [int] NULL,
	[StartTime] [int] NULL,
	[EndTime] [int] NULL,
	[Type] [int] NULL,
 CONSTRAINT [PK_Shifts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Date]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Date](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[PersianDate] [char](10) NOT NULL,
	[SpecialDay] [int] NULL,
	[PersianYear] [smallint] NOT NULL,
	[PersianYearTitle] [nvarchar](100) NOT NULL,
	[FiscalYear] [smallint] NOT NULL,
	[WorkingPeriodYear] [int] NULL,
	[WorkingPeriod] [int] NULL,
	[WorkingPeriodTitle] [nvarchar](10) NULL,
	[PersianSemester] [tinyint] NOT NULL,
	[PersianSemesterTitle] [nvarchar](10) NOT NULL,
	[PersianQuarter] [tinyint] NOT NULL,
	[PersianQuarterTitle] [nvarchar](10) NOT NULL,
	[PersianMonth] [tinyint] NOT NULL,
	[PersianMonthTitle] [nvarchar](50) NOT NULL,
	[PersianWeekNumberOfYear] [tinyint] NOT NULL,
	[PersianWeekNumberOfMonth] [smallint] NOT NULL,
	[PersianDayOfMonth] [tinyint] NOT NULL,
	[PersianDayOfYear] [smallint] NOT NULL,
	[PersianWeekDay] [tinyint] NOT NULL,
	[PersianWeekDayTitle] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Dim_Date_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Get_PersonnelRequest]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Get_PersonnelRequest]
AS
SELECT 
	   p.WorkSectionId
	  ,p.YearWorkingPeriod
	  ,P.[PersonnelBaseId]      
      ,D.PersianDayOfMonth [Day]
      ,SH.TYPE [ShiftTypeId]
      ,CASE WHEN [Value] IS NULL THEN 0 ELSE [Value] END  [Value]
FROM 
	Personnel P 
	JOIN Dim_Date D ON D.PersianYear = P.YearWorkingPeriod/100 AND D.PersianMonth = P.YearWorkingPeriod%100 	
	JOIN Shifts SH ON SH.Type BETWEEN 1 AND 3
	LEFT JOIN PersonnelRequest PRQ ON P.PersonnelBaseId = PRQ.PersonnelBaseId 
			  AND P.YearWorkingPeriod = PRQ.YearWorkingPeriod AND D.PersianDayOfMonth = PRQ.Day	
			  AND SH.Type = PRQ.ShiftTypeId 
GO
/****** Object:  View [dbo].[Get_PersonnelRequestPivoted]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Get_PersonnelRequestPivoted]
AS
SELECT * FROM   
(
    SELECT [WorkSectionId]
      ,[YearWorkingPeriod]
      ,[PersonnelBaseId]
      ,'D'+dbo.com_udfGetZeroPad([Day],2) [Day]
      ,[ShiftTypeId]
      ,[Value]
	FROM [Didgah_Timekeeper_DM].[dbo].[Get_PersonnelRequest]
	WHERE [WorkSectionId] = 1
		  and [YearWorkingPeriod] = 139806
	--ORDER BY [WorkSectionId]
	--	  ,[YearWorkingPeriod]
	--	  ,[PersonnelBaseId]
	--	  ,[Day]
	--	  ,[ShiftTypeId]		
) t 
PIVOT(
    sum([Value]) 
    FOR [Day] IN ([D01],[D02],[D03],[D04],[D05],[D06],[D07],[D08],[D09],[D10],
				  [D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],
				  [D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],
				  [D31]
				)
) AS pivot_table;
GO
/****** Object:  Table [dbo].[PersonnelShiftDateAssignments]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonnelShiftDateAssignments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PersonnelBaseId] [int] NULL,
	[Day] [int] NULL,
	[ShiftId] [int] NULL,
	[Rank] [int] NULL,
	[Cost] [real] NULL,
	[EndTime] [smalldatetime] NULL,
	[UsedParentCount] [int] NULL,
	[WorkSectionId] [int] NULL,
	[YearWorkingPeriod] [int] NULL,
 CONSTRAINT [PK_PersonnelShiftDateAssignments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Get_DiffByPersonnel]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[Get_DiffByPersonnel] 
AS
SELECT
	 PA.PersonnelBaseId
	,PA.WorkSectionId
	,PA.YearWorkingPeriod
	,PA.Cost
	,PA.Rank
	,PA.EndTime
	,RequirementWorkMins_esti
	,SUM(Length) AssignmentLenght	
	,SUM(Length) - RequirementWorkMins_esti DIFF
FROM
	PersonnelShiftDateAssignments PA
	JOIN Shifts S ON PA.ShiftId = S.id
	JOIN Personnel P ON P.PersonnelBaseId = PA.PersonnelBaseId AND P.YearWorkingPeriod = PA.YearWorkingPeriod
--WHERE
--	PA.WorkSectionId = 1 AND PA.YearWorkingPeriod = 139806
GROUP BY 
	 PA.PersonnelBaseId
	,PA.WorkSectionId
	,PA.YearWorkingPeriod
	,PA.Cost
	,PA.Rank
	,PA.EndTime
	,P.RequirementWorkMins_esti
GO
/****** Object:  View [dbo].[Get_Shifts]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[Get_Shifts]
AS
SELECT [id]
      ,[Code]
      ,[Title]
      ,[Length]
      ,[StartTime]
      ,[EndTime]
      ,[Type]	 
  FROM [Didgah_Timekeeper_DM].[dbo].[Shifts]
WHERE ID<10
union
SELECT 
	   [id]
      ,[Code]
      ,[Title]
      ,[Length]/2[Length]
      ,[StartTime]
      ,[EndTime]
      ,[Type]/10 [Type]
FROM
	Shifts
WHERE id>=10
UNION
SELECT 
	   [id]+3 ID
      ,[Code]
      ,[Title]
      ,[Length]/2[Length]
      ,[StartTime]
      ,[EndTime]
      ,[Type]%10 [Type]
FROM
	Shifts
WHERE id>=10
GO
/****** Object:  Table [dbo].[WorkSectionRequirements]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkSectionRequirements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[WorkSectionId] [int] NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[DayType] [int] NULL,
	[PersonnelTypeReqID] [int] NULL,
	[ShiftTypeID] [int] NULL,
	[ReqMinCount] [int] NULL,
	[ReqMaxCount] [int] NULL,
	[day_diff_typ] [float] NULL,
	[Date] [datetime2](7) NULL,
	[PersonnelTypeReqCount] [int] NULL,
 CONSTRAINT [PK_WorkSectionRequirements] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Get_DiffByDays]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[Get_DiffByDays]
AS 
WITH T AS
(SELECT
	  PA.WorkSectionId
	 ,PA.Cost
	 ,PA.EndTime
	 ,PA.Rank
	 ,PersianYear Year
	 ,PersianMonth Month
	 ,PA.Day
	 ,P.TypeId prs_typ_id
	 ,S.Type ShiftTypeID	  
	 ,COUNT(*) prs_count
	 ,SUM(EfficiencyRolePoint) prs_points	 
FROM
	PersonnelShiftDateAssignments PA
	JOIN Get_Shifts S ON PA.ShiftId = S.id
	JOIN Dim_Date D ON (D.PersianYear*100)+D.PersianMonth = PA.YearWorkingPeriod 
					AND D.PersianDayOfMonth = PA.Day	
	JOIN Personnel P ON P.PersonnelBaseId = PA.PersonnelBaseId 
					AND P.YearWorkingPeriod = PA.YearWorkingPeriod	
WHERE
	S.Length>0 
GROUP BY
	  PA.WorkSectionId
	 ,PA.Cost
	 ,PA.EndTime
	 ,PersianYear
	 ,PersianMonth
	 ,PA.Day
	 ,P.TypeId
	 ,S.Type
	 ,PA.Rank
)
SELECT 
	 T.WorkSectionId
	,(T.Year*100) + T.Month YearWorkingPeriod	
	,T.Cost
	,T.Rank
	,T.EndTime
	,T.Day
	,T.prs_typ_id
	,T.ShiftTypeID
	,RQ.ReqMinCount
	,RQ.ReqMaxCount		
	,T.prs_count
	,T.prs_points		
	,case when abs(prs_count - ReqMaxCount) >= abs(prs_count - ReqMinCount) then abs(prs_count - ReqMinCount) 
		 else abs(prs_count - ReqMaxCount) end diff
FROM
	WorkSectionRequirements RQ LEFT JOIN T   ON T.WorkSectionId = RQ.WorkSectionId 
												AND T.Year = RQ.Year AND T.Month = RQ.Month 
												AND T.prs_typ_id = RQ.PersonnelTypeReqID									 
												AND (T.ShiftTypeID%10 = RQ.ShiftTypeID or T.ShiftTypeID/10 = RQ.ShiftTypeID)



GO
/****** Object:  View [VW].[ShiftAssignmentPivoted]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [VW].[ShiftAssignmentPivoted]
AS
SELECT * FROM   
(
    SELECT 
	   ps.WorkSectionId + ps.YearWorkingPeriod + ps.[Rank] + ps.PersonnelBaseId as id
	  ,ps.WorkSectionId
	  ,ps.YearWorkingPeriod
	  ,ps.Cost
	  ,ps.[Rank]
	  ,ps.PersonnelBaseId
	  ,P.FullName
	  ,P.TypeId	  
      ,'D'+dbo.com_udfGetZeroPad([Day],2) [Day]
      ,ps.ShiftId	  
	FROM 
		[PersonnelShiftDateAssignments] PS	
		JOIN Personnel P ON P.PersonnelBaseId = PS.PersonnelBaseId			
) t 
PIVOT(
    sum(ShiftId) 
    FOR [Day] IN ([D01],[D02],[D03],[D04],[D05],[D06],[D07],[D08],[D09],[D10],
				  [D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],
				  [D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],
				  [D31]
        )
) AS pivot_table;
GO
/****** Object:  View [dbo].[Get_ShiftAssignmentPivoted]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[Get_ShiftAssignmentPivoted]
AS
SELECT * FROM   
(
    SELECT 
	   ps.WorkSectionId
	  ,ps.YearWorkingPeriod
	  ,ps.Cost
	  ,ps.[Rank]
	  ,ps.PersonnelBaseId
	  ,P.FullName
	  ,P.TypeId	  
      ,'D'+dbo.com_udfGetZeroPad([Day],2) [Day]
      ,SH.Title ShiftId	  
	FROM 
		[PersonnelShiftDateAssignments] PS	
		JOIN Personnel P ON P.PersonnelBaseId = PS.PersonnelBaseId	
		JOIN Shifts SH ON SH.ID = PS.ShiftId		
) t 
PIVOT(
    MIN(ShiftId) 
    FOR [Day] IN ([D01],[D02],[D03],[D04],[D05],[D06],[D07],[D08],[D09],[D10],
				  [D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],
				  [D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],
				  [D31]
        )
) AS pivot_table;
GO
/****** Object:  View [dbo].[Get_ShiftAssignmentPivoted_by_id]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE view [dbo].[Get_ShiftAssignmentPivoted_by_id]
AS
SELECT * FROM   
(
    SELECT 
	   ps.WorkSectionId
	  ,ps.YearWorkingPeriod
	  ,ps.Cost
	  ,ps.[Rank]
	  ,ps.PersonnelBaseId
	  ,P.FullName
	  ,P.TypeId	  
      ,'D'+dbo.com_udfGetZeroPad([Day],2) [Day]
      ,ps.ShiftId	  
	FROM 
		[PersonnelShiftDateAssignments] PS	
		JOIN Personnel P ON P.PersonnelBaseId = PS.PersonnelBaseId			
) t 
PIVOT(
    sum(ShiftId) 
    FOR [Day] IN ([D01],[D02],[D03],[D04],[D05],[D06],[D07],[D08],[D09],[D10],
				  [D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],
				  [D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],
				  [D31]
        )
) AS pivot_table;
GO
/****** Object:  View [dbo].[get_SolutionSummarize]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[get_SolutionSummarize]
AS
SELECT DISTINCT   
	 [Rank]
	,[Cost]      
	,[WorkSectionId]
	,[YearWorkingPeriod]
	,[EndTime]
	,DATEDIFF(SECOND,EndTime,GETDATE())life_cycle	 
    ,[UsedParentCount]
FROM [PersonnelShiftDateAssignments]        
GO
/****** Object:  Table [dbo].[tkp_Logs]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tkp_Logs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PersonnelBaseID] [int] NOT NULL,
	[Date] [smalldatetime] NOT NULL,
	[Login] [int] NOT NULL,
	[Logout] [int] NOT NULL,
	[DayDisposition] [int] NOT NULL,
	[YearWorkingPeriodId] [int] NULL,
	[LoginDayDisposition] [int] NOT NULL,
 CONSTRAINT [PK_tkp_Logs] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkSection]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkSection](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [int] NULL,
	[Title] [nvarchar](500) NULL,
 CONSTRAINT [PK_WorkSection] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Personnel]  WITH NOCHECK ADD  CONSTRAINT [FKnems297m2gqadfdar84lpnei9] FOREIGN KEY([WorkSectionId])
REFERENCES [dbo].[WorkSection] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Personnel] NOCHECK CONSTRAINT [FKnems297m2gqadfdar84lpnei9]
GO
ALTER TABLE [dbo].[PersonnelShiftDateAssignments]  WITH NOCHECK ADD  CONSTRAINT [FK_PersonnelShiftDateAssignments_Shifts] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Shifts] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[PersonnelShiftDateAssignments] NOCHECK CONSTRAINT [FK_PersonnelShiftDateAssignments_Shifts]
GO
ALTER TABLE [dbo].[PersonnelShiftDateAssignments]  WITH CHECK ADD  CONSTRAINT [FKd8c4sw0b3g3ste5r78q54ul6c] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[Shifts] ([id])
GO
ALTER TABLE [dbo].[PersonnelShiftDateAssignments] CHECK CONSTRAINT [FKd8c4sw0b3g3ste5r78q54ul6c]
GO
ALTER TABLE [dbo].[WorkSectionRequirements]  WITH NOCHECK ADD  CONSTRAINT [FK_WorkSectionRequirements_WorkSection] FOREIGN KEY([WorkSectionId])
REFERENCES [dbo].[WorkSection] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[WorkSectionRequirements] NOCHECK CONSTRAINT [FK_WorkSectionRequirements_WorkSection]
GO
ALTER TABLE [dbo].[WorkSectionRequirements]  WITH CHECK ADD  CONSTRAINT [FK53ar44ubo41q6ufhvutejpgo3] FOREIGN KEY([WorkSectionId])
REFERENCES [dbo].[WorkSection] ([id])
GO
ALTER TABLE [dbo].[WorkSectionRequirements] CHECK CONSTRAINT [FK53ar44ubo41q6ufhvutejpgo3]
GO
/****** Object:  StoredProcedure [dbo].[com_SetDimDate]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[com_SetDimDate]
AS
DECLARE @D0 SMALLDATETIME = '2005-01-01'
DECLARE @DateKey VARCHAR(20)
      ,@Date SMALLDATETIME
      ,@Per_Date VARCHAR(20)
      ,@Per_Year INT
      ,@Per_Season INT
      ,@Per_Month INT
	  ,@Per_FirstOfYearDate varchar(20)
	  ,@Per_DayInYear INT
	  ,@Per_DayInMonth INT
      ,@Per_WeekNoInMonth INT
      ,@Per_WeekNoInYear INT
      ,@Per_WeekDay INT
	  ,@PersianSemester INT
	  ,@PersianSemesterTitle nvarchar(100)
	  ,@FiscalYear int	  
      ,@Per_YearTitle NVARCHAR(20)
      ,@Per_SeasonTitle NVARCHAR(20)
      ,@Per_MonthTitle NVARCHAR(20)
      ,@Per_weekDayTitle NVARCHAR(20)
      ,@WeekDay INT
      ,@WeekDayTitle VARCHAR(20)
	  ,@WorkingPriodIndex INT
	  ,@WorkingPriodTitle VARCHAR(50)
WHILE (@D0 < = '2050-01-30')
BEGIN
	SELECT @Date = @D0
	SELECT @Per_Date = [DBO].com_udfGetSolarDate(@Date)
	SELECT @Per_Year = SUBSTRING(@Per_Date,1,4)
	SELECT @Per_YearTitle = SUBSTRING(@Per_Date,1,4)
	SELECT @Per_Month = SUBSTRING(@Per_Date,6,2)
	
	SELECT @Per_Season = CASE 
							WHEN @Per_Month <= 3 THEN 1
							WHEN @Per_Month >= 4 AND @Per_Month <= 6 THEN 2
							WHEN @Per_Month >= 7 AND @Per_Month <= 9 THEN 3
							WHEN @Per_Month >= 10 AND @Per_Month <= 12 THEN 4
							ELSE 0 END
	SELECT @Per_YearTitle = [dbo].com_GetPersianDateVarchar(@Per_Year)
	SELECT @Per_SeasonTitle = CASE 
								WHEN @Per_Season = 1 THEN 'بهار'
								WHEN @Per_Season = 2 THEN 'تابستان'
								WHEN @Per_Season = 3 THEN 'پاییز'
								WHEN @Per_Season = 4 THEN  'زمستان'
								ELSE '' END
	SELECT @Per_MonthTitle = CASE 
								WHEN @Per_Month = 1 THEN 'فروردین'
								WHEN @Per_Month = 2 THEN 'اردیبهشت'
								WHEN @Per_Month = 3 THEN 'خرداد'
								WHEN @Per_Month = 4 THEN 'تیر'
								WHEN @Per_Month = 5 THEN 'مرداد'
								WHEN @Per_Month = 6 THEN 'شهریور'
								WHEN @Per_Month = 7 THEN 'مهر'
								WHEN @Per_Month = 8 THEN 'آبان'
								WHEN @Per_Month = 9 THEN 'آذر'
								WHEN @Per_Month = 10 THEN 'دی'
								WHEN @Per_Month = 11 THEN 'بهمن'
								WHEN @Per_Month = 12 THEN 'اسفند'
								ELSE '' END
	SELECT @Per_WeekDay =	CASE 
								WHEN DATEPART(WEEKDAY,@Date) = 1 THEN 2
								WHEN DATEPART(WEEKDAY,@Date) = 2 THEN 3
								WHEN DATEPART(WEEKDAY,@Date) = 3 THEN 4 
								WHEN DATEPART(WEEKDAY,@Date) = 4 THEN 5
								WHEN DATEPART(WEEKDAY,@Date) = 5 THEN 6 
								WHEN DATEPART(WEEKDAY,@Date) = 6 THEN 7 
								WHEN DATEPART(WEEKDAY,@Date) = 7 THEN 1
								ELSE 0 END
	SELECT @Per_weekDayTitle =CASE 
								WHEN DATEPART(WEEKDAY,@Date) = 1 THEN 'یکشنبه'
								WHEN DATEPART(WEEKDAY,@Date) = 2 THEN 'دوشنبه'
								WHEN DATEPART(WEEKDAY,@Date) = 3 THEN 'سه شنبه'
								WHEN DATEPART(WEEKDAY,@Date) = 4 THEN 'چهارشنبه'
								WHEN DATEPART(WEEKDAY,@Date) = 5 THEN 'پنجشنبه'
								WHEN DATEPART(WEEKDAY,@Date) = 6 THEN 'جمعه'
								WHEN DATEPART(WEEKDAY,@Date) = 7 THEN 'شنبه'
								ELSE '' END
	SELECT @Per_FirstOfYearDate = CAST(@Per_Year AS VARCHAR(4)) + '/01/01' 
	
	SELECT @Per_DayInYear = DATEDIFF(DAY,DBO.com_udfGetChristianDate(@Per_FirstOfYearDate),@Date)	 
	SELECT @Per_WeekNoInYear = @Per_DayInYear / 7
	SELECT @Per_DayInMonth = CASE 
								WHEN @Per_Month<10 THEN DATEDIFF(DAY,DBO.com_udfGetChristianDate(CAST(@Per_Year AS VARCHAR(4)) +'/0' + CAST(@Per_Month AS VARCHAR(2)) +'/01' ),@Date)
								ELSE DATEDIFF(DAY,DBO.com_udfGetChristianDate(CAST(@Per_Year AS VARCHAR(4)) +'/' + CAST(@Per_Month AS VARCHAR(2)) +'/01' ),@Date) END + 1
	SELECT @Per_WeekNoInMonth = @Per_DayInMonth / 7
	SELECT @PersianSemester = CASE WHEN @Per_Month <= 6 THEN 1 ELSE 2 END
	SELECT @PersianSemesterTitle = CASE WHEN @PersianSemester = 1 THEN 'نیمسال اول' ELSE 'نیمسال دوم' END
	SELECT @FiscalYear = @Per_Year

	SELECT @WeekDay = DATEPART(WEEKDAY,@Date)
	SELECT @WeekDayTitle =	CASE 
								WHEN DATEPART(WEEKDAY,@Date) = 1 THEN 'SUN'
								WHEN DATEPART(WEEKDAY,@Date) = 2 THEN 'MON'
								WHEN DATEPART(WEEKDAY,@Date) = 3 THEN 'TUE'
								WHEN DATEPART(WEEKDAY,@Date) = 4 THEN 'THR'
								WHEN DATEPART(WEEKDAY,@Date) = 5 THEN 'WEN'
								WHEN DATEPART(WEEKDAY,@Date) = 6 THEN 'FRI'
								WHEN DATEPART(WEEKDAY,@Date) = 7 THEN 'SAT'
								ELSE '' END	
	INSERT INTO [Dim_Date]
		SELECT @Date [Date]
			  ,@Per_Date [PersianDate]
			  ,CASE WHEN @Per_WeekDay =7 THEN 1 ELSE 0 END [SpecialDay]
			  ,@Per_Year [PersianYear]			  
			  ,@Per_YearTitle [PersianYearTitle]
			  ,@FiscalYear [FiscalYear]
			  ,null [WorkingPriodYear]
			  ,null [WorkingPeriod]
			  ,null [WorkingPeriodTitle]
			  ,@PersianSemester [PersianSemester]
 			  ,@PersianSemesterTitle [PersianSemesterTitle]
			  ,@Per_Season [PersianQuarter]
			  ,@Per_SeasonTitle [PersianQuarterTitle]
			  ,@Per_Month [PersianMonth]
			  ,@Per_MonthTitle [PersianMonthTitle]
			  ,@Per_WeekNoInYear [PersianWeekNumberOfYear]
			  ,@Per_WeekNoInMonth [PersianWeekNumberOfMonth]
			  ,@Per_DayInMonth [PersianDayOfMonth]	
			  ,@Per_DayInYear [PersianDayOfYear]
			  ,@Per_WeekDay [PersianWeekDay]			  			  			  
			  ,@Per_weekDayTitle [PersianWeekDayTitle]			  
			  -------------------------------------			  		  			  			  		  			  			  
			  --,@WeekDay [WeekDay]
			  --,@WeekDayTitle [WeekDayTitle]													
    
     
      
     
			       			  			       
	SET @D0 = DATEADD(DAY,1,@D0)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateLastRanks]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateLastRanks](@WorkSectionId int, @YearWorkingPeriod int)
AS
UPDATE [PersonnelShiftDateAssignments]
SET [Rank] = T.[Rank]
FROM [PersonnelShiftDateAssignments] JOIN
	 (SELECT distinct
		   ROW_NUMBER() over(order by [Cost],[EndTime]) [Rank]
		  ,[Cost] 
			,[EndTime]  
		  ,[WorkSectionId]
		  ,[YearWorkingPeriod]
	  FROM [PersonnelShiftDateAssignments]
	  WHERE WorkSectionId = 1
			  AND YearWorkingPeriod = 139806
	  GROUP BY
		   [Cost]      
		  ,[EndTime]
		  ,[WorkSectionId]
		  ,[YearWorkingPeriod]
	) T ON 
	  [PersonnelShiftDateAssignments].YearWorkingPeriod = 
	  t.YearWorkingPeriod AND
	  [PersonnelShiftDateAssignments].WorkSectionId = 
	  t.WorkSectionId AND
	  [PersonnelShiftDateAssignments].Cost = t.Cost AND
	  [PersonnelShiftDateAssignments].EndTime = t.EndTime 
GO
/****** Object:  StoredProcedure [dbo].[UpdateUsedParentCount]    Script Date: 2/12/2020 4:32:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateUsedParentCount](@WorkSectionId int, @YearWorkingPeriod int, @RANK int)
AS
UPDATE [PersonnelShiftDateAssignments]
SET [UsedParentCount] += 1
FROM [PersonnelShiftDateAssignments] 
WHERE WorkSectionId = @WorkSectionId 
      AND YearWorkingPeriod = @YearWorkingPeriod
      AND RANK = @RANK
GO
USE [master]
GO
ALTER DATABASE [Didgah_Timekeeper_DM] SET  READ_WRITE 
GO
