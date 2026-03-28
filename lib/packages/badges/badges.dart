// import '../packages.dart';

// enum BadgeSize {
//   sm,
//   md,
//   lg,
// }

// enum BadgeIcon {
//   none,
//   xClose,
//   arrowUp,
// }

// class AppBadge extends StatelessWidget {
//   final String text;
//   final BadgeSize size;
//   final BadgeIcon icon;
//   final EdgeInsets? padding;
//   final Color backgroundColor;
//   final Color textColor;
//   const AppBadge({
//     super.key,
//     required this.text,
//     required this.backgroundColor,
//     required this.textColor,
//     this.size = BadgeSize.lg,
//     this.icon = BadgeIcon.none,
//     this.padding,
//   });

//   const AppBadge.yellow({
//     super.key,
//     required this.text,
//     this.size = BadgeSize.lg,
//     this.icon = BadgeIcon.none,
//     this.padding,
//   })  : textColor = const Color(0xffEC913C),
//         backgroundColor = const Color(0xffFFE3B0);

//   const AppBadge.solid({
//     super.key,
//     required this.text,
//     required this.backgroundColor,
//     this.size = BadgeSize.lg,
//     this.icon = BadgeIcon.none,
//     this.textColor = Colors.white,
//     this.padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(40),
//       ),
//       padding: padding ??
//           (size == BadgeSize.lg
//               ? const EdgeInsets.symmetric(
//                   vertical: 4,
//                   horizontal: 12,
//                 )
//               : const EdgeInsets.symmetric(
//                   vertical: 2,
//                   horizontal: 8,
//                 )),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon == BadgeIcon.arrowUp) ...[
//             SvgPicture.asset(
//               IconsaxLinear.arrowUp,
//               color: textColor,
//               height: 12,
//               width: 12,
//             ),
//             7.spacingW,
//           ],
//           Text(
//             text,
//             style: size == BadgeSize.sm
//                 ? CustomTextStyle.textsmall14.w500.withColor(textColor)
//                 : CustomTextStyle.textmedium16.w500.withColor(textColor),
//           ),
//           if (icon == BadgeIcon.xClose) ...[],
//         ],
//       ),
//     );
//   }
// }
