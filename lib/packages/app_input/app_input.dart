import 'package:calorie_tracker/core/utils/extensions/date_extensions.dart';

import '../packages.dart';

class InputIcon extends StatelessWidget {
  final String asset;
  const InputIcon(this.asset, {super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      color: Colors.black,
    ).paddingOnly(r: 12);
  }
}

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String? v)? validator;
  final dynamic Function(dynamic v)? dropdownValidator;

  /// If initialText is not null, it will override the initialText from controller
  final String? initialText;

  /// If errorText is not null, it will override the errorText from validator
  final String? errorText;

  final List<TextInputFormatter>? inputFormatters;

  final bool readOnly;

  final bool autoFocus;

  final TextAlign? textAlign;

  /// Hint text to be displayed when the input is empty
  final String? hintText;

  /// What should be displayed over the hint icon
  final String? hintIcon;

  final Widget? trailingIcon;

  /// Label text on top
  final String? labelText;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// Icon to be displayed on the left of the input
  final Widget? leadingIcon;
  final Function()? onTap;

  /// Use this only for bertical padding
  final EdgeInsets? contentPadding;
  final String? helperText;
  final AutovalidateMode autovalidateMode;
  final TextInputType? keyboardType;
  final List<DropdownMenuItem>? items;
  final dynamic initialItem;
  final int? maxLines;
  final int? minLines;
  final bool isPasswordField;
  final TextStyle? labelStyle;
  final void Function(String? v)? onChanged;
  final void Function(dynamic v)? onDropdownChanged;
  final void Function(DateTime? v)? onDateTimeChanged;
  final void Function(TimeOfDay? v)? onTimeChanged;
  final bool isDateTimeInputField;
  final bool isTimeInputField;
  final bool expands;
  final DateTime? initialDateTime;
  final TimeOfDay? initialTime;

  final bool enabled;

  final String? currentCountryCode;
  final Function(CountryCode v)? onCountryPicked;

  final String? currentCurrency;
  final Function(Currency v)? onCurrencyPicked;

  /// Width of the input
  final double? width;
  final double? height;

  final TextStyle? style;
  final TextStyle? hintStyle;

  final bool isDropDown;

  /// If obscureText is true, maxLines must be specified as 1.
  final bool? obscureText;

  const AppInput({
    super.key,
    this.controller,
    this.hintText,
    this.hintIcon,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.initialText,
    this.contentPadding,
    this.trailingIcon,
    this.hintStyle,
    this.firstDate,
    this.lastDate,
    this.obscureText,
    this.style,
    this.onChanged,
    this.readOnly = false,
    this.inputFormatters,
    this.minLines,
    this.textAlign,
    this.autoFocus = false,
    this.enabled = true,
    this.labelStyle,
    this.keyboardType,
    this.helperText,
    this.leadingIcon,
    this.maxLines = 1,
    this.labelText,
    this.validator,
    this.height,
    this.errorText,
    this.expands = false,
    this.width,
  })  : isPasswordField = false,
        initialDateTime = null,
        initialTime = null,
        isDateTimeInputField = false,
        isTimeInputField = false,
        dropdownValidator = null,
        isDropDown = false,
        currentCountryCode = null,
        onDateTimeChanged = null,
        onTimeChanged = null,
        items = null,
        onDropdownChanged = null,
        initialItem = null,
        onCountryPicked = null,
        currentCurrency = null,
        onCurrencyPicked = null;

  const AppInput.datePicker({
    super.key,
    this.hintText,
    this.hintIcon,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialDateTime,
    this.contentPadding,
    this.onTap,
    this.trailingIcon,
    this.hintStyle,
    this.obscureText,
    this.style,
    required this.onDateTimeChanged,
    this.labelStyle,
    this.inputFormatters,
    this.minLines,
    this.firstDate,
    this.lastDate,
    this.textAlign,
    this.enabled = true,
    this.keyboardType,
    this.helperText,
    this.leadingIcon,
    this.maxLines = 1,
    this.labelText,
    this.validator,
    this.height,
    this.autoFocus = false,
    this.errorText,
    this.expands = false,
    this.width,
  })  : isPasswordField = false,
        controller = null,
        isDateTimeInputField = true,
        isTimeInputField = false,
        dropdownValidator = null,
        initialTime = null,
        isDropDown = false,
        currentCountryCode = null,
        onTimeChanged = null,
        items = null,
        readOnly = true,
        initialText = null,
        onChanged = null,
        onDropdownChanged = null,
        initialItem = null,
        onCountryPicked = null,
        currentCurrency = null,
        onCurrencyPicked = null;

  const AppInput.timePicker({
    super.key,
    this.hintText,
    this.hintIcon,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialTime,
    this.contentPadding,
    this.onTap,
    this.trailingIcon,
    this.hintStyle,
    this.obscureText,
    this.style,
    required this.onTimeChanged,
    this.autoFocus = false,
    this.labelStyle,
    this.firstDate,
    this.lastDate,
    this.inputFormatters,
    this.minLines,
    this.enabled = true,
    this.keyboardType,
    this.helperText,
    this.textAlign,
    this.leadingIcon,
    this.maxLines = 1,
    this.labelText,
    this.validator,
    this.height,
    this.errorText,
    this.expands = false,
    this.width,
  })  : isPasswordField = false,
        controller = null,
        isDateTimeInputField = false,
        isTimeInputField = true,
        isDropDown = false,
        initialDateTime = null,
        currentCountryCode = null,
        dropdownValidator = null,
        onDateTimeChanged = null,
        items = null,
        onDropdownChanged = null,
        readOnly = true,
        initialText = null,
        onChanged = null,
        initialItem = null,
        onCountryPicked = null,
        currentCurrency = null,
        onCurrencyPicked = null;

  const AppInput.dropdown({
    super.key,
    this.hintText,
    this.hintIcon,
    required this.items,
    this.initialItem,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding,
    this.firstDate,
    this.lastDate,
    this.trailingIcon,
    this.hintStyle,
    this.textAlign,
    this.obscureText,
    this.style,
    this.autoFocus = false,
    this.inputFormatters,
    this.minLines,
    this.enabled = true,
    this.labelStyle,
    this.keyboardType,
    this.dropdownValidator,
    this.helperText,
    this.leadingIcon,
    this.maxLines = 1,
    this.labelText,
    this.onTap,
    this.height,
    this.errorText,
    required this.onDropdownChanged,
    this.expands = false,
    this.width,
  })  : isPasswordField = false,
        initialText = null,
        onDateTimeChanged = null,
        onTimeChanged = null,
        controller = null,
        onChanged = null,
        validator = null,
        readOnly = false,
        initialDateTime = null,
        initialTime = null,
        isDateTimeInputField = false,
        isTimeInputField = false,
        isDropDown = true,
        currentCountryCode = null,
        onCountryPicked = null,
        currentCurrency = null,
        onCurrencyPicked = null;

  const AppInput.password({
    super.key,
    this.controller,
    this.hintText,
    this.hintIcon,
    this.inputFormatters,
    this.onChanged,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialText,
    this.contentPadding,
    this.firstDate,
    this.lastDate,
    this.trailingIcon,
    this.autoFocus = false,
    this.hintStyle,
    this.labelStyle,
    this.textAlign,
    this.readOnly = false,
    this.obscureText,
    this.style,
    this.onTap,
    this.minLines,
    this.enabled = true,
    this.keyboardType,
    this.helperText,
    this.leadingIcon,
    this.maxLines = 1,
    this.labelText,
    this.validator,
    this.height,
    this.errorText,
    this.expands = false,
    this.width,
  })  : isDropDown = false,
        initialItem = null,
        isPasswordField = true,
        dropdownValidator = null,
        initialDateTime = null,
        initialTime = null,
        isDateTimeInputField = false,
        isTimeInputField = false,
        onDateTimeChanged = null,
        onDropdownChanged = null,
        onTimeChanged = null,
        currentCountryCode = null,
        items = null,
        onCountryPicked = null,
        currentCurrency = null,
        onCurrencyPicked = null;

  // const AppInput.phoneNumber({
  //   super.key,
  //   this.controller,
  //   this.hintText,
  //   this.hintIcon,
  //   this.autovalidateMode = AutovalidateMode.onUserInteraction,

  //   this.enabled = true,
  //   this.minLines,
  //   this.obscureText,
  //   this.initialText,
  //   this.hintStyle,
  //   this.style,
  //   this.expands = false,
  //   this.height,
  //   this.trailingIcon,
  //   required this.onCountryPicked,
  //   this.horizontalMargin,
  //   this.helperText,
  //   this.labelText,
  //   this.currentCountryCode,
  //   this.validator,
  //   this.contentPadding,
  //   this.errorText,
  //   this.width,
  // })  : leadingIcon = null,
  //       keyboardType = null,
  //       isPhoneNumberField = true,
  //       isEmailField = false,
  //       isPasswordField = false,
  //       isCurrencyInputField = false,
  //       isHttpInputField = false,
  //       isCardNumberInputField = false,
  //       currentCurrency = null,
  //       maxLines = 1,
  //       onCurrencyPicked = null;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  final _onNullController = TextEditingController();

  bool isFocused = false;
  bool isEmpty = true;
  String dropdownText = '';
  final _focusNode = FocusNode();
  String? error;
  String? get errorText => widget.errorText ?? error;

  CountryCode? _phoneDropdownValue;

  void controllerOnEmptyListiner() {
    if (controller.text.isEmpty) {
      if (isEmpty == false) {
        setState(() {
          isEmpty = true;
        });
      }
    } else {
      if (isEmpty) {
        setState(() {
          isEmpty = false;
        });
      }
    }
  }

  // asyncValidator() async {
  //   setState(() {
  //     errorText = '';
  //   });
  //   final error = await widget.asyncValidator!(controller.text);
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     setState(() {
  //       errorText = error;
  //     });
  //     errorText;
  //   });
  // }

  final radius = 16.0;

  @override
  void initState() {
    error = widget.errorText;
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    if (widget.isDropDown) {
      _focusNode.addListener(() {
        setState(() {
          isFocused = _focusNode.hasFocus;
        });
      });
    }
    // if (widget.asyncValidator != null) {
    //   controller.addListener(asyncValidator);
    // }
    if (widget.initialText != null) {
      controller.text = widget.initialText!;
    }
    if (widget.initialDateTime != null) {
      controller.text = widget.initialDateTime!.formatDateDash;
    }
    if (widget.initialTime != null) {
      controller.text =
          '${widget.initialTime!.hour.toString().padLeft(2, '0')}:${widget.initialTime!.minute.toString().padLeft(2, '0')}';
    }
    // if (widget.initialDateTime != null) {
    //   controller.text = widget.initialDateTime!.formatDateDash;
    // }
    if (controller.text.isNotEmpty) {
      isEmpty = false;
    }

    controller.addListener(controllerOnEmptyListiner);

    // if (widget.isPhoneNumberField) {
    //   onPhoneInit();
    // }

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(controllerOnEmptyListiner);
    // if (widget.asyncValidator != null) {
    //   controller.removeListener(asyncValidator);
    // }
    super.dispose();
  }

  void onPhoneInit() {
    _phoneDropdownValue =
        countries.data!.firstWhere((element) => element.dialCode == '234');

    if (widget.currentCountryCode != null) {
      _phoneDropdownValue = countries.data!.firstWhereOrNull((element) =>
              element.shortCode == widget.currentCountryCode ||
              element.dialCode == widget.currentCountryCode) ??
          countries.data!.first;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onCountryPicked!(_phoneDropdownValue!);
      });
    } else {
      _phoneDropdownValue = countries.data!
              .firstWhereOrNull((element) => element.shortCode == 'NG') ??
          countries.data!.first;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onCountryPicked!(_phoneDropdownValue!);
      });
    }
    if (widget.isDropDown) {
      if (widget.initialItem != null) {
        widget.items!.add(
          DropdownMenuItem(
            value: widget.initialItem,
            child: Text(widget.initialItem ?? ''),
          ),
        );
      }
    }
  }

  bool passwordVisibilityChange = true;

  Widget _passwordVisibility() {
    return InkWell(
      onTap: () {
        setState(() {
          passwordVisibilityChange = !passwordVisibilityChange;
        });
      },
      child: passwordVisibilityChange
          ? const Text('show').paddingOnly(r: 12)
          : const Text('hide').paddingOnly(r: 12),
    );
  }

  DateTime? chosenDate;
  TimeOfDay? chosenTime;

  TextEditingController get controller =>
      widget.controller ?? _onNullController;

  @override
  Widget build(BuildContext context) {
    Color textColor() {
      return AppColors.baseBlack;
    }

    Color hintColor() {
      return AppColors.primary400;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap ??
          (widget.readOnly
              ? null
              : () async {
                  if (widget.isTimeInputField) {
                    handleTime();
                  }
                  if (widget.isDateTimeInputField) {
                    handleDateTime();
                  }
                  _focusNode.requestFocus();
                }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelText != null) ...[
            Text(
              widget.labelText!,
              style: widget.labelStyle ?? CustomTextStyle.textsmall14.w700,
            ),
            8.spacingH,
          ],
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: AppColors.primary100,
            ),
            // height: widget.height,
            width: widget.width,
            child: Row(
              children: [
                if (widget.leadingIcon != null) ...[
                  widget.leadingIcon!,
                  8.spacingW,
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.isDropDown)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radius),
                          child: dropDown(textColor(), hintColor()),
                        )
                      else
                        onEmptyField(textColor(), hintColor())
                    ],
                  ),
                ),
                if (widget.isPasswordField) ...[_passwordVisibility()],
                if (widget.trailingIcon != null) ...[
                  8.spacingW,
                  widget.trailingIcon!,
                ],
              ],
            ),
          ),
          if (errorText != null) ...[
            8.spacingH,
            Text(
              errorText!,
              style: widget.style?.withColor(AppColors.error400) ??
                  CustomTextStyle.textsmall14.withColor(AppColors.error400),
            ).paddingOnly(l: 8),
          ],
          if (widget.helperText != null) ...[
            4.spacingH,
            Text(
              widget.helperText!,
              style: widget.style?.withColor(AppColors.greyTertiary) ??
                  CustomTextStyle.textsmall14.withColor(AppColors.greyTertiary),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> handleDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.initialDateTime ?? chosenDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
    if (date != null) {
      chosenDate = date;
      widget.onDateTimeChanged!(date);
      controller.text = date.formatDateDash;
    }
  }

  Future<void> handleTime() async {
    final date = await showTimePicker(
      context: context,
      initialTime: widget.initialTime ?? chosenTime ?? TimeOfDay.now(),
    );
    if (date != null) {
      chosenTime = date;
      widget.onTimeChanged!(date);
      controller.text =
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
  }

  @widgetFactory
  Widget dropDown(Color textColor, Color hintColor) {
    return DropdownButtonFormField<dynamic>(
      items: widget.items!,
      onChanged: (v) {
        widget.onDropdownChanged!(v);
        setState(() {
          isEmpty = v!.isEmpty;
        });
      },
      value: widget.initialItem,
      focusNode: _focusNode,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.greyTertiary,
      ),
      hint: widget.hintText == null
          ? null
          : Text(
              widget.hintText!,
              style: widget.hintStyle?.withColor(hintColor) ??
                  CustomTextStyle.textmedium16.withColor(hintColor),
            ),
      style: widget.style?.withColor(textColor) ??
          CustomTextStyle.textmedium16.w500.withColor(textColor),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.5, horizontal: 12),
        hintText: widget.hintText,
        fillColor: Colors.transparent,
        filled: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        errorStyle: const TextStyle(
          height: 0.00000000000000000000000000000000000000000000001,
        ),
      ),
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator == null
          ? null
          : (v) {
              final error = widget.validator!(v);

              if (widget.errorText == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    this.error = error;
                  });
                });
              }
              if (error == null) {
                return null;
              }
              return '';
            },
    );
  }

  var border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: AppColors.bordersLight,
      width: 1,
    ),
  );
  Widget onEmptyField(Color textColor, Color hintColor) {
    return TextFormField(
      focusNode: _focusNode,
      enabled: widget.enabled,

      expands: widget.expands,
      readOnly: widget.readOnly,

      onChanged: widget.onChanged,
      //cursorHeight: 10,
      obscureText: widget.isPasswordField ? passwordVisibilityChange : false,
      keyboardType: widget.keyboardType,
      style: widget.style?.withColor(textColor) ??
          CustomTextStyle.textmedium16.w500.withColor(textColor),
      inputFormatters: [
        if (widget.inputFormatters != null) ...widget.inputFormatters!,
      ],
      textAlign: widget.textAlign ?? TextAlign.start,
      onTap: widget.isDateTimeInputField
          ? () {
              handleDateTime();
            }
          : widget.isTimeInputField
              ? () {
                  handleTime();
                }
              : widget.onTap,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        hintText: widget.isTimeInputField ? '00:00' : widget.hintText,
        fillColor: Colors.transparent,
        filled: true,
        hintStyle: widget.hintStyle?.withColor(hintColor) ??
            CustomTextStyle.textmedium16.withColor(hintColor),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        errorStyle: const TextStyle(
          height: 0.00000000000000000000000000000000000000000000001,
        ),
      ),

      autovalidateMode: widget.autovalidateMode,
      controller: controller,
      validator: widget.validator == null
          ? null
          : (v) {
              final error = widget.validator!(v);

              if (widget.errorText == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    this.error = error;
                  });
                });
              }
              if (error == null) {
                return null;
              }
              return '';
            },
    );
  }
}
