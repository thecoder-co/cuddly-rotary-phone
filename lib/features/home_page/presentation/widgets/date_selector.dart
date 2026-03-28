import 'package:intl/intl.dart';
import 'package:calorie_tracker/core/utils/extensions/date_extensions.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelector extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime v)? onDateSelected;
  const DateSelector({
    super.key,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime selectedDate = widget.initialDate ?? DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: TableCalendar(
        calendarFormat: CalendarFormat.week,
        currentDay: selectedDate,
        onDaySelected: (day, focusedDay) {
          setState(() {
            selectedDate = day;
          });
          if (widget.onDateSelected == null) return;
          widget.onDateSelected!(day);
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          leftChevronIcon: Container(
            width: 32,
            height: 32,
            decoration: ShapeDecoration(
              color: AppColors.primary100,
              shape: RoundedRectangleBorder(
                // side: const BorderSide(
                //   width: 1,
                //   strokeAlign: BorderSide.strokeAlignCenter,
                //   color: Color(0xFFE4E8EB),
                // ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.chevron_left_rounded,
              size: 13,
              color: AppColors.primary,
            ),
          ),
          rightChevronIcon: Container(
            width: 32,
            height: 32,
            decoration: ShapeDecoration(
              color: AppColors.primary100,
              shape: RoundedRectangleBorder(
                // side: const BorderSide(
                //   width: 1,
                //   strokeAlign: BorderSide.strokeAlignCenter,
                //   color: Color(0xFFE4E8EB),
                // ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.chevron_right_rounded,
              size: 13,
              color: AppColors.primary,
            ),
          ),
        ),
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) => Text(
            day.formatMonthYear,
            textAlign: TextAlign.center,
            style: CustomTextStyle.textsmall14.w600,
          ),
          dowBuilder: (context, day) {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                color: day.day == selectedDate.day
                    ? AppColors.primary100
                    : Colors.transparent,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                DateFormat('E').format(day),
                style: TextStyle(
                  color: day.day == selectedDate.day
                      ? AppColors.primary
                      : AppColors.textColorGrey1,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(t: 3),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Container(
              decoration: BoxDecoration(
                color: day.day == focusedDay.day
                    ? AppColors.primary100
                    : Colors.transparent,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: day.day == focusedDay.day
                      ? AppColors.primary
                      : Colors.transparent,
                ),
                padding: const EdgeInsets.all(6),
                child: Text(
                  DateFormat('d').format(day),
                  style: TextStyle(
                    color: day.day == selectedDate.day
                        ? Colors.white
                        : AppColors.textColorGrey1,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
        focusedDay: selectedDate,
        firstDay: DateTime(1900),
        lastDay: DateTime(2100),
      ),
    );
  }
}
