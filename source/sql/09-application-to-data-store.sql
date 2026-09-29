-- Create the WRITE relationships between Applications and Data Stores
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 36

SELECT AD.[Application Title]     AS [ITEM], 
       AD.[Data Store]            AS [RELATED ITEM],
       AD.[Caption] & '\l'        AS [LABEL],
       IIF(AD.[Data Classification] IS NULL, '', 'data_classification="' & AD.[Data Classification]  & '" ') &
       IIF(AD.[Contains PII]        IS NULL, '', 'contains_pii='         & IIF(AD.[Contains PII] = 'Yes', 'true', 'false') & ' ') &
       IIF(AD.[Auth Mechanism]      IS NULL, '', 'auth_mechanism="'      & AD.[Auth Mechanism]       & '" ') &
       IIF(AD.[Failure Disposition] IS NULL, '', 'failure_disposition="' & AD.[Failure Disposition]  & '" ') &
       IIF(AD.[Retry Strategy]      IS NULL, '', 'retry_strategy="'      & AD.[Retry Strategy]       & '" ') &
       IIF(AD.[Failure Alerting]    IS NULL, '', 'failure_alerting="'    & AD.[Failure Alerting]     & '" ') &
       IIF(AD.[Approximate Volume]  IS NULL, '', 'approximate_volume="'  & AD.[Approximate Volume]   & '" ') &
       IIF(AD.[Custom Properties]   IS NULL, '', AD.[Custom Properties]) &
       Left(MA.[MemoAnchor] & '', 0)
                                  AS [PROPERTIES],
       TRIM(LCASE(REPLACE(AD.[Action] & '_' & AD.[Via],' ','_'))) 
                                  AS [STYLE NAME],
       10                         AS [SPLIT LENGTH],
       '\l'                       AS [LINE ENDING],
       AD.[Caption]               AS [TOOLTIP]
FROM   [Application to Data Store$] AD,
       (
           SELECT TOP 1 [Value] AS [MemoAnchor]
           FROM [Hidden Options$]
           WHERE [Option] = 'Memo Anchor'
       ) AS MA
WHERE  AD.[Application Title] IS NOT NULL
