import 'package:calorie_tracker/packages/packages.dart';

class StepperButton extends StatefulWidget {
  final int initialStep;
  final bool isDisabled;
  final void Function(int) onStepAdd;
  final void Function(int) onStepSubtract;
  final int? maxStep;
  final int minStep;
  const StepperButton({
    super.key,
    required this.onStepAdd,
    required this.onStepSubtract,
    this.isDisabled = false,
    this.initialStep = 0,
    this.maxStep,
    this.minStep = 0,
  });

  @override
  State<StepperButton> createState() => _StepperButtonState();
}

class _StepperButtonState extends State<StepperButton> {
  late int step = widget.initialStep;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StepButton(
          onPressed: widget.isDisabled || step <= widget.minStep
              ? null
              : () {
                  if (step > widget.minStep) {
                    setState(() {
                      step--;
                    });
                    widget.onStepSubtract(step);
                  }
                },
          icon: Icons.remove,
        ),
        8.gap,
        Text(
          step.toString(),
          style: CustomTextStyle.label2XLBold,
        ),
        8.gap,
        StepButton(
          onPressed: widget.isDisabled ||
                  (widget.maxStep != null && step >= widget.maxStep!)
              ? null
              : () {
                  if (widget.maxStep != null && step >= widget.maxStep!) return;
                  setState(() {
                    step++;
                  });
                  widget.onStepAdd(step);
                },
          icon: Icons.add,
        ),
      ],
    );
  }
}

class StepButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;

  const StepButton({super.key, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                onPressed == null ? AppColors.bordersDark : AppColors.primary,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon,
            color:
                onPressed == null ? AppColors.bordersDark : AppColors.primary),
      ),
    );
  }
}
