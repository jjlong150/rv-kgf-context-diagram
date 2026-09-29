-- Ensure the notes flow in sequence, if enabled in the Options worksheet.
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 24

SELECT 'Note ' & N.[ID]    AS [ITEM],
       'transparent_edge'  AS [STYLE NAME],
       O.[Value]           AS [ATTRIBUTES],
       TRUE                AS [CREATE EDGES]
FROM   [Notes$] N,
       (SELECT TOP 1 [Value], [Enabled] FROM [Options$]
        WHERE [Option] = 'Add Canvas Notes') AS O
WHERE  N.[Boundary 1] IS NULL
AND    N.[Boundary 2] IS NULL
AND    O.[Enabled] = TRUE
