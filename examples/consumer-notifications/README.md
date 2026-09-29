# Example: Consumer Notifications

This example follows one system through the whole toolkit: from the data workbook, to the diagram and knowledge graph, to the AI-written architecture assessment.

**The scenario.** Consumer Notifications is a homegrown service that emails consumers. It handles two use cases:
- **Credit decisions:** the Credit Application System notifies a consumer of a decision.
- **Marketing campaigns:** a Campaign Owner uploads a distribution list.

Requests are queued. On a timer, the service calls a SaaS marketing CRM through the forward proxy, and the CRM sends the email through a mail relay to the consumer's mailbox.

> [!IMPORTANT]
> **The sample data contains deliberate mistakes.** Erroneous and conflicting values were entered into the data workbook on purpose, to see whether the review would catch them and how it would report them. For example, some sensitive data stores have no encryption at rest, some failures are discarded without alerting, some classifications and PII flags contradict each other, and some attributes are filled in where they don't apply.
>
> Treat the report as a **v0.0 assessment**: the first pass an architect would receive before any design conversation. Its job is to surface risks, contradictions and missing information, so the architect knows which questions to take back to the team to clarify the design. The findings describe the test data, not a real system, and certainly not how anyone would design one.

## Files

| File | What it is |
|---|---|
| [`context-diagram.pdf`](context-diagram.pdf) | The context diagram, rendered by Relationship Visualizer |
| [`context-diagram.png`](context-diagram.png) | The same diagram as an image, for previews and slides |
| [`context-diagram.gv`](context-diagram.gv) | The Graphviz DOT source that Relationship Visualizer generated for the diagram |
| [`context-diagram.json`](context-diagram.json) | The RV-KGF knowledge graph, pretty-printed for reading |
| [`context-diagram-minified.json`](context-diagram-minified.json) | The same knowledge graph, minified. It contains identical content in about 30% fewer characters, which leaves more of an AI's context window for the review. |
| [`assessment-report.pdf`](assessment-report.pdf) | The architecture assessment, produced by Claude from the knowledge graph and the [review prompt](../../prompts/Architecture_Design_Review_Prompt.md) |

The data comes from the default [`Context Diagram Data.xlsx`](../../Context%20Diagram%20Data.xlsx) workbook in the repository root.

## What the report shows

The nine-page report follows the prompt's structure:
1. A scope check.
2. An architecture overview.
3. A component and relationship inventory, including the trust-zone hierarchy.
4. Ratings for seven architecture qualities.
5. A risk register, with a mitigation for each risk.
6. Assumptions and open questions.

A few things worth looking for:

- **Findings that come from combinations of facts,** rather than any single value. For example:
  - unauthenticated, optionally encrypted SMTP crossing the internet;
  - audit records that are discarded on failure with no alerting.
- **Contradictions called out rather than smoothed over.** For example, an application styled as open source but recorded with a commercial vendor product, and failure attributes on data stores where they don't apply.
- **Evidence for every finding.** Each one is marked as coming from instance data, a style default, or inference, so the architect can see what is known and what is assumed.
- **Positives, not just problems.** For example, TLS-enforced, proxied egress, and queue-based decoupling with a dead-letter queue.

## Why the diagram is a PDF

Relationship Visualizer can also publish an interactive SVG, with pan, zoom, filtering and highlighting. That file is not a good way to share a sample, for two reasons:
- it contains JavaScript;
- it only shows its icons when the `images/` folder is next to it.

The PDF opens anywhere and looks the same everywhere. To see the interactive version, run the example yourself (see [Running the toolkit](../../docs/user-guide.md#running-the-toolkit)) and publish it as SVG.

> [!NOTE]
> The report is an AI-generated review of fictional sample data. It demonstrates the kind of output the prompt produces. It is not an assessment of any real system, and it does not replace review by a qualified architect.
