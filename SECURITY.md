# Security

This toolkit is built on [Relationship Visualizer](https://exceltographviz.com). Two of its security topics apply here unchanged, and are covered in detail in [Relationship Visualizer's security guidance](https://github.com/jjlong150/ExcelToGraphviz):

- **The macro-enabled workbook.** `Relationship Visualizer.xlsm` runs VBA macros. Before you enable them, check the file, review the code and use your organization's macro settings.
- **Interactive SVG diagrams.** An SVG published with post-processing enabled contains JavaScript that adds pan, zoom and highlighting. Treat that file like a small web page, not a static image.

This page covers what is specific to this toolkit.

## Your architecture data is sensitive

A context diagram, and especially its knowledge graph, describes how your systems connect. That includes:
- the trust zones data passes through;
- which flows carry PII;
- which connections are unencrypted or unauthenticated;
- how failures are handled.

That is exactly what an attacker would want to know. So:

- **Treat the data workbooks, the JSON knowledge graph and the assessment report as confidential,** at the same classification as the most sensitive system they describe.
- **Check your organization's policy before sending a knowledge graph to an AI service.** Use an approved AI service. Where appropriate, choose one that does not keep your data or use it for training.
- **Anonymize before sharing publicly.** Replace real application names, IDs, owners and vendor products before you publish a diagram, open an issue, or ask for help.
- **Don't commit real data to a public fork.** The sample data in this repository is fictional.

## AI-generated assessments

The review prompt asks the AI to ground its findings in the data and to say where the data is too thin to be confident. Even so, an AI assessment can miss risks or overstate them. Use the report as input to a review by a qualified architect or security professional, not as a replacement for one.

## Reporting a vulnerability

If you find a security problem in the workbook's SQL, the styles or the prompt, report it privately rather than in a public issue. For example, a way for data-workbook content to inject instructions into the review prompt.

Use GitHub's **Report a vulnerability** button on the repository's **Security** tab. Please include steps to reproduce the problem.
