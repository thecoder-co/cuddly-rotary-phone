import 'package:calorie_tracker/core/dialogs/toast.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:calorie_tracker/features/home/presentation/home.dart';
import 'package:calorie_tracker/packages/packages.dart';

import '../models/auth_dto.dart';
import '../repo/auth_repo.dart';
import '../presentation/verify_otp_screen.dart';
import '../presentation/login_screen.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthRepo>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthRepo> {
  @override
  AuthRepo build() {
    return AuthRepo();
  }

  Future<void> refreshTokenOnStartup() async {
    final res = await state.refreshToken();
    if (res.valid && res.data != null) {
      final tokens = res.data!.token;
      await LocalData.setToken(
        tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    }
  }

  Future<void> createUser({required CreateUserDto model}) async {
    Dialogs.showLoadingDialog();
    final res = await state.createUser(model: model);
    pop();

    if (res.valid) {
      AppToast.success(res.message ?? 'OTP Sent!');
      pushTo(VerifyOtpScreen(email: model.email));
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
      // Setup Storage locally
      await LocalData.setToken(
        res.data!.token.accessToken,
        refreshToken: res.data!.token.refreshToken,
      );
      await LocalData.setUserInfo(
        res.data!.user.id,
        res.data!.user.email,
        res.data!.user.name,
      );

      AppToast.success('Logged in successfully!');
      pushReplacementTo(const Home());
    } else {
      AppToast.error(res.message ?? 'Invalid OTP');
    }
  }
}
