USE [RM]
GO
/****** Object:  StoredProcedure [dbo].[AJJB_PAYMENT]    Script Date: 3/2/2021 8:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[AJJB_PAYMENT]

as
SELECT  acc.Accountid
		, Newid()												TransactionID
		, [Transaction_ID]										FL_TransactionID
		, [Client_Reference] as									clientreference
		, [payment_date] as										[date]
		, [Payment_Amount]										[Amount]	
		, 32													FL_CommissionRate
		, round(cast([Payment_Amount] as float) * .32,2)		FL_Commission
		, 3 as													JDM_CommissionRate
		, round(cast([Payment_Amount] as float) * .03,2) as		JDM_Commission
		, 'AJJB' as source
		, getdate() as dtstamp
		, ass.ASSIGNMENTID
		, 'pay' as adjustmenttypecode

FROM #Transaction ap
join rm.dbo.account acc on acc.ClientReference=ap.[Client_Reference]
join rm.dbo.ASSIGNMENT	ass on ass.accountid=acc.Accountid and ass.dca = 'ajjb'


update		rm.dbo.Account
set			OutstandingBalance = (acc.OriginalBalance - act.colls)
-- select *
from		rm.dbo.Account acc
join		(
			select acc.Accountid
					, sum(act.Amount) colls
			from rm.dbo.account					acc
			join rm.dbo.AccountTransaction		act		on acc.ClientReference=act.ClientReference
			group by acc.Accountid
			) act on act.Accountid= acc.Accountid
join #Transaction tr on tr.[Client_Reference] = acc.ClientReference