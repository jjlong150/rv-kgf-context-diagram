-- Create the canvas notes
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 21

SELECT 'Note ' & [ID]         AS [ITEM],
       [Note] & '\l'          AS [LABEL], 
       30                     AS [SPLIT LENGTH],
       '\l'                   AS [LINE ENDING],
       'Note ' & [ID]         AS [TOOLTIP],
       'Note'                 AS [STYLE NAME]
FROM   [Notes$]
WHERE  [Boundary 1] IS NULL
AND    [Boundary 2] IS NULL
AND    (SELECT [Enabled] FROM [Options$] WHERE [Option] = 'Add Canvas Notes') = TRUE
