import 'package:calorie_tracker/features/workout/presentation/exercise_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:calorie_tracker/packages/packages.dart';

class RecordSetSheet extends StatefulWidget {
  final double initialWeight;
  final int initialReps;
  final void Function(double weight, int reps) onSave;

  const RecordSetSheet({
    super.key,
    required this.initialWeight,
    required this.initialReps,
    required this.onSave,
  });

  @override
  State<RecordSetSheet> createState() => _RecordSetSheetState();
}

class _RecordSetSheetState extends State<RecordSetSheet> {
  late double _weight;
  late int _reps;
  int _activeRow = 1; // 0 = reps, 1 = weight
  String _inputBuffer = '';
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
    _reps = widget.initialReps;
  }

  void _onNumpadKey(String key) {
    setState(() {
      if (key == '⌫') {
        // Backspace
        if (_inputBuffer.isNotEmpty) {
          _inputBuffer = _inputBuffer.substring(0, _inputBuffer.length - 1);
        }
        if (_inputBuffer.isEmpty) {
          _isTyping = false;
          if (_activeRow == 0) {
            _reps = 0;
          } else {
            _weight = 0;
          }
          return;
        }
      } else if (key == '.') {
        // Decimal point — only for weight
        if (_activeRow != 1) return;
        if (!_isTyping) {
          _inputBuffer = '0.';
          _isTyping = true;
        } else if (!_inputBuffer.contains('.')) {
          _inputBuffer += '.';
        }
      } else {
        // Digit
        if (!_isTyping) {
          _inputBuffer = key;
          _isTyping = true;
        } else {
          _inputBuffer += key;
        }
      }

      // Apply buffer to active value
      if (_activeRow == 0) {
        _reps = int.tryParse(_inputBuffer) ?? 0;
      } else {
        _weight = double.tryParse(_inputBuffer) ?? 0.0;
      }
    });
  }

  void _switchActiveRow(int row) {
    setState(() {
      _activeRow = row;
      _isTyping = false;
      _inputBuffer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // WEIGHT label
              Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    'WEIGHT',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Reps Row
              GestureDetector(
                onTap: () => _switchActiveRow(0),
                child: _buildStepperRow(
                  value: '$_reps',
                  unit: 'rep',
                  isActive: _activeRow == 0,
                  hasLargeStep: false,
                  onSmallDecrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    if (_reps > 0) _reps--;
                  }),
                  onSmallIncrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _reps++;
                  }),
                ),
              ),
              const SizedBox(height: 10),
              // Weight Row
              GestureDetector(
                onTap: () => _switchActiveRow(1),
                child: _buildStepperRow(
                  value: _weight % 1 == 0
                      ? '${_weight.toInt()}'
                      : _weight.toStringAsFixed(1),
                  unit: 'kg',
                  isActive: _activeRow == 1,
                  hasLargeStep: true,
                  onLargeDecrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight - 5).clamp(0.0, 999.0);
                  }),
                  onSmallDecrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight - 1).clamp(0.0, 999.0);
                  }),
                  onSmallIncrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight + 1).clamp(0.0, 999.0);
                  }),
                  onLargeIncrement: () => setState(() {
                    _isTyping = false;
                    _inputBuffer = '';
                    _weight = (_weight + 5).clamp(0.0, 999.0);
                  }),
                ),
              ),
              const SizedBox(height: 20),
              // Record Set Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: AppButton(
                  onPressed: () => widget.onSave(_weight, _reps),
                  label: 'Record Set',
                ),
              ),
              const SizedBox(height: 16),
              // Numpad
              _buildNumpad(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumpad() {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', '⌫'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: row.map((key) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildNumpadKey(key),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNumpadKey(String key) {
    final isBackspace = key == '⌫';
    final isDot = key == '.';
    // Disable dot for reps row
    final isDisabled = isDot && _activeRow == 0;

    return GestureDetector(
      onTap: isDisabled ? null : () => _onNumpadKey(key),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDisabled
              ? const Color(0xFF2C2C2E).withValues(alpha: 0.3)
              : const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isBackspace
              ? Icon(
                  CupertinoIcons.delete_left,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 22,
                )
              : Text(
                  key,
                  style: TextStyle(
                    color: isDisabled ? Colors.grey.shade700 : Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildStepperRow({
    required String value,
    required String unit,
    required bool isActive,
    required bool hasLargeStep,
    VoidCallback? onLargeDecrement,
    required VoidCallback onSmallDecrement,
    required VoidCallback onSmallIncrement,
    VoidCallback? onLargeIncrement,
  }) {
    final borderColor = isActive ? Colors.orange : const Color(0xFF2C2C2E);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: isActive ? 2 : 1),
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF2C2C2E),
      ),
      child: Row(
        children: [
          3.gap,
          // Left controls
          Icon(
            Icons.remove,
            color: isDark ? Colors.white : Colors.black,
            size: 14,
          ),

          if (hasLargeStep)
            _buildStepButton(label: '5', onTap: onLargeDecrement),
          _buildStepButton(label: '1', onTap: onSmallDecrement),
          // Center value
          Expanded(
            child: Center(
              child: Text(
                '$value $unit',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Right controls
          _buildStepButton(label: '1', onTap: onSmallIncrement),
          if (hasLargeStep)
            _buildStepButton(label: '5', onTap: onLargeIncrement),
          3.gap,
          Icon(
            Icons.add,
            color: isDark ? Colors.white : Colors.black,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildStepButton({required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
