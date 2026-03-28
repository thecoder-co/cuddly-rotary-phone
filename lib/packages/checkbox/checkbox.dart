// import 'dart:developer';
// import '../packages.dart';

// enum CheckboxSize { sm, md }

// extension CheckboxSizeExtension on CheckboxSize {
//   double get boxSize {
//     switch (this) {
//       case CheckboxSize.sm:
//         return 16;
//       case CheckboxSize.md:
//         return 20;
//     }
//   }

//   double get radius {
//     switch (this) {
//       case CheckboxSize.sm:
//         return 4;
//       case CheckboxSize.md:
//         return 6;
//     }
//   }

//   double get focusRadius {
//     switch (this) {
//       case CheckboxSize.sm:
//         return 8;
//       case CheckboxSize.md:
//         return 6;
//     }
//   }

//   double get checkWidth {
//     switch (this) {
//       case CheckboxSize.sm:
//         return 8;
//       case CheckboxSize.md:
//         return 9.33;
//     }
//   }

//   double get checkHeight {
//     switch (this) {
//       case CheckboxSize.sm:
//         return 5.5;
//       case CheckboxSize.md:
//         return 6.42;
//     }
//   }

//   double get bottomSpacing {
//     switch (this) {
//       case CheckboxSize.sm:
//         return 24;
//       case CheckboxSize.md:
//         return 29;
//     }
//   }

//   TextStyle get mainTextStyle {
//     switch (this) {
//       case CheckboxSize.sm:
//         return CustomTextStyle.textmedium16.w500;
//       case CheckboxSize.md:
//         return CustomTextStyle.textlarge18.w500;
//     }
//   }

//   TextStyle get secondaryTextStyle {
//     switch (this) {
//       case CheckboxSize.sm:
//         return CustomTextStyle.textmedium16;
//       case CheckboxSize.md:
//         return CustomTextStyle.textlarge18;
//     }
//   }
// }

// class AppCheckbox extends StatefulWidget {
//   final bool value;
//   final Function(bool)? onToggle;
//   final bool isDisabled;
//   final String? mainText;
//   final bool canToggle;
//   final bool straightBar;
//   final CheckboxSize size;
//   final String? subText;

//   const AppCheckbox({
//     super.key,
//     required this.value,
//     this.mainText,
//     this.straightBar = false,
//     this.subText,
//     this.canToggle = true,
//     this.size = CheckboxSize.sm,
//     required this.onToggle,
//   })  : assert(onToggle != null),
//         isDisabled = false;

//   const AppCheckbox.disabled({
//     super.key,
//     required this.value,
//     this.mainText,
//     this.straightBar = false,
//     this.canToggle = false,
//     this.subText,
//     this.size = CheckboxSize.sm,
//   })  : isDisabled = true,
//         onToggle = null;

//   @override
//   State<AppCheckbox> createState() => _AppCheckboxState();
// }

// class _AppCheckboxState extends State<AppCheckbox> {
//   @override
//   void initState() {
//     toggleValue = widget.value;
//     super.initState();
//   }

//   bool onHover = false;
//   bool isFocused = false;

//   late bool toggleValue;
//   @override
//   Widget build(BuildContext context) {
//     return FocusableActionDetector(
//       onShowFocusHighlight: (v) {
//         setState(() => isFocused = v);
//         log('focused');
//       },
//       actions: {
//         ActivateIntent: CallbackAction(
//           onInvoke: (v) {
//             if (!widget.isDisabled) {
//               setState(() {
//                 toggleValue = !toggleValue;
//               });
//               widget.onToggle!(toggleValue);
//             }
//             return null;
//           },
//         ),
//       },
//       shortcuts: {
//         LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(widget.size.focusRadius),
//                   color: widget.isDisabled
//                       ? Colors.transparent
//                       : isFocused
//                           ? AppColors.indigo50
//                           : Colors.transparent,
//                   boxShadow: [
//                     BoxShadow(
//                       color: widget.isDisabled
//                           ? Colors.transparent
//                           : isFocused
//                               ? AppColors.indigo50
//                               : Colors.transparent,
//                       spreadRadius: 4,
//                       blurRadius: 0,
//                       offset: const Offset(0, 0),
//                     ),
//                   ],
//                 ),
//                 child: InkWell(
//                   canRequestFocus: false,
//                   onHover: (v) => setState(() => onHover = v),
//                   borderRadius: BorderRadius.circular(widget.size.radius),
//                   onTap: () {
//                     if (!widget.isDisabled && widget.canToggle) {
//                       setState(() {
//                         toggleValue = !toggleValue;
//                       });
//                       widget.onToggle!(!toggleValue);
//                     }
//                   },
//                   child: Container(
//                     height: widget.size.boxSize,
//                     width: widget.size.boxSize,
//                     decoration: BoxDecoration(
//                       color: widget.isDisabled
//                           ? AppColors.gray20
//                           : onHover || toggleValue
//                               ? AppColors.indigo50
//                               : Colors.white,
//                       borderRadius: BorderRadius.circular(widget.size.radius),
//                       border: Border.all(
//                         width: 1,
//                         color: widget.isDisabled
//                             ? AppColors.gray50
//                             : toggleValue || onHover
//                                 ? AppColors.indigo200
//                                 : isFocused
//                                     ? AppColors.indigo75
//                                     : AppColors.gray50,
//                       ),
//                     ),
//                     alignment: Alignment.center,
//                     child: toggleValue
//                         ? Padding(
//                             padding: const EdgeInsets.all(1.5),
//                             child: SvgPicture.asset(
//                               widget.straightBar
//                                   ? IconsaxLinear.minus
//                                   : IconsaxLinear.check,
//                               color: widget.isDisabled
//                                   ? AppColors.gray50
//                                   : AppColors.indigo200,
//                               //height: widget.size.checkHeight,
//                               //width: widget.size.checkWidth,
//                             ),
//                           )
//                         : const SizedBox(),
//                   ),
//                 ),
//               ),
//               if (widget.mainText != null) ...[
//                 8.spacingW,
//                 Text(
//                   widget.mainText ?? '',
//                   style: widget.size.mainTextStyle.withColor(AppColors.gray800),
//                 ),
//               ],
//             ],
//           ),
//           if (widget.subText != null)
//             Row(
//               children: [
//                 widget.size.bottomSpacing.spacingW,
//                 Text(
//                   widget.subText ?? '',
//                   style: widget.size.secondaryTextStyle
//                       .withColor(AppColors.gray300),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

