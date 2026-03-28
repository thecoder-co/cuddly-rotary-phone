import 'package:calorie_tracker/packages/packages.dart';

class RatingBar extends StatefulWidget {
  final Function(int) onRatingChange;
  final int initialRating;
  final int length;

  final double? size;
  final double? spacing;
  const RatingBar({
    super.key,
    required this.onRatingChange,
    required this.length,
    required this.initialRating,
    this.size,
    this.spacing,
  }) : assert(length >= initialRating);

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int value = 0;
  @override
  void initState() {
    value = widget.initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.length,
        (index) {
          return Padding(
            padding: index != widget.length - 1 && widget.spacing != null
                ? EdgeInsets.only(right: widget.spacing ?? 4)
                : const EdgeInsets.only(),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  value = index + 1;
                });
                widget.onRatingChange(value);
              },
              child: value > index
                  ? Icon(
                      Icons.star_rounded,
                      color: AppColors.primary,
                      size: widget.size,
                    )
                  : Icon(
                      Icons.star_outline_rounded,
                      color: AppColors.greyQuatinary,
                      size: widget.size,
                    ),
            ),
          );
        },
      ),
    );
    // return SizedBox(
    //   height: widget.size,
    //   child: ListView.separated(
    //     physics: const NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: widget.length,
    //     scrollDirection: Axis.horizontal,
    //     separatorBuilder: (BuildContext context, int index) {
    //       return (widget.spacing ?? 4).spacingW;
    //     },
    //     itemBuilder: (BuildContext context, int index) {
    //       return;
    //     },
    //   ),
    // );
  }
}
