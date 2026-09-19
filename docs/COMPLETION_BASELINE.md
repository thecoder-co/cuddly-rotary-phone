# QarrTrack completion baseline

Recorded 6 September 2026 before and during execution of the completion plan.

## Source revisions

| Repository | Revision | Baseline working-tree state |
|---|---:|---|
| Flutter (`cuddly-rotary-phone`) | `481adce` | Existing uncommitted medication, notification, Android and iOS changes are intentionally preserved. |
| NestJS (`qarr-tracker`) | `7d37d9e` | Existing uncommitted medication schema/module/migration/test work is intentionally preserved. |

## Implemented in this execution

- Session bootstrap, secure credential migration, guest account state, explicit retry/recovery, and serialized refresh.
- Account-scoped local tracking databases, preserving legacy records whose owner cannot be proved for deliberate reconciliation.
- Branded native/Flutter launch transition, responsive four-page introduction, account choices, guest creation, and guest email linking.
- Protected backend guest-link endpoint, normalized identity inputs, cryptographically generated OTPs, and one refresh-token issuance policy.
- Notification payload account binding, secure TLS defaults, and public-auth requests without inherited bearer headers.

## Acceptance evidence

| Check | Result | Boundary |
|---|---|---|
| `flutter analyze` | No analyzer errors; existing checkout has 538 lint/info findings. | Static analysis only. |
| `flutter test test/features/medications` | Passed (41 tests). | Existing medication recurrence, sync, notification and UI coverage. |
| `flutter test test/widget_test.dart` | Passed. | New-install signed-out routing renders the introduction actions. |
| `npm run build` in `qarr-tracker` | Passed. | NestJS compilation only; no database migration or mail delivery was invoked. |

## Deliberate verification limits

- No live auth endpoint, OTP mail, database migration, anonymous-account creation, or device notification was exercised.
- The supplied Stitch screenshots establish the visual family, but their downloadable source imagery is not present in this checkout. The introduction therefore uses local semantic icon illustrations and a derived QARRTRACK wordmark treatment; it needs screenshot comparison against the approved export before release.
- Spending and Mood remain explicitly marked **Coming soon**. Their proposed product rules in the completion plan need a separate implementation stream and acceptance pass before a full-product release.
