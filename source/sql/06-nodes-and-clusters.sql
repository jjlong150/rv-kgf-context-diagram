-- Create the application nodes by querying multiple worksheets and UNION the results to aggregate into clusters.
-- Source: Relationship Visualizer.xlsm, sql worksheet, row 27

SELECT
    AB.[Boundary 1]
        AS [CLUSTER],
    AB.[Boundary 1]
        AS [CLUSTER LABEL],
    AB.[Boundary 1]
        AS [CLUSTER TOOLTIP],
    'boundary_1'
        AS [CLUSTER STYLE NAME],

    AB.[Boundary 2]
        AS [SUBCLUSTER],
    AB.[Boundary 2]
        AS [SUBCLUSTER LABEL],
    AB.[Boundary 2]
        AS [SUBCLUSTER TOOLTIP],
    'boundary_2'
        AS [SUBCLUSTER STYLE NAME],

    AB.[Application Title]
        AS [ITEM],

    AB.[APP ID] & '\n\n' & REPLACE(AB.[Application Title], '&', '&amp;')
        AS [LABEL],

    IIF(AB.[A Vendor Product]    IS NULL, '', 'vendor_product="'      & AB.[A Vendor Product]    & '" ') &
    IIF(AB.[APP ID]              IS NULL, '', 'app_id="'              & AB.[APP ID]              & '" ') &
    IIF(AB.[Application Title]   IS NULL, '', 'app_title="'           & AB.[Application Title]   & '" ') &
    IIF(AB.[Business Owner]      IS NULL, '', 'business_owner="'      & AB.[Business Owner]      & '" ') &
    IIF(AB.[Technical Owner]     IS NULL, '', 'technical_owner="'     & AB.[Technical Owner]     & '" ') &
    IIF(AB.[B Vendor Product]    IS NULL, '', 'vendor_product="'      & AB.[B Vendor Product]    & '" ') &
    IIF(AB.[Hosting Model]       IS NULL, '', 'hosting_model="'       & AB.[Hosting Model]       & '" ') &
    IIF(AB.[End of Support Date] IS NULL, '', 'end_of_support_date="' & AB.[End of Support Date] & '" ') &
    IIF(AB.[Data Classification] IS NULL, '', 'data_classification="' & AB.[Data Classification] & '" ') &
    IIF(AB.[Contains PII]        IS NULL, '', 'contains_pii='         & IIF(AB.[Contains PII] = 'Yes', 'true', 'false') & ' ') &
    IIF(AB.[Redundancy Model]    IS NULL, '', 'redundancy_model="'    & AB.[Redundancy Model]    & '" ') &
    IIF(AB.[Criticality]         IS NULL, '', 'criticality="'         & AB.[Criticality]         & '" ') &
    IIF(AB.[Regulatory Scope]    IS NULL, '', 'regulatory_scope="'    & AB.[Regulatory Scope]    & '" ') &
    IIF(AB.[Integrity]           IS NULL, '', 'integrity="'           & AB.[Integrity]           & '" ') &
    IIF(AB.[Availability]        IS NULL, '', 'availability="'        & AB.[Availability]        & '" ') &
    IIF(AB.[Business Continuity] IS NULL, '', 'business_continuity="' & AB.[Business Continuity] & '" ') &
    IIF(AB.[Custom Properties]   IS NULL, '', AB.[Custom Properties])                                    &
    Left(MA.[MemoAnchor] & '', 0)
        AS [PROPERTIES],

    10
        AS [SPLIT LENGTH],

    '\n'
        AS [LINE ENDING],

    REPLACE(AB.[Application Title], '&', '&amp;') & ': ' & REPLACE(AB.[Application Description], CHR(10), ' ')
        AS [TOOLTIP],

    LCASE(REPLACE(AB.[Application Type], ' ', '_'))
        AS [STYLE NAME],

    IIF(AB.[Emphasize] = TRUE, 'peripheries=2','')
        AS [ATTRIBUTES]
