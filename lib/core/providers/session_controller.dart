import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/core/services/notifications/notification_coordinator.dart';
import 'package:calorie_tracker/core/services/session/session_state.dart';
import 'package:calorie_tracker/features/auth/models/auth_dto.dart';
import 'package:calorie_tracker/features/auth/repo/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionProvider = AsyncNotifierProvider<SessionController, SessionState>(
  SessionController.new,
);

/// The sole authority for application-session transitions.
///
/// A failed refresh intentionally keeps a fully cached account usable. Only an
/// explicit invalid-token response signs the user out; transient network and
/// server failures must not erase offline tracking data.
class SessionController extends AsyncNotifier<SessionState> {
  Future<SessionState>? _activeRefresh;

  @override
  Future<SessionState> build() => _restore();

  Future<void> retryBootstrap() async {
    state = const AsyncLoading();
    state = AsyncData(await _restore());
  }

  Future<void> refresh() async {
    final current = state.asData?.value;
    if (current?.status != SessionStatus.authenticated) return;
    state = AsyncData(await _refreshOnce());
  }

  Future<SessionState> _restore() async {
    try {
      await LocalData.init();
      await NotificationCoordinator.instance.initialize();
    } catch (error) {
      return SessionState.recoverableFailure(
        message: 'Unable to open local storage: $error',
      );
    }
    return _refreshOnce();
  }

  Future<SessionState> _refreshOnce() {
    return _activeRefresh ??= _refresh().whenComplete(() {
      _activeRefresh = null;
    });
  }

  Future<SessionState> _refresh() async {
    final cached = _cachedSession();
    final hasAnyCredential =
        LocalData.token?.isNotEmpty == true ||
        LocalData.refreshToken?.isNotEmpty == true;
    if (!hasAnyCredential) {
      return SessionState.signedOut(onboardingComplete: LocalData.isOnboarded);
    }

    if (!LocalData.hasCredentials) {
      return SessionState.recoverableFailure(
        message:
            'Your saved sign-in is incomplete. Retry before signing in again.',
        userId: cached?.userId,
        email: cached?.email,
        name: cached?.name,
        userType: cached?.userType,
      );
    }

    final result = await AuthRepo().refreshToken();
    if (result.valid && result.data != null) {
      try {
        return await _persist(result.data!);
      } catch (error) {
        return SessionState.recoverableFailure(
          message: 'Unable to save your refreshed session: $error',
          userId: cached?.userId,
          email: cached?.email,
          name: cached?.name,
          userType: cached?.userType,
        );
      }
    }

    if (result.statusCode == 401 || result.statusCode == 403) {
      try {
        await LocalData.removeToken();
        return SessionState.signedOut(
          onboardingComplete: LocalData.isOnboarded,
        );
      } catch (error) {
        return SessionState.recoverableFailure(
          message: 'Your session could not be cleared safely: $error',
          userId: cached?.userId,
          email: cached?.email,
          name: cached?.name,
          userType: cached?.userType,
        );
      }
    }

    if (cached != null) {
      return SessionState.authenticated(
        userId: cached.userId!,
        email: cached.email,
        name: cached.name!,
        userType: cached.userType!,
        usingCachedCredentials: true,
      );
    }

    return SessionState.recoverableFailure(
      message: result.message ?? 'Unable to restore your saved session.',
    );
  }

  Future<void> establishAuthenticatedSession(AuthResponseDto response) async {
    final next = await _persist(response);
    // Publish the authenticated state only after both the session and the
    // onboarding marker are durable, so routing cannot observe half a login.
    await LocalData.setOnboarded(true);
    state = AsyncData(next);
  }

  Future<void> signOut() async {
    await LocalData.removeToken();
    state = AsyncData(
      SessionState.signedOut(onboardingComplete: LocalData.isOnboarded),
    );
  }

  Future<void> markOnboardingComplete() async {
    await LocalData.setOnboarded(true);
    state = const AsyncData(SessionState.signedOut(onboardingComplete: true));
  }

  Future<void> continueWithCachedAccount() async {
    final cached = _cachedSession();
    if (cached != null) state = AsyncData(cached);
  }

  SessionState? _cachedSession() {
    final userId = LocalData.userId;
    final name = LocalData.userName;
    final userType = _storedUserType(LocalData.userType);
    if (userId == null || userId.isEmpty || name == null || name.isEmpty) {
      return null;
    }
    if (userType == SessionUserType.unsupported) return null;
    return SessionState.authenticated(
      userId: userId,
      email: LocalData.userEmail,
      name: name,
      userType: userType,
      usingCachedCredentials: true,
    );
  }

  SessionUserType _storedUserType(String? type) =>
      switch (type?.toUpperCase()) {
        'ANONYMOUS' => SessionUserType.anonymous,
        'NORMAL' => SessionUserType.normal,
        // Existing installs predate account type. They were email accounts.
        null || '' => SessionUserType.normal,
        _ => SessionUserType.unsupported,
      };

  Future<SessionState> _persist(AuthResponseDto response) async {
    final user = response.user;
    if (response.token.accessToken.isEmpty ||
        response.token.refreshToken.isEmpty) {
      throw const FormatException(
        'The server returned incomplete credentials.',
      );
    }
    if (user.id.isEmpty || user.name.trim().isEmpty) {
      throw const FormatException('The server returned an incomplete user.');
    }
    if (user.type == SessionUserType.unsupported) {
      throw const FormatException(
        'The server returned an unsupported account type.',
      );
    }
    await LocalData.saveSession(
      accessToken: response.token.accessToken,
      refreshToken: response.token.refreshToken,
      id: user.id,
      email: user.email,
      name: user.name.trim(),
      userType: user.type.name.toUpperCase(),
    );
    return SessionState.authenticated(
      userId: user.id,
      email: user.email,
      name: user.name.trim(),
      userType: user.type,
    );
  }
}
