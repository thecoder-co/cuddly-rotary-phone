# QarrTrack project completion plan

Prepared 6 September 2026 from the current Flutter working tree, the local `qarr-tracker` NestJS backend, and the live QarrTrack Stitch project. This is an implementation backlog, not a claim that existing features have passed runtime acceptance tests. Existing uncommitted medication and platform changes are part of the baseline and must be preserved.

The first delivery milestone completes splash, introduction, anonymous access, and the account lifecycle around the existing Meals, Workouts, and Medications modules. Full product completion additionally includes Spending and Mood, which currently appear as “Coming soon”. Their detailed product rules and full feature designs are not established by the intro screens; the proposed scope below is a starting specification.

## 1. Verified baseline

| Area | Current evidence | Remaining work |
|---|---|---|
| Startup | `lib/main.dart` initializes storage and notifications, starts meal sync, and routes by token presence. `Home.initState` refreshes tokens afterward. | Centralize bootstrap, resolve session before cloud sync, display splash, handle failure and notification launches. |
| Introduction | `LocalData.isOnboarded` exists; the current router does not use it. No introduction feature exists in `lib/features`. | Build the Stitch introduction and persist completion. |
| Authentication | Flutter supports email registration, OTP login, and refresh. | Anonymous registration, explicit account type, nullable email, upgrade flow, reliable recovery. |
| Backend guest support | `/anonymous-register` creates a server user; `/create-user` accepts `anonymous_id`. | Client integration plus ownership verification and retry safety on the backend. |
| Local data | Medication data is partitioned by account. Meals and workouts use the shared Isar instance; some exercise queries filter ownership, but meal/program pending queues are not account-scoped. | Extend account isolation and migrate legacy data safely. |
| Tracking | Meals, workouts, medication screens/services and medication tests exist. | Acceptance testing, sync hardening, remaining screen/action gaps. |
| Spending/Mood | Home has inactive “Coming soon” cards; no corresponding feature modules or Prisma models were found. | New backend and Flutter implementations for full product completion. |
| Release quality | Counter-template widget test remains; native splash config references old assets/colors. Dio accepts invalid certificates. | Replace obsolete test, align branding, restore certificate validation, validate release builds. |

## 2. Design reference and implementation choices

