import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseDetailsHeaderRow extends StatelessWidget {
  const ExerciseDetailsHeaderRow({
    super.key,
    required this.context,
    required this.icon,
    this.iconColor,
    required this.title,
    this.value,
    required this.onTap,
  });

  final BuildContext context;
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? CupertinoColors.systemGreen,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            if (value != null)
              Text(
                value!,
                style: const TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            const SizedBox(width: 4),
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }
}
