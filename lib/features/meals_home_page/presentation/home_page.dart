import 'package:calorie_tracker/core/utils/extensions/date_extensions.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/date_selector.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/meal_tile.dart';
import 'package:calorie_tracker/features/meals/presentation/add_meal.dart';
import 'package:calorie_tracker/features/meals/providers/meal_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String date = DateTime.now().formatDateDash;

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider((date: date, query: null)));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            width: 0.5,
          ),
        ),
        middle: Text(
          DateTime.parse(date).isCurrentDay
              ? 'Today'
              : DateTime.parse(date).formatDatePretty,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppColors.primary900,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => pushTo(AddMealPage(date: date)),
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.add,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Material(
          color: Colors.transparent,
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              ref.invalidate(mealProvider((date: date, query: null)));
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: CustomTextStyle.base
                            .withColor(isDark
                                ? AppColors.primary50
                                : const Color(0xff565656))
                            .withSize(13),
                      ),
                      Text(
                        'Qarr, baby❤️',
                        style: CustomTextStyle.textxLarge20.w700,
                      ),
                      Text(
                        'You are amazing',
                        style: CustomTextStyle.base.withColor(isDark
                            ? Colors.white.withOpacity(0.45)
                            : const Color(0xff444444)),
                      ),
                      20.gap,
                      DateSelector(
                        onDateSelected: (v) {
                          setState(() {
                            date = v.formatDateDash;
                          });
                        },
                      ),
                      24.gap,
                    ],
                  ),
                ),
                if (meals.valueOrNull != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateTime.parse(date).isCurrentDay
                              ? "Today's meals"
                              : "${DateTime.parse(date).formatDatePretty} meals",
                          style: CustomTextStyle.textmedium16.w600,
                        ),
                      ),
                      Text(
                        '${meals.valueOrNull!.calories}kcal',
                        style: CustomTextStyle.textxLarge20.w700,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                  12.gap,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    itemCount: meals.valueOrNull!.meals?.length ?? 0,
                    separatorBuilder: (BuildContext context, int index) {
                      return 12.gap;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return MealTile(
                          mealId: meals.valueOrNull!.meals![index].id);
                    },
                  ),
                ] else if (meals.isLoading)
                  const SizedBox(
                    height: 200,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                else if (meals.hasError)
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: Text('Error: ${meals.error}'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