Source: [QarrTrack in Stitch](https://stitch.withgoogle.com/projects/14944471736849264059), project `14944471736849264059`. This is the main QarrTrack project, distinct from the separate medication project.

| Screen/asset | Stitch screen ID | Intended use |
|---|---|---|
| `1.png` | `3514446499823535312` | Green QARRTRACK wordmark asset for splash branding. It is a square logo reference, not a separately specified full-screen splash layout. |
| Welcome to Qarrtrack (Updated) | `ee99ec24c8e84a6f9a6d2fe4d9a2807e` | Preferred welcome shell: pale green surface, headline, horizontal feature cards, Get Started, Sign In, Use Anonymously. |
| Welcome to Qarrtrack | `c1fd9e3fa6ea40959c0aba8ad2eef832` | Meal intro card, Skip control, pagination reference. |
| Onboarding: Workout Tracking | `7f2b4cb5f7884c2fbca085b6199a43d0` | Workout feature content and blue accent. |
| Onboarding: Spending Tracking | `172dcd7b96124441ae2d979dfe42e858` | Spending content and purple accent. |
| Onboarding: Mood Tracking | `a0b6f93c6aa64d4bb922b4996e055c6d` | Mood content and warm accent. |
| Welcome to Qarrtrack | `ea24a6ae9511488b9cd6133bfbba0d23` | Alternative overview explicitly marking Spending/Mood as Coming Soon. |

The downloaded screenshots were visually inspected. They contain inconsistent branding (“Pulse” on the workout screen), different headers, and stray icon/text artifacts on the mood screen. Normalize these to QarrTrack using the updated welcome shell. Preserve the feature imagery, card hierarchy, typography, color roles, and CTA hierarchy rather than reproducing generator artifacts.

Planned behavior: Get Started opens email registration; Sign In opens email login; Use Anonymously opens a short name-entry sheet and creates a guest account; Skip ends the introduction and presents the same account choices without creating an account. Swiping/dots control the feature pages independently of these account actions. These routing choices are implementation assumptions, since screenshots alone do not define navigation.

## 3. Backend authentication contract

Routes are relative to the configured API base URL; `src/main.ts` defines no global `/api` prefix (`/api` serves Swagger).

**Creating a regularised user:** pass the existing user's `anonymous_id` together with `email` and `name` to `POST /create-user`. This regularises the existing anonymous account while retaining its user ID and associated records. The endpoint attaches the email/name and sends an OTP; successful OTP verification through `POST /token` completes regularisation by changing the account type to `NORMAL`.

| Operation | Request | Current response/behavior |
|---|---|---|
| Create guest | `POST /anonymous-register`, JSON `{ "name": "Alex" }`, no token required | Creates a fresh `ANONYMOUS` user and returns `{ token: { accessToken, refreshToken }, user: { id, email, name, type }, settings }`; email is initially null. |
| Create a regularised user from an anonymous account | `POST /create-user`, JSON `{ "email": "alex@example.com", "name": "Alex", "anonymous_id": "<current-user-uuid>" }` | Updates the same user’s email/name and sends OTP; returns a message. Retains the anonymous user’s ID and associated records. Type becomes `NORMAL` after OTP verification. |
| Verify email | `POST /token`, JSON `{ "email": "alex@example.com", "otp": "123456" }` | Six-character OTP, currently generated as six digits and valid for ten minutes; successful verification sets type to `NORMAL`, clears OTP, and returns tokens, user, settings. |
| Email login/resend | `POST /send-login-otp`, JSON `{ "email": "alex@example.com" }` | Sends OTP for an existing email. |
| Restore session | `GET /token/refresh`, header `Authorization: Bearer <refreshToken>` | Validates the stored refresh token and returns the same session envelope. |

Important implementation details:

- Anonymous registration is server-backed and requires network access initially. It is not an offline-only guest mode or a reusable login-by-name endpoint.
- Every anonymous-register call creates another account. The current API has no idempotency key or recovery-by-installation contract.
- The backend rejects linking an email already owned by another user. No account-merge endpoint exists.
- `getTokensAndUser` currently issues 30-day access and 365-day refresh tokens. `refreshTokens` also creates an intermediate 1-day/30-day pair before calling that helper again. Consolidate this into one issuance policy; clients should use the returned token expiry rather than hardcoded durations.
- The current linking controller has no ownership guard: accepting `anonymous_id` alone is insufficient authorization. Fix this before exposing guest upgrade.
- Email/name are changed before mail delivery succeeds. Preserve resumability after delivery failure, and define pending-email behavior explicitly.

## 4. Itemised delivery backlog

### Phase 0 — Establish the completion baseline

- [ ] **0.1** Record Flutter/backend commit IDs and working-tree changes; preserve the in-progress medication implementation and native configuration.
- [ ] **0.2** Create a screen/action inventory across Meals, Workouts, Medications, Settings, and authentication, recording implemented, partial, placeholder, and unverified states.
- [ ] **0.3** Capture the Stitch IDs above, export the chosen imagery/logo, and document approved text, spacing, type styles, colors, and light/dark behavior.
- [ ] **0.4** Define two release boundaries: existing-module release with guest onboarding; full release with Spending and Mood. Keep unfinished modules labelled Coming Soon in the first release, including their intro pages.
- [ ] **0.5** Record baseline analysis/test results and configure disposable backend test accounts/data for later integration checks.

**Exit:** a reproducible baseline and traceable acceptance checklist, with existing failures distinguished from new regressions.

### Phase 1 — Make sessions and account storage reliable

Dependencies: Phase 0. Required before guest access ships.

- [ ] **1.1** Extend `UserResponseDto` with `UserType` (`ANONYMOUS`, `NORMAL`), nullable email, and explicit handling for unsupported/malformed values. Parse the returned settings using the existing profile/settings DTOs where compatible.
- [ ] **1.2** Introduce a single session repository/controller for bootstrapping, signed out, authenticated anonymous, authenticated normal, refreshing, and recoverable failure states. Keep introduction completion separate from account type.
- [ ] **1.3** Move access/refresh credentials to platform-secure storage. Migrate existing preference tokens once, verify the secure write before removing old values, and recover safely from partial migration or storage failure.
- [ ] **1.4** Persist user identity, type, and session coherently; announce account changes only after the account database and credentials are ready. Prevent navigation on partially saved sessions.
- [ ] **1.5** Extend account partitions to meals, programs, exercises, workout sets, cached analytics, settings, and upload queues. Deliberately distinguish shared exercise catalogue data from user-owned records.
- [ ] **1.6** Migrate legacy shared data only to its demonstrable owner/current account. Retain ambiguous records for explicit reconciliation; verify copied records before deleting originals. Preserve backend IDs and pending operations.
- [ ] **1.7** Add one refresh operation shared by concurrent callers. Serialize token rotation, handle 401 without refresh loops, and preserve cached account data on network/5xx failures.
- [ ] **1.8** Freeze/cancel account work during transitions; capture the account identity for in-flight requests so late responses cannot write into another user’s store.
- [ ] **1.9** Restore normal TLS validation in `bad_certificate_fixer.dart`; ensure public auth requests do not receive stale access headers and never log tokens/OTPs.

**Likely files:** `auth_dto.dart`, `auth_provider.dart`, `local_data.dart`, `isar_service.dart`, `api_client_config.dart`, feature local repositories/providers; new session controller and secure-storage adapter.

**Exit:** guest A → normal B → guest A cannot leak records or send queued writes under the wrong identity; failed refresh does not erase offline work.

### Phase 2 — Splash and startup routing

Dependencies: Phase 1 session interface; visual work can begin after Phase 0.

- [ ] **2.1** Create a native launch screen using the QARRTRACK wordmark and green brand background; adapt the square reference to launch-screen safe areas rather than stretching it.
- [ ] **2.2** Align Android launch resources, Android 12+ splash presentation, and iOS launch storyboard/assets. Correct the existing pale/blue configuration mismatch and verify logo legibility/cropping on each platform.
- [ ] **2.3** Build a matching Flutter splash/bootstrap view for initialization after the first frame; avoid an arbitrary forced delay and provide a recoverable error/retry state.
- [ ] **2.4** Replace `TokenRouter` with centralized routing: first-run signed-out → intro; returning signed-out → account choices; restored anonymous/normal session → Home.
- [ ] **2.5** Existing signed-in installs bypass first-run intro. Persist/version intro completion and never replay it merely because tokens refresh or the app resumes.
- [ ] **2.6** Move pre-session cloud work out of `main()`/`Home.initState`; initialize local resources first and release account-specific sync after session resolution.
- [ ] **2.7** Preserve cold-start medication notification payloads until session and navigator are ready; consume once and verify the target belongs to the active account.
- [ ] **2.8** Hide workout overlays on splash/auth screens and recover persisted workout state only for the active account.

**Proposed files:** `lib/features/onboarding/presentation/splash_screen.dart`, `lib/core/providers/bootstrap_provider.dart`, `main.dart`, Android/iOS launch resources.

**Exit:** clean install, upgrade, warm resume, slow initialization, offline restart, and notification launch reach the correct destination without a login/Home flash or indefinite spinner.

### Phase 3 — Stitch introduction screens

Dependencies: Phase 0 design inventory and Phase 2 routing.

- [ ] **3.1** Build a reusable responsive intro shell: QarrTrack header, hero copy, feature pager, indicators, and fixed account-action area with safe-area support.
- [ ] **3.2** Implement meal, workout, spending, and mood pages from the referenced screenshots; use the updated welcome shell consistently. Label unavailable modules Coming Soon until implemented.
- [ ] **3.3** Bundle logo, imagery, and necessary font assets locally so first-run UI renders offline; register assets in `pubspec.yaml`. Match source headline/body styles rather than inheriting unrelated app text styles.
- [ ] **3.4** Support swipe, dots, Skip, and all three CTAs with accessible labels and deterministic navigation; retain the selected page when cancelling an auth flow.
- [ ] **3.5** Persist completion only on deliberate skip/exit into an account flow; handle restart midway through intro consistently.
- [ ] **3.6** Adapt missing dark intro variants from established theme tokens and record them as derived designs. Test large text, small phones, landscape constraints, reduced motion, and screen readers.
- [ ] **3.7** If adding a medication intro card, specify its copy/layout as a new derived design; no dedicated medication intro screen was found in the inspected project.

**Proposed files:** `lib/features/onboarding/models/intro_page.dart`, `presentation/intro_screen.dart`, reusable intro widgets, bundled onboarding assets.

**Exit:** every visible CTA works; four feature pages match the selected design family and remain usable without network access or clipped content.

### Phase 4 — Anonymous registration and continued guest use

Dependencies: Phases 1–3; backend retry contract must be settled before enabling automatic retries.

- [ ] **4.1** Add `AnonymousRegisterDto(name)` and `AuthRepo.registerAnonymous`; accept trimmed, nonempty names, with a matching backend length/whitespace policy.
- [ ] **4.2** Add the guest name sheet, inline validation, loading state, disabled duplicate submission, timeout/offline feedback, and retry action.
- [ ] **4.3** Disable generic automatic retries for anonymous creation until server idempotency exists. Add a persisted client request ID and backend idempotency contract if transparent retry/recovery is required; define replay expiry and protect session responses.
- [ ] **4.4** On success, validate and save the full session, open the account partition, apply returned settings, mark intro complete, and clear the auth route stack before opening Home.
- [ ] **4.5** Show the supplied name and a Guest account label; do not render null/empty email as a broken profile field.
- [ ] **4.6** Enable the existing tracker endpoints with guest access tokens and verify backend ownership guards work when JWT email is null.
- [ ] **4.7** Restore the same anonymous account on relaunch via stored credentials. Refresh failure must never silently call anonymous-register and replace the account.
- [ ] **4.8** For a first launch offline, allow browsing intro and retrying creation. Once a session exists, permit local tracking offline with queued sync. A fully offline initial identity is a separate, currently unsupported backend contract.
- [ ] **4.9** Explain account persistence/recovery in the guest profile and before guest sign-out: recovery across reinstall/devices requires linking email; name alone cannot restore the account.

**Exit:** one successful guest action produces one persisted account; the same ID survives restart, refresh, offline work, and retryable failures.

### Phase 5 — Guest-to-email upgrade and account transitions

Dependencies: Phase 4 plus backend ownership fix.

- [ ] **5.1 Backend:** authenticate anonymous linking and bind the requested anonymous ID to the access-token subject. Preserve public normal registration, but require ownership on the linking branch (or introduce a dedicated protected linking endpoint).
- [ ] **5.2 Backend:** define/resume pending-email linking after send failure, normalize email consistently, enforce uniqueness under concurrent requests, and preserve anonymous access until verification succeeds.
- [ ] **5.3 Backend:** consolidate refresh issuance; distinguish invalid credentials from infrastructure failures; add bounded OTP issuance/verification protections and use appropriate random OTP generation.
- [ ] **5.4 Flutter:** show Link email/Create account in guest settings, prefill name, and send the active guest’s UUID through the verified linking contract.
- [ ] **5.5 Flutter:** reuse registration and OTP views with an explicit upgrade mode, resend/error states, and cancellation back to the existing guest session.
- [ ] **5.6 Flutter:** on OTP success update credentials/type/settings in place. Do not call `removeToken()` for a same-ID upgrade: its current side effects switch medication storage and cancel account reminders.
- [ ] **5.7** Preserve all meals, sets, medication schedules/history, pending writes, reminder preferences, and active timer state across same-ID upgrade.
- [ ] **5.8** Handle “Email already in use” without switching accounts or losing guest data. Offer normal sign-in with a clear separate-account transition; merging is unavailable and requires its own explicit backend design if desired.
- [ ] **5.9** Make sign-out/clear-local-data behavior account-scoped, retain or deliberately discard pending changes through clear UI, cancel the correct reminders, and invalidate stale providers.

**Exit:** guest → verified normal user retains the same ID and data; abandoned/failed OTP remains usable as guest; another account cannot be linked by supplying its UUID.

### Phase 6 — Complete and validate existing tracking modules

Dependencies: account isolation and stable authentication.

- [ ] **6.1 Meals:** verify template and log CRUD, nested components, image upload, calorie/macro overrides, unit/precision conversions, daily date selection, analytics totals, and custom budgets against backend DTOs. Correct actual mismatches found by these checks.
- [ ] **6.2 Workouts:** verify program/exercise CRUD, catalogue versus owned exercises, set recording/editing, units, comments, rest timer, resume behavior, history, and analytics. Audit whether `AnalyticsPlaceholderScreen` is reachable and replace/remove any unfinished route.
- [ ] **6.3 Medications:** validate the existing implementation rather than rebuilding it: add/edit flow, recurrence variants, timezone/date policies, pause/archive, scheduled and PRN doses, correction history, supply adjustments, reports, and settings.
- [ ] **6.4 Notifications:** verify scheduling/actions on devices, denied permissions, reboot/resume, timezone changes, repeated taps, app-terminated launches, privacy content, account changes, and coexistence with workout timers. Ensure actions are durably saved before sync.
- [ ] **6.5 Sync:** standardize triggers at module entry, app resume, and local changes; use foreground periodic checks for queued uploads only. Keep queues durable, account-scoped and idempotent with backoff, tombstones, visible failure state, and manual reconciliation.
- [ ] **6.6 Sync:** preserve parent/child ordering (programs → exercises/sets; meal components; medication schedules/actions), avoid marking incomplete responses synced, retain local images until upload is confirmed, and reject late responses from old accounts.
- [ ] **6.7 Settings/Home:** reconcile backend and local settings, test guest/normal profile display, theme behavior, navigation, empty/loading/error states, large text, and all visible controls.

**Exit:** all three modules pass an acceptance matrix for guest and normal accounts, online/offline operation, and account switching. App timers are not represented as running after OS termination.

### Phase 7 — Implement Spending for full product completion

Dependencies: Phase 6 shared storage/sync patterns. Proposed product scope; detailed module designs remain to be specified.

- [ ] **7.1** Specify expense/income types, categories, currency rules, entry date/timezone, budget period, edit/delete semantics, and manual-entry MVP behavior. Intro language about “automated” budgeting must match actual delivered behavior.
- [ ] **7.2 Backend:** add user-owned transactions, categories and budgets with Prisma migrations; validated CRUD, pagination/filtering, period summaries, account authorization, and idempotent mutation support.
- [ ] **7.3** Define exact monetary representation and currency-separated totals; avoid binary floating-point money and unspecified cross-currency aggregation.
- [ ] **7.4 Flutter:** add DTOs, account-scoped Isar models, local/cloud repositories, durable sync, providers, transaction form/list/detail, budget controls and analytics.
- [ ] **7.5** Specify consistent light/dark feature screens from the established design system, then implement responsive and accessible states.
- [ ] **7.6** Verify totals, month boundaries, currencies, corrections/deletions, offline duplicates, and guest-to-normal preservation; activate the Home card and update intro copy when complete.

**Exit:** users can record spending and inspect accurate budget progress without data loss or currency mixing.

### Phase 8 — Implement Mood for full product completion

Dependencies: Phase 6 shared storage/sync patterns. Proposed product scope; detailed module designs remain to be specified.

- [ ] **8.1** Specify mood scale, entries-per-day policy, timestamp/timezone, optional notes/tags, edit/delete rules, and trend aggregation.
- [ ] **8.2 Backend:** add user-owned mood entries, validated CRUD, filtered history, summaries, migrations, authorization, and idempotent sync.
- [ ] **8.3 Flutter:** implement account-scoped local models, DTOs, repositories, providers, mood entry, history/calendar, entry detail, and trends.
- [ ] **8.4** Specify and implement light/dark designs consistent with the intro, including empty/error states and accessible non-color-only mood labels.
- [ ] **8.5** Keep journal content out of logs; make any reminder opt-in and privacy-aware. Present trends as recorded data without inferring diagnoses.
- [ ] **8.6** Verify multiple entries/date boundaries, edits/deletes, offline conflict behavior, account isolation, and guest upgrade; activate Home and intro availability when complete.

**Exit:** users can record, revisit and understand their mood history with consistent persistence and privacy behavior.

### Phase 9 — Release acceptance and handover

- [ ] **9.1** Replace the counter-template test with bootstrap/auth routing tests using injected storage/session dependencies.
- [ ] **9.2** Add targeted unit/widget tests for DTOs, intro actions, refresh serialization, session migration, guest retry, same-ID upgrade, cross-account sync isolation, and deferred notification routing.
- [ ] **9.3** Add backend contract tests for anonymous creation, null email, ownership-protected linking, invalid/expired OTP, email conflicts, refresh behavior, and same-ID data preservation.
- [ ] **9.4** Run existing medication recurrence/shared-contract/sync/UI/notification tests and meaningful meal/workout integration scenarios; record failures and verification limits.
- [ ] **9.5** Perform screenshot comparisons for splash and every intro page on representative small/large devices, both themes and large text. Inspect native-to-Flutter launch transitions manually.
- [ ] **9.6** Exercise clean install, existing-user upgrade, lost network during guest creation, process death during session persistence, expired/revoked credentials, logout/login, and concurrent API failures.
- [ ] **9.7** Run static analysis, relevant tests, backend build/migration validation, and Android/iOS release builds against intended environments. Verify production identity/display name, icons, signing, notification capabilities, environment selection, and certificate checks.
- [ ] **9.8** Define and implement account deletion/data export behavior needed for the intended release, including guest eligibility, reauthentication, queued data and notification cleanup. Treat cloud deletion separately from the existing Clear Local Data action.
- [ ] **9.9** Update README from Calorie Tracker to the actual QarrTrack feature set; document setup, environments, anonymous lifecycle, migrations, limitations, and a reproducible release checklist.

**Exit:** milestone-specific acceptance is demonstrated on Android/iOS; no active screen advertises unfinished functionality; known limitations and release artifacts are documented.

## 5. Required acceptance scenarios

| Scenario | Expected result |
|---|---|
| New installation | Branded splash → intro → intentional account choice. |
| Existing signed-in installation | Session restored; no forced intro or record reassignment. |
| Anonymous registration with null email | Valid Guest profile, Home accessible, settings applied. |
| Repeated guest taps / uncertain network response | No concurrent client creation; backend idempotency or explicit unresolved-request handling prevents unsafe automatic replay. |
| Offline with no prior account | Intro usable; account creation explains connectivity requirement. |
| Offline with prior guest | Cached data and queued local changes retained; no replacement account. |
| Guest links unused email | OTP success returns the original UUID as NORMAL; all data/reminders survive. |
| Wrong/expired OTP or email send failure | Error is actionable; guest remains available and linking can resume. |
| Email belongs to another user | No implicit merge, account switch, or guest-data deletion. |
| Forged anonymous ID | Backend rejects linking without ownership. |
| Account switch while sync is running | Old work remains under old identity; no cross-account reads/writes. |
| Medication notification cold start | Bootstrap resolves active account, then opens/processes the intended payload once. |
| Reinstall or loss of anonymous credentials | No promise of name-based recovery; linked accounts recover through email. |
| Spending/Mood not shipped | Home and introduction clearly reflect Coming Soon status. |

## 6. Delivery order and completion definition

Execute Phase 0 → Phase 1 → Phases 2–3 → Phase 4 → Phase 5 → Phase 6 → Phase 9 for the existing-module release. Backend ownership/retry work can be prepared alongside splash and intro UI work. Phases 7 and 8 are independent feature streams after the shared foundation, followed by another Phase 9 acceptance pass for full completion.

Do not estimate a final release date until the baseline checks and Spending/Mood specifications are complete. The largest dependencies are account-data migration, backend linking/idempotency changes, device notification verification, and the two unbuilt modules.

Completion means implemented behavior plus passing acceptance evidence, not the presence of screens alone. This planning task changed no application/backend implementation and did not invoke auth endpoints, send OTPs, run test suites, or validate a deployed backend.

## 7. Source map

- Flutter startup/routing: `lib/main.dart`, `lib/features/home/presentation/home.dart`.
- Auth: `lib/features/auth/{models/auth_dto.dart,repo/auth_repo.dart,providers/auth_provider.dart,presentation/}`.
- Persistence: `lib/core/services/local_data/{local_data.dart,isar_service.dart}`, meal/workout/medication local repositories.
- API behavior: `lib/core/services/api_handler/{api_client_config.dart,app_endpoints.dart,bad_certificate_fixer.dart}`.
- Tracking: `lib/features/{meals,meals_home_page,workout,medications,user}/` and `test/features/medications/`.
- Backend root: `/Users/qarr-m2air/code/node/qarr-tracker`.
- Backend auth contract: `src/auth/auth.controller.ts`, `src/auth/auth.service.ts`, `src/auth/dto/auth.dto.ts`, `src/auth/guards/auth.guard.ts`.
- Backend identity/data model: `prisma/schema.prisma`; configuration: `src/main.ts`.
- Stitch screen references: Section 2; screenshots and available HTML inspected during planning.
