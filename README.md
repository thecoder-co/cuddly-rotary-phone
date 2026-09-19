# QarrTrack

QarrTrack is a local-first Flutter tracker for meals, workouts, and medications. Spending and Mood are visible only as **Coming soon** until those modules have a complete product and acceptance pass.

## Current feature set

- Meal templates and daily meal logging, including components, macros, images, and offline sync.
- Workout programs, exercises, sets, history, and a rest timer.
- Medication schedules, dose history, supply adjustments, recurrence, and local reminder actions.
- Branded splash and introduction, email OTP sign-in, and an anonymous account option.

Guest accounts are real server-backed accounts. They persist on this device through their stored credentials; linking an email is required for recovery after reinstalling or on another device. A guest-to-email upgrade keeps the same account ID and data.

## Local data and sync

Credentials are migrated from legacy preferences to platform-secure storage. Tracking data is opened in an account-scoped Isar database, and pending medication operations are durable and account-bound. Existing legacy meals or workout sets that have no demonstrable owner are intentionally retained for review rather than assigned to whichever account signs in first.

Sync is triggered at module entry, on local changes, and on app resume. It does not claim to run after the operating system terminates the app.

## Setup

```bash
flutter pub get
flutter run
```

The development API defaults to `http://localhost:3000` on iOS and desktop and `http://10.0.2.2:3000` on an Android emulator. Configure a live build through `AppEndpoints` deliberately; TLS certificate validation is enabled.

The paired API repository is `../qarr-tracker`. Run its build before changing authentication contracts:

```bash
cd ../qarr-tracker
npm run build
```

## Verification

```bash
flutter analyze
flutter test test/features/medications test/widget_test.dart
```

These checks do not exercise real OTP delivery, a production database migration, or device notification delivery. Release work must also verify Android/iOS splash transitions, notification permissions/actions, account switching, offline recovery, signing, and the intended API environment.

## License

Licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/).
