import 'package:intl/intl.dart';
import 'package:calorie_tracker/packages/packages.dart';

/// A premium horizontal date selector widget.
/// Shows a scrollable week strip with month/year navigation.
class DateSelector extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime v)? onDateSelected;
  const DateSelector({super.key, this.initialDate, this.onDateSelected});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime _selected;
  late DateTime _focusedMonth;
  late PageController _pageController;

  // Number of days to show per page = one week
  static const _daysPerPage = 7;

  late int _initialPage;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate ?? DateTime.now();
    _focusedMonth = DateTime(_selected.year, _selected.month);
    // Compute the number of weeks since a fixed epoch for the initial page
    final epoch = DateTime(2020);
    _initialPage = _selected.difference(epoch).inDays ~/ _daysPerPage;
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _firstDayOfPage(int page) {
    final epoch = DateTime(2020);
    return epoch.add(Duration(days: page * _daysPerPage));
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selected = day;
      _focusedMonth = DateTime(day.year, day.month);
    });
    widget.onDateSelected?.call(day);
  }

  void _goToPrevWeek() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextWeek() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Neutral surfaces — green only on the selected day
    final containerColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final monthColor = isDark ? Colors.white : const Color(0xFF1C1C1E);
    final dayLabelColor = isDark
        ? Colors.white.withOpacity(0.4)
        : CupertinoColors.secondaryLabel;
    final unselectedDayColor = isDark
        ? Colors.white.withOpacity(0.85)
        : const Color(0xFF1C1C1E);
    final chevronBg = isDark ? const Color(0xFF2C2C2E) : Colors.white;
    final chevronColor = isDark
        ? Colors.white.withOpacity(0.6)
        : const Color(0xFF3C3C43);

    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Month/year header ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _ChevronBtn(
                  icon: Icons.chevron_left_rounded,
                  bgColor: chevronBg,
                  iconColor: chevronColor,
                  onTap: _goToPrevWeek,
                ),
                Expanded(
                  child: Text(
                    DateFormat('MMMM yyyy').format(_focusedMonth),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: monthColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                _ChevronBtn(
                  icon: Icons.chevron_right_rounded,
                  bgColor: chevronBg,
                  iconColor: chevronColor,
                  onTap: _goToNextWeek,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // ── Day strip ────────────────────────────────────────────────
          SizedBox(
            height: 72,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                final first = _firstDayOfPage(page);
                setState(() {
                  _focusedMonth = DateTime(first.year, first.month);
                });
              },
              itemBuilder: (context, page) {
                final first = _firstDayOfPage(page);
                return Row(
                  children: List.generate(_daysPerPage, (i) {
                    final day = first.add(Duration(days: i));
                    final isSelected =
                        day.year == _selected.year &&
                        day.month == _selected.month &&
                        day.day == _selected.day;
                    final isToday =
                        day.year == DateTime.now().year &&
                        day.month == DateTime.now().month &&
                        day.day == DateTime.now().day;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDay(day),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : isToday
                                ? (isDark
                                      ? AppColors.primary.withOpacity(0.15)
                                      : AppColors.primary100)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('E').format(day).substring(0, 1),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.75)
                                      : dayLabelColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                day.day.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : isToday
                                      ? AppColors.primary
                                      : unselectedDayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChevronBtn extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ChevronBtn({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }
}
