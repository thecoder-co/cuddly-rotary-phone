import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';
import '../../../core/services/local_data/local_data.dart';
import '../models/medication_models.dart';
import '../providers/medication_provider.dart';
import '../services/medication_recurrence_engine.dart';
import 'widgets/medication_ui.dart';

class AddMedicationFlow extends ConsumerStatefulWidget {
  final MedicationLocal? medication;
  final MedicationScheduleLocal? schedule;
  final String? suggestedTimezone;
  const AddMedicationFlow({
    super.key,
    this.medication,
    this.schedule,
    this.suggestedTimezone,
  });
  @override
  ConsumerState<AddMedicationFlow> createState() => _AddMedicationFlowState();
}

class _AddMedicationFlowState extends ConsumerState<AddMedicationFlow> {
  static const uuid = Uuid();
  static const strengthUnits = [
    'mg',
    'mcg',
    'g',
    'mL',
    'units',
    'IU',
    '%',
    'mg/mL',
    'mcg/mL',
    'g/mL',
    'units/mL',
    'IU/mL',
    'mEq',
    'mmol',
    'other',
  ];
  static const forms = [
    'tablet',
    'capsule',
    'liquid',
    'suspension',
    'injectable',
    'drops',
    'inhaler',
    'spray',
    'patch',
    'cream',
    'ointment',
    'gel',
    'suppository',
    'powder',
    'sachet',
    'other',
  ];
  static const routes = [
    'oral',
    'sublingual',
    'buccal',
    'topical',
    'transdermal',
    'inhaled',
    'nasal',
    'ophthalmic',
    'otic',
    'rectal',
    'vaginal',
    'subcutaneous',
    'intramuscular',
    'intravenous',
    'other',
  ];
  final formKey = GlobalKey<FormState>();
  int step = 0;
  bool saving = false;
  final name = TextEditingController(),
      strength = TextEditingController(),
      strengthUnit = TextEditingController(text: 'mg'),
      medicationForm = TextEditingController(text: 'tablet'),
      route = TextEditingController(text: 'oral'),
      purpose = TextEditingController(),
      quantity = TextEditingController(text: '1'),
      doseUnit = TextEditingController(text: 'tablet'),
      instructions = TextEditingController(),
      supply = TextEditingController(),
      threshold = TextEditingController();
  MedicationFrequency frequency = MedicationFrequency.daily;
  MedicationTimezoneBehavior timezoneBehavior =
      MedicationTimezoneBehavior.followDevice;
  MedicationInvalidDatePolicy invalidPolicy =
      MedicationInvalidDatePolicy.lastValidDay;
  List<int> weekdays = [1, 3, 5];
  int interval = 1, monthlyDay = 1, cycleOn = 7, cycleOff = 7;
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  String intervalUnit = 'HOURS';
  late String regimenTimezone;
  List<TimeOfDay> times = const [TimeOfDay(hour: 8, minute: 0)];
  bool reminders = true, sound = true, vibration = true, supplyEnabled = false;
  int snooze = 15;
  MedicationPrivacyLevel privacy = MedicationPrivacyLevel.private;
  final labels = const [
    'Medication',
    'Dose',
    'Schedule',
    'Reminders',
    'Supply',
    'Review',
  ];
  @override
  void initState() {
    super.initState();
    final medication = widget.medication;
    final schedule = widget.schedule;
    regimenTimezone =
        widget.suggestedTimezone ?? schedule?.timezone ?? tz.local.name;
    if (widget.suggestedTimezone != null) step = 2;
    if (medication != null) {
      name.text = medication.displayName;
      strength.text = medication.strengthValue?.toString() ?? '';
      strengthUnit.text = medication.strengthUnit ?? 'mg';
      medicationForm.text = medication.form ?? '';
      route.text = medication.route ?? '';
      purpose.text = medication.purpose ?? '';
      instructions.text = medication.instructions ?? '';
    }
    if (schedule != null) {
      frequency = schedule.frequency;
      timezoneBehavior = schedule.timezoneBehavior;
      invalidPolicy = schedule.invalidDatePolicy;
      weekdays = [...schedule.weekdays];
      monthlyDay = schedule.monthDays.firstOrNull ?? 1;
      interval = schedule.interval;
      intervalUnit = schedule.intervalUnit ?? 'HOURS';
      cycleOn = schedule.cycleOnDays ?? 7;
      cycleOff = schedule.cycleOffDays ?? 7;
      startDate = DateTime.parse(schedule.startDate);
      endDate = schedule.endDate == null
          ? null
          : DateTime.parse(schedule.endDate!);
      times = schedule.slots.map((slot) {
        final parts = slot.localTime.split(':');
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }).toList();
      if (schedule.slots.isNotEmpty) {
        quantity.text = schedule.slots.first.doseQuantity.toString();
        doseUnit.text = schedule.slots.first.doseUnit;
      }
    }
    reminders = LocalData.prefs.getBool('medication_reminders') ?? true;
    sound = LocalData.prefs.getBool('medication_sound') ?? true;
    vibration = LocalData.prefs.getBool('medication_vibration') ?? true;
    snooze = LocalData.prefs.getInt('medication_snooze') ?? 15;
    for (final controller in [
      name,
      strength,
      strengthUnit,
      quantity,
      doseUnit,
    ]) {
      controller.addListener(_refreshSummary);
    }
  }

