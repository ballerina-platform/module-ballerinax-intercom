# Changelog

All notable changes to the Ballerina Intercom connector are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **Connector package** (`ballerinax/intercom` v0.1.0) — full client for the Intercom REST API v2.15 covering Contacts, Conversations, Tickets, Articles, Tags, Companies, Admins, and Help Center operations.
- **Mock server module** (`intercom.mock.server`) — an in-process HTTP server that mirrors the live API, enabling fully offline unit tests.
- **Test suite** (`ballerina/tests/test.bal`) — 29 tests covering all major operations; runs against the mock server by default and against the live Intercom API when `isLiveServer = true` is set in `Config.toml`.
- **Four working examples** demonstrating real-world use cases:
  - `support-team-analytics` — authenticate, list admins, search open conversations, and count contacts.
  - `knowledge-base-management` — create, update, and delete Help Center articles.
  - `priority-ticket-escalation` — create a contact, raise a high-priority ticket, reply, and mark it as escalated.
  - `support-ticket-automation` — create a ticket, retrieve details, search open tickets, reply, and close.
- **Connector documentation** (`docs/connector/`):
  - `overview.md` — key features and actions overview.
  - `setup-guide.md` — step-by-step guide for creating an Intercom app, configuring permissions, obtaining an access token, and finding ticket type IDs.
  - `action-reference.md` — full operation reference with Ballerina code samples for all supported endpoints.
- **`Accept: application/json` header** — added as a default header on all 161 operations to satisfy Intercom's strict content-negotiation requirement.
- **Package keywords** in `Ballerina.toml`: `Area/Communication`, `Vendor/Intercom`, `Type/Connector`.

### Fixed

- `TicketReply.partType` — widened from `"note"|"comment"|"quick_reply"` to `string` to accommodate additional values (e.g. `"assignment"`) returned by the live API.
- `CursorPages.perPage` — changed from `int` to `int|string` to handle the live API returning `per_page` as a string.
- `CreateConversationRequestFrom.id` — removed `minLength`/`maxLength` constraints that caused validation failures for standard contact IDs.
- `CreateTicketRequest.ticketTypeId` — made optional in the type definition so the mock server HTTP payload binding succeeds (the field is still required by the live API and must be provided at call time).
- Removed stray `client.bal`, `types.bal`, and `utils.bal` files from the repository root; the canonical copies are under `ballerina/`.
