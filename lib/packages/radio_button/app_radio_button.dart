import 'dart:developer';
import '../packages.dart';

enum RadioSize { sm, md }

extension RadioSizeExtension on RadioSize {
  double get boxSize {
    switch (this) {
      case RadioSize.sm:
        return 16;
      case RadioSize.md:
        return 20;
    }
  }

  double get checkSize {
    switch (this) {
      case RadioSize.sm:
        return 8;
      case RadioSize.md:
        return 10;
    }
  }

  double get bottomSpacing {
    switch (this) {
      case RadioSize.sm:
        return 20;
      case RadioSize.md:
        return 25;
    }
  }

  TextStyle get mainTextStyle {
    switch (this) {
      case RadioSize.sm:
        return CustomTextStyle.textmedium16.w500;
      case RadioSize.md:
        return CustomTextStyle.textlarge18.w500;
    }
  }

  TextStyle get secondaryTextStyle {
    switch (this) {
      case RadioSize.sm:
        return CustomTextStyle.textmedium16;
      case RadioSize.md:
        return CustomTextStyle.textlarge18;
    }
  }
}

class AppRadio<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final Function(bool)? onToggle;
  final bool isDisabled;
  final TextStyle? mainTextStyle;
  final TextStyle? secondaryTextStyle;
  final Color? mainTextColor;
  final Color? secondaryTextColor;
  final String? mainText;
  final bool canToggle;

  final RadioSize size;
  final String? subText;

  const AppRadio({
    super.key,
    required this.value,
    this.groupValue,
    this.mainText,
    this.subText,
    this.mainTextStyle,
    this.secondaryTextStyle,
    this.mainTextColor,
    this.secondaryTextColor,
    this.canToggle = true,
    this.size = RadioSize.sm,
    required this.onToggle,
  })  : assert(onToggle != null),
        isDisabled = false;

  const AppRadio.disabled({
    super.key,
    required this.value,
    this.groupValue,
    this.mainText,
    this.mainTextStyle,
    this.secondaryTextStyle,
    this.mainTextColor,
    this.secondaryTextColor,
    this.canToggle = false,
    this.subText,
    this.size = RadioSize.sm,
  })  : isDisabled = true,
        onToggle = null;

  @override
  State<AppRadio> createState() => _AppRadioState();
}

class _AppRadioState extends State<AppRadio> {
  @override
  void initState() {
    toggleValue = widget.value == widget.groupValue;
    super.initState();
  }

  bool onHover = false;
  bool isFocused = false;

  late bool toggleValue;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowFocusHighlight: (v) {
        setState(() => isFocused = v);
        log('focused');
      },
      actions: {
        ActivateIntent: CallbackAction(
          onInvoke: (v) {
            if (!widget.isDisabled) {
              setState(() {
                toggleValue = !toggleValue;
              });
              widget.onToggle!(toggleValue);
            }
            return null;
          },
        ),
      },
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.focusShadow(widget.isDisabled
                      ? Colors.transparent
                      : isFocused
                          ? AppColors.primary100
                          : Colors.transparent),
                ),
                child: InkWell(
                  canRequestFocus: false,
                  onHover: (v) => setState(() => onHover = v),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    if (!widget.isDisabled && widget.canToggle) {
                      setState(() {
                        toggleValue = !toggleValue;
                      });
                      widget.onToggle!(!toggleValue);
                    }
                  },
                  child: Container(
                    height: widget.size.boxSize,
                    width: widget.size.boxSize,
                    decoration: BoxDecoration(
                      color: widget.isDisabled
                          ? AppColors.greyTertiary
                          : onHover || toggleValue
                              ? AppColors.primary100
                              : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: widget.isDisabled
                            ? AppColors.greyTertiary
                            : toggleValue || onHover
                                ? AppColors.primary600
                                : isFocused
                                    ? AppColors.primary200
                                    : AppColors.greyTertiary,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: toggleValue
                        ? Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary600,
                            ),
                            height: widget.size.checkSize,
                            width: widget.size.checkSize,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              if (widget.mainText != null) ...[
                4.spacingW,
                Expanded(
                  child: Text(
                    widget.mainText ?? '',
                    style: widget.mainTextStyle ??
                        widget.size.mainTextStyle.withColor(
                            widget.mainTextColor ?? AppColors.greyTertiary),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
