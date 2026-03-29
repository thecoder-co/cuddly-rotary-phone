import 'package:calorie_tracker/packages/packages.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? label;
  final Color? textColor;
  final double? width;
  final String? preIcon;
  final String? postIcon;
  final double preIconSpace;
  final double postIconSpace;
  //final Color borderColor;
  final Color? backgroundColor;
  final bool isOutline;
  final double height;
  final TextStyle? textStyle;
  final Color shadowColor;
  final Color? iconColor;
  final Widget? child;
  final double borderWidth;

  final double radius;

  final bool isText;

  const AppButton({
    super.key,
    required this.onPressed,
    this.label,
    this.borderWidth = 1,
    this.textStyle,
    this.shadowColor = const Color.fromARGB(73, 158, 158, 158),
    this.preIcon,
    this.postIcon,
    this.iconColor,
    this.backgroundColor,
    this.postIconSpace = 20,
    this.preIconSpace = 20,
    this.textColor,
    this.height = 55,
    this.child,
    this.width = double.infinity,
    this.radius = 16,
  })  : assert(label != null || child != null),
        isText = false,
        isOutline = false;

  const AppButton.outline({
    super.key,
    required this.onPressed,
    this.label,
    this.borderWidth = 1,
    this.textStyle,
    this.preIcon,
    this.iconColor,
    this.postIcon,
    this.postIconSpace = 8,
    this.preIconSpace = 8,
    this.shadowColor = Colors.transparent,
    this.height = 55,
    this.child,
    this.width = double.infinity,
    this.radius = 16,
  })  : assert(label != null || child != null),
        isText = true,
        textColor = null,
        backgroundColor = null,
        isOutline = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Resolved colours
    final resolvedBg = backgroundColor ??
        (isOutline ? Colors.transparent : AppColors.primary);
    final resolvedFg = textColor ??
        (isOutline
            ? (isDark ? Colors.white : AppColors.primary)
            : Colors.white);
    final disabledBg = isOutline ? Colors.transparent : const Color(0xFFE2E2E2);
    final disabledFg = AppColors.greyQuatinary;

    final buttonChild = child ??
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (preIcon != null) ...[
              SvgPicture.asset(preIcon!, colorFilter: ColorFilter.mode(iconColor ?? resolvedFg, BlendMode.srcIn)),
              preIconSpace.spacingW,
            ],
            Text(
              label!,
              style: CustomTextStyle.textmedium16.w700
                  .withColor(onPressed == null ? disabledFg : resolvedFg),
            ),
            if (postIcon != null) ...[
              postIconSpace.spacingW,
              SvgPicture.asset(postIcon!, colorFilter: ColorFilter.mode(iconColor ?? resolvedFg, BlendMode.srcIn)),
            ],
          ],
        );

    return SizedBox(
      width: width,
      height: height,
      child: isOutline
          ? CupertinoButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: onPressed == null
                        ? AppColors.greySecondary
                        : const Color(0xFF3C3C3E),
                    width: borderWidth,
                  ),
                ),
                child: buttonChild,
              ),
            )
          : CupertinoButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(radius),
              color: onPressed == null ? disabledBg : resolvedBg,
              disabledColor: disabledBg,
              child: SizedBox(
                width: width,
                height: height,
                child: Center(child: buttonChild),
              ),
            ),
    );
  }
}
