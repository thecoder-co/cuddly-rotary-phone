import 'package:calorie_tracker/core/utils/extensions/date_extensions.dart';
import 'package:calorie_tracker/features/home_page/presentation/widgets/date_selector.dart';
import 'package:calorie_tracker/features/home_page/presentation/widgets/meal_tile.dart';
import 'package:calorie_tracker/features/meals/presentation/add_meal.dart';
import 'package:calorie_tracker/features/meals/providers/meal_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    // ref.read(mealProvider((date:null, query:null)).notifier).
    super.initState();
  }

  String date = DateTime.now().formatDateDash;

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider((date: date, query: null)));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushTo(AddMealPage(
            date: date,
          ));
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediaQuery.paddingOf(context).top.gap,
                Text(
                  'Welcome',
                  style: CustomTextStyle.base
                      .withColor(const Color(0xff565656))
                      .withSize(13),
                ),
                // 12.gap,
                Text(
                  'Qarr, baby❤️',
                  style: CustomTextStyle.textxLarge20.w700,
                ),
                // 20.gap,
                Text(
                  'You are amazing',
                  style:
                      CustomTextStyle.base.withColor(const Color(0xff444444)),
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
          meals.whenOrNull(
                data: (data) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Today's meals",
                                style: CustomTextStyle.textmedium16.w600,
                              ),
                            ),
                            Text(
                              '${data.calories}kcal',
                              style: CustomTextStyle.textxLarge20.w700,
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20),
                        Expanded(
                          child: RefreshIndicator.adaptive(
                            onRefresh: () async {
                              ref.invalidate(
                                  mealProvider((date: date, query: null)));
                            },
                            child: ListView.separated(
                              itemCount: data.meals?.length ?? 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return 12.gap;
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return MealTile(mealId: data.meals![index].id);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ) ??
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
        ],
      ),
    );
  }
}