FROM
    (
        SELECT
            A.[Boundary 1],
            A.[Boundary 2],
            A.[Vendor Product]      AS [A Vendor Product],
            A.[Custom Properties],
            A.[Emphasize],
            B.[APP ID],
            B.[Application Title],
            B.[Business Owner],
            B.[Technical Owner],
            B.[Vendor Product]      AS [B Vendor Product],
            B.[Hosting Model],
            B.[End of Support Date],
            B.[Data Classification],
            B.[Contains PII],
            B.[Redundancy Model],
            B.[Criticality],
            B.[Regulatory Scope],
            B.[Integrity],
            B.[Availability],
            B.[Business Continuity],
            B.[Application Description],
            B.[Application Type]
        FROM
            [Applications$] A LEFT JOIN [Application Descriptions$] B
                ON A.[Application Title] = B.[Application Title]
        WHERE
            A.[Application Title] IS NOT NULL
    ) AS AB,
    (
        SELECT TOP 1 [Value] AS [MemoAnchor]
        FROM [Hidden Options$]
        WHERE [Option] = 'Memo Anchor'
    ) AS MA

UNION ALL

SELECT
    C.[Boundary 1]
        AS [CLUSTER],
    C.[Boundary 1]
        AS [CLUSTER LABEL],
    C.[Boundary 1]
        AS [CLUSTER TOOLTIP],
    'boundary_1'
        AS [CLUSTER STYLE NAME],

    C.[Boundary 2]
        AS [SUBCLUSTER],
    C.[Boundary 2]
        AS [SUBCLUSTER LABEL],
    C.[Boundary 2]
        AS [SUBCLUSTER TOOLTIP],
    'boundary_2'
        AS [SUBCLUSTER STYLE NAME],

    C.[Actor]
        AS [ITEM],

    C.[Actor Type] & '\n' & C.[Actor]
        AS [LABEL],

    IIF(C.[Origin]            IS NULL, '', 'origin="'           & C.[Origin]            & '" ') &
    IIF(C.[Population Scale]  IS NULL, '', 'population_scale="' & C.[Population Scale]  & '" ') &
    IIF(C.[Trigger Source]    IS NULL, '', 'trigger_source="'   & C.[Trigger Source]    & '" ') &
    IIF(C.[Failure Impact]    IS NULL, '', 'failure_impact="'   & C.[Failure Impact]    & '" ') &
    IIF(C.[Custom Properties] IS NULL, '', C.[Custom Properties]) &
    Left(MA.[MemoAnchor] & '', 0)
        AS [PROPERTIES],

    10
        AS [SPLIT LENGTH],

    '\n'
        AS [LINE ENDING],

    C.[Actor] & ': ' & C.[Description]
        AS [TOOLTIP],

    LCASE(REPLACE(C.[Actor Type], ' ', '_'))
        AS [STYLE NAME],

    ''
        AS [ATTRIBUTES]
FROM
    [Actors$] C,
    (
        SELECT TOP 1 [Value] AS [MemoAnchor]
        FROM [Hidden Options$]
        WHERE [Option] = 'Memo Anchor'
    ) AS MA
WHERE
    C.[Actor] IS NOT NULL

UNION ALL

