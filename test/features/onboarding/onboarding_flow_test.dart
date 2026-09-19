import 'package:calorie_tracker/core/providers/session_controller.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/core/services/session/session_state.dart';
import 'package:calorie_tracker/features/auth/models/auth_dto.dart';
import 'package:calorie_tracker/features/auth/providers/auth_provider.dart';
import 'package:calorie_tracker/features/auth/repo/auth_repo.dart';
import 'package:calorie_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _SignedOutSession extends SessionController {
  @override
  Future<SessionState> build() async =>
      SessionState.signedOut(onboardingComplete: LocalData.isOnboarded);
}

class _GuestAuthNotifier extends AuthNotifier {
  static String? failureMessage;
  static String? submittedName;

  @override
  AuthRepo build() => AuthRepo();

  @override
  Future<String?> registerAnonymous({
    required AnonymousRegisterDto model,
  }) async {
    submittedName = model.name;
    return failureMessage;
  }
}

void main() {
  setUp(() async {
    _GuestAuthNotifier.failureMessage = null;
    _GuestAuthNotifier.submittedName = null;
    SharedPreferences.setMockInitialValues({});
    LocalData.prefs = await SharedPreferences.getInstance();
  });

  Future<void> pumpSignedOutApp(
    WidgetTester tester, {
    bool onboarded = false,
    bool overrideGuestAuth = false,
  }) async {
    if (onboarded) {
      await LocalData.setOnboarded(true);
    }
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionProvider.overrideWith(_SignedOutSession.new),
          if (overrideGuestAuth)
            authProvider.overrideWith(_GuestAuthNotifier.new),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();
  }

  testWidgets('first launch renders the introduction and advances pages', (
    tester,
  ) async {
    await pumpSignedOutApp(tester);

    expect(find.text('Meals made simple'), findsOneWidget);
    await tester.drag(find.byType(PageView), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Make every workout count'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Use anonymously'), findsOneWidget);
  });

  testWidgets('Skip completes onboarding and shows account choices', (
    tester,
  ) async {
    await pumpSignedOutApp(tester);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(LocalData.isOnboarded, isTrue);
    expect(find.text('Track what matters to you.'), findsOneWidget);
  });

  testWidgets('returning signed-out user bypasses the introduction', (
    tester,
  ) async {
    await pumpSignedOutApp(tester, onboarded: true);

    expect(find.text('Track what matters to you.'), findsOneWidget);
    expect(find.text('Skip'), findsNothing);
  });

  testWidgets('guest form validates an empty name without making a request', (
    tester,
  ) async {
    await pumpSignedOutApp(tester, onboarded: true, overrideGuestAuth: true);

    await tester.tap(find.text('Use anonymously'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('guest-submit-button')));
    await tester.pump();

    expect(find.text('Enter a name to continue.'), findsOneWidget);
    expect(_GuestAuthNotifier.submittedName, isNull);
  });

  testWidgets('guest form normalizes the name and exposes server failures', (
    tester,
  ) async {
    _GuestAuthNotifier.failureMessage = 'Please check your network connection!';
    await pumpSignedOutApp(tester, onboarded: true, overrideGuestAuth: true);

    await tester.tap(find.text('Use anonymously'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('guest-name-field')),
      '  Ada   Lovelace  ',
    );
    await tester.tap(find.byKey(const ValueKey('guest-submit-button')));
    await tester.pump();

    expect(_GuestAuthNotifier.submittedName, 'Ada Lovelace');
    expect(find.text('Please check your network connection!'), findsOneWidget);
  });

  testWidgets('successful guest creation closes the name sheet', (
    tester,
  ) async {
    await pumpSignedOutApp(tester, onboarded: true, overrideGuestAuth: true);

    await tester.tap(find.text('Use anonymously'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('guest-name-field')),
      'Alex',
    );
    await tester.tap(find.byKey(const ValueKey('guest-submit-button')));
    await tester.pumpAndSettle();

    expect(_GuestAuthNotifier.submittedName, 'Alex');
    expect(find.byKey(const ValueKey('guest-name-field')), findsNothing);
  });
}
