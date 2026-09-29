# Architecture Design Review Prompt

You are acting as a senior Solution Architect performing an independent architecture review. I'm attaching a JSON knowledge graph in the **RV-KGF** format (Excel-to-Graphviz Relationship Visualizer export, schema at github.com/jjlong150/rv-kgf). It represents an Application Context Diagram.

## 1. Schema — read this first

The file has a top-level `styles` dictionary that is the authoritative schema for each style.
- Every node and edge carries a `style` key. Resolve it against `styles` to get that style's `type` (`node` / `edge` / `cluster`), `description`, and `properties`.
- Style properties describe what is inherently true of **every** node or edge of that type, never a specific instance.
- Use whatever keys actually appear. The vocabulary below explains the ones you are most likely to see.

## 2. Style property vocabulary

### 2.1 Node properties

| Key | Applies to | Values |
|---|---|---|
| `kind` | All nodes | `actor`, `app`, `datastore`, `annotation` |
| `subtype` | All nodes | Refines `kind` (e.g. `homegrown`, `cloud`, `queue`, `person`) |
| `code_ownership` | Apps | `internal`, `vendor`, `community`, `partner`, `mixed` |
| `operated_by` | Apps | `internal`, `vendor`, `partner` |
| `support_model` | Apps | Who supports the application |
| `structure`, `persistence`, `access_pattern`, `concurrency_model` | Data stores | Inherent traits of the data store type |
| `actor_role` | Actors | `human`, `automated`, `system` |

### 2.2 Edge properties

`status` describes the governance of the connection **pattern**, not of this specific integration:

| `status` | Meaning |
|---|---|
| `approved` | No objections |
| `requires_approval` | Permitted only with an explicit approval or exception |
| `under_review` | Architecture position not yet decided |
| `deprecated` | Permitted for existing use; migrate away |
| `prohibited` | Not permitted |

`encryption_in_transit` describes the protocol's encryption:

| `encryption_in_transit` | Meaning |
|---|---|
| `enforced` | The protocol always encrypts |
| `optional` | Depends on configuration (e.g. STARTTLS, LDAPS, TLS listeners) |
| `none` | Cleartext by design |
| `not_applicable` | Local file I/O |

Other edge keys:

- **`preferred_alternative`**: the name of another style that should be used instead.
  - That style is usually **not** in `styles`, because only styles in use are exported. Its absence is expected, not an export error.
  - Interpret the alternative from its self-describing name (e.g. `file_transfer_sftp` = SFTP via file transfer). Also use the governance note at the end of the current style's description (e.g. "Approved; SFTP preferred.").
- **`risk_level`** (`low` | `medium` | `high`): the inherent risk of the pattern.
- **`modernity`** (`modern` | `established` | `legacy`): the age of the technology.
- **`via`**: the integration path or intermediary. Values: `api_gateway`, `esb`, `forward_proxy`, `reverse_proxy`, `direct_network`, `message_broker`, `email`, `file_transfer`, `telephony`.
- **`protocol_type`**: the normalized protocol.
- **`transport`**: the network layer only. Values: `tcp`, `udp`, `tcp_udp`, `ssh`, `file_io`, `circuit`.
- **`directionality`**: `request_response` | `push` | `pull` | `push_pull` | `bidirectional`.
- **`reliable_delivery`**, **`ordered_delivery`**, **`real_time`**, **`synchronous`**: protocol characteristics.
- **Data store edges:** `interaction_type` (`gets` | `sends`) says which side initiates. `operation` (`read` | `write` | `delete` | `execute` | `consume`) says what happens to the data. The two can differ (e.g. `sends_to_sql_select` is a read).
- **Actor-to-application edges** carry no `status` or `risk_level`. Their color identifies the actor type, not governance, so infer nothing about approval from their absence.

> **Authentication is deliberately not a style property.** It comes only from instance-level data (e.g. `auth_mechanism`). Where that is missing, treat authentication as unknown.

## 3. Instance-level properties

An individual node or edge object may carry its **own** `properties` field (a sibling of `style`, `label`, etc.), holding per-instance facts from the source workbook.
- Per the published schema, this field is entirely **omitted** (not an empty object) whenever the source data was blank, so check for its presence.
- Its key names are chosen by the author. Expect keys such as: `data_classification`, `contains_pii`, `auth_mechanism`, `retry_strategy`, `failure_disposition`, `failure_alerting`, `approximate_volume`, `agreements_in_place`, `stability`, `criticality`, `hosting_model`, `regulatory_scope`, `end_of_support_date`, `redundancy_model`, `deployment_model`, `data_residency`, `retention_period`, `encryption_at_rest`, `backup_strategy`, `origin`, `population_scale`, `channel`.

`contains_pii`, `encryption_at_rest` and `agreements_in_place` are booleans (`true` / `false`). Other instance values are display text, as entered in the workbook (e.g. "Dead Letter Queue").

The three failure keys are independent:

| Key | Meaning |
|---|---|
| `retry_strategy` | How the caller retries |
| `failure_disposition` | What happens once retries are exhausted. `Unhandled` means handling is known to be missing; an absent key means unknown. |
| `failure_alerting` | Whether operations is notified |

On edges, these keys describe how the application handles failure. On data stores, they are expected **only for queues**, where they describe the broker's redelivery, dead-letter and monitoring behavior.

## 4. Instance vs. style precedence

Style and instance keys are designed to be mostly disjoint: style properties describe the type, and instance properties describe the specific integration or component. Apply these rules:

- **Same key at both levels** (e.g. `encryption_in_transit`): the instance value overrides the style default for that node or edge. Say so explicitly: "X overrides the style default of Y".
- **Instance key with no style-level counterpart**: an additional fact, not an override.
- **Related but different keys**: do not treat these as overrides or conflicts.
  - Instance `stability` (e.g. Deprecated) is the lifecycle of this integration. Style `status` (e.g. approved) is the governance of the pattern. Report both.
  - Instance `approximate_volume` is not a counterpart to any style key.
- **Format differences**: values may differ in format between levels ("On Premise" vs `on_prem`). Compare them by meaning, not by string.
- **No `properties` field at all**: everything about that node or edge comes from its style. Say so, and don't present a style-level default as a verified fact about that instance.

Ignore `debuglabel` fields entirely; they are diagnostic only, not architectural content. If any node has `defined: false`, note it separately as a tool-synthesized artifact rather than an author-modeled component (it will never carry `properties`).

## 5. Before anything else

In 2–3 sentences, tell me:

- how many real architectural nodes and edges you found after applying the exclusions below;
- whether any instance-level `properties` were present, and on which nodes/edges;
- anything that doesn't fit this description (in case the export format has changed).

## 6. Exclude from the architecture itself

These are diagram scaffolding, not components. Match style names without regard to case or separators ("Transparent Edge" = `transparent_edge`).

- **Clusters:** any node whose `type` is `cluster`. These are groupings or zones, not components; use them for boundary analysis instead (section 7).
- **Legend:** any node with style `legend node`. This is the diagram's rendered key.
- **Notes:** any node with style `note` (or style property `kind` = `annotation`). These are author annotations. Pull their text into *Assumptions & Open Questions* rather than treating them as components.
- **Transparent edges:** any edge with style `transparent edge`. These are layout-only, not real relationships.

## 7. Trust boundaries

Reconstruct the nesting of `cluster` fields into a zone hierarchy. Each node or cluster points to a parent cluster id, and clusters can nest inside clusters. For example: "Corporate Applications" vs "Internet", with inner zones like "Perimeter Network", "Cloud Service Provider", "Consumer's Home" and "Email Services".

For every edge, note whether it crosses zones, and give zone-crossing edges higher scrutiny in the security assessment.

- Styles do not carry boundary information. Infer boundary-crossing from the cluster hierarchy.
- Use `security_boundary_crossed` only when an instance provides it.
- A proxy style (`via` = `forward_proxy` / `reverse_proxy`) does not by itself mean that edge crosses a zone. Often only the next hop does.

## 8. Non-unique IDs

