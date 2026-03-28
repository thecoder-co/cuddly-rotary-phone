import 'package:calorie_tracker/core/utils/validators.dart';
import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/meals/presentation/add_meal.dart';
import 'package:calorie_tracker/features/meals/providers/meal_provider.dart';
import 'package:calorie_tracker/packages/packages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum WeightConversions {
  g100(100, '100g'),
  g1(1, '1g'),
  kg1(1000, '1kg'),
  lbs(453.592, '1lbs');

  final double grams;
  final String format;

  const WeightConversions(this.grams, this.format);

  /// Converts the current weight unit to grams.
  double toGrams() => grams;

  /// Converts a given value in the current weight unit to grams.
  double convertToGrams(double value) => value * grams;
}

class MealTile extends ConsumerStatefulWidget {
  final int mealId;
  final double? initialWeight;
  final bool validateWeight;
  final bool asSubMeal;
  final bool shouldReturn;
  final Function(double? weight)? onWeightChanged;
  const MealTile({
    super.key,
    required this.mealId,
    this.validateWeight = true,
    this.asSubMeal = false,
    this.initialWeight,
    this.shouldReturn = false,
    this.onWeightChanged,
  }) : assert(asSubMeal == false || onWeightChanged != null);

  @override
  ConsumerState<MealTile> createState() => _MealTileState();
}

class _MealTileState extends ConsumerState<MealTile> {
  bool isExpanded = false;
  bool closeText = true;
  WeightConversions weightUnit = WeightConversions.g1;
  static const duration = Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    final meal = ref.watch(mealByIdProvider(widget.mealId));
    if (!meal.hasValue) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    final weight = (meal.value!.weight ??
        meal.value!.subMeals.fold(
          0,
          (previousValue, element) =>
              (element.chosenWeight ?? 0) + (previousValue ?? 0),
        ) ??
        0);
    final calorieCount = meal.value!.calories;

