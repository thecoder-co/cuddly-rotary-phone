import 'package:calorie_tracker/features/home_page/presentation/widgets/date_selector.dart';
import 'package:calorie_tracker/features/home_page/presentation/widgets/meal_tile.dart';
import 'package:calorie_tracker/features/meals/presentation/add_meal.dart';
import 'package:calorie_tracker/features/meals/providers/meal_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class MealsPage extends ConsumerStatefulWidget {
  final bool shouldReturn;
  const MealsPage({
    super.key,
    this.shouldReturn = false,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MealsPage> {
  String? query;
  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider((date: null, query: query)));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushTo(const AddMealPage());
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaQuery.paddingOf(context).top.gap,
            Text(
              'Meals',
              style: CustomTextStyle.textxLarge20.w700,
            ),
            8.gap,
            Text(
              'Search All Meals',
              style: CustomTextStyle.base.withColor(const Color(0xff444444)),
            ),
            20.gap,
            AppInput(
              textAlign: TextAlign.center,
              hintText: 'Search meals...',
              onChanged: (v) {
                setState(() {
                  query = v;
                });
              },
            ),
            meals.whenOrNull(
                  data: (data) {
                    return Expanded(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () async {
                          ref.invalidate(
                              mealProvider((date: null, query: query)));
                        },
                        child: ListView.separated(
                          itemCount: data.meals?.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) {
                            return 12.gap;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return MealTile(
                              mealId: data.meals![index].id,
                              shouldReturn: widget.shouldReturn,
                            );
                          },
                        ),
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
      ),
    );
  }
}