Edge `id` is conventionally `<source>-><target>`, and duplicates are expected and allowed by the schema (e.g. separate enqueue and dequeue edges between the same app and queue). Key each relationship by (source, target, style, label). Don't deduplicate edges that share an id or endpoint pair.

## 9. Required output

Produce the following sections, in order.

### 9.1 Architecture Overview

Write a plain-language narrative covering the system boundary, major components, external integrations, and primary data and control flows. Also include:

- a one-line technology portfolio summary: homegrown vs. vendor/cloud vs. open-source vs. partner, plus the share of edges using legacy or deprecated patterns;
- the diagram's provenance (source workbook, author, date), if present.

### 9.2 Component & Relationship Inventory

**Components table** (post-exclusions), with these columns:
- name;
- asset ID (instance-level if present, otherwise parsed from the label);
- resolved kind/subtype;
- zone/cluster;
- instance-level properties found.

**Relationships table**, with these columns:
- source and target;
- `via` / `protocol_type`;
- `encryption_in_transit` (resolved, noting any override);
- direction;
- zone crossing (yes/no);
- `status` (plus `preferred_alternative`, if any);
- instance-level properties found.

### 9.3 Architecture Assessment

Rate each attribute as **Strong / Adequate / Weak / Unclear**, with a 1–2 sentence rationale.
- Ground each rating first in properties, weighting instance-level values above style-level defaults.
- Fall back to structural inference (fan-in/out, cycles, centrality) only where no property applies.

Attributes:
- Security & trust boundaries
- Scalability
- Resilience & availability
- Coupling & complexity
- Data flow integrity
- Maintainability & technology diversity
- Observability & operability

### 9.4 Key Risks & Weaknesses

Table columns: ID, Weakness, Affected node(s)/edge(s), Evidence type (*Instance override / Instance fact / Style default / Inferred*), Severity, Rationale.

The following must appear by default:

- any edge whose resolved `status` is `prohibited`, `deprecated` or `under_review`, or whose resolved `risk_level` is `high`;
- any edge whose resolved `encryption_in_transit` is `none`;
- any edge whose resolved `encryption_in_transit` is `optional` and which also does one of the following (because the encryption is unverified):
  - crosses a zone boundary,
  - carries a `data_classification` above Internal,
  - has `contains_pii` = true;
- any edge whose instance `stability` is Deprecated;
- any node or edge whose `failure_disposition` is `Unhandled` or `Discard`;
- any application whose `end_of_support_date` is past or within 12 months.

Weigh combinations, not just single values. For example:

- `contains_pii` = true, on an edge whose style has `encryption_in_transit` = `optional`, with no `auth_mechanism`, is more severe than any one of those facts alone.
- `failure_disposition` = `Discard` or `Unhandled` combined with `failure_alerting` = `None` is silent data loss.

### 9.5 Proposed Mitigations

Table mapped 1:1 to risk IDs, with columns: Risk ID, Recommended mitigation, Priority (High/Medium/Low), Rough effort (Low/Medium/High), Rationale.

- Where the edge's style has a `preferred_alternative`, recommend that alternative by name, in plain language. If it happens to be defined in `styles`, cite its description; otherwise, do not invent its properties.
- Keep mitigations concrete and architectural, not generic advice.

### 9.6 Assumptions & Open Questions

Include:

- The text of every excluded note node.
- Data-collection gaps:
  - For each instance-level attribute that appears anywhere in the graph, count the nodes/edges of the same kind where it is missing (e.g. "`auth_mechanism` present on 4 of 6 app-to-app edges").
  - List nodes or edges with no instance-level properties at all.
  - On data stores, count the failure keys only against queues. Their absence on other data store types is expected, not a gap.
- Edges with `status` = `requires_approval`, as approvals to confirm, unless instance data shows an approval or exception.
- Edges where `encryption_in_transit` is `optional` with no instance override, as configurations to confirm (unless already listed as risks).
- Clarifying questions for the architecture team.

## 10. Formatting

- Use clear headers and tables.
- Keep prose tight, with no padding.
- Say plainly where graph sparsity limits confidence, rather than filling gaps with generic platitudes.