// class MainAppCheckbox extends StatefulWidget {
//   final bool value;
//   final Function(bool)? onChanged;
//   final bool isDisabled;
//   final bool canToggle;
//   final bool straightBar;
//   final CheckboxSize size;

//   const MainAppCheckbox({
//     super.key,
//     required this.value,
//     this.straightBar = false,
//     this.canToggle = true,
//     this.size = CheckboxSize.sm,
//     required this.onChanged,
//   })  : assert(onChanged != null),
//         isDisabled = false;

//   const MainAppCheckbox.disabled({
//     super.key,
//     required this.value,
//     this.straightBar = false,
//     this.canToggle = false,
//     this.size = CheckboxSize.sm,
//   })  : isDisabled = true,
//         onChanged = null;

//   @override
//   State<MainAppCheckbox> createState() => _MainAppCheckboxState();
// }

// class _MainAppCheckboxState extends State<MainAppCheckbox> {
//   @override
//   void initState() {
//     toggleValue = widget.value;
//     super.initState();
//   }

//   bool onHover = false;
//   bool isFocused = false;

//   late bool toggleValue;
//   @override
//   Widget build(BuildContext context) {
//     return FocusableActionDetector(
//       onShowFocusHighlight: (v) {
//         setState(() => isFocused = v);
//         log('focused');
//       },
//       actions: {
//         ActivateIntent: CallbackAction(
//           onInvoke: (v) {
//             if (!widget.isDisabled) {
//               setState(() {
//                 toggleValue = !toggleValue;
//               });
//               widget.onChanged!(toggleValue);
//             }
//             return null;
//           },
//         ),
//       },
//       shortcuts: {
//         LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(widget.size.focusRadius),
//           color: widget.isDisabled
//               ? Colors.transparent
//               : isFocused
//                   ? AppColors.indigo50
//                   : Colors.transparent,
//           boxShadow: [
//             BoxShadow(
//               color: widget.isDisabled
//                   ? Colors.transparent
//                   : isFocused
//                       ? AppColors.indigo50
//                       : Colors.transparent,
//               spreadRadius: 4,
//               blurRadius: 0,
//               offset: const Offset(0, 0),
//             ),
//           ],
//         ),
//         child: InkWell(
//           canRequestFocus: false,
//           onHover: (v) => setState(() => onHover = v),
//           borderRadius: BorderRadius.circular(widget.size.radius),
//           onTap: () {
//             if (!widget.isDisabled && widget.canToggle) {
//               setState(() {
//                 toggleValue = !toggleValue;
//               });
//               widget.onChanged!(!toggleValue);
//             }
//           },
//           child: Container(
//             height: widget.size.boxSize,
//             width: widget.size.boxSize,
//             decoration: BoxDecoration(
//               color: widget.isDisabled
//                   ? AppColors.gray20
//                   : onHover || toggleValue
//                       ? AppColors.indigo50
//                       : Colors.white,
//               borderRadius: BorderRadius.circular(widget.size.radius),
//               border: Border.all(
//                 width: 1,
//                 color: widget.isDisabled
//                     ? AppColors.gray50
//                     : toggleValue || onHover
//                         ? AppColors.indigo200
//                         : isFocused
//                             ? AppColors.indigo75
//                             : AppColors.gray50,
//               ),
//             ),
//             alignment: Alignment.center,
//             child: toggleValue
//                 ? Padding(
//                     padding: const EdgeInsets.all(1.5),
//                     child: SvgPicture.asset(
//                       widget.straightBar
//                           ? IconsaxLinear.minus
//                           : IconsaxLinear.check,
//                       color: widget.isDisabled
//                           ? AppColors.gray50
//                           : AppColors.indigo200,
//                       //height: widget.size.checkHeight,
//                       //width: widget.size.checkWidth,
//                     ),
//                   )
//                 : const SizedBox(),
//           ),
//         ),
//       ),
//     );
//   }
// }
