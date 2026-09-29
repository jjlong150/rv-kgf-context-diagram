-- Conclude the Primary Border, if enabled on the Options worksheet.
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 30

SELECT TOP 1
       '}'               AS [ITEM], 
       'page_border_end' AS [STYLE NAME]
FROM  [Options$]
WHERE [Option] = 'Add Page Border' AND [Enabled] = TRUE
