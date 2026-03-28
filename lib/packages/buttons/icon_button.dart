import 'package:calorie_tracker/packages/packages.dart';

class AppIconButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String svgPath;
  final void Function() onTap;
  final Color? borderColor;
  final Color? svgColor;
  final bool hasBorder;
  const AppIconButton({
    super.key,
    this.borderColor,
    this.height,
    required this.onTap,
    this.svgColor,
    required this.svgPath,
    this.hasBorder = false,
    this.width,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.height ?? 40,
        width: widget.width ?? 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: widget.hasBorder
              ? Border.all(
                  color: widget.borderColor ?? AppColors.greyTertiary,
                  width: 1,
                )
              : null,
          boxShadow: AppShadows.def,
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: SvgPicture.asset(
          widget.svgPath,
          color: Colors.white,
        ),
      ),
    );
  }
}
