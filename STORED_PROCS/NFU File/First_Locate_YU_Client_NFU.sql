USE [RM]
GO
/****** Object:  StoredProcedure [dbo].[YU_1ST_LOCATE_Client_NFU]    Script Date: 3/2/2021 8:27:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[YU_1ST_LOCATE_Client_NFU]
as

insert into  rm.dbo.nfu
select 	[account_number] as ClientReference
,	'' as CompanyName
,	'' as Salutation
,	'' as [First Name]
,	'' as Surname
,	cast( isnull(date_of_birth,''		   ) as date)	as DateofBirth 
,	cast( isnull([New_Address_Line_1]	,'') as nvarchar(250))		as MailingAddressLine1 
,	cast( isnull([New_Address_Line_2]	,'') as nvarchar(250))		as MailingAddressLine2 
,	cast( isnull([New_Address_Line_3]	,'') as nvarchar(250))		as MailingAddressLine3 
,	cast( isnull([New_Address_Line_4]	,'') as nvarchar(250))		as MailingAddressLine4 
,	cast( isnull([New_Address_Line_5]	,'') as nvarchar(250))		as MailingAddressLine5 
,	cast( isnull([New_Address_Postcode]	,'') as nvarchar(250))		as MailingAddressPostcode
,	'' as SupplyAddressLine1 
,	'' as SupplyAddressLine2 
,	'' as SupplyAddressLine3 
,	'' as SupplyAddressLine4 
,	'' as SupplyAddressLine5 
,	'' as SupplyAddressPostcode
,	cast(isnull([telephone_number],'')	as nvarchar (50)) as Telephone1
,	cast('' as nvarchar (50)) as Telephone2
,	cast('' as nvarchar (50)) as Telephone3
,	cast(isnull(emailaddress,''				) as nvarchar(50))as [E-mail]
,	'' as Balance
,	'' as Vulnerabilityidentified
,	 getdate() dtstamp
,	 'First Locate' [source]
from rm_files.dbo.[1ST_NFU_TEMP]
where [Account_Number] not like '%/%'