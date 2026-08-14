\newpage
# Data Architecture & Flow

This document details how the SDK fetches, transforms, and persists data locally.

## Network Layer

- **HTTP Client:** {{AI_FILL: Identify the HTTP client library, if any (e.g., OkHttp, Ktor, Retrofit, HttpServiceClient, Spring).}}
- **Base URL(s):** {{AI_FILL: Extract hardcoded URLs or Base URL constants used in Http clients.}}
- **Interceptors/Middleware:** {{AI_FILL: Search for implementations of interceptors or middleware plugins. List them and briefly describe what they modify (e.g., Headers, Auth tokens, Logging).}}

## Storage & Caching

### Storage

{{AI_FILL: Search for local data storage. State what kind of data is stored here (e.g., session tokens, user preferences).}}

### Database and Data Entities

{{AI_FILL: Search for any database declarations If found, list the core entities/tables defined in the codebase, create an ERD of the database. If not found, state "No internal relational database is used."}}

### Caching Strategy

{{AI_FILL: Search for any data caching declarations. If found, list the objects that are cached and what strategy (e.g. Read through, Write through), eviction policy (e.g. TTL, Sliding Window)}}

## Background Tasks & Synchronization

For operations that must survive app termination or run periodically:

### Frameworks

{{AI_FILL: Search for implementations of `Worker` (WorkManager), `JobService` or any scheduled job manager.}}

### Registered Jobs

{{AI_FILL: List the specific background workers found and what triggers them (e.g., `SyncAnalyticsWorker` triggered on network availability).}}
