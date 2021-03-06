USE [RM]
GO
/****** Object:  StoredProcedure [dbo].[LIT_PLACEMENT_PROCESS_3]    Script Date: 2/26/2021 6:47:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[LIT_PLACEMENT_PROCESS_3]

AS

--5) insert into assignment table					

--INSERT  into rm.dbo.assignment
select			ac.[ClientReference]						
				,	ac.Accountid
				,	newid()									Assignmentid
				,	'Litigation'							Segment									
				,	getdate()								AssignedDate
				,	'AJJB'									DCA
				,   ac.OutstandingBalance					AssignedAmount
				,	NULL									CLOsuredate
				,	null									recallreason
				,	null									recalldate
				,	null									closurereason

from			rm.dbo.account								ac
join			rm_Files.[dbo].[TEMP_PLACEMENT_FILE]						lit on lit.clientreference = ac.clientreference		


select accountid, number, rank()over(partition by accountid order by telephoneid) rank
into #tel
from rm.dbo.CustomerTelephone

select			
				'AJJB Legal'					[DEBTOR STAGE]
				, acc.ClientReference			[ACC NUM]
				, [Full Name]					[BUS NAME]
				, FirstName + ' ' + surname		[CONTACT NAME]
				, outstandingbalance			[BALANCE]
				, [e-mail]						[EMAIL]
				, tel1.Number					[PHONE]
				, tel2.Number					[MOBILE]
				, mai.addressline1				[ADDR1]
				, mai.addressline3				[ADDR2]
				, mai.addressline3				[ADDR3]
				, mai.addressline4				[ADDR4]
				, mai.AddressPostcode			[POSTCODE]
				, sup.addressline1				[SUPPLYADDR1]
				, sup.addressline3				[SUPPLYADDR2]
				, sup.addressline3				[SUPPLYADDR3]
				, sup.addressline4				[SUPPLYADDR4]
				, sup.AddressPostcode			[SUPPLYPOSTCODE]
				, [Supply Date From]			[SUPPLY START DATE]
				, [Supply Date To]				[SUPPLY END DATE]
				, [Last Payment Amount]			[LAST PAYMENT]
				, [Last Payment Date]			[LAST PAYMENT DATE]
			
from			rm.dbo.Account				acc
join			rm.dbo.Customer				cus		on cus.accountid=acc.Accountid
left join		rm.dbo.CustomerAddress		sup		on sup.accountid=acc.Accountid		and sup.AddressType = 'supply'
left join		rm.dbo.CustomerAddress		mai		on mai.accountid=acc.Accountid		and mai.AddressType <> 'supply'
left join		RM.dbo.supplementarydata	sd		on sd.ClientReference=acc.clientreference
left join		#tel	tel1	on tel1.accountid=acc.Accountid and tel1.rank = 1
left join		#tel    tel2	on tel2.accountid=acc.Accountid and tel2.rank = 2
left join		#tel    tel3	on tel3.accountid=acc.Accountid and tel3.rank = 3
join			rm.dbo.Assignment			ass		on ass.ClientReference = acc.ClientName and ass.segment = 'Litigation' and cast(assigneddate as date) = cast(getdate() as date)