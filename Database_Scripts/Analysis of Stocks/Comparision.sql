WITH 
ValueSource AS (
    SELECT Batch_No, Screen_Names, Value
    FROM Master_Screen_Name_Values
    WHERE Batch_No = 1
),
ValuePivot AS (
    SELECT *
    FROM ValueSource
    PIVOT (
        SUM(Value) FOR Screen_Names IN (
            [Bullish_Single_Screen_Yearly],
            [Bullish_Single_Screen_Quarterly],
            [Bullish_Single_Screen_Monthly],
            [Bearish_Single_Screen_Yearly],
            [Bearish_Single_Screen_Quarterly],
            [Bearish_Single_Screen_Monthly]
        )
    ) AS vp
),
DescSource AS (
    SELECT Batch_No, Screen_Names, Description
    FROM Master_Screen_Name_Values
    WHERE Batch_No = 1
),
DescPivot AS (
    SELECT *
    FROM DescSource
    PIVOT (
        MAX(Description) FOR Screen_Names IN (
            [Bullish_Single_Screen_Yearly],
            [Bullish_Single_Screen_Quarterly],
            [Bullish_Single_Screen_Monthly],
            [Bearish_Single_Screen_Yearly],
            [Bearish_Single_Screen_Quarterly],
            [Bearish_Single_Screen_Monthly]
        )
    ) AS dp
)
SELECT 'calculation' as mailtable,
    a.Symbol,
    a.Batch_No,
    Trade_Type = ISNULL(a.Trade_Type, '') + 
        CASE 
            WHEN a.Bullish_Single_Screen_Yearly > 0 OR 
                 a.Bullish_Single_Screen_Quarterly > 0 OR 
                 a.Bullish_Single_Screen_Monthly > 0 THEN 'bullish;'
            WHEN a.Bearish_Single_Screen_Yearly > 0 OR 
                 a.Bearish_Single_Screen_Quarterly > 0 OR 
                 a.Bearish_Single_Screen_Monthly > 0 THEN 'bearish;'
            ELSE ''
        END,
    Trade_Type_Details = ISNULL(a.Trade_Type_Details, '') +
        COALESCE(
            CASE 
                WHEN a.Bullish_Single_Screen_Yearly > 0 THEN dp.Bullish_Single_Screen_Yearly
                WHEN a.Bullish_Single_Screen_Quarterly > 0 THEN dp.Bullish_Single_Screen_Quarterly
                WHEN a.Bullish_Single_Screen_Monthly > 0 THEN dp.Bullish_Single_Screen_Monthly
                WHEN a.Bearish_Single_Screen_Yearly > 0 THEN dp.Bearish_Single_Screen_Yearly
                WHEN a.Bearish_Single_Screen_Quarterly > 0 THEN dp.Bearish_Single_Screen_Quarterly
                WHEN a.Bearish_Single_Screen_Monthly > 0 THEN dp.Bearish_Single_Screen_Monthly
                ELSE ''
            END, ''
        ),
    Trade_Type_Details_Sum = ISNULL(a.Trade_Type_Details_Sum, 0) + 
        COALESCE(
            CASE 
                WHEN a.Bullish_Single_Screen_Yearly > 0 THEN vp.Bullish_Single_Screen_Yearly
                WHEN a.Bullish_Single_Screen_Quarterly > 0 THEN vp.Bullish_Single_Screen_Quarterly
                WHEN a.Bullish_Single_Screen_Monthly > 0 THEN vp.Bullish_Single_Screen_Monthly
                WHEN a.Bearish_Single_Screen_Yearly > 0 THEN vp.Bearish_Single_Screen_Yearly
                WHEN a.Bearish_Single_Screen_Quarterly > 0 THEN vp.Bearish_Single_Screen_Quarterly
                WHEN a.Bearish_Single_Screen_Monthly > 0 THEN vp.Bearish_Single_Screen_Monthly
                ELSE 0
            END, 0
        ),
    Trade_Type_Bullish_Sum = ISNULL(a.Trade_Type_Bullish_Sum, 0) +
        ISNULL(vp.Bullish_Single_Screen_Yearly, 0) +
        ISNULL(vp.Bullish_Single_Screen_Quarterly, 0) +
        ISNULL(vp.Bullish_Single_Screen_Monthly, 0),
    Trade_Type_Bearish_Sum = ISNULL(a.Trade_Type_Bearish_Sum, 0) +
        ISNULL(vp.Bearish_Single_Screen_Yearly, 0) +
        ISNULL(vp.Bearish_Single_Screen_Quarterly, 0) +
        ISNULL(vp.Bearish_Single_Screen_Monthly, 0)
FROM dbo.Analyse_Stocks a
JOIN DescPivot dp ON dp.Batch_No = 1 AND a.Batch_No = (SELECT MAX(Batch_No) FROM Analyse_Stocks)
JOIN ValuePivot vp ON vp.Batch_No = 1
union all
select 'Analyse_Stocks' as mailtable,symbol,Batch_No,Trade_Type,Trade_Type_Details,Trade_Type_Details_Sum,Trade_Type_Bullish_Sum,Trade_Type_Bearish_Sum
from Analyse_stocks where Batch_No = (select max(batch_no) from Analyse_Stocks)
order by Symbol
