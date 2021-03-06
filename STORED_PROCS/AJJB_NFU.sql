USE [RM]
GO
/****** Object:  StoredProcedure [dbo].[AJJB_NFU]    Script Date: 3/2/2021 8:24:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[AJJB_NFU]
as

-- AJJB NFU insert
insert into  rm.dbo.nfu
select [dt_cliref] as ClientReference
,'' as CompanyName
,'' as Salutation
,'' as [First Name]
,'' as Surname
,'' as DateofBirth
,isnull([newhousenr]	,'')		as MailingAddressLine1 
,isnull([Newstreet]		,'')		as MailingAddressLine2 
,isnull([newtown]		,'')		as MailingAddressLine3 
,isnull([newcounty]		,'')		as MailingAddressLine4 
,''		as MailingAddressLine5 
,isnull(newpostcode		,'')		as MailingAddressPostcode
,'' as SupplyAddressLine1 
,'' as SupplyAddressLine2 
,'' as SupplyAddressLine3 
,'' as SupplyAddressLine4 
,'' as SupplyAddressLine5 
,'' as SupplyAddressPostcode
,isnull(newphone1,'') as Telephone1
,isnull(newphone2,'') as Telephone2
,'' as Telephone3
,isnull(newemail,'') as [E-mail]
,'' as Balance
,'' as Vulnerabilityidentified
, getdate() dtstamp
, 'AJJB' [source]
from rm_files.dbo.[AJJB_NFU_TEMP]





--YU NFU Export
select ClientReference
, CompanyName
, Salutation
, [First Name]
, Surname
, DateofBirth
, MailingAddressLine1 
, MailingAddressLine2 
, MailingAddressLine3 
, MailingAddressLine4 
, MailingAddressLine5 
, MailingAddressPostcode
, SupplyAddressLine1 
, SupplyAddressLine2 
, SupplyAddressLine3 
, SupplyAddressLine4 
, SupplyAddressLine5 
, SupplyAddressPostcode
, Telephone1
, Telephone2
, Telephone3
, [E-mail]
, Balance
, Vulnerabilityidentified
into rm_files.dbo.[YU_NFU_TEMP]
from rm.dbo.nfu 
where cast(dtstamp as date) = cast(getdate() as date)
