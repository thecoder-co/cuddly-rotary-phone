import 'package:calorie_tracker/packages/packages.dart';
import '../providers/auth_provider.dart';
import '../models/auth_dto.dart';
import 'login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
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
                  const Text(
                    'Create an Account 🚀',
                    style: CustomTextStyle.textextraBold24,
                  ),
                  8.spacingH,
                  const Text(
                    'Log your meals and track your macros.',
                    style: CustomTextStyle.textmedium16,
                  ),
                  40.spacingH,
                  AppInput(
                    controller: _nameController,
                    labelText: 'Full Name',
                    hintText: 'John Doe',
                    keyboardType: TextInputType.name,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  20.spacingH,
                  AppInput(
                    controller: _emailController,
                    labelText: 'Email Address',
                    hintText: 'john@example.com',

                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  40.spacingH,
                  AppButton(
                    label: 'Register & Send OTP',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authProvider.notifier)
                            .createUser(
                              model: CreateUserDto(
                                email: _emailController.text.trim(),
                                name: _nameController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  20.spacingH,
                  CupertinoButton(
                    onPressed: () => pushReplacementTo(const LoginScreen()),
                    child: Text(
                      'Already have an account? Log in',
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
