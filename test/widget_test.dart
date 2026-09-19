import 'package:calorie_tracker/core/providers/session_controller.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/core/services/session/session_state.dart';
import 'package:calorie_tracker/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _SignedOutSession extends SessionController {
  @override
  Future<SessionState> build() async =>
      SessionState.signedOut(onboardingComplete: LocalData.isOnboarded);
}

void main() {
  testWidgets('a new signed-out install starts at introduction', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    LocalData.prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sessionProvider.overrideWith(_SignedOutSession.new)],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
    expect(find.text('Use anonymously'), findsOneWidget);
  });
}
