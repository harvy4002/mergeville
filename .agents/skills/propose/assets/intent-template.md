---
title: "Intent: {title}"
feature: ""
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# Intent: {title}

## Objective
[What is the overarching goal of this task? Why are we doing this? Define the "North Star" for this implementation.]

## Boundaries & Scope Constraints
[Define what is strictly out of bounds. List files, modules, or architectural layers that MUST NOT be modified or impacted.]
- **Untouchable:** [e.g., core auth logic, legacy database schema]
- **Scope Limits:** [e.g., only update the web dashboard, do not touch mobile APIs, MUST NOT create or implement any screens/views not explicitly defined in the mockups and spec]

## Technical Constraints
[List rigid technical requirements and limitations.]
- **Dependencies:** [e.g., must use React 18 primitives, no new external libraries]
- **Performance:** [e.g., must not increase bundle size by more than 5kb, API response must be < 200ms]
- **Compatibility:** [e.g., must support Node 16+, must be backwards compatible with v2 API]

## Data Definitions & Schemas
[Define any new or modified data models, database schemas, internal data structures, DTOs, or code types/interfaces required for the implementation.]

### Database Schema Changes
- **New Tables / Collections:** [Define table/collection name, columns/fields with types, primary/foreign keys, indexes, and constraints. Use SQL DDL or NoSQL schemas where applicable.]
- **Modified Tables / Collections:** [Define columns to add, modify, or drop, and outline any data migration requirements.]
- **Data Constraints:** [Define uniqueness, non-nullability, foreign keys, or check constraints.]

### Code Data Structures
- **Domain Models & Entities:** [Define classes, types, or interfaces representing core business entities (e.g., in TypeScript, Python, Swift, etc.).]
- **DTOs (Data Transfer Objects):** [Define the structures used to transfer data between subsystems or across the network API.]
- **Internal Data Flows & State Objects:** [Define UI state objects, configuration schemas, or data structures used for internal processing.]
- **Type/Schema Verification:** [Specify references to existing files containing types/interfaces that must align with these definitions.]

## API & Integration Contracts
[Define the API endpoints, input/output payload structures, and external/internal system integration contracts.]

### Endpoints (REST / RPC / GraphQL)
- **Endpoint Definitions:**
  | Method | Path / Operation | Description | Auth Required |
  | :--- | :--- | :--- | :--- |
  | `GET` | `/api/v1/resources` | List resources | Yes |
- **Headers & Query Parameters:** [Define required/optional HTTP headers and query params.]

### Payload Contracts
- **Request Payloads:** [Provide JSON schemas or example payloads for requests, highlighting required vs optional fields and types.]
  ```json
  {
    "field": "type"
  }
  ```
- **Response Payloads:** [Provide JSON schemas or example payloads for successful responses (e.g., 200 OK, 201 Created).]
  ```json
  {
    "id": "uuid"
  }
  ```
- **Error Responses:** [Specify the payload structure for expected error responses (e.g., 400 Bad Request, 404 Not Found, 422 Unprocessable Entity).]
  ```json
  {
    "error": "Reason"
  }
  ```

### Webhooks & Messaging
- **Publish/Subscribe Event Schemas:** [Define event names, topics, or message structures used in message brokers or event queues.]
- **Third-Party Integrations:** [Define request/response schemas for external webhook integrations (e.g., Stripe, Slack, etc.).]

## Validation Rules
[Business validation rules that MUST be strictly true for the implementation to be valid. Each should be phrased as an executable assertion that will be written into the codebase as a test during the `implement` skill.]

### Test Sets (Input/Output Rulesets)
[Specific input/output combinations that must be satisfied.]
- [Test Set 1: e.g., Given `status='active'`, the system must return a 200 response with `isActive=true`]

### Properties (Universally Quantifiable Predicates)
[Universal truths about the system's behavior or data.]
- [Property 1: e.g., For all generated user IDs, the ID must be a valid UUIDv4]

### Contracts (Preconditions, Invariants, Postconditions)
[State boundaries before, during, and after an operation.]
- [Contract 1: e.g., Precondition: Account balance >= withdrawal amount. Postcondition: Account balance = old balance - withdrawal amount]

## Measurable Success Criteria
[Specific, measurable metrics or boolean checks that define success.]
- [Criterion 1: e.g., The `validate()` function returns true for all legacy payloads]
- [Criterion 2: e.g., Lighthouse performance score remains above 90]
- [Criterion 3: e.g., Zero new linting or type-check warnings]

## Implementation Directives
[Specific instructions for the `implement` skill regarding how to validate this specific task.]
- [Directive 1: e.g., Run `npm run verify-integrity` after each task group]
- [Directive 2: e.g., Manually inspect the generated SQL for N+1 query patterns]
