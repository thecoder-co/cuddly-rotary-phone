import 'package:calorie_tracker/core/dialogs/toast.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                      .deleteMeal(
                        meal: meal.value!,
                        id: meal.value?.backendId,
                      );
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  ref
                      .read(mealProvider((query: null, date: null)).notifier)
                      .deleteMeal(
                        meal: meal.value!,
                        id: meal.value?.backendId,
                      );
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              duration: duration,
              decoration: BoxDecoration(
                color: isExpanded
                    ? (isDark
                        ? const Color(0xFF2C2C2E)
                        : const Color(0xFFF2F2F7))
                    : (isDark ? const Color(0xFF1C1C1E) : Colors.white),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : Colors.black.withOpacity(0.06),
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${meal.value!.name ?? meal.value!.subMeals.map((element) => element.name).where((name) => name != null && name.isNotEmpty).join(' and ')}${meal.value!.syncStatus != SyncStatus.synced ? ' (Unsynced)' : ''}',
                                    style: CustomTextStyle.textsmall14.w600,
                                  ),
                                ),
                                Text(
                                  widget.initialWeight != null
                                      ? (widget.initialWeight! *
                                              (meal.value!.caloriePerGram ?? 1))
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
                      // Chevron — no background, just a tinted icon
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => isExpanded = !isExpanded),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0,
                            duration: duration,
                            child: Icon(
                              CupertinoIcons.chevron_down,
                              size: 16,
                              color: isDark
                                  ? Colors.white.withOpacity(0.45)
                                  : CupertinoColors.secondaryLabel,
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
                              '${(meal.value!.macros!.protein * 100).toStringAsFixed(1)}g'
                            ]),
                            _tile([
                              'Carbs',
                              '${(meal.value!.macros!.carbs * 100).toStringAsFixed(1)}g'
                            ]),
                            _tile([
                              'Fats',
                              '${(meal.value!.macros!.fats * 100).toStringAsFixed(1)}g'
                            ]),
                          ] else if (combinedMacros.isNotEmpty) ...[
                            _tile([
                              'Protein',
                              '${(combinedMacros.protein * 100).toStringAsFixed(1)}g'
                            ]),
                            _tile([
                              'Carbs',
                              '${(combinedMacros.carbs * 100).toStringAsFixed(1)}g'
                            ]),
                            _tile([
                              'Fats',
                              '${(combinedMacros.fats * 100).toStringAsFixed(1)}g'
                            ]),
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
