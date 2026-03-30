import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/meal_tile.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Meals'),
              backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.06),
                  width: 0.5,
                ),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => pushTo(const AddMealPage()),
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
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                ref.invalidate(mealProvider((date: null, query: query)));
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: CupertinoSearchTextField(
                  placeholder: 'Search meals...',
                  onChanged: (v) =>
                      setState(() => query = v.isEmpty ? null : v),
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.primary900,
                  ),
                  itemColor: isDark
                      ? Colors.white.withOpacity(0.45)
                      : CupertinoColors.secondaryLabel,
                  backgroundColor: isDark
                      ? const Color(0xFF2C2C2E)
                      : CupertinoColors.systemFill,
                ),
              ),
            ),
            meals.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CupertinoActivityIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: Center(child: Text('Error: $e')),
              ),
              data: (data) {
                final list = data.meals ?? [];
                if (list.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No meals yet.')),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => MealTile(
                      mealId: list[index].id,
                      shouldReturn: widget.shouldReturn,
                    ),
                  ),
                );
              },
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}
