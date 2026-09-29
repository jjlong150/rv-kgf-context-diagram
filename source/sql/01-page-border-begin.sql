-- Start Primary Border
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 12

SELECT TOP 1
       '{'                 AS [ITEM], 
       [Value]             AS [LABEL], 
       [Value]             AS [TOOLTIP],
       'page_border_begin' AS [STYLE NAME]
FROM   [Options$]
WHERE  [Option]  = 'Add Page Border' 
AND    [Enabled] = TRUE
