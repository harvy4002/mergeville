\newpage
# Security & Privacy Architecture

This document maps the security posture of the SDK based on static analysis of its components and manifests.

## Required Permissions

{{AI_FILL: Generate a list of all permissions needed to run this SDK. For each, provide a brief explanation of *why* the codebase requires it. }}

## Data at Rest

* **Encryption implementation:** {{AI_FILL: Look for usages of cryptographic libraries usages. Describe how sensitive data on disk is protected. If plain text `SharedPreferences` is used, note it here.}}

{{AI FILL: if required, provide a sequence diagram of any data that goes through a cryptographic process or is stored as part of the SDK.}}

## Data in Transit

* **Network Security Configuration:** {{AI_FILL: Check for `res/xml/network_security_config.xml`. Does it explicitly disable cleartext traffic? Does it implement certificate pinning?}}
* **TLS Enforcements:** {{AI_FILL: Analyze OkHttp/Ktor configurations for custom `ConnectionSpec` or explicit TLS versions forced.}}

## Obfuscation & Minification

To protect intellectual property and minimize SDK size in the host app:

{{AI_FILL: Describe minification or obuscation techniques used (e.g. Proguard/R8, .Net Reactor etc. )}}

## Information security profile

{{AI_FILL: Create a table of potential PII usage. Using the following table as a format guide: 

| Entity | PII Risk | Mitigation                                          |
|:-------|:---------|:----------------------------------------------------|
| <Entity name> | <PII Risk>      | <Mitigation>                          |
}}
