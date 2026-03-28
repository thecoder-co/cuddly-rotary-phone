// import 'package:calorie_tracker/packages/packages.dart';

// class BigBadge extends StatelessWidget {
//   final String label;
//   final Color color;
//   final Color backColor;

//   const BigBadge({
//     super.key,
//     required this.label,
//     required this.color,
//     required this.backColor,
//   });

//   const BigBadge.red({
//     super.key,
//     required this.label,
//   })  : color = const Color(0xffFFE8E8),
//         backColor = const Color(0xffD92D20);

//   const BigBadge.yellow({
//     super.key,
//     required this.label,
//   })  : color = const Color(0xffFFF8E8),
//         backColor = const Color(0xffD9B120);

//   const BigBadge.green({
//     super.key,
//     required this.label,
//   })  : color = const Color(0xffE8FFE8),
//         backColor = const Color(0xff039855);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: ShapeDecoration(
//         color: color,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             IconsaxOutline.warning2,
//             color: backColor,
//             height: 12,
//           ),
//           6.spacingW,
//           Text(
//             label,
//             style:
//                 CustomTextStyle.textsmall14.withColor(const Color(0xFF667085)),
//           ),
//         ],
//       ),
//     );
//   }
// }
