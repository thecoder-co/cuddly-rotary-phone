import 'package:calorie_tracker/features/home_page/presentation/widgets/date_selector.dart';
import 'package:calorie_tracker/features/home_page/presentation/widgets/meal_tile.dart';
import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/meals/presentation/meals.dart';
import 'package:calorie_tracker/features/meals/providers/meal_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';

class AddMealPage extends ConsumerStatefulWidget {
  final String? date;
  final Meal? meal;
  const AddMealPage({
    super.key,
    this.date,
    this.meal,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<AddMealPage> {
  late final model = widget.meal ?? Meal();

  late List<SubMeal> submeals = widget.meal?.subMeals ?? [];
  late bool showAsSubmeal = widget.date == null;
  WeightConversions weightUnit = WeightConversions.g100;
  WeightConversions calorieWeightUnit = WeightConversions.g100;
  // fetchSubMeals() async {
  //   if (widget.meal == null) return;
  //   if (widget.meal!.subMeals.isEmpty) return;
  //   final ids = widget.meal!.subMeals
  //       .map(
  //         (e) => e.parentId,
  //       )
  //       .nonNulls
  //       .toList();
  //   if (ids.isEmpty) return;
  //   submeals = (await ref
  //           .read(mealProvider((date: widget.date, query: null)).notifier)
  //           .getMealByIds(ids))
  //       .map(
  //         (e) => e..withoutWeight = true,
  //       )
  //       .toList();
  //   setState(() {});
  // }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // fetchSubMeals();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Meal? meal = await pushTo(const MealsPage(
            shouldReturn: true,
          ));
          if (meal == null) return;
          setState(() {
            submeals.add(
              SubMeal()
                ..caloriesPerGram = meal.caloriePerGram
                ..macros = meal.macros
                ..name = meal.name
                ..parentId = meal.id,
            );
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            MediaQuery.paddingOf(context).top.gap,
            Text(
              'Add Meal',
              style: CustomTextStyle.textxLarge20.w700,
            ),
            16.gap,
            AppInput(
              textAlign: TextAlign.center,
              hintText: 'Name',
              initialText: widget.meal?.name,
              validator: (v) {
                if (submeals.isEmpty && v!.isEmpty) {
                  return 'You have to input a name';
                }
                return null;
              },
              onChanged: (v) {
                model.name = v;
              },
            ),
            24.gap,
            Text(
              'Submeals',
              style: CustomTextStyle.textmedium16.w600,
            ),
            SizedBox(
              height: 300,
              child: submeals.isEmpty
                  ? const Center(
                      child: Text('No submeals'),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: submeals.length,
                      separatorBuilder: (context, index) {
                        return 12.gap;
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  submeals.removeAt(index);
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.delete_rounded,
                                    color: Colors.red),
                              ),
                            ),
                            MealTile(
                              mealId: submeals[index].parentId!,
                              asSubMeal: true,
                              initialWeight: submeals[index].chosenWeight,
                              validateWeight: model.caloriePerGram == null,
                              onWeightChanged: (weight) {
                                setState(() {
                                  submeals[index].chosenWeight = weight;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
            ),
            Text(
              'Calorie Overrides',
              style: CustomTextStyle.textmedium16.w600,
            ),
            20.gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 2,
                  child: AppInput(
                    labelText: 'Override Calories',
                    hintText: 'Calories per unit',
                    initialText: widget.meal?.caloriePerGram == null
                        ? null
                        : (widget.meal!.caloriePerGram! * 100).toString(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (v) {
                      if (v == null) return;
                      if (v.isEmpty) {
                        model.caloriePerGram = null;
                        return;
                      }

                      setState(() {
                        model.caloriePerGram =
                            (double.parse(v) / calorieWeightUnit.grams);
                      });
                    },
                  ),
                ),
                12.gap,
                Flexible(
                  child: AppInput.dropdown(
                    initialItem: WeightConversions.g100,
                    items: WeightConversions.values
                        .map(
                          (e) => DropdownMenuItem(
                              value: e, child: Text('per ${e.format}')),
                        )
                        .toList(),
                    onDropdownChanged: (v) {
                      calorieWeightUnit = v;
                    },
                  ),
                ),
              ],
            ),
            20.gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 2,
                  child: AppInput(
                    initialText: widget.meal?.weight?.toString(),
                    labelText: 'Weight',
                    hintText: 'Add item weight...',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (v) {
                      if (v == null) return;
                      if (v.isEmpty) {
                        model.weight = null;
                        return;
                      }
                      model.weight = weightUnit.convertToGrams(double.parse(v));
                    },
                  ),
                ),
                12.gap,
                Flexible(
                  child: AppInput.dropdown(
                    initialItem: WeightConversions.g1,
                    items: WeightConversions.values
                        .where(
                          (e) => e != WeightConversions.g100,
                        )
                        .map(
                          (e) =>
                              DropdownMenuItem(value: e, child: Text(e.format)),
                        )
                        .toList(),
                    onDropdownChanged: (v) {
                      weightUnit = v;
                      // model.weight = weightUnit.convertToGrams(double.parse(model));
                    },
                  ),
                ),
              ],
            ),
            24.gap,
            Text(
              'Macros',
              style: CustomTextStyle.textmedium16.w600,
            ),
            20.gap,
            AppInput(
              initialText: widget.meal?.macros?.protein.toString(),
              labelText: 'Override Protein',
              hintText: 'Add text to use this protein count',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (v) {
                if (v == null) return;
                model.macros ??= Macros();
                if (v.isEmpty) {
                  model.macros!.protein = 0;
                }
                model.macros!.protein = double.parse(v);
              },
            ),
            20.gap,
            AppInput(
              initialText: widget.meal?.macros?.carbs.toString(),
              labelText: 'Override Carbs',
              hintText: 'Add text to use this carb count',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (v) {
                if (v == null) return;
                model.macros ??= Macros();
                if (v.isEmpty) {
                  model.macros!.carbs = 0;
                }
                model.macros!.carbs = double.parse(v);
              },
            ),
            20.gap,
            AppInput(
              initialText: widget.meal?.macros?.fats.toString(),
              labelText: 'Override Fats',
              hintText: 'Add text to use this fat count',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (v) {
                if (v == null) return;
                model.macros ??= Macros();
                if (v.isEmpty) {
                  model.macros!.fats = 0;
                }
                model.macros!.fats = double.parse(v);
              },
            ),
            24.gap,
            Row(
              children: [
                Checkbox.adaptive(
                  value: showAsSubmeal,
                  onChanged: widget.date == null
                      ? null
                      : (v) {
                          setState(() {
                            showAsSubmeal = !showAsSubmeal;
                          });
                        },
                ),
                12.gap,
                const Text('Show as submeal'),
              ],
            ),
            24.gap,
            AppButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                final mainMeal = model.copyWith(
                  date: widget.date,
                  showAsSubmeal: widget.date == null,
                  subMeals: submeals,
                );
                final data = await ref
                    .read(
                        mealProvider((date: widget.date, query: null)).notifier)
                    .addMeal(
                      meal: mainMeal,
                    );

                if (showAsSubmeal && widget.date != null) {
                  ref
                      .read(mealProvider((date: widget.date, query: null))
                          .notifier)
                      .addMeal(
                          meal: model
                            ..date = null
                            ..name = submeals
                                .map((element) => element.name)
                                .where(
                                    (name) => name != null && name.isNotEmpty)
                                .join(' and ')
                            ..weight = null
                            ..showAsSubmeal = true
                            ..subMeals = submeals
                                .map(
                                  (e) => e..chosenWeight = null,
                                )
                                .toList()
                            ..caloriePerGram =
                                double.parse(model.calories) / 100);
                }
                pop(data);
              },
              label: 'Add Meal',
            ),
          ],
        ),
      ),
    );
  }
}
