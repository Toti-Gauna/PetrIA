# 0006. Usage metering and quotas instead of billing

Status: Accepted (2026-11-20)

## Context
Version 2.0 planned billing: free and Pro plans, subscription plus per-query
usage, and idempotent payment webhooks (Mercado Pago or Stripe in test mode),
about 9 hours of work. Charging for a product built on data with an
unconfirmed license is not appropriate ([ADR-0005](0005-data-license-unconfirmed.md)),
and payments are not the skill this project is meant to show.

## Options
A. **Billing**: plans, subscriptions, payment webhooks.
B. **Usage metering and quotas per tenant** (chosen), about 3 hours.
C. **Nothing.**

## Decision
Option B. Record queries, tokens and cost per tenant using the cost traces
from version 1.1, enforce limits, and alert near the quota through
notification-service. Idempotent webhooks stay in notification-service for
the WhatsApp and Twilio callbacks.

## Consequences
+ Less scope, no payment compliance, and it builds on work we already do.
- No payment flow in the demo.
- Billing can be added later, with a new ADR, if the license allows it.