SELECT
    D.[Boundary 1]
        AS [CLUSTER],
    D.[Boundary 1]
        AS [CLUSTER LABEL],
    D.[Boundary 1]
        AS [CLUSTER TOOLTIP],
    'boundary_1'
        AS [CLUSTER STYLE NAME],

    D.[Boundary 2]
        AS [SUBCLUSTER],
    D.[Boundary 2]
        AS [SUBCLUSTER LABEL],
    D.[Boundary 2]
        AS [SUBCLUSTER TOOLTIP],
    'boundary_2'
        AS [SUBCLUSTER STYLE NAME],

    D.[Data Store]
        AS [ITEM],

    D.[Data Store]
        AS [LABEL],

    IIF(D.[Data Owner]           IS NULL, '', 'data_owner="'           & D.[Data Owner]            & '" ') &
    IIF(D.[Deployment Model]     IS NULL, '', 'deployment_model="'     & D.[Deployment Model]      & '" ') &
    IIF(D.[Data Residency]       IS NULL, '', 'data_residency="'       & D.[Data Residency]        & '" ') &
    IIF(D.[Data Classification]  IS NULL, '', 'data_classification="'  & D.[Data Classification]   & '" ') &
    IIF(D.[Contains PII]         IS NULL, '', 'contains_pii='          & IIF(D.[Contains PII]       = 'Yes', 'true', 'false') & ' ') &
    IIF(D.[Retention Period]     IS NULL, '', 'retention_period="'     & D.[Retention Period]      & '" ') &
    IIF(D.[Encryption at Rest]   IS NULL, '', 'encryption_at_rest='    & IIF(D.[Encryption at Rest] = 'Yes', 'true', 'false') & ' ') &
    IIF(D.[Backup Strategy]      IS NULL, '', 'backup_strategy="'      & D.[Backup Strategy]       & '" ') &
    IIF(D.[Failure Disposition]  IS NULL, '', 'failure_disposition="'  & D.[Failure Disposition]   & '" ') &
    IIF(D.[Retry Strategy]       IS NULL, '', 'retry_strategy="'       & D.[Retry Strategy]        & '" ') &
    IIF(D.[Failure Alerting]     IS NULL, '', 'failure_alerting="'     & D.[Failure Alerting]      & '" ') &
    IIF(D.[Custom Properties]    IS NULL, '', D.[Custom Properties]) &
    Left(MA.[MemoAnchor] & '', 0)
        AS [PROPERTIES],

    10
        AS [SPLIT LENGTH],

    '\n'
        AS [LINE ENDING],

    D.[Data Store] & ': ' & D.[Description]
        AS [TOOLTIP],

    LCASE(REPLACE(D.[Data Store Type], ' ', '_'))
        AS [STYLE NAME],

    ''
        AS [ATTRIBUTES]
FROM
    [Data Stores$] D,
    (
        SELECT TOP 1 [Value] AS [MemoAnchor]
        FROM [Hidden Options$]
        WHERE [Option] = 'Memo Anchor'
    ) AS MA
WHERE
    D.[Data Store] IS NOT NULL

UNION ALL

SELECT
    E.[Boundary 1]
        AS [CLUSTER],
    E.[Boundary 1]
        AS [CLUSTER LABEL],
    E.[Boundary 1]
        AS [CLUSTER TOOLTIP],
    'boundary_1'
        AS [CLUSTER STYLE NAME],

    E.[Boundary 2]
        AS [SUBCLUSTER],
    E.[Boundary 2]
        AS [SUBCLUSTER LABEL],
    E.[Boundary 2]
        AS [SUBCLUSTER TOOLTIP],
    'boundary_2'
        AS [SUBCLUSTER STYLE NAME],

    'Note ' & E.[ID]
        AS [ITEM],

    E.[Note] & '\l'
        AS [LABEL],

    IIF(E.[ID]                IS NULL, '', 'id="' & E.[ID] & '" ') &
    IIF(E.[Custom Properties] IS NULL, '', E.[Custom Properties]) &
    Left(MA.[MemoAnchor] & '', 0)
        AS [PROPERTIES],

    30
        AS [SPLIT LENGTH],

    '\l'
        AS [LINE ENDING],

    'Note ' & E.[ID]
        AS [TOOLTIP],

    'note'
        AS [STYLE NAME],

    ''
        AS [ATTRIBUTES]
FROM
    [Notes$] E,
    (
        SELECT TOP 1 [Value] AS [MemoAnchor]
        FROM [Hidden Options$]
        WHERE [Option] = 'Memo Anchor'
    ) AS MA
WHERE
    E.[Boundary 1] IS NOT NULL
AND
    E.[Boundary 2] IS NOT NULL
AND
    (SELECT [Enabled] FROM [Options$] WHERE [Option] = 'Add Cluster Notes') = TRUE
