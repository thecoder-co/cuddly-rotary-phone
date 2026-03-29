class CreateUserDto {
  final String email;
  final String name;

  CreateUserDto({required this.email, required this.name});

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
      };
}

class SendLoginOtpDto {
  final String email;

  SendLoginOtpDto({required this.email});

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

class TokenDto {
  final String email;
  final String otp;

  TokenDto({required this.email, required this.otp});

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };
}

class TokenResponseDto {
  final String accessToken;
  final String refreshToken;

  TokenResponseDto({required this.accessToken, required this.refreshToken});

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) {
    return TokenResponseDto(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}

class UserResponseDto {
  final String id;
  final String email;
  final String name;

  UserResponseDto({required this.id, required this.email, required this.name});

  factory UserResponseDto.fromJson(Map<String, dynamic> json) {
    return UserResponseDto(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class AuthResponseDto {
  final TokenResponseDto token;
  final UserResponseDto user;

  AuthResponseDto({required this.token, required this.user});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      token: TokenResponseDto.fromJson(json['token'] ?? {}),
      user: UserResponseDto.fromJson(json['user'] ?? {}),
    );
  }
}
