USE [RM]
GO
/****** Object:  StoredProcedure [dbo].[AJJB_ACTIVITY]    Script Date: 3/2/2021 8:23:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[AJJB_ACTIVITY]
as

insert into rm.dbo.activity
select [REF NUM] clientreference	
	, DESCRIPTION AS Activity
	, CONVERT(NVARCHAR(255),CONVERT(date, date,105)) date
	, ass.AssignmentID
--select *
from #Activity		act
join rm.dbo.Assignment ass on ass.ClientReference = act.[REF NUM] and ass.dca <> 'first locate'