import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_tracker/features/meals_home_page/presentation/widgets/meal_tile.dart';
import 'package:calorie_tracker/features/meals/models/meal.dart';
import 'package:calorie_tracker/features/meals/presentation/meals.dart';
import 'package:calorie_tracker/features/meals/providers/meal_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:calorie_tracker/packages/packages.dart';

class AddMealPage extends ConsumerStatefulWidget {
  final String? date;
  final Meal? meal;
  const AddMealPage({super.key, this.date, this.meal});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<AddMealPage> {
  late final model = widget.meal ?? Meal();

  late List<SubMeal> submeals = widget.meal?.subMeals ?? [];
  late bool showAsSubmeal = widget.date == null;
  var weightUnit = WeightConversions.g100;
  var calorieWeightUnit = WeightConversions.g100;
  var proteinWeightUnit = WeightConversions.g100;
  var carbsWeightUnit = WeightConversions.g100;
  var fatsWeightUnit = WeightConversions.g100;
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
  //     setState(() {});
  // }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      // Use timestamp to avoid name collisions
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${pickedFile.name}';
      final savedFile = await File(
        pickedFile.path,
      ).copy('${appDir.path}/$fileName');

      setState(() {
        model.image = 'offline_file:${savedFile.path}';
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    if (kIsWeb) return;
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Add Meal Image'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  calculateOverrides() {
    double totalCalories = 0;
    double totalWeight = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFats = 0;

    for (var submeal in submeals) {
      final weight = submeal.chosenWeight ?? 0;
      totalWeight += weight;
      totalCalories += (submeal.caloriesPerGram ?? 0) * weight;
      totalProtein += (submeal.macros?.protein ?? 0) * weight;
      totalCarbs += (submeal.macros?.carbs ?? 0) * weight;
      totalFats += (submeal.macros?.fats ?? 0) * weight;
    }

    if (totalWeight == 0) {
      caloriesController.clear();
      weightController.clear();
      proteinController.clear();
      carbsController.clear();
      fatsController.clear();
      setState(() {
        model.caloriePerGram = null;
        model.weight = null;
        model.macros = Macros();
      });
      return;
    }

    final calPerGram = totalCalories / totalWeight;
    final protPerGram = totalProtein / totalWeight;
    final carbPerGram = totalCarbs / totalWeight;
    final fatPerGram = totalFats / totalWeight;

    caloriesController.text = (calPerGram * calorieWeightUnit.grams)
        .toStringAsFixed(2);
    weightController.text = (totalWeight).toStringAsFixed(2);
    proteinController.text = (protPerGram * proteinWeightUnit.grams)
        .toStringAsFixed(2);
    carbsController.text = (carbPerGram * carbsWeightUnit.grams)
        .toStringAsFixed(2);
    fatsController.text = (fatPerGram * fatsWeightUnit.grams).toStringAsFixed(
      2,
    );

    setState(() {
      model.weight = totalWeight;
      model.caloriePerGram = calPerGram;
      model.macros ??= Macros();
      model.macros!.protein = protPerGram;
      model.macros!.carbs = carbPerGram;
      model.macros!.fats = fatPerGram;
    });
  }

  final caloriesController = TextEditingController();
  final weightController = TextEditingController();
  final proteinController = TextEditingController();
  final carbsController = TextEditingController();
  final fatsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.meal != null) {
      if (widget.meal!.caloriePerGram != null) {
        caloriesController.text = (widget.meal!.caloriePerGram! * 100)
            .toStringAsFixed(2);
      }
      if (widget.meal!.weight != null) {
        weightController.text = (widget.meal!.weight!).toStringAsFixed(2);
      }
      if (widget.meal!.macros?.protein != null) {
        proteinController.text = (widget.meal!.macros!.protein * 100)
            .toStringAsFixed(2);
      }
      if (widget.meal!.macros?.carbs != null) {
        carbsController.text = (widget.meal!.macros!.carbs * 100)
            .toStringAsFixed(2);
      }
      if (widget.meal!.macros?.fats != null) {
        fatsController.text = (widget.meal!.macros!.fats * 100).toStringAsFixed(
          2,
        );
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // fetchSubMeals();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Log Meal${widget.meal?.backendId == null ? ' (*)' : ''}'),
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
          onPressed: () async {
            Meal? meal = await pushTo(const MealsPage(shouldReturn: true));
            if (meal == null) return;
            setState(() {
              submeals.add(
                SubMeal()
                  ..caloriesPerGram = meal.caloriePerGram
                  ..macros = meal.macros
                  ..name = meal.name
                  ..backendId = meal.backendId
                  ..parentId = meal.id,
              );
            });
            calculateOverrides();
          },
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
      backgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      child: Material(
        color: Colors.transparent,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppInput(
                        style: CustomTextStyle.textxLarge20.w700,
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
                      GestureDetector(
                        onTap: () => _showImageSourceActionSheet(context),
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: model.image != null
                              ? (model.image!.startsWith('offline_file:')
                                    ? Image.file(
                                        File(
                                          model.image!.replaceAll(
                                            'offline_file:',
                                            '',
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: model.image!,
                                        fit: BoxFit.cover,
                                      ))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 40,
                                      color: Theme.of(
                                        context,
                                      ).primaryColor.withOpacity(0.6),
                                    ),
                                    8.gap,
                                    Text(
                                      'Add Photo',
                                      style: CustomTextStyle.textsmall14
                                          .withColor(
                                            Theme.of(
                                              context,
                                            ).primaryColor.withOpacity(0.8),
                                          ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      24.gap,
                      Text(
                        'Submeals',
                        style: CustomTextStyle.textmedium16.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 300,
                          child: submeals.isEmpty
                              ? const Center(child: Text('No submeals'))
                              : ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  itemCount: submeals.length,
                                  separatorBuilder: (context, index) {
                                    return 12.gap;
                                  },
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              submeals.removeAt(index);
                                            });
                                            calculateOverrides();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.delete_rounded,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        MealTile(
                                          mealId:
                                              submeals[index].parentId ??
                                              submeals[index].backendId ??
                                              0,
                                          asSubMeal: true,
                                          initialWeight:
                                              submeals[index].chosenWeight,
                                          validateWeight:
                                              model.caloriePerGram == null,
                                          onWeightChanged: (weight) {
                                            setState(() {
                                              submeals[index].chosenWeight =
                                                  weight;
                                            });
                                            calculateOverrides();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
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
                              controller: caloriesController,
                              labelText: 'Override Calories',
                              hintText: 'Calories per unit',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (v) {
                                if (v == null) return;
                                if (v.isEmpty) {
                                  model.caloriePerGram = null;
                                  return;
                                }
                                final parsed = double.tryParse(
                                  v.replaceAll(RegExp(r'\.$'), '.0'),
                                );
                                if (parsed == null) return;
                                setState(() {
                                  model.caloriePerGram =
                                      parsed / calorieWeightUnit.grams;
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
                                      value: e,
                                      child: Text('per ${e.format}'),
                                    ),
                                  )
                                  .toList(),
                              onDropdownChanged: (v) {
                                calorieWeightUnit = v;
                                model.caloriePerGram =
                                    (double.parse(v) / calorieWeightUnit.grams);
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
                              controller: weightController,
                              labelText: 'Weight',
                              hintText: 'Add item weight...',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (v) {
                                if (v == null) return;
                                if (v.isEmpty) {
                                  model.weight = null;
                                  return;
                                }
                                final parsed = double.tryParse(
                                  v.replaceAll(RegExp(r'\.$'), '.0'),
                                );
                                if (parsed == null) return;
                                model.weight = weightUnit.convertToGrams(
                                  parsed,
                                );
                              },
                            ),
                          ),
                          12.gap,
                          Flexible(
                            child: AppInput.dropdown(
                              initialItem: WeightConversions.g1,
                              items: WeightConversions.values
                                  .where((e) => e != WeightConversions.g100)
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.format),
                                    ),
                                  )
                                  .toList(),
                              onDropdownChanged: (v) {
                                weightUnit = v;
                                model.weight = weightUnit.convertToGrams(
                                  double.parse(v),
                                );
                                // model.weight = weightUnit.convertToGrams(double.parse(model));
                              },
                            ),
                          ),
                        ],
                      ),
                      24.gap,
                      Text('Macros', style: CustomTextStyle.textmedium16.w600),
                      20.gap,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 2,
                            child: AppInput(
                              controller: proteinController,
                              labelText: 'Override Protein',
                              hintText: 'Add text to use this protein count',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (v) {
                                if (v == null) return;
                                model.macros ??= Macros();
                                if (v.isEmpty) {
                                  model.macros!.protein = 0;
                                  return;
                                }
                                final parsed = double.tryParse(
                                  v.replaceAll(RegExp(r'\.$'), '.0'),
                                );
                                if (parsed != null)
                                  model.macros!.protein =
                                      parsed / proteinWeightUnit.grams;
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
                                      value: e,
                                      child: Text('per ${e.format}'),
                                    ),
                                  )
                                  .toList(),
                              onDropdownChanged: (v) {
                                proteinWeightUnit = v;
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
                              controller: carbsController,
                              labelText: 'Override Carbs',
                              hintText: 'Add text to use this carb count',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (v) {
                                if (v == null) return;
                                model.macros ??= Macros();
                                if (v.isEmpty) {
                                  model.macros!.carbs = 0;
                                  return;
                                }
                                final parsed = double.tryParse(
                                  v.replaceAll(RegExp(r'\.$'), '.0'),
                                );
                                if (parsed != null)
                                  model.macros!.carbs =
                                      parsed / carbsWeightUnit.grams;
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
                                      value: e,
                                      child: Text('per ${e.format}'),
                                    ),
                                  )
                                  .toList(),
                              onDropdownChanged: (v) {
                                carbsWeightUnit = v;
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
                              controller: fatsController,
                              labelText: 'Override Fats',
                              hintText: 'Add text to use this fat count',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (v) {
                                if (v == null) return;
                                model.macros ??= Macros();
                                if (v.isEmpty) {
                                  model.macros!.fats = 0;
                                  return;
                                }
                                final parsed = double.tryParse(
                                  v.replaceAll(RegExp(r'\.$'), '.0'),
                                );
                                if (parsed != null)
                                  model.macros!.fats =
                                      parsed / fatsWeightUnit.grams;
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
                                      value: e,
                                      child: Text('per ${e.format}'),
                                    ),
                                  )
                                  .toList(),
                              onDropdownChanged: (v) {
                                fatsWeightUnit = v;
                              },
                            ),
                          ),
                        ],
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
                          var mainMeal = model.copyWith(
                            date: widget.date,
                            type: widget.date == null ? 'TEMPLATE' : 'LOGENTRY',
                            showAsSubmeal: showAsSubmeal,
                            subMeals: submeals,
                          );
                          if (widget.meal == null) {
                            final data = await ref
                                .read(
                                  mealProvider((
                                    date: widget.date,
                                    query: null,
                                  )).notifier,
                                )
                                .addMeal(meal: mainMeal);
                            pop(data);
                          } else {
                            final data = await ref
                                .read(
                                  mealProvider((
                                    date: widget.date,
                                    query: null,
                                  )).notifier,
                                )
                                .updateMeal(
                                  meal: mainMeal,
                                  id: widget.meal?.backendId,
                                );
                            if (data == null) return;
                            pop(data);
                          }
                        },
                        label: 'Add Meal',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),
    );
  }
}
