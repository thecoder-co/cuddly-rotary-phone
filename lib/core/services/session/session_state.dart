enum SessionStatus { signedOut, authenticated, recoverableFailure }

enum SessionUserType { anonymous, normal, unsupported }

class SessionState {
  final SessionStatus status;
  final String? userId;
  final String? email;
  final String? name;
  final SessionUserType? userType;
  final String? message;
  final bool usingCachedCredentials;
  final bool onboardingComplete;

  const SessionState._({
    required this.status,
    this.userId,
    this.email,
    this.name,
    this.userType,
    this.message,
    this.usingCachedCredentials = false,
    this.onboardingComplete = false,
  });

  const SessionState.signedOut({bool onboardingComplete = false})
    : this._(
        status: SessionStatus.signedOut,
        onboardingComplete: onboardingComplete,
      );

  const SessionState.authenticated({
    required String userId,
    required String? email,
    required String name,
    required SessionUserType userType,
    bool usingCachedCredentials = false,
  }) : this._(
         status: SessionStatus.authenticated,
         userId: userId,
         email: email,
         name: name,
         userType: userType,
         usingCachedCredentials: usingCachedCredentials,
       );

  const SessionState.recoverableFailure({
    required String message,
    String? userId,
    String? email,
    String? name,
    SessionUserType? userType,
  }) : this._(
         status: SessionStatus.recoverableFailure,
         message: message,
         userId: userId,
         email: email,
         name: name,
         userType: userType,
       );

  bool get isGuest => userType == SessionUserType.anonymous;
  bool get hasCachedAccount => userId != null && name != null;
}