    final combinedMacros = meal.value!.subMeals.fold(
      Macros(),
      (previousValue, element) {
        previousValue.carbs += (element.macros?.carbs ?? 0);
        previousValue.protein += (element.macros?.protein ?? 0);
        previousValue.fats += (element.macros?.fats ?? 0);
        return previousValue;
      },
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slidable(
          key: ValueKey(widget.mealId),

          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: null,
            children: [
              SlidableAction(
                onPressed: (context) {
                  ref
                      .read(mealProvider((query: null, date: null)).notifier)
                      .deleteMeal(widget.mealId);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              // SlidableAction(
              //   onPressed: (context) {
              //     pushTo(
              //       CreateStudySessionScreen(
              //           date: todo.taskStartDate!.stripTime, todo: todo),
              //     );
              //   },
              //   backgroundColor: const Color(0xFF21B7CA),
              //   foregroundColor: Colors.white,
              //   icon: Icons.edit,
              //   label: 'Edit',
              // ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  ref
                      .read(mealProvider((query: null, date: null)).notifier)
                      .deleteMeal(widget.mealId);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              // SlidableAction(
              //   onPressed: (context) {
              //     pushTo(
              //       CreateStudySessionScreen(
              //           date: todo.taskStartDate!.stripTime, todo: todo),
              //     );
              //   },
              //   backgroundColor: const Color(0xFF21B7CA),
              //   foregroundColor: Colors.white,
              //   icon: Icons.edit,
              //   label: 'Edit',
              // ),
            ],
          ),
          child: InkWell(
            onTap: () {
              if (widget.shouldReturn) {
                pop(meal.value!);
              } else {
                pushTo(
                  AddMealPage(
                    date: meal.value!.date,
                    meal: meal.value!,
                  ),
                );
              }
            },
            child: AnimatedContainer(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: duration,
              decoration: ShapeDecoration(
                color: isExpanded ? AppColors.primary50 : null,
                shape: isExpanded
                    ? RoundedRectangleBorder(
                        // side: const BorderSide(width: 1, color: Color(0xFF93CDF0)),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : RoundedRectangleBorder(
                        // side: const BorderSide(width: 1, color: Color(0xFFE4E8EB)),
                        borderRadius: BorderRadius.circular(8),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    meal.value!.name ??
                                        meal.value!.subMeals
                                            .map((element) => element.name)
                                            .where((name) =>
                                                name != null && name.isNotEmpty)
                                            .join(' and '),
                                    style: CustomTextStyle.textsmall14.w600,
                                  ),
                                ),
                                Text(
                                  widget.initialWeight != null
                                      ? (widget.initialWeight! *
                                              meal.value!.caloriesUnit)
                                          .toStringAsFixed(2)
                                      : '${(weight) <= 0 || widget.asSubMeal ? '' : '${weight}g/'}${calorieCount}kcal${(weight) <= 0 || widget.asSubMeal ? '/100g' : ''}',
                                  style: CustomTextStyle.textmedium16.w700,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      16.gap,
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: AnimatedContainer(
                          duration: duration,
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: switch (isExpanded) {
                              true => AppColors.primary,
                              false => AppColors.primary100,
                            },
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: AnimatedRotation(
                            turns: switch (isExpanded) {
                              false => 0,
                              true => 0.5,
                            },
                            duration: duration,
                            child: AnimatedTheme(
                              onEnd: () {
                                setState(() {
                                  closeText = !closeText;
                                });
                              },
                              data: switch (isExpanded) {
                                true => ThemeData(
                                    iconTheme: const IconThemeData(
                                      color: AppColors.primary50,
                                    ),
                                  ),
                                false => ThemeData(
                                    iconTheme: const IconThemeData(
                                      color: AppColors.primary,
                                    ),
                                  ),
                              },
                              child:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isExpanded) ...[
                    16.gap,
                    AnimatedOpacity(
                      opacity: isExpanded ? 1 : 0,
                      duration: duration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var (index, element)
                              in meal.value!.subMeals.indexed) ...[
                            _tile(
                              [
                                element.name ?? '',
                                '${element.chosenWeight}g',
                                '${(element.caloriesPerGram ?? 1) * (element.chosenWeight ?? 1)}kcal'
                              ],
                              onTap: () {},
                            ),
                            if (index != meal.value!.subMeals.length - 1) 2.gap,
                          ],
                          8.gap,
                          Text(
                            'Macros',
                            style: CustomTextStyle.textxSmall12.w700,
                          ),
                          5.gap,
                          if (meal.value!.macros != null) ...[
                            _tile([
                              'Protein',
                              '${meal.value!.macros!.protein * 100}g'
                            ]),
                            _tile([
                              'Carbs',
                              '${meal.value!.macros!.carbs * 100}'
                            ]),
                            _tile(
                                ['Fats', '${meal.value!.macros!.fats * 100}']),
                          ] else if (combinedMacros.isNotEmpty) ...[
                            _tile([
                              'Protein',
                              '${combinedMacros.protein * 100}g'
                            ]),
                            _tile(['Carbs', '${combinedMacros.carbs * 100}']),
                            _tile(['Fats', '${combinedMacros.fats * 100}']),
                          ],
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
        if (widget.asSubMeal) ...[
          12.gap,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: AppInput(
                  hintText: 'Add item weight...',
                  initialText: widget.initialWeight?.toString(),
                  validator: widget.validateWeight
                      ? Validator().isNotEmpty().validate
                      : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (v) {
                    if (v == null) return;
                    if (v.isEmpty) {
                      widget.onWeightChanged!(null);
                      return;
                    }
                    widget.onWeightChanged!(
                        weightUnit.convertToGrams(double.parse(v)));
                  },
                ),
              ),
              12.gap,
              Flexible(
                child: AppInput.dropdown(
                  initialItem: weightUnit,
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
                  },
                ),
              ),
            ],
          )
        ],
      ],
    );
  }

  @widgetFactory
  Widget _tile(List<String> tiles, {VoidCallback? onTap}) {
    while (tiles.length < 3) {
      tiles.add('');
    }
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            '\u2022 ',
            style: CustomTextStyle.textxSmall12.w700,
          ),
          ...tiles.mapIndexed(
            (index, element) {
              return Expanded(
                child: Text(
                  element,
                  style: CustomTextStyle.textxSmall12.copyWith(
                    fontWeight:
                        index == 0 ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              );
            },
          ),
          3.gap,
          Icon(
            Icons.keyboard_arrow_right,
            size: 14,
            color: onTap != null ? AppColors.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
