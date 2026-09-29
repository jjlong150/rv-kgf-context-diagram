-- Create the relationships between the applications
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 33

SELECT AA.[Application Title]    AS [ITEM], 
       AA.[Uses Application]     AS [RELATED ITEM],
       AA.[Caption] & '\l'       AS [LABEL],
       IIF(AA.[Data Classification] IS NULL, '', 'data_classification="' & AA.[Data Classification]  & '" ') &
       IIF(AA.[Contains PII]        IS NULL, '', 'contains_pii='         & IIF(AA.[Contains PII] = 'Yes', 'true', 'false') & ' ') &
       IIF(AA.[Auth Mechanism]      IS NULL, '', 'auth_mechanism="'      & AA.[Auth Mechanism]       & '" ') &
       IIF(AA.[Failure Disposition] IS NULL, '', 'failure_disposition="' & AA.[Failure Disposition]  & '" ') &
       IIF(AA.[Retry Strategy]      IS NULL, '', 'retry_strategy="'      & AA.[Retry Strategy]       & '" ') &
       IIF(AA.[Failure Alerting]    IS NULL, '', 'failure_alerting="'    & AA.[Failure Alerting]     & '" ') &
       IIF(AA.[Approximate Volume]  IS NULL, '', 'approximate_volume="'  & AA.[Approximate Volume]   & '" ') &
       IIF(AA.[Agreements in Place] IS NULL, '', 'agreements_in_place=' & IIF(AA.[Agreements in Place] = 'Yes', 'true', 'false') & ' ') &
       IIF(AA.[Stability]           IS NULL, '', 'stability="'           & AA.[Stability]            & '" ') &
       IIF(AA.[Custom Properties]   IS NULL, '', AA.[Custom Properties]) &
       Left(MA.[MemoAnchor] & '', 0)
                                 AS [PROPERTIES],
       TRIM(LCASE(REPLACE(AA.[Via] & '_' & AA.[Protocol],' ','_'))) 
                                 AS [STYLE NAME],
       10                        AS [SPLIT LENGTH],
       '\l'                      AS [LINE ENDING],
       AA.[Caption]              AS [TOOLTIP]
FROM   [Application to Application$] AA,
       (
           SELECT TOP 1 [Value] AS [MemoAnchor]
           FROM [Hidden Options$]
           WHERE [Option] = 'Memo Anchor'
       ) AS MA
WHERE  AA.[Application Title] IS NOT NULL AND 
       AA.[Uses Application]  IS NOT NULL
