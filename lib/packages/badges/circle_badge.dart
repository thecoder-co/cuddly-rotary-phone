// import '../packages.dart';

// extension Size on BadgeSize {
//   double get size {
//     switch (this) {
//       case BadgeSize.sm:
//         return 4;
//       case BadgeSize.md:
//         return 6;
//       case BadgeSize.lg:
//         return 8;
//     }
//   }
// }

// class AppCircleBadge extends StatelessWidget {
//   final BadgeSize size;

//   final Color backgroundColor;
//   final Color iconColor;
//   const AppCircleBadge({
//     super.key,
//     required this.backgroundColor,
//     required this.iconColor,
//     this.size = BadgeSize.md,
//   });
//   const AppCircleBadge.solid({
//     super.key,
//     required this.backgroundColor,
//     this.size = BadgeSize.md,
//     this.iconColor = Colors.white,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(40),
//       ),
//       padding: EdgeInsets.all(size.size),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SvgPicture.asset(
//             SvgBaseIcons.arrowUp,
//             color: iconColor,
//             height: 7,
//             width: 7,
//           ),
//         ],
//       ),
//     );
//   }
// }
