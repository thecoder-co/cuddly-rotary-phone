import 'dart:ui';
import 'package:calorie_tracker/features/workout/providers/timer_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:flutter/cupertino.dart';

class WorkoutTimerOverlay extends ConsumerWidget {
  const WorkoutTimerOverlay({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  double _progress(TimerState state) {
    if (state.endTime == null) return 0;
    final totalSeconds = LocalData.restIntervalSeconds;
    if (totalSeconds <= 0) return 0;
    final remainingSeconds = state.remaining.inSeconds;
    return (remainingSeconds / totalSeconds).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(workoutTimerProvider);

    if (!timerState.isRunning || timerState.endTime == null) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = _progress(timerState);
    final isLow = timerState.remaining.inSeconds <= 10;

    return Positioned(
      bottom: MediaQuery.paddingOf(context).bottom + 12,
      left: 12,
      right: 12,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: (isDark ? const Color(0xFF1C1C1E) : Colors.white)
                      .withOpacity(0.82),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        (isDark ? Colors.white : Colors.black).withOpacity(0.06),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress bar at top
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 3,
                        backgroundColor: (isDark
                                ? Colors.white
                                : AppColors.primary)
                            .withOpacity(0.08),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isLow
                              ? const Color(0xFFFF9500)
                              : AppColors.primary,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                      child: Row(
                        children: [
                          // Timer ring icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(
                                  isDark ? 0.15 : 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              CupertinoIcons.timer,
                              size: 18,
                              color: isLow
                                  ? const Color(0xFFFF9500)
                                  : AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Exercise info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'REST',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: isLow
                                        ? const Color(0xFFFF9500)
                                        : AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  timerState.exerciseName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Countdown
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: (isLow
                                      ? const Color(0xFFFF9500)
                                      : AppColors.primary)
                                  .withOpacity(isDark ? 0.15 : 0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _formatDuration(timerState.remaining),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                fontFeatures: const [
                                  FontFeature.tabularFigures()
                                ],
                                fontFamily: 'SF Mono',
                                color: isLow
                                    ? const Color(0xFFFF9500)
                                    : (isDark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // +30s
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            minSize: 34,
                            onPressed: () {
                              ref
                                  .read(workoutTimerProvider.notifier)
                                  .addSeconds(30);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary
                                    .withOpacity(isDark ? 0.15 : 0.08),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '+30s',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 4),

                          // Stop button
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            minSize: 34,
                            onPressed: () {
                              ref
                                  .read(workoutTimerProvider.notifier)
                                  .stopTimer();
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.xmark,
                                size: 14,
                                color: isDark
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