  void _refreshSummary() {
    if (mounted) setState(() {});
  }

  void _selectForm(String value) {
    if (value == medicationForm.text) return;
    setState(() {
      medicationForm.text = value;
      // Form describes presentation, not a prescribed dose. Never carry a
      // tablet quantity/unit into a liquid, injectable or topical preparation.
      const countUnits = {
        'tablet': 'tablet',
        'capsule': 'capsule',
        'patch': 'patch',
        'suppository': 'suppository',
        'sachet': 'sachet',
      };
      doseUnit.text = countUnits[value] ?? '';
      if (!countUnits.containsKey(value)) quantity.clear();
      const formRoutes = {
        'tablet': 'oral',
        'capsule': 'oral',
        'liquid': 'oral',
        'suspension': 'oral',
        'patch': 'transdermal',
        'cream': 'topical',
        'ointment': 'topical',
        'gel': 'topical',
        'inhaler': 'inhaled',
      };
      route.text = formRoutes[value] ?? '';
    });
  }

  String get _doseDescription =>
      quantity.text.trim().isEmpty || doseUnit.text.trim().isEmpty
      ? 'Dose: enter quantity and unit'
      : 'Dose: ${quantity.text} ${doseUnit.text}';

  String get _medicationSummary => [
    if (strength.text.trim().isNotEmpty)
      '${strength.text} ${strengthUnit.text}',
    _doseDescription,
  ].join(' · ');

  Widget _category(
    TextEditingController controller,
    String label,
    List<String> options, {
    ValueChanged<String>? onChanged,
  }) {
    final current = controller.text.trim();
    // Keep existing/custom values editable without rewriting stored strings.
    final values = [
      ...options,
      if (current.isNotEmpty && !options.contains(current)) current,
    ];
    return DropdownButtonFormField<String>(
      key: ValueKey('category-$label-$current'),
      initialValue: current.isEmpty ? null : current,
      isExpanded: true,
      decoration: _decoration(label),
      hint: Text(
        'Select ${label.toLowerCase()}',
        overflow: TextOverflow.ellipsis,
      ),
      items: values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(
                value == 'injectable' ? 'Injectable' : value,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        if (onChanged != null) {
          onChanged(value);
        } else {
          setState(() => controller.text = value);
        }
      },
    );
  }

  @override
  void dispose() {
    for (final c in [
      name,
      strength,
      strengthUnit,
      medicationForm,
      route,
      purpose,
      quantity,
      doseUnit,
      instructions,
      supply,
      threshold,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MedicationPageScaffold(
    backgroundColor: medicationPageColor(context),
    navigationBar: CupertinoNavigationBar(
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () =>
            step == 0 ? Navigator.pop(context) : setState(() => step--),
        child: Text(step == 0 ? 'Cancel' : 'Back'),
      ),
      middle: Text(
        widget.medication == null ? 'Add Medication' : 'Edit Medication',
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: saving ? null : _next,
        child: Text(step == labels.length - 1 ? 'Save' : 'Next'),
      ),
    ),
    child: SafeArea(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _Progress(step: step, labels: labels),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: KeyedSubtree(
                    key: ValueKey(step),
                    child: Column(
                      children: [
                        if (step > 0 && step < 5)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: MedicationSurface(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  const MedicationAvatar(size: 36),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name.text,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          _medicationSummary,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: CupertinoColors.systemGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () => setState(() => step = 0),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        _page(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              decoration: BoxDecoration(
                color: medicationCardColor(context),
                border: Border(
                  top: BorderSide(color: Colors.grey.withOpacity(.15)),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: const Color(0xFF17621A),
                  onPressed: saving ? null : _next,
                  child: Text(
                    saving
                        ? 'Saving…'
                        : step == labels.length - 1
                        ? 'Save Medication'
                        : 'Continue to ${labels[step + 1]} ›',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  Widget _page(BuildContext context) => switch (step) {
    0 => _FormPage(
      title: 'What are you taking?',
      subtitle: 'Search is optional. Custom entry is always available.',
      children: [
        _Field(
          controller: name,
          label: 'Medication name *',
          validator: _required,
        ),
        Row(
          children: [
            Expanded(
              child: _Field(
                controller: strength,
                label: 'Strength',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _category(strengthUnit, 'Strength unit', strengthUnits),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _category(
                medicationForm,
                'Form',
                forms,
                onChanged: _selectForm,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: _category(route, 'Route', routes)),
          ],
        ),
        _Field(controller: purpose, label: 'Purpose (optional)'),
      ],
    ),
    1 => _FormPage(
      title: 'Dose & instructions',
      subtitle: 'Strength and quantity taken are stored separately.',
      children: [
        Row(
          children: [
            Expanded(
              child: _Field(
                controller: quantity,
                label: 'Quantity *',
                keyboardType: TextInputType.number,
                validator: _positive,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _Field(
                controller: doseUnit,
                label: 'Dose unit *',
                validator: _required,
              ),
            ),
          ],
        ),
        _Field(controller: instructions, label: 'Instructions', maxLines: 3),
        _SafetyNote(),
      ],
    ),
    2 => _schedulePage(),
    3 => _remindersPage(),
    4 => _supplyPage(),
    _ => _reviewPage(),
  };
  Widget _schedulePage() => _FormPage(
    title: 'Schedule & Rules',
    subtitle: 'Set the timing you already use.',
    children: [
      Text(
        'SCHEDULE TYPE',
        style: TextStyle(
          fontSize: 11,
          letterSpacing: .5,
          color: CupertinoColors.systemGrey,
        ),
      ),
      Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          for (final value in MedicationFrequency.values)
            ChoiceChip(
              label: Text(
                _frequencyLabel(value),
                style: TextStyle(fontSize: 11),
              ),
              selected: frequency == value,
              showCheckmark: false,
              onSelected: (_) => setState(() => frequency = value),
              selectedColor: const Color(0xFF17621A),
              labelStyle: TextStyle(
                color: frequency == value ? Colors.white : null,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        ],
      ),
      if (frequency == MedicationFrequency.weekly)
        Wrap(
          spacing: 6,
          children: [
            for (var day = 1; day <= 7; day++)
              FilterChip(
                label: Text(DateFormat.E().format(DateTime(2026, 9, 6 + day))),
                selected: weekdays.contains(day),
                onSelected: (selected) => setState(
                  () => selected ? weekdays.add(day) : weekdays.remove(day),
                ),
              ),
          ],
        ),
      if (frequency == MedicationFrequency.monthly)
        _NumberStepper(
          label: 'Day of month',
          value: monthlyDay,
          min: 1,
          max: 31,
          onChanged: (v) => setState(() => monthlyDay = v),
        ),
      if (frequency == MedicationFrequency.interval)
        _NumberStepper(
          label: 'Repeat every',
          value: interval,
          min: 1,
          max: 168,
          onChanged: (v) => setState(() => interval = v),
        ),
      if (frequency == MedicationFrequency.interval)
        DropdownButtonFormField<String>(
          value: intervalUnit,
          decoration: _decoration('Interval unit'),
          items: const [
            DropdownMenuItem(value: 'HOURS', child: Text('Hours')),
            DropdownMenuItem(value: 'DAYS', child: Text('Days')),
            DropdownMenuItem(value: 'WEEKS', child: Text('Weeks')),
          ],
          onChanged: (value) => setState(() => intervalUnit = value!),
        ),
      if (frequency == MedicationFrequency.cyclical)
        Row(
          children: [
            Expanded(
              child: _NumberStepper(
                label: 'Days on',
                value: cycleOn,
                min: 1,
                max: 365,
                onChanged: (v) => setState(() => cycleOn = v),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberStepper(
                label: 'Days off',
                value: cycleOff,
                min: 1,
                max: 365,
                onChanged: (v) => setState(() => cycleOff = v),
              ),
            ),
          ],
        ),
      if (frequency != MedicationFrequency.prn) ...[
        const SizedBox(height: 8),
        Text(
          'INTAKE TIMES & QUANTITY',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: .5,
            color: CupertinoColors.systemGrey,
          ),
        ),
        for (var i = 0; i < times.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MedicationSurface(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 11,
                        backgroundColor: medicationGreen.withOpacity(.12),
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            color: CupertinoDynamicColor.resolve(
                              medicationGreen,
                              context,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          times[i].hour < 12
                              ? 'Morning Dose'
                              : times[i].hour < 18
                              ? 'Afternoon Dose'
                              : 'Evening Dose',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (times.length > 1)
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => setState(() => times.removeAt(i)),
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              fontSize: 11,
                              color: medicationMissed,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          color: medicationPageColor(context),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          onPressed: () => _pickTime(i),
                          child: Text(
                            times[i].format(context),
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: medicationPageColor(context),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${quantity.text} ${doseUnit.text}',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (instructions.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ⓘ  ${instructions.text}',
                          style: TextStyle(
                            fontSize: 11,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        CupertinoButton(
          onPressed: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null && times.length < 24)
              setState(() => times = [...times, picked]);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.add_circled),
              SizedBox(width: 6),
              Text('Add another time'),
            ],
          ),
        ),
      ],
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Start date'),
        trailing: TextButton(
          onPressed: _pickStart,
          child: Text(DateFormat.yMMMd().format(startDate)),
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('End date (optional)'),
        trailing: TextButton(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: endDate ?? startDate,
              firstDate: startDate,
              lastDate: DateTime(2100),
            );
            if (picked != null) setState(() => endDate = picked);
          },
          child: Text(
            endDate == null
                ? 'No end date'
                : DateFormat.yMMMd().format(endDate!),
          ),
        ),
      ),
      DropdownButtonFormField<MedicationTimezoneBehavior>(
        value: timezoneBehavior,
        decoration: _decoration('Timezone behavior'),
        items: const [
          DropdownMenuItem(
            value: MedicationTimezoneBehavior.followDevice,
            child: Text('Follow device time'),
          ),
          DropdownMenuItem(
            value: MedicationTimezoneBehavior.fixedHome,
            child: Text('Keep home timezone'),
          ),
        ],
        onChanged: (v) => setState(() => timezoneBehavior = v!),
      ),
      if (frequency == MedicationFrequency.monthly ||
          frequency == MedicationFrequency.annual)
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: invalidPolicy != MedicationInvalidDatePolicy.skip,
          onChanged: (value) => setState(
            () => invalidPolicy = value
                ? MedicationInvalidDatePolicy.lastValidDay
                : MedicationInvalidDatePolicy.skip,
          ),
          title: Text('Use last valid date'),
          subtitle: Text(
            'Otherwise skip months or years where the date does not exist.',
          ),
        ),
      const SizedBox(height: 8),
      Text(
        'COMPUTED TIMELINE PREVIEW',
        style: TextStyle(
          fontSize: 11,
          letterSpacing: .5,
          color: CupertinoColors.systemGrey,
        ),
      ),
      _schedulePreview(),
    ],
  );
  Widget _schedulePreview() {
    final draft = _build();
    final preview = const MedicationRecurrenceEngine()
        .expand(
          userId: LocalData.userId ?? 'local-user',
          medication: draft.$1,
          schedule: draft.$2,
          from: DateTime.now(),
          to: DateTime.now().add(const Duration(days: 370)),
        )
        .take(5);
    return MedicationSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _summary(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'NEXT 5 SCHEDULED DOSES',
            style: TextStyle(fontSize: 10, color: CupertinoColors.systemGrey),
          ),
          const SizedBox(height: 6),
          for (final occurrence in preview)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.circle_fill,
                    color: CupertinoDynamicColor.resolve(
                      medicationGreen,
                      context,
                    ),
                    size: 5,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      DateFormat('EEE, MMM d').format(occurrence.scheduledAt!),
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  Text(
                    '${DateFormat.jm().format(occurrence.scheduledAt!)} · ${quantity.text} ${doseUnit.text}',
                    style: TextStyle(
                      fontSize: 11,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
          if (preview.isEmpty)
            Text(
              'As-needed doses have no expected time.',
              style: TextStyle(fontSize: 11),
            ),
        ],
      ),
    );
  }

  Widget _remindersPage() => _FormPage(
    title: 'Reminders',
    subtitle: 'Delivery depends on device permissions and platform rules.',
    children: [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Medication reminders'),
        value: reminders,
        onChanged: (v) => setState(() => reminders = v),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Sound'),
        value: sound,
        onChanged: reminders ? (v) => setState(() => sound = v) : null,
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Vibration'),
        value: vibration,
        onChanged: reminders ? (v) => setState(() => vibration = v) : null,
      ),
      DropdownButtonFormField<int>(
        value: snooze,
        decoration: _decoration('Default snooze'),
        items: [10, 15, 20, 30, 60]
            .map((v) => DropdownMenuItem(value: v, child: Text('$v minutes')))
            .toList(),
        onChanged: (v) => setState(() => snooze = v!),
      ),
      DropdownButtonFormField<MedicationPrivacyLevel>(
        value: privacy,
        decoration: _decoration('Lock-screen privacy'),
        items: const [
          DropdownMenuItem(
            value: MedicationPrivacyLevel.full,
            child: Text('Full details'),
          ),
          DropdownMenuItem(
            value: MedicationPrivacyLevel.private,
            child: Text('Private name'),
          ),
          DropdownMenuItem(
            value: MedicationPrivacyLevel.hidden,
            child: Text('Hidden'),
          ),
        ],
        onChanged: (v) => setState(() => privacy = v!),
      ),
    ],
  );
  Widget _supplyPage() => _FormPage(
    title: 'Supply',
    subtitle:
        'Optional stock tracking decrements once when a dose is recorded as Taken.',
    children: [
      if (widget.medication != null)
        Text(
          'Use Add refill or Adjust stock on Medication Details to change supply without losing its history.',
        ),
      if (widget.medication == null) ...[
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Track supply'),
          value: supplyEnabled,
          onChanged: (v) => setState(() => supplyEnabled = v),
        ),
        if (supplyEnabled) ...[
          _Field(
            controller: supply,
            label: 'Quantity on hand',
            keyboardType: TextInputType.number,
            validator: _nonNegative,
          ),
          _Field(
            controller: threshold,
            label: 'Low-supply alert at',
            keyboardType: TextInputType.number,
            validator: _nonNegative,
          ),
        ],
      ],
    ],
  );
  Widget _reviewPage() {
    final temp = _build();
    final preview = const MedicationRecurrenceEngine()
        .expand(
          userId: LocalData.userId ?? 'local-user',
          medication: temp.$1,
          schedule: temp.$2,
          from: DateTime.now(),
          to: DateTime.now().add(const Duration(days: 370)),
        )
        .take(5)
        .toList();
    return _FormPage(
      title: 'Review',
      subtitle: 'Check the details before saving.',
      children: [
        MedicationSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.text.isEmpty ? 'Medication' : name.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(_summary(), style: TextStyle(height: 1.4)),
              if (instructions.text.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(instructions.text),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'NEXT OCCURRENCES',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Theme.of(
              context,
            ).textTheme.bodySmall?.color?.withOpacity(.55),
          ),
        ),
        const SizedBox(height: 8),
        MedicationSurface(
          child: preview.isEmpty
              ? Text(
                  'As-needed medications do not create expected occurrences.',
                )
              : Column(
                  children: [
                    for (final item in preview)
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          CupertinoIcons.clock,
                          color: CupertinoDynamicColor.resolve(
                            medicationTeal,
                            context,
                          ),
                        ),
                        title: Text(
                          DateFormat(
                            'EEE, MMM d • h:mm a',
                          ).format(item.scheduledAt!),
                        ),
                        subtitle: Text(
                          '${item.slot.doseQuantity.g} ${item.slot.doseUnit}',
                        ),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 12),
        _SafetyNote(),
      ],
    );
  }

  (MedicationLocal, MedicationScheduleLocal, MedicationSupplyLocal?) _build() {
    final existing = widget.medication;
    final medicationId = existing?.clientId ?? uuid.v4();
    final medication = MedicationLocal()
      ..clientId = medicationId
      ..displayName = name.text.trim()
      ..strengthValue = double.tryParse(strength.text)
      ..strengthUnit = strengthUnit.text.trim()
      ..form = medicationForm.text.trim()
      ..route = route.text.trim()
      ..purpose = purpose.text.trim()
      ..instructions = instructions.text.trim();
    if (existing != null) {
      medication
        ..id = existing.id
        ..backendId = existing.backendId
        ..version = existing.version
        ..status = existing.status
        ..createdAt = existing.createdAt
        ..genericName = existing.genericName
        ..brandName = existing.brandName
        ..image = existing.image
        ..prescriber = existing.prescriber
        ..pharmacy = existing.pharmacy
        ..notes = existing.notes
        ..privateLabel = existing.privateLabel;
    }
    final schedule = MedicationScheduleLocal()
      ..clientId = uuid.v4()
      ..seriesId = widget.schedule?.seriesId ?? uuid.v4()
      ..revision = (widget.schedule?.revision ?? 0) + 1
      ..effectiveFrom = existing == null ? null : DateTime.now()
      ..medicationClientId = medicationId
      ..frequency = frequency
      ..interval = interval
      ..weekdays = weekdays
      ..monthDays = [monthlyDay]
      ..annualDatesJson = jsonEncode([
        {'month': startDate.month, 'day': startDate.day},
      ])
      ..cycleOnDays = cycleOn
      ..cycleOffDays = cycleOff
      ..intervalUnit = intervalUnit
      ..timezone = regimenTimezone
      ..timezoneBehavior = timezoneBehavior
      ..startDate = DateFormat('yyyy-MM-dd').format(startDate)
      ..endDate = endDate == null
          ? null
          : DateFormat('yyyy-MM-dd').format(endDate!)
      ..invalidDatePolicy = invalidPolicy
      ..active = true
      ..slots = times
          .map(
            (time) => MedicationDoseSlotLocal()
              ..clientId = uuid.v4()
              ..localTime =
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
              ..doseQuantity = double.tryParse(quantity.text) ?? 1
              ..doseUnit = doseUnit.text.trim()
              ..instructions = instructions.text.trim(),
          )
          .toList();
    final stock = supplyEnabled
        ? (MedicationSupplyLocal()
            ..medicationClientId = medicationId
            ..quantity = double.tryParse(supply.text) ?? 0
            ..unit = doseUnit.text.trim()
            ..refillThreshold = double.tryParse(threshold.text))
        : null;
    return (medication, schedule, stock);
  }

  Future<void> _next() async {
    if (step < labels.length - 1) {
      if ((step == 0 || step == 1 || step == 4) &&
          !(formKey.currentState?.validate() ?? false))
        return;
      if (step == 2) {
        if (frequency == MedicationFrequency.weekly && weekdays.isEmpty) {
          await _showError('Select at least one weekday.');
          return;
        }
        if (times.map((time) => '${time.hour}:${time.minute}').toSet().length !=
            times.length) {
          await _showError('Use a different time for each dose.');
          return;
        }
        if (endDate != null && endDate!.isBefore(startDate)) {
          await _showError('The end date must be on or after the start date.');
          return;
        }
      }
      setState(() => step++);
      return;
    }
    final built = _build();
    setState(() => saving = true);
    await Future.wait([
      LocalData.prefs.setBool('medication_reminders', reminders),
      LocalData.prefs.setBool('medication_sound', sound),
      LocalData.prefs.setBool('medication_vibration', vibration),
      LocalData.prefs.setInt('medication_snooze', snooze),
      LocalData.prefs.setString('medication_privacy', switch (privacy) {
        MedicationPrivacyLevel.full => 'Full',
        MedicationPrivacyLevel.private => 'Private',
        MedicationPrivacyLevel.hidden => 'Hidden',
      }),
    ]);
    if (widget.medication == null) {
      await ref
          .read(medicationActionsProvider)
          .create(
            medication: built.$1,
            schedules: [built.$2],
            supply: built.$3,
          );
    } else {
      await ref
          .read(medicationActionsProvider)
          .update(medication: built.$1, schedule: built.$2);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _pickTime(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: times[index],
    );
    if (picked != null)
      setState(() {
        final next = [...times];
        next[index] = picked;
        times = next;
      });
  }

  Future<void> _pickStart() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => startDate = picked);
  }

  String _summary() => frequency == MedicationFrequency.prn
      ? 'Recorded dose: ${quantity.text} ${doseUnit.text} as needed, following your recorded instructions.'
      : 'Recorded dose: ${quantity.text} ${doseUnit.text} ${_frequencyLabel(frequency).toLowerCase()} at ${times.map((t) => t.format(context)).join(' and ')}, starting ${DateFormat.yMMMd().format(startDate)}, in $regimenTimezone${timezoneBehavior == MedicationTimezoneBehavior.followDevice ? ' (review when travelling)' : ''}.';
  String _frequencyLabel(MedicationFrequency value) => const {
    MedicationFrequency.daily: 'Daily',
    MedicationFrequency.weekly: 'Selected weekdays',
    MedicationFrequency.monthly: 'Monthly',
    MedicationFrequency.annual: 'Annually',
    MedicationFrequency.interval: 'Repeating interval',
    MedicationFrequency.cyclical: 'Cyclical treatment',
    MedicationFrequency.prn: 'As needed (PRN)',
  }[value]!;
  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;
  String? _positive(String? value) =>
      (double.tryParse(value ?? '') ?? 0) <= 0 ||
          double.tryParse(value ?? '')?.isFinite != true
      ? 'Enter a value greater than zero'
      : null;
  String? _nonNegative(String? value) =>
      value != null && value.isNotEmpty && (double.tryParse(value) ?? -1) < 0
      ? 'Cannot be negative'
      : null;

  Future<void> _showError(String message) => showCupertinoDialog<void>(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text('Check the details'),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

class _Progress extends StatelessWidget {
  final int step;
  final List<String> labels;
  const _Progress({required this.step, required this.labels});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
    child: Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < labels.length; i++)
              Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: i < labels.length - 1 ? 5 : 0),
                  decoration: BoxDecoration(
                    color: i <= step
                        ? medicationGreen
                        : Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '${step + 1} of ${labels.length} • ${labels[step]}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: CupertinoDynamicColor.resolve(medicationGreen, context),
          ),
        ),
      ],
    ),
  );
}

class _FormPage extends StatelessWidget {
  final String title, subtitle;
  final List<Widget> children;
  const _FormPage({
    required this.title,
    required this.subtitle,
    required this.children,
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 5),
      Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.65),
        ),
      ),
      const SizedBox(height: 20),
      ...children.map(
        (e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: e),
      ),
    ],
  );
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  const _Field({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: maxLines,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: _decoration(label),
  );
}

InputDecoration _decoration(String label) => InputDecoration(
  labelText: label,
  filled: true,
  fillColor: Colors.grey.withOpacity(.06),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
);

class _NumberStepper extends StatelessWidget {
  final String label;
  final int value, min, max;
  final ValueChanged<int> onChanged;
  const _NumberStepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(label)),
      CupertinoButton(
        onPressed: value > min ? () => onChanged(value - 1) : null,
        child: Icon(CupertinoIcons.minus_circle),
      ),
      Text('$value', style: TextStyle(fontWeight: FontWeight.w700)),
      CupertinoButton(
        onPressed: value < max ? () => onChanged(value + 1) : null,
        child: Icon(CupertinoIcons.plus_circle),
      ),
    ],
  );
}

class _SafetyNote extends StatelessWidget {
  _SafetyNote();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: medicationTeal.withOpacity(.08),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          CupertinoIcons.info_circle,
          color: CupertinoDynamicColor.resolve(medicationTeal, context),
          size: 19,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Use the instructions from your prescriber or medication label. Qarr Track records your instructions and does not recommend a dose or missed-dose response.',
            style: TextStyle(fontSize: 12, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

extension _DoseFormat on double {
  String get g => this == roundToDouble() ? toInt().toString() : toString();
}
