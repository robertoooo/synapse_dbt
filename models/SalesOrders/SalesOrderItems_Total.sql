
SELECT 
    PRODUCTID,
    SUM(CAST(GROSSAMOUNT AS dec)) as GROSSAMOUNT,
    SUM(CAST(NETAMOUNT AS dec)) as NETAMOUNT,
    SUM(CAST(TAXAMOUNT AS dec)) as TAXAMOUNT,
    SUM(CAST(QUANTITY AS INT)) as QUANTITY
    
FROM
    {{source('dbo', 'SalesOrderItems') }}
GROUP BY PRODUCTID