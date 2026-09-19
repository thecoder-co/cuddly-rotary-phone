import 'package:calorie_tracker/core/providers/session_controller.dart';
import 'package:calorie_tracker/packages/packages.dart';

import '../models/auth_dto.dart';
import '../repo/auth_repo.dart';
import '../presentation/verify_otp_screen.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthRepo>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthRepo> {
  @override
  AuthRepo build() {
    return AuthRepo();
  }

  Future<void> refreshTokenOnStartup() async {
    await ref.read(sessionProvider.notifier).refresh();
  }

  Future<void> createUser({required CreateUserDto model}) async {
    Dialogs.showLoadingDialog();
    final res = model.anonymousId == null
        ? await state.createUser(model: model)
        : await state.linkAnonymousEmail(model: model);
    pop();

    if (res.valid) {
      AppToast.success(res.message ?? 'OTP Sent!');
      pushTo(
        VerifyOtpScreen(
          email: model.email,
          isGuestUpgrade: model.anonymousId != null,
        ),
      );
    } else {
      AppToast.error(res.message ?? 'An error occurred');
    }
  }

  Future<void> sendLoginOtp({required SendLoginOtpDto model}) async {
    Dialogs.showLoadingDialog();
    final res = await state.sendLoginOtp(model: model);
    pop();

    if (res.valid) {
      AppToast.success(res.message ?? 'OTP Sent!');
      pushTo(VerifyOtpScreen(email: model.email));
    } else {
      AppToast.error(res.message ?? 'An error occurred');
    }
  }

  Future<void> verifyToken({required TokenDto model}) async {
    Dialogs.showLoadingDialog();
    final res = await state.verifyToken(model: model);
    pop();

    if (res.valid && res.data != null) {
      try {
        await ref
            .read(sessionProvider.notifier)
            .establishAuthenticatedSession(res.data!);
        AppToast.success('Logged in successfully!');
      } catch (error) {
        AppToast.error('Unable to save this session: $error');
      }
    } else {
      AppToast.error(res.message ?? 'Invalid OTP');
    }
  }

  /// Creates and persists a guest session.
  ///
  /// A `null` result means the complete session was stored successfully. Any
  /// non-null result is safe to show beside the guest form. Keeping this small
  /// result surface prevents the onboarding UI from depending on transport
  /// response types.
  Future<String?> registerAnonymous({
    required AnonymousRegisterDto model,
  }) async {
    final res = await state.registerAnonymous(model: model);
    if (!res.valid || res.data == null) {
      return res.message ?? 'Unable to create a guest account.';
    }
    try {
      await ref
          .read(sessionProvider.notifier)
          .establishAuthenticatedSession(res.data!);
      return null;
    } catch (_) {
      return 'This device could not save the guest session. Please try again.';
    }
  }
}
