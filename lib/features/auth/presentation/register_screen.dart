import 'package:calorie_tracker/packages/packages.dart';
import '../providers/auth_provider.dart';
import '../models/auth_dto.dart';
import 'login_screen.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final bool isGuestUpgrade;
  const RegisterScreen({super.key, this.isGuestUpgrade = false});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isGuestUpgrade) _nameController.text = LocalData.userName ?? '';
  }

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
                  Text(
                    widget.isGuestUpgrade
                        ? 'Link your email'
                        : 'Create an Account 🚀',
                    style: CustomTextStyle.textextraBold24,
                  ),
                  8.spacingH,
                  Text(
                    widget.isGuestUpgrade
                        ? 'Keep this guest account and its data recoverable.'
                        : 'Log your meals and track your macros.',
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
                                anonymousId: widget.isGuestUpgrade
                                    ? LocalData.userId
                                    : null,
                              ),
                            );
                      }
                    },
                  ),
                  20.spacingH,
                  CupertinoButton(
                    onPressed: () => widget.isGuestUpgrade
                        ? Navigator.of(context).pop()
                        : pushReplacementTo(const LoginScreen()),
                    child: Text(
                      widget.isGuestUpgrade
                          ? 'Not now'
                          : 'Already have an account? Log in',
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
