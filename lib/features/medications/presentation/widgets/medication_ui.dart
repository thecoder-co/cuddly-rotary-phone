import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/medication_models.dart';

const medicationGreen = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF17621A),
  darkColor: Color(0xFF4ADE80),
);
const medicationTeal = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF00796B),
  darkColor: Color(0xFF5EEAD4),
);
const medicationTaken = medicationGreen;
const medicationSnoozed = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF1976D2),
  darkColor: Color(0xFF60A5FA),
);
const medicationDue = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFA95F00),
  darkColor: Color(0xFFFBBF24),
);
const medicationSkipped = Color(0xFF6E6E73);
const medicationMissed = Color(0xFFC62828);

class MedicationPageScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final ObstructingPreferredSizeWidget? navigationBar;
  const MedicationPageScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.navigationBar,
  });

  @override
  Widget build(BuildContext context) => CupertinoTheme(
    data: CupertinoThemeData(
      brightness: Theme.of(context).brightness,
      primaryColor: CupertinoDynamicColor.resolve(medicationGreen, context),
    ),
    child: CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: navigationBar,
      child: Material(type: MaterialType.transparency, child: child),
    ),
  );
}

Color medicationPageColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? const Color(0xFF000000)
    : const Color(0xFFF2F2F7);
Color medicationCardColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? const Color(0xFF1C1C1E)
    : Colors.white;

class MedicationSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final VoidCallback? onTap;
  final Color? borderColor;
  const MedicationSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 16,
    this.onTap,
    this.borderColor,
  });
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: medicationCardColor(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color:
              borderColor ??
              (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(.07)
                  : Colors.transparent),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    ),
  );
}

class MedicationStatusPill extends StatelessWidget {
  final MedicationDoseOutcome outcome;
  const MedicationStatusPill(this.outcome, {super.key});
  @override
  Widget build(BuildContext context) {
    final (rawColor, icon, label) = switch (outcome) {
      MedicationDoseOutcome.taken => (
        medicationTaken,
        CupertinoIcons.check_mark_circled_solid,
        'Taken',
      ),
      MedicationDoseOutcome.snoozed => (
        medicationSnoozed,
        CupertinoIcons.clock_fill,
        'Snoozed',
      ),
      MedicationDoseOutcome.skipped => (
        medicationSkipped,
        CupertinoIcons.forward_fill,
        'Skipped',
      ),
      MedicationDoseOutcome.missed => (
        medicationMissed,
        CupertinoIcons.exclamationmark_circle_fill,
        'Missed',
      ),
      MedicationDoseOutcome.due => (
        medicationDue,
        CupertinoIcons.bell_fill,
        'Due',
      ),
      _ => (medicationSkipped, CupertinoIcons.clock, 'Upcoming'),
    };
    final color = CupertinoDynamicColor.resolve(rawColor, context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared large-title layout from the Stitch medication screens.
class MedicationHeader extends StatelessWidget {
  final String title;
  final String? eyebrow;
  final List<Widget> actions;
  const MedicationHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.actions = const [],
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow != null)
          Text(
            eyebrow!,
            style: TextStyle(
              fontSize: 11,
              letterSpacing: .6,
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(.6),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.8,
                ),
              ),
            ),
            ...actions,
          ],
        ),
      ],
    ),
  );
}

class MedicationRoundButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool filled;
  const MedicationRoundButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.filled = false,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Semantics(
      label: label,
      button: true,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: filled
                ? const Color(0xFF17621A)
                : medicationCardColor(context),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 22,
            color: filled
                ? Colors.white
                : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    ),
  );
}

class MedicationAvatar extends StatelessWidget {
  final double size;
  const MedicationAvatar({super.key, this.size = 44});
  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Medication',
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: medicationTeal.withOpacity(.12),
        borderRadius: BorderRadius.circular(size * .3),
      ),
      child: Center(
        child: MedicationPillIcon(
          color: CupertinoDynamicColor.resolve(medicationTeal, context),
        ),
      ),
    ),
  );
}

class MedicationPillIcon extends StatelessWidget {
  final Color? color;
  const MedicationPillIcon({super.key, this.color});
  @override
  Widget build(BuildContext context) => CustomPaint(
    size: const Size(24, 24),
    painter: _PillPainter(
      color ?? IconTheme.of(context).color ?? medicationTeal,
    ),
  );
}

class _PillPainter extends CustomPainter {
  final Color color;
  const _PillPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-.785398);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-5, -10, 10, 20),
        const Radius.circular(5),
      ),
      paint,
    );
    canvas.drawLine(const Offset(-5, 0), const Offset(5, 0), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PillPainter oldDelegate) =>
      oldDelegate.color != color;
}
