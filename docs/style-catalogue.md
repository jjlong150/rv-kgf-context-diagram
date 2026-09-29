# Style catalogue

Every style defined on the Styles worksheet of `Relationship Visualizer.xlsm`. This page is generated from the styles; do not edit it by hand. For the meaning of each property, see the [style property reference](user-guide.md#6-style-property-reference). The **Line** column uses the governance color code described in [Reading the diagram](user-guide.md#52-edges).

## Node styles

| Style | Properties | Description |
|---|---|---|
| `alarm` | `subtype=alarm` `actor_role=automated` | Automated signal that raises an alert when a condition, threshold, or fault is detected, triggering a predefined response. It notifies rather than decides. |
| `bot` | `subtype=bot` `actor_role=automated` | Software agent that performs tasks, exchanges data, or triggers actions by following programmed rules, without human intervention. |
| `event` | `subtype=event` `actor_role=system` | Occurrence such as a message arrival, timer expiration, or state change that starts, continues, or interrupts a process. |
| `organization` | `subtype=organization` `actor_role=human` | Business unit, department, vendor, or external entity interacting with the system in an institutional role rather than as an individual. |
| `person` | `subtype=person` `actor_role=human` | Individual user who initiates or receives interactions, such as submitting requests, approving steps, or consuming information. |
| `process` | `subtype=process` `actor_role=system` | Operational workflow or business activity that interacts with applications or data stores to perform actions and transform information. |
| `cloud` | `subtype=cloud` `code_ownership=vendor` `operated_by=vendor` `support_model=vendor` | Application hosted on remote infrastructure and delivered as an on-demand service, integrated through APIs or managed platform endpoints. |
| `commercial` | `subtype=commercial` `code_ownership=vendor` `operated_by=internal` `support_model=vendor` | Licensed, vendor-supported software product with standardized functionality. Integration is governed by vendor APIs and configuration options. |
| `homegrown` | `subtype=homegrown` `code_ownership=internal` `operated_by=internal` `support_model=internal` | Custom application built and supported internally to meet specific business needs, often tightly coupled to internal processes. |
| `open-source` | `subtype=open_source` `code_ownership=community` `operated_by=internal` `support_model=community` | Community-maintained application with modifiable source code, self-hosted or customized to fit organizational workflows. |
| `partner` | `subtype=partner` `code_ownership=partner` `operated_by=partner` `support_model=partner` | Application operated by a business partner under a formal agreement, exchanging data or services through contracted interfaces. |
| `system` | `subtype=system` `code_ownership=mixed` `operated_by=internal` `support_model=internal` | Foundational platform such as an operating system, middleware, or enterprise service that provides core capabilities to other applications. |
| `database` | `subtype=database` `structure=structured` `persistence=persistent` `access_pattern=query` `concurrency_model=transactional` | Structured data store supporting queries, updates, and transactions, with reliable persistence and controlled access to records. |
| `directory` | `subtype=directory` `structure=semi_structured` `persistence=persistent` `access_pattern=lookup` `concurrency_model=none` | Hierarchical store used to look up identities, attributes, devices, or configuration entries. |
| `file` | `subtype=file` `structure=unstructured` `persistence=persistent` `access_pattern=read_write` `concurrency_model=none` | Single, discrete data object in a defined format, such as a document, payload, export, or artifact. |
| `folder` | `subtype=folder` `structure=unstructured` `persistence=persistent` `access_pattern=read_write` `concurrency_model=none` | Container grouping related files for organization or processing. Provides structure without imposing a schema. |
| `queue` | `subtype=queue` `structure=semi_structured` `persistence=transient` `access_pattern=sequential` `concurrency_model=ordered` | Ordered store holding messages or tasks awaiting processing, decoupling producers from consumers. |
| `repository` | `subtype=repository` `structure=semi_structured` `persistence=persistent` `access_pattern=versioned` `concurrency_model=append_only` | Managed store of versioned content such as code, artifacts, or documents, with controlled access and change history. |
| `note` | `subtype=note` | Annotation that clarifies or supplements the diagram. It is not part of any data flow. |

## Actor-to-application edge styles

All actor edges use the actor's color and have no governance status.

| Style | Mode | Direction | Sync | Real-time | Description |
|---|---|---|---|---|---|
| `alarm_gets_from` | consume | pull | false | true | Alarm receives status, thresholds, or condition data from the application to decide whether to trigger. |
| `alarm_interacts_with` | notify | bidirectional | false | true | Alarm and application exchange conditions and state changes in both directions as part of an automated monitoring loop. |
| `alarm_sends_to` | notify | push | false | true | Alarm sends alerts, fault notifications, or trigger signals to the application to initiate a response. |
| `bot_gets_from` | consume | pull | true | false | Bot retrieves data, instructions, or status from the application to perform automated tasks. |
| `bot_interacts_with` | control | bidirectional | true | false | Bot and application exchange data and actions in both directions as part of a programmed workflow. |
| `bot_sends_to` | produce | push | true | false | Bot sends commands, updates, or processed results to the application. |
| `event_gets_from` | consume | pull | false | true | Event draws conditions or state from the application that determine when or how it fires. |
| `event_interacts_with` | notify | bidirectional | false | true | Event and application exchange triggering conditions and resulting state changes in an event-driven workflow. |
| `event_sends_to` | notify | push | false | true | Event notifies the application that a defined condition has occurred, triggering a response. |
| `organization_gets_from` | consume | pull | true | false | Organization receives reports, data, or outputs from the application for oversight and decision-making. |
| `organization_interacts_with` | control | bidirectional | true | false | Organization consumes application data and returns inputs, approvals, or directives. |
| `organization_sends_to` | produce | push | true | false | Organization sends requests, policies, or operational data that drive application behavior. |
| `person_gets_from` | consume | pull | true | false | Person receives information, results, or feedback from the application. |
| `person_interacts_with` | control | bidirectional | true | false | Person provides inputs to and receives outputs from the application during normal use. |
| `person_sends_to` | produce | push | true | false | Person sends requests, commands, or data to the application. |
| `process_gets_from` | consume | pull | true | false | Process receives data or outputs from the application to execute or advance its workflow. |
| `process_interacts_with` | control | bidirectional | true | false | Process consumes application data and returns updates or results as part of an operational workflow. |
| `process_sends_to` | produce | push | true | false | Process sends actions, results, or transformed data to the application. |

## Application-to-application edge styles

| Style | Line | Status | Encryption | Risk | Modernity | Preferred alternative | Description |
|---|---|---|---|---|---|---|---|
| `api_gateway_https_rest` | green, solid | approved | enforced | low | modern |  | REST calls with JSON payloads over HTTPS, routed through the API gateway for authentication, throttling, and monitoring. Standard API pattern. |
| `api_gateway_graphql` | amber, dashed | requires_approval | enforced | low | modern | `api_gateway_https_rest` | GraphQL queries and mutations through a single API gateway endpoint for flexible, schema-driven data access. Requires approval; REST preferred. |
| `api_gateway_grpc_and_http2` | amber, dashed | requires_approval | enforced | low | modern | `api_gateway_https_rest` | Binary, strongly typed gRPC calls over HTTP/2 through the API gateway for efficient service-to-service communication. Requires approval; REST preferred. |
| `api_gateway_websocket` | amber, solid | under_review | enforced | medium | modern |  | Persistent, bidirectional WebSocket connection through the API gateway for real-time messaging or streaming. Under architecture review. |
| `api_gateway_https_soap` | amber, dashed | deprecated | enforced | medium | legacy | `api_gateway_https_rest` | XML-based SOAP web service calls over HTTPS through the API gateway. Deprecated; migrate to REST. |
| `api_gateway_webhooks_and_sse` | amber, solid | requires_approval | enforced | medium | modern |  | Gateway-managed outbound event delivery using webhook callbacks or Server-Sent Events streams. Requires approval. |
| `direct_network_https_rest` | green, solid | approved | enforced | low | modern |  | Point-to-point REST calls over HTTPS on the internal network, without an intermediary. |
| `direct_network_https_soap` | amber, dashed | deprecated | enforced | medium | legacy | `direct_network_https_rest` | Point-to-point SOAP calls over HTTPS on the internal network. Deprecated; migrate to REST. |
| `direct_network_grpc` | green, solid | approved | enforced | low | modern |  | Point-to-point gRPC calls over HTTP/2 with TLS for low-latency internal service communication. |
| `direct_network_graphql` | amber, dashed | requires_approval | enforced | low | modern | `direct_network_https_rest` | Point-to-point GraphQL queries over HTTPS on the internal network. Requires approval; REST preferred. |
| `direct_network_raw_tcp_udp` | red, solid | prohibited | none | high | legacy | `direct_network_service_mesh_mtls` | Custom protocol over raw TCP or UDP sockets without standard encryption or authentication. Prohibited; use a service mesh or TLS-based protocol. |
| `direct_network_service_mesh_mtls` | green, solid | approved | enforced | low | modern |  | Service-to-service traffic within a service mesh using mutual TLS for workload identity, encryption, and policy enforcement. |
| `email_microsoft_exchange` | amber, dashed | deprecated | enforced | medium | legacy | `email_microsoft_graph_api` | Direct integration with Exchange servers via MAPI/HTTP or Exchange Web Services for mail, contacts, and calendars. Deprecated; use Microsoft Graph API. |
| `email_smtp` | green, solid | approved | optional | low | established |  | Application sends email over SMTP for notifications or message-based delivery between systems. TLS is negotiated per connection. |
| `email_imap` | green, dashed | approved | optional | low | established | `email_microsoft_graph_api` | Application retrieves or monitors mailbox content over IMAP, often to ingest inbound mail. Approved; mail APIs such as Microsoft Graph preferred. |
| `email_microsoft_graph_api` | green, solid | approved | enforced | low | modern |  | Cloud-native access to Microsoft 365 mail and calendars through Graph REST endpoints and change notifications, using OAuth. |
| `email_gmail_api` | green, solid | approved | enforced | low | modern |  | Access to Google Workspace mailboxes through the Gmail REST API, using OAuth token-based authentication. |
| `email_pop3` | amber, dashed | deprecated | optional | medium | legacy | `email_microsoft_graph_api` | Batch download of email over POP3, typically removing messages from the server after retrieval. Deprecated; use a mail API. |
| `esb_jms_or_mq_messaging` | green, solid | approved | optional | low | established |  | Asynchronous, guaranteed message delivery through the ESB over JMS or IBM MQ queues and topics. |
| `esb_soap_web_services` | green, dashed | approved | optional | medium | legacy | `esb_rest_apis` | Contract-driven SOAP web services mediated by the ESB. Approved for existing integrations; ESB REST preferred for new work. |
| `esb_rest_apis` | green, solid | approved | optional | low | modern |  | RESTful endpoints mediated by the ESB for routing, transformation, and policy enforcement. |
| `esb_proprietary_adapters` | amber, solid | requires_approval | optional | medium | legacy |  | Vendor-specific ESB connectors to back-end platforms such as SAP IDoc or Oracle EBS. Requires approval due to licensing and lock-in. |
| `esb_data_and_file_integration` | green, solid | approved | optional | low | established |  | Batch file polling, transformation, and delivery performed on the ESB. |
| `esb_orchestration_and_bpel` | green, solid | approved | optional | medium | legacy |  | Multi-step process orchestration executed within the ESB runtime, typically defined in BPEL. |
| `file_transfer_cloud_storage_buckets` | green, solid | approved | enforced | low | modern |  | File exchange through cloud object storage such as AWS S3 or Azure Blob, using API calls over HTTPS. |
| `file_transfer_ftp` | red, solid | prohibited | none | high | legacy | `file_transfer_sftp` | Unencrypted FTP file transfer with clear-text credentials. Prohibited; use SFTP or MFT. |
| `file_transfer_https` | green, dashed | approved | enforced | low | modern | `file_transfer_mft` | File upload or download over HTTPS web endpoints. Approved; MFT preferred for scheduled or audited transfers. |
| `file_transfer_mft` | green, solid | approved | enforced | low | modern |  | Managed File Transfer platform providing encrypted delivery, scheduling, auditing, and guaranteed transfer. Standard for file exchange. |
| `file_transfer_scp` | green, dashed | approved | enforced | low | established | `file_transfer_sftp` | Point-to-point file copy over SSH using SCP. Approved; SFTP preferred. |
| `file_transfer_sftp` | green, solid | approved | enforced | low | established |  | Encrypted file exchange over SSH with directory access controls. Standard for point-to-point transfers. |
| `forward_proxy_https_rest` | amber, solid | requires_approval | enforced | low | modern |  | Outbound REST calls over HTTPS routed through the forward proxy for filtering and inspection before reaching external services. Requires approval. |
| `forward_proxy_https_soap` | amber, dashed | requires_approval | enforced | medium | legacy | `forward_proxy_https_rest` | Outbound SOAP calls over HTTPS routed through the forward proxy. Requires approval; REST preferred. |
| `forward_proxy_grpc_and_http2` | amber, dashed | requires_approval | enforced | medium | modern | `forward_proxy_https_rest` | Outbound gRPC calls over HTTP/2 routed through the forward proxy, with limited inspection support. Requires approval; REST preferred. |
| `forward_proxy_graphql` | amber, dashed | requires_approval | enforced | medium | modern | `forward_proxy_https_rest` | Outbound GraphQL queries routed through the forward proxy. Requires approval; REST preferred. |
| `forward_proxy_tcp_or_udp_tunneling` | red, solid | prohibited | optional | high | legacy |  | Non-HTTP socket traffic tunneled through the forward proxy with CONNECT, bypassing content inspection. Prohibited. |
| `message_broker_amqp` | green, solid | approved | optional | low | established |  | Asynchronous messaging through the broker over AMQP queues and exchanges with acknowledged, reliable delivery. Standard messaging protocol. |
| `message_broker_kafka_protocol` | green, solid | approved | optional | low | modern |  | High-throughput event streaming through Kafka topics with durable, partition-ordered, replayable logs. |
| `message_broker_mqtt` | green, solid | approved | optional | low | modern |  | Lightweight publish/subscribe messaging over MQTT, suited to IoT devices and constrained networks. |
| `message_broker_jms` | green, dashed | approved | optional | low | established | `message_broker_amqp` | Java-based messaging through the broker using the JMS API. Approved; AMQP preferred for cross-platform interoperability. |
| `message_broker_stomp` | green, dashed | approved | optional | low | established | `message_broker_amqp` | Simple text-based messaging through the broker using STOMP. Approved; AMQP preferred. |
| `message_broker_http_webhook` | green, solid | approved | optional | low | modern |  | Broker delivers messages to, or accepts messages from, applications through HTTP webhook callbacks. |
| `reverse_proxy_https_rest` | amber, solid | requires_approval | enforced | low | modern |  | Inbound REST calls over HTTPS through the reverse proxy for routing, load balancing, and TLS termination. Requires approval. |
| `reverse_proxy_https_soap` | amber, dashed | requires_approval | enforced | medium | legacy | `reverse_proxy_https_rest` | Inbound SOAP calls over HTTPS through the reverse proxy. Requires approval; REST preferred. |
| `reverse_proxy_grpc_and_http2` | amber, dashed | requires_approval | enforced | medium | modern | `reverse_proxy_https_rest` | Inbound gRPC calls over HTTP/2 through the reverse proxy. Requires approval; REST preferred. |
| `reverse_proxy_graphql` | amber, dashed | requires_approval | enforced | medium | modern | `reverse_proxy_https_rest` | Inbound GraphQL queries through the reverse proxy. Requires approval; REST preferred. |
| `reverse_proxy_tcp_or_udp_tunneling` | amber, solid | requires_approval | optional | high | established |  | Inbound non-HTTP TCP or UDP streams forwarded by the reverse proxy at the transport layer. Requires approval. |
| `telephony_cpaas_api` | green, solid | approved | enforced | low | modern |  | Programmable cloud communications, such as SMS or voice, through a CPaaS provider API such as Twilio. |
| `telephony_sip_trunk` | green, solid | approved | optional | low | established |  | IP-based voice connectivity to carriers or PBX systems over SIP trunks. Standard for voice routing. |
| `telephony_webrtc` | green, solid | approved | enforced | low | modern |  | Real-time browser-based audio and video over encrypted peer-to-peer WebRTC media streams. |
| `telephony_cti_dialer` | green, solid | approved | optional | low | established |  | Computer telephony integration linking applications to softphones or contact center dialers for call control and screen pops. |
| `telephony_pstn_legacy` | amber, dashed | deprecated | none | medium | legacy | `telephony_sip_trunk` | Analog lines, TDM circuits, or switches requiring on-premises gateway hardware. Deprecated; migrate to SIP trunking. |

## Application-to-data-store edge styles

Each operation has a *gets_from* style and a *sends_to* style. The table shows the pair together: the *gets_from* operation is listed first, and a second value appears only where the *sends_to* operation differs. In the alternative column, `*_x` means the matching `gets_from_x` / `sends_to_x` style.

| Via (operation) | Styles | Line | Status | Operation (gets / sends) | Encryption | Risk | Preferred alternative |
|---|---|---|---|---|---|---|---|
| Data Loader | `gets_from_data_loader`, `sends_to_data_loader` | green, solid | approved | read / write | optional | low |  |
| JDBC | `gets_from_jdbc`, `sends_to_jdbc` | green, solid | approved | read / write | optional | low |  |
| ODBC | `gets_from_odbc`, `sends_to_odbc` | amber, dashed | requires_approval | read / write | optional | low | `*_jdbc` |
| SQL Delete | `gets_from_sql_delete`, `sends_to_sql_delete` | green, solid | approved | delete | optional | medium |  |
| SQL Insert | `gets_from_sql_insert`, `sends_to_sql_insert` | green, solid | approved | write | optional | medium |  |
| SQL Select | `gets_from_sql_select`, `sends_to_sql_select` | green, solid | approved | read | optional | low |  |
| SQL Update | `gets_from_sql_update`, `sends_to_sql_update` | green, solid | approved | write | optional | medium |  |
| Stored Procedure | `gets_from_stored_procedure`, `sends_to_stored_procedure` | amber, solid | requires_approval | execute | optional | medium |  |
| CDC and Replication | `gets_from_cdc_and_replication`, `sends_to_cdc_and_replication` | green, solid | approved | read / write | optional | low |  |
| HTTP Data API | `gets_from_http_data_api`, `sends_to_http_data_api` | green, solid | approved | read / write | enforced | low |  |
| Active Directory | `gets_from_active_directory`, `sends_to_active_directory` | green, dashed | approved | read / write | optional | low | `*_cloud_identity_provider` |
| LDAP | `gets_from_ldap`, `sends_to_ldap` | amber, solid | requires_approval | read / write | optional | low |  |
| Cloud Identity Provider | `gets_from_cloud_identity_provider`, `sends_to_cloud_identity_provider` | green, solid | approved | read / write | enforced | low |  |
| SCIM | `gets_from_scim`, `sends_to_scim` | green, solid | approved | read / write | enforced | low |  |
| Read | `gets_from_read`, `sends_to_read` | green, solid | approved | read | not_applicable | low |  |
| Write | `gets_from_write`, `sends_to_write` | green, solid | approved | read / write | not_applicable | low |  |
| Append | `gets_from_append`, `sends_to_append` | green, solid | approved | read / write | not_applicable | low |  |
| Execute | `gets_from_execute`, `sends_to_execute` | amber, solid | requires_approval | execute | not_applicable | high |  |
| Delete | `gets_from_delete`, `sends_to_delete` | green, solid | approved | delete | not_applicable | medium |  |
| Enqueue | `gets_from_enqueue`, `sends_to_enqueue` | green, solid | approved | read / write | optional | low |  |
| Dequeue | `gets_from_dequeue`, `sends_to_dequeue` | green, solid | approved | consume | optional | low |  |
| Peek | `gets_from_peek`, `sends_to_peek` | green, solid | approved | read | optional | low |  |
| Ack | `gets_from_ack`, `sends_to_ack` | green, solid | approved | read / delete | optional | low |  |
| Clone | `gets_from_clone`, `sends_to_clone` | green, solid | approved | read / write | enforced | low |  |
| Pull | `gets_from_pull`, `sends_to_pull` | green, solid | approved | read / write | optional | low |  |
| Fetch | `gets_from_fetch`, `sends_to_fetch` | green, solid | approved | read | optional | low |  |
| Commit | `gets_from_commit`, `sends_to_commit` | green, solid | approved | read / write | optional | low |  |
| Push | `gets_from_push`, `sends_to_push` | green, solid | approved | read / write | optional | low |  |
| Merge | `gets_from_merge`, `sends_to_merge` | green, solid | approved | read / write | optional | low |  |

<details>
<summary>Data store edge descriptions (tooltip text)</summary>

| Style | Description |
|---|---|
| `gets_from_active_directory` | Application reads identities, groups, or attributes from on-premises Active Directory. Approved; cloud identity provider preferred. |
| `gets_from_cloud_identity_provider` | Application reads identities, groups, or attributes from a cloud identity provider such as Okta or Microsoft Entra ID. |
| `gets_from_scim` | Application receives user and group provisioning updates from an identity provider through SCIM. |
| `gets_from_commit` | Application reads committed, finalized transaction data from the data store. |
| `gets_from_data_loader` | Application receives bulk data unloaded or staged by a data loader. |
| `gets_from_dequeue` | Application removes and consumes the next message or task from a queue. |
| `gets_from_enqueue` | Application reads items newly placed in a queue. |
| `gets_from_peek` | Application browses queue messages without removing them or altering queue state. |
| `gets_from_ack` | Application receives acknowledgments confirming a message was processed, completing a distributed transaction step. |
| `gets_from_fetch` | Application retrieves data from the data store with a direct fetch or lookup. |
| `gets_from_jdbc` | Application reads database records with SQL over a JDBC connection. |
| `gets_from_ldap` | Application reads directory entries with LDAP queries. Requires approval. |
| `gets_from_merge` | Application reads merged or consolidated results from the data store. |
| `gets_from_odbc` | Application reads database records with SQL over an ODBC connection. Requires approval; JDBC preferred. |
| `gets_from_clone` | Application downloads a full copy of a code repository, including its history. |
| `gets_from_pull` | Application pulls data or changes from the store on demand rather than receiving pushed updates. |
| `gets_from_push` | Application receives data or changes pushed to it by the store. |
| `gets_from_read` | Application reads file content from a file system or folder. |
| `gets_from_append` | Application reads records appended to a file, such as tailing a rolling log, or picks up files dropped into a folder. |
| `gets_from_delete` | Application receives the results of file or directory delete and rename operations. |
| `gets_from_execute` | Application receives output from scripts or binaries launched from a file system location. Requires approval. |
| `gets_from_sql_delete` | Application receives the results of SQL DELETE statements, such as affected row counts. |
| `gets_from_sql_insert` | Application receives the results of SQL INSERT statements, such as generated keys or row counts. |
| `gets_from_sql_select` | Application retrieves records from database tables with SQL SELECT queries. |
| `gets_from_sql_update` | Application receives the results of SQL UPDATE statements, such as modified values or row counts. |
| `gets_from_stored_procedure` | Application receives results from a database stored procedure. Requires approval to limit business logic in the database. |
| `gets_from_cdc_and_replication` | Application receives a continuous stream of changes captured from a database transaction log through CDC or replication. |
| `gets_from_http_data_api` | Application reads from a cloud database through a driverless HTTPS data API. |
| `gets_from_write` | Application reads back data it previously wrote, such as to verify persisted content. |
| `sends_to_active_directory` | Application creates or updates identities, groups, or attributes in on-premises Active Directory. Approved; cloud identity provider preferred. |
| `sends_to_cloud_identity_provider` | Application creates or updates identities, groups, or attributes in a cloud identity provider such as Okta or Microsoft Entra ID. |
| `sends_to_scim` | Application pushes user and group provisioning changes to a target system through SCIM. |
| `sends_to_commit` | Application commits a transaction, making its changes durable in the data store. |
| `sends_to_data_loader` | Application sends data to a data loader for staging or bulk ingestion. |
| `sends_to_cdc_and_replication` | Application database changes are captured from the transaction log and replicated continuously to a target store. |
| `sends_to_http_data_api` | Application writes to a cloud database through a driverless HTTPS data API. |
| `sends_to_dequeue` | Application removes a processed item from a queue. |
| `sends_to_enqueue` | Application places messages or tasks on a queue for asynchronous processing. |
| `sends_to_peek` | Application issues a peek request to inspect queue messages without removing them. |
| `sends_to_ack` | Application acknowledges a processed message so the queue can release it, completing a distributed transaction step. |
| `sends_to_fetch` | Application submits a fetch request or lookup parameters to the data store. |
| `sends_to_jdbc` | Application writes or updates database records with SQL over a JDBC connection. |
| `sends_to_ldap` | Application creates or modifies directory entries with LDAP operations. Requires approval. |
| `sends_to_merge` | Application sends data to be merged or consolidated in the data store. |
| `sends_to_odbc` | Application writes or updates database records with SQL over an ODBC connection. Requires approval; JDBC preferred. |
| `sends_to_clone` | Application initiates a clone of a code repository, such as mirroring or forking it to a new location. |
| `sends_to_pull` | Application stages data for the store to pull on its own schedule. |
| `sends_to_push` | Application pushes data or changes to the store, such as a push to a remote repository. |
| `sends_to_read` | Application issues a read request against a file or folder. |
| `sends_to_sql_delete` | Application removes database records with SQL DELETE statements. |
| `sends_to_sql_insert` | Application adds database records with SQL INSERT statements. |
| `sends_to_sql_select` | Application issues SQL SELECT queries to retrieve records. |
| `sends_to_sql_update` | Application modifies existing database records with SQL UPDATE statements. |
| `sends_to_stored_procedure` | Application invokes a database stored procedure with input parameters. Requires approval to limit business logic in the database. |
| `sends_to_write` | Application writes or overwrites file content in a file system or folder. |
| `sends_to_append` | Application appends records to the end of a file, such as a rolling log, or drops files into a folder. |
| `sends_to_delete` | Application deletes or renames files or directories. |
| `sends_to_execute` | Application launches scripts or binaries from a file system location. Requires approval. |

</details>

## Utility styles

| Style | Purpose |
|---|---|
| `transparent_edge` | An invisible edge used only for layout. It is excluded from the review. |
| `legend node`, `legend native` | Render the diagram legend. |
| `title block node`, `title block native` | Render the title block. |
| `page_border_begin` / `_end` | Page border cluster with the diagram heading. |
| `boundary_1_begin` / `_end` | Outer trust zone (grey fill). |
| `boundary_2_begin` / `_end` | Inner zone (white fill). |

