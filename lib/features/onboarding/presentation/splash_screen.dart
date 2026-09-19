import 'package:calorie_tracker/packages/packages.dart';

class SplashScreen extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final Widget? recoveryAction;

  const SplashScreen({
    super.key,
    this.message,
    this.onRetry,
    this.recoveryAction,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Semantics(
                  image: true,
                  label: 'QarrTrack',
                  child: Image.asset(
                    'assets/feature_logo.png',
                    width: 260,
                    height: 140,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(height: 28),
                if (message == null)
                  const CupertinoActivityIndicator(
                    radius: 14,
                    color: Colors.white,
                  ),
                if (message != null) ...[
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  if (onRetry != null)
                    AppButton(
                      label: 'Retry',
                      onPressed: onRetry,
                      backgroundColor: Colors.white,
                      textColor: AppColors.primary,
                    ),
                  if (recoveryAction != null) ...[
                    const SizedBox(height: 10),
                    recoveryAction!,
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
