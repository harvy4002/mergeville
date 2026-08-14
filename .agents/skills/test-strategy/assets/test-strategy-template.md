# {Project Name} — Test Strategy

## Overview

{A concise summary of the project testing goals, scope, and key integrations.}

## Test Environments & Access

- **Environments:** {e.g., Local, CI, Staging, Production}
- **Access Needs:** {e.g., API keys, test user credentials, VPN}
- **Data Management:** {How test data is created, isolated, and torn down}
- **CI/CD Integration:** {Brief overview of testing in the release pipeline}

## Testing Approach

| Level | Scope / Objective | Tools / Frameworks | Success Criteria | Responsibilities |
|---|---|---|---|---|
| **Unit** | Individual functions/components in isolation. | {e.g., Jest, Vitest} | {e.g., 80% coverage} | Devs |
| **Integration** | Interaction between components/modules. | {e.g., Supertest, MSW} | {e.g., All external APIs mocked} | Devs, QA |
| **Functional** | Feature verification against requirements. | {e.g., Playwright, Cypress} | {e.g., All acceptance criteria met} | QA, Devs |
| **End-to-End (E2E)** | Full user journeys, frontend to database. | {e.g., Playwright} | {e.g., Critical paths pass in CI} | QA |
| **Performance (API)** | Load, stress, and spike testing for APIs. | {e.g., k6, JMeter} | {e.g., <200ms latency @ 1k RPS} | QA, DevOps |
| **Performance (Web)** | Lighthouse scores, Web Vitals, bundle size. | {e.g., Lighthouse, PageSpeed} | {e.g., LCP < 2.5s, TBT < 200ms} | Devs, QA |
| **Security** | SAST, DAST, dependency scanning. | {e.g. OWASP, Snyk, SonarQube} | {e.g., 0 Critical/High vulns} | Sec, Devs |
| **Accessibility** | WCAG compliance, screen readers, keyboard. | {e.g., axe-core} | {e.g., WCAG 2.2 AA compliant} | QA, UX |

## Risk & Mitigation

| Risk | Mitigation |
|---|---|
| E2E test flakiness (async state) | Use state-based waits (e.g., `waitForSelector`), avoid `sleep()`. |
| Third-party API availability | Use contract testing (e.g., Pact) and reliable mocks. |
| Test data contamination | Use isolated test seeds and robust teardown logic. |
| {Add specific risk} | {Add mitigation} |

## Sign off

| Name | Role | Approved | Date |
|---|---|---|---|
| {Name} | Test Lead | [ ] | {YYYY-MM-DD} |
