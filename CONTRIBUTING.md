# Contributing

Thank you for your interest in improving this toolkit. Issues and pull requests are welcome.

## Reporting a problem

Open an issue and include:
- the Relationship Visualizer version you're using;
- what you expected to happen, and what happened instead;
- if the diagram or JSON is wrong, the relevant rows from your data workbook, anonymized.

Report security problems privately; see [SECURITY.md](SECURITY.md).

## Proposing a new connection style

New protocols and integration patterns are the most common contribution. Open an issue with the following, following the conventions in the [user guide](docs/user-guide.md#8-maintaining-the-style-set):

| Field | Example |
|---|---|
| Style name | `message_broker_nats` (built from the Via and Protocol values; see [How rows select styles](docs/user-guide.md#4-how-rows-select-styles)) |
| Description | One or two sentences, 255 characters at most, ending with a governance note if it isn't plain approved |
| Properties | Values from the [property reference](docs/user-guide.md#6-style-property-reference): `via`, `protocol_type`, `transport`, `directionality`, `encryption_in_transit`, `status`, `risk_level`, `modernity`, and `preferred_alternative` if one applies |
| Rationale | Why this pattern belongs in the shared set, and why you chose this status |

Remember that the governance decisions in the style set are demonstration choices. Proposals should describe the pattern accurately; they don't need to reflect any one organization's standards.

## Pull requests

Git can't show what changed inside `.xlsm` and `.xlsx` files, so the repository keeps text copies:

- **When you change a style:** update `Relationship Visualizer.xlsm` and `source/styles.csv` in the same pull request.
- **When you change a SQL query:** update the workbook and the matching file in `source/sql/`.
- **The style catalogue is generated:** don't edit `docs/style-catalogue.md` by hand; it is regenerated from the styles.
- **When you change the prompt:** keep `prompts/*.md` and `prompts/*.txt` in step.

Contributions are accepted under the project's [MIT License](LICENSE).
