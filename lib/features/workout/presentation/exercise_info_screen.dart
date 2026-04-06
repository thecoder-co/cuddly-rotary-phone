import 'dart:convert';
import 'package:calorie_tracker/features/workout/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseInfoScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseInfoScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? desc;
    if (exercise.jsonDesc != null) {
      try {
        desc = jsonDecode(exercise.jsonDesc!);
      } catch (e) {
        // ignore
      }
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? CupertinoColors.black
        : CupertinoColors.systemGroupedBackground;
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Back',
          middle: Text(
            exercise.name ?? 'Exercise Info',
            style: TextStyle(color: textColor),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImageCarousel(context, cardColor),
                if (desc != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeaderInfo(desc, textColor, isDark),
                        const SizedBox(height: 16),
                        _buildPropertiesCard(desc, cardColor, isDark),
                        const SizedBox(height: 16),
                        _buildMusclesCard(desc, cardColor, isDark),
                        const SizedBox(height: 16),
                        _buildInstructionsCard(desc, cardColor, isDark),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                        'No detailed description available.',
                        style: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel(BuildContext context, Color cardColor) {
    final images = exercise.images;
    if (images == null || images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      color: cardColor,
      height: 250,
      width: double.infinity,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final imageUrl = images[index];
          return InteractiveViewer(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    CupertinoIcons.photo,
                    size: 40,
                    color: CupertinoColors.systemGrey,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CupertinoActivityIndicator());
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderInfo(
    Map<String, dynamic> desc,
    Color textColor,
    bool isDark,
  ) {
    final title = desc['name'] as String? ?? exercise.name ?? 'Unknown';
    final category = desc['category'] as String?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (category != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              category.toUpperCase(),
              style: const TextStyle(
                color: CupertinoColors.systemGreen,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPropertiesCard(
    Map<String, dynamic> desc,
    Color cardColor,
    bool isDark,
  ) {
    final level = desc['level'] as String?;
    final force = desc['force'] as String?;
    final mechanic = desc['mechanic'] as String?;
    final equipment = desc['equipment'] as String?;

    if (level == null &&
        force == null &&
        mechanic == null &&
        equipment == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          if (level != null)
            _buildPropertyChip(
              'Level',
              level,
              CupertinoColors.systemPurple,
              isDark,
            ),
          if (force != null)
            _buildPropertyChip(
              'Force',
              force,
              CupertinoColors.systemBlue,
              isDark,
            ),
          if (mechanic != null)
            _buildPropertyChip(
              'Mechanic',
              mechanic,
              CupertinoColors.systemOrange,
              isDark,
            ),
          if (equipment != null)
            _buildPropertyChip(
              'Equipment',
              equipment,
              CupertinoColors.systemTeal,
              isDark,
            ),
        ],
      ),
    );
  }

  Widget _buildPropertyChip(
    String label,
    String value,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _capitalize(value),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusclesCard(
    Map<String, dynamic> desc,
    Color cardColor,
    bool isDark,
  ) {
    final primary = desc['primaryMuscles'] as List<dynamic>?;
    final secondary = desc['secondaryMuscles'] as List<dynamic>?;

    if ((primary == null || primary.isEmpty) &&
        (secondary == null || secondary.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Target Muscles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          if (primary != null && primary.isNotEmpty) ...[
            Text(
              'PRIMARY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: primary
                  .map((m) => _buildMuscleTag(m.toString(), true, isDark))
                  .toList(),
            ),
            if (secondary != null && secondary.isNotEmpty)
              const SizedBox(height: 16),
          ],
          if (secondary != null && secondary.isNotEmpty) ...[
            Text(
              'SECONDARY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: secondary
                  .map((m) => _buildMuscleTag(m.toString(), false, isDark))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMuscleTag(String muscle, bool isPrimary, bool isDark) {
    final color = isPrimary
        ? CupertinoColors.systemRed
        : CupertinoColors.systemIndigo;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        _capitalize(muscle),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color.withValues(alpha: isDark ? 1.0 : 0.8),
        ),
      ),
    );
  }

  Widget _buildInstructionsCard(
    Map<String, dynamic> desc,
    Color cardColor,
    bool isDark,
  ) {
    final instructions = desc['instructions'] as List<dynamic>?;
    if (instructions == null || instructions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.book,
                size: 20,
                color: isDark ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                'Instructions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...instructions.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGreen.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        entry.value.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
