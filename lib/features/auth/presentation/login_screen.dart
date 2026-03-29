import 'package:calorie_tracker/packages/packages.dart';
import '../providers/auth_provider.dart';
import '../models/auth_dto.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                  100.spacingH,
                  Text(
                    'Welcome Back 👋',
                    style: CustomTextStyle.textextraBold24.w700,
                  ),
                  8.spacingH,
                  const Text(
                    'Enter your email to receive an OTP',
                    style: CustomTextStyle.textmedium16,
                  ),
                  40.spacingH,
                  AppInput(
                    controller: _emailController,
                    labelText: 'Email Address',
                    hintText: 'john@example.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  40.spacingH,
                  AppButton(
                    label: 'Send OTP',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(authProvider.notifier).sendLoginOtp(
                              model: SendLoginOtpDto(
                                  email: _emailController.text.trim()),
                            );
                      }
                    },
                  ),
                  20.spacingH,
                  CupertinoButton(
                    onPressed: () => pushReplacementTo(const RegisterScreen()),
                    child: Text(
                      'Don\'t have an account? Register',
                      style: CustomTextStyle.textmedium16.w600
                          .withColor(AppColors.primary),
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
