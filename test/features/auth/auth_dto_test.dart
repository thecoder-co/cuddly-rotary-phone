import 'package:calorie_tracker/core/services/session/session_state.dart';
import 'package:calorie_tracker/features/auth/models/auth_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('anonymous auth response accepts a null email', () {
    final response = AuthResponseDto.fromJson({
      'token': {'accessToken': 'access', 'refreshToken': 'refresh'},
      'user': {
        'id': 'guest-id',
        'email': null,
        'name': 'Guest',
        'type': 'ANONYMOUS',
      },
      'settings': {'dailyCalories': 2000},
    });

    expect(response.token.accessToken, 'access');
    expect(response.token.refreshToken, 'refresh');
    expect(response.user.email, isNull);
    expect(response.user.type, SessionUserType.anonymous);
    expect(response.settings?['dailyCalories'], 2000);
  });

  test('unknown account types are rejected by the session layer', () {
    final response = AuthResponseDto.fromJson({
      'token': {'accessToken': 'access', 'refreshToken': 'refresh'},
      'user': {
        'id': 'user-id',
        'email': 'person@example.com',
        'name': 'Person',
        'type': 'ADMIN',
      },
    });

    expect(response.user.type, SessionUserType.unsupported);
  });

  test('anonymous registration sends only the normalized display name', () {
    final request = AnonymousRegisterDto(name: 'Ada Lovelace');

    expect(request.toJson(), {'name': 'Ada Lovelace'});
  });

  test('malformed nested session objects become an invalid DTO safely', () {
    final response = AuthResponseDto.fromJson({
      'token': 'not-an-object',
      'user': <String>['not-an-object'],
    });

    expect(response.token.accessToken, isEmpty);
    expect(response.token.refreshToken, isEmpty);
    expect(response.user.id, isEmpty);
    expect(response.user.type, SessionUserType.unsupported);
  });
}
