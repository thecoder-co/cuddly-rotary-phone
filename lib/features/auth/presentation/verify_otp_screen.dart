import 'package:calorie_tracker/packages/packages.dart';
import '../providers/auth_provider.dart';
import '../models/auth_dto.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        border: Border(),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  60.spacingH,
                  Text(
                    'Verify It\'s You 🔐',
                    style: CustomTextStyle.textextraBold24.w700,
                  ),
                  8.spacingH,
                  Text(
                    'Enter the OTP sent to ${widget.email}',
                    style: CustomTextStyle.textmedium16,
                  ),
                  40.spacingH,
                  AppInput(
                    controller: _otpController,
                    labelText: 'One Time Password',
                    hintText: '123456',
                    keyboardType: TextInputType.number,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  40.spacingH,
                  AppButton(
                    label: 'Verify OTP',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authProvider.notifier)
                            .verifyToken(
                              model: TokenDto(
                                email: widget.email,
                                otp: _otpController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  20.spacingH,
                  CupertinoButton(
                    onPressed: () {
                      ref
                          .read(authProvider.notifier)
                          .sendLoginOtp(
                            model: SendLoginOtpDto(email: widget.email),
                          );
                    },
                    child: Text(
                      'Didn\'t receive it? Resend',
                      style: CustomTextStyle.textmedium16.w600.withColor(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
