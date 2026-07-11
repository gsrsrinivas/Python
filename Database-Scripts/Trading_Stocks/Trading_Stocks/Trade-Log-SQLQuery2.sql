
SELECT TOP (1000) [Client ID]
      ,[Tradebook for Equity from ]
      ,[Symbol]
      ,[ISIN]
      ,[Trade Date]
      ,[Exchange]
      ,[Segment]
      ,[Series]
      ,[Trade Type]
      ,[Auction]
      ,[Quantity]
      ,[Price]
      ,[Trade ID]
      ,[Order ID]
      ,[Order Execution Time]
  FROM [Stocks_db].[dbo].[TradeBook];

select * from [_TS].[Shares]
