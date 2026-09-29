-- Create the legend, if enabled in the Options worksheet
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 15

SELECT TOP 1
       '>'             AS [ITEM], 
       'subgraph legend_%rsc% { rank="' & [Value] & '"; "legend" };' AS [LABEL], 
       'legend native' AS [STYLE NAME]
FROM   [Options$]
WHERE  [Option]  = 'Add Legend' 
AND    [Enabled] = TRUE
