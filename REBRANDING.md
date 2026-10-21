# Rebranding: Removal of "SAP BTP" Terminology

This document tracks the rebranding effort to remove "SAP BTP" and related terms from the repository.

## Scope

- **In scope**: All `.md` files in the repository.
- **Out of scope (flagged for later review)**: `.yml`, `.yaml`, `.json`, `.txt`, `.html`, and other non-markdown files.

---

## Removal Rules Applied

Rules were applied in order of specificity (most specific first) across all 157 `.md` files.

| # | Pattern | Action | Example |
|---|---------|--------|---------|
| 1 | `SAP Business Technology Platform (SAP BTP)` | Removed entire compound (with optional trailing comma) | `services of SAP Business Technology Platform (SAP BTP), which` → `services, which` |
| 2 | `SAP Business Technology Platform` | Removed the string | `# Deploy to SAP Business Technology Platform` → `# Deploy to` |
| 3 | `SAP BTP, Cloud Foundry Runtime` | Removed `SAP BTP, ` — kept runtime name | `Deploy in SAP BTP, Cloud Foundry Runtime` → `Deploy in Cloud Foundry Runtime` |
| 4 | `SAP BTP, Kyma Runtime` | Removed `SAP BTP, ` — kept runtime name | `Deploy in SAP BTP, Kyma Runtime` → `Deploy in Kyma Runtime` |
| 5 | `SAP BTP` (all remaining forms) | Removed the string | `developing on SAP BTP.` → `developing on.` |

**Result**: 0 occurrences of `SAP Business Technology Platform` or `SAP BTP` remain in `.md` files, except for the intentionally preserved `SAP BTP Developer's Guide` references. All references to that published guide retain its full proper name.

---

## Items Flagged for Manual Review

All flagged items have been resolved.

### 1. Colloquial "the BTP" — ✅ Fixed
- **File**: `documentation/observability/enable-sap-cloud-alm.md`, line 73
- **Before**: `These properties can be updated from the BTP cockpit using application environment variables.`
- **After**: `These properties can be updated from the cockpit using application environment variables.`

### 2. Residual from typo "SAP SAP Business Technology Platform" — ✅ No action needed
- **File**: `documentation/remote-service/s4hana-cloud-to-btp-connectivity/README.md`, line 16
- **Current line**: `To connect to an SAP S/4HANA Cloud system using service binding, you have to register the system in your account.`
- Resolved naturally by subsequent cleanup passes.

### 3. Product name: "SAP BTP Developer's Guide" — ✅ No action needed
- **Files**: `README.md` and 42 other occurrences across the repo.
- Decision: Keep as-is — this is a proper product name of a published guide.

---

## Out-of-Scope Files (Non-Markdown — Review Later)

The following file types contain occurrences of the target strings and should be reviewed separately:

| File type | Notes |
|-----------|-------|
| `.yml` / `.yaml` | CI/CD pipelines, configuration files |
| `.json` | Package files, metadata |
| `.html` | Any static HTML content |
| `.txt` | Plain text files |

---

## Leftover Artifact Cleanup (Pass 2)

After the initial removal, a second pass was applied to fix artifacts left behind in `.md` files.

### Fixes applied

| Type | Description | Files affected |
|------|-------------|---------------|
| Double spaces | Collapsed 2+ consecutive spaces between words into single space | 127 |
| Dangling `in .` / `on .` / `to .` | Removed orphaned prepositions before sentence-ending periods | ~20 lines, 14 files |
| `, Kyma runtime` / `, Cloud Foundry runtime` | Removed leading comma left by product-name removal (e.g. `in , Kyma runtime` → `in Kyma runtime`) | ~40 lines, 25+ files |
| Lines starting with `,` | Removed leading comma from sentence-starting fragments (e.g. `, Kyma runtime is a cloud-native...`) | 2 lines, 2 files |

### Sentence fixes by pattern

| Before | After | Occurrences |
|--------|-------|-------------|
| `...global account in .` | `...global account.` | 21 |
| `...global account in . Developers then...` | `...global account. Developers then...` | 3 |
| `enter your the email and password for your global account in .` | `enter your email and password for your global account.` | 1 |
| `enter the e-mail and password for your global account in .` | `enter the e-mail and password for your global account.` | 1 |
| `...in the same subaccount in .` | `...in the same subaccount.` | 2 |
| `...implementing a business application on .` | `...implementing a business application.` | 1 |
| `...build eventing logic in mock server and deploy it on .` | `...and deploy it.` | 1 |
| `...sent from your SAP S/4HANA Cloud system to .` | `...sent from your SAP S/4HANA Cloud system.` | 1 |
| `Before you deploy the application on , you can...` | `Before you deploy the application, you can...` | 1 |
| `...streamlines the application development process on .` | `...streamlines the application development process.` | 1 |
| `...with the most essential services and SDKs on .` | `...with the most essential services and SDKs.` | 1 |
| `...starting point for developing a business application on .` | `...starting point for developing a business application.` | 1 |
| `...what you should consider when working on development projects on .` | `...what you should consider when working on development projects.` | 1 |
| `, Kyma runtime is a cloud-native application runtime...` | `Kyma runtime is a cloud-native application runtime...` | 2 |
| `The files of the , Kyma runtime are provided...` | `The files of the Kyma runtime are provided...` | 1 |

---

## Change Summary

| Metric | Value |
|--------|-------|
| `.md` files changed (pass 1) | 157 |
| Lines changed (pass 1) | 617 |
| `.md` files changed (pass 2 cleanup) | ~140 |
| `SAP Business Technology Platform` remaining | 0 |
| `SAP BTP` remaining (excluding Developer's Guide) | 0 |
| `SAP BTP Developer's Guide` preserved | 42 occurrences |
| Items flagged for manual review | 3 |
