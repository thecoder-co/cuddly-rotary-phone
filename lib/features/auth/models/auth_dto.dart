import 'package:calorie_tracker/core/services/session/session_state.dart';

class CreateUserDto {
  final String email;
  final String name;
  final String? anonymousId;

  CreateUserDto({required this.email, required this.name, this.anonymousId});

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    if (anonymousId != null) 'anonymous_id': anonymousId,
  };
}

class AnonymousRegisterDto {
  final String name;

  AnonymousRegisterDto({required this.name});

  Map<String, dynamic> toJson() => {'name': name};
}

class SendLoginOtpDto {
  final String email;

  SendLoginOtpDto({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class TokenDto {
  final String email;
  final String otp;

  TokenDto({required this.email, required this.otp});

  Map<String, dynamic> toJson() => {'email': email, 'otp': otp};
}

class TokenResponseDto {
  final String accessToken;
  final String refreshToken;

  TokenResponseDto({required this.accessToken, required this.refreshToken});

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) {
    return TokenResponseDto(
      accessToken: json['accessToken'] is String
          ? json['accessToken'] as String
          : '',
      refreshToken: json['refreshToken'] is String
          ? json['refreshToken'] as String
          : '',
    );
  }
}

class UserResponseDto {
  final String id;
  final String? email;
  final String name;
  final SessionUserType type;

  UserResponseDto({
    required this.id,
    required this.email,
    required this.name,
    required this.type,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) {
    final rawType = json['type'];
    final type = switch (rawType is String ? rawType.toUpperCase() : '') {
      'ANONYMOUS' => SessionUserType.anonymous,
      'NORMAL' => SessionUserType.normal,
      _ => SessionUserType.unsupported,
    };
    return UserResponseDto(
      id: json['id'] is String ? json['id'] as String : '',
      email: json['email'] is String && (json['email'] as String).isNotEmpty
          ? json['email'] as String
          : null,
      name: json['name'] is String ? json['name'] as String : '',
      type: type,
    );
  }
}

class AuthResponseDto {
  final TokenResponseDto token;
  final UserResponseDto user;
  final Map<String, dynamic>? settings;

  AuthResponseDto({required this.token, required this.user, this.settings});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    final tokenJson = json['token'];
    final userJson = json['user'];
    return AuthResponseDto(
      token: TokenResponseDto.fromJson(
        tokenJson is Map
            ? Map<String, dynamic>.from(tokenJson)
            : const <String, dynamic>{},
      ),
      user: UserResponseDto.fromJson(
        userJson is Map
            ? Map<String, dynamic>.from(userJson)
            : const <String, dynamic>{},
      ),
      settings: json['settings'] is Map
          ? Map<String, dynamic>.from(json['settings'] as Map)
          : null,
    );
  }
}
