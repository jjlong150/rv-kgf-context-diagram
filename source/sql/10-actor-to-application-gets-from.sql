-- Create the Actor to Application relationships
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 39

SELECT A.[Actor]                  AS [RELATED ITEM], 
       A.[Uses Application]       AS [ITEM],
       A.[Caption] & '\l'         AS [LABEL],
       IIF(A.[Data Classification] IS NULL, '', 'data_classification="' & A.[Data Classification]  & '" ') &
       IIF(A.[Contains PII]        IS NULL, '', 'contains_pii='         & IIF(A.[Contains PII] = 'Yes', 'true', 'false') & ' ') &
       IIF(A.[Auth Mechanism]      IS NULL, '', 'auth_mechanism="'      & A.[Auth Mechanism]       & '" ') &
       IIF(A.[Failure Disposition] IS NULL, '', 'failure_disposition="' & A.[Failure Disposition]  & '" ') &
       IIF(A.[Retry Strategy]      IS NULL, '', 'retry_strategy="'      & A.[Retry Strategy]       & '" ') &
       IIF(A.[Failure Alerting]    IS NULL, '', 'failure_alerting="'    & A.[Failure Alerting]     & '" ') &
       IIF(A.[Approximate Volume]  IS NULL, '', 'approximate_volume="'  & A.[Approximate Volume]   & '" ') &
       IIF(A.[Channel]             IS NULL, '', 'channel="'             & A.[Channel]              & '" ') &
       IIF(A.[Custom Properties]   IS NULL, '', A.[Custom Properties]) &
       Left(MA.[MemoAnchor] & '', 0)
                                  AS [PROPERTIES],
       LCASE(REPLACE((SELECT TOP 1 B.[Actor Type] FROM [Actors$] B WHERE B.[Actor] = A.[Actor]) & "_" & A.[Action],' ','_'))
                                  AS [STYLE NAME],
       10                         AS [SPLIT LENGTH],
       '\l'                       AS [LINE ENDING],
       A.[Caption]                AS [TOOLTIP]
FROM   [Actor to Application$] A,
       (
           SELECT TOP 1 [Value] AS [MemoAnchor]
           FROM [Hidden Options$]
           WHERE [Option] = 'Memo Anchor'
       ) AS MA
WHERE  A.[Actor]            IS NOT NULL AND 
       A.[Uses Application] IS NOT NULL AND
       A.[Action]           = 'Gets From'
