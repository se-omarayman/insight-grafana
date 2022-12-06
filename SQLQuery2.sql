
select COUNT(*) as cnt, Entities, Sentiment FROM [ConnectorsDB].[dbo].[TwitterAPI]
group by Entities, Sentiment

select * FROM [ConnectorsDB].[dbo].[TwitterAPI]

select [Sentiment] as [Sentiment], [Negative],[Positive], [Mixed], [Neutral]
FROM (
	select [Entities], [Sentiment] FROM [ConnectorsDB].[dbo].[TwitterAPI]
) as SourceTable
PIVOT
(
	count(Sentiment) for [Sentiment] in ([Negative],[Positive], [Mixed], [Neutral])
) as PivotTable

select * from (
	select [Entities], [Sentiment] FROM [ConnectorsDB].[dbo].[TwitterAPI]
)
PIVOT (
	[Sentiment] for Sentiment in ([Positive], [Negative])
)


--WITH Pivoted AS (
--	select [Entities], Positive, Negative, Neutral, Mixed
--	from(
--		select * FROM [ConnectorsDB].[dbo].[TwitterAPI]
--	) as SourceTable
--	PIVOT(
--		count(Sentiment) for [Sentiment] in ([Positive], [Negative], [Neutral], [Mixed]) 
--	) as PivotTable 
--)
--select Entities,
--sum(Positive) as Positive, 
--sum(Negative) as Negative, 
--sum(Neutral) as Neutral, 
--sum(Mixed) Mixed from Pivoted group by Entities


WITH Pivoted AS (
	select [Country], Positive, Negative, Neutral, Mixed
	from(
		select * FROM [ConnectorsDB].[dbo].[TwitterAPI]
	) as SourceTable
	PIVOT(
		count(Sentiment) for [Sentiment] in ([Positive], [Negative], [Neutral], [Mixed]) 
	) as PivotTable 
)
select Country,
sum(Positive) as Positive, 
sum(Negative) as Negative, 
sum(Neutral) as Neutral, 
sum(Mixed) Mixed from Pivoted group by Country



