USE [RM]
GO
/****** Object:  StoredProcedure [dbo].[TO_AJJB_BALANCE_UPDATE]    Script Date: 3/2/2021 8:25:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[TO_AJJB_BALANCE_UPDATE]

AS


select		distinct act.clientreference	 as acc_num
			, [Full Name] acc_name
			, tr.balanceafter as updated_balance

into rm_files.dbo.[TEMP_AJJB_BalanceUpdate] 
from		rm.dbo.AccountTransaction	act
join		rm.dbo.account				acc		on acc.accountid=act.accountid	
join		rm.dbo.Assignment			ass		on ass.AssignmentID=act.assignmentid and ass.dca='ajjb'
join		rm.dbo.Customer				cus		on cus.accountid=acc.Accountid
join		(select distinct clientreference, balanceafter from #trans)			tr		on tr.clientreference=act.clientreference
where		source = 'YU'
and			act.adjustmenttypecode in ('pba', 'nba')
and			cast(act.dtstamp as date) = cast(getdate() as date)
and			act.amount <>0