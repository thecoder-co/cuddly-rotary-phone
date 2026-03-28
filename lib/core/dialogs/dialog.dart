/// The above class provides methods to show loading dialogs and snackbars with different types of
/// messages in a Flutter app.
library;

import 'package:calorie_tracker/packages/packages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showLoadingDialog() {
    showDialog(
      context: NavigationService.navigatorKey.currentState!.context,
      barrierDismissible: kDebugMode,
      builder: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  static void showErrorSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        // backgroundColor: Colors.red,
      ),
    );
  }

  static void showSuccessSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static Future<bool> confirmDialog({
    String? title,
    String? subtitle,
    String yesText = 'Confirm',
    String noText = 'Cancel',
  }) async {
    final t = await openBottomSheet(
      children: [
        34.gap,
        if (title != null)
          Text(
            title,
            style: CustomTextStyle.labelLBold,
          ),
        8.gap,
        if (subtitle != null)
          Text(
            subtitle,
            style: CustomTextStyle.paragraphMedium,
          ),
        34.gap,
        AppButton(
          onPressed: () {
            pop(true);
          },
          label: yesText,
        ),
        8.gap,
        AppButton.outline(
          onPressed: () {
            pop(false);
          },
          label: noText,
        ),
      ],
    );

    if (t.runtimeType != bool) return false;
    return t;
  }

  static Future openCloseBottomSheet({
    String? title,
    List<Widget>? children,
    Widget? child,
  }) {
    return showModalBottomSheet(
      context: NavigationService.navigatorKey.currentState!.context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CustomCloseBottomsheet(
          title: title,
          children: children,
          child: child,
        );
      },
    );
  }

  static Future openBottomSheet({
    bool showBar = true,
    List<Widget>? children,
    Widget? child,
  }) {
    return showModalBottomSheet(
      context: NavigationService.navigatorKey.currentState!.context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CustomBottomSheet(
          showBar: showBar,
          children: children,
          child: child,
        );
      },
    );
  }
}

class CustomCloseBottomsheet extends StatelessWidget {
  final String? title;
  final List<Widget>? children;
  final Widget? child;
  const CustomCloseBottomsheet({
    super.key,
    this.title,
    this.children,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title ?? '',
                        style: CustomTextStyle.labelLBold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pop();
                      },
                      child: const SizedBox(
                        height: 32,
                        width: 32,
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: AppColors.greyQuatinary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (children != null) ...children!,
                if (child != null) child!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final bool showBar;
  final List<Widget>? children;
  final Widget? child;
  const CustomBottomSheet({
    super.key,
    this.showBar = true,
    this.children,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(),
              if (showBar)
                Container(
                  width: 80,
                  height: 4,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE2E2E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ).alignCenter,
              if (children != null) ...children!,
              if (child != null) child!,
            ],
          ),
        ),
      ],
    );
  }
}

typedef Choice = ({String title, dynamic value});

class ChoiceBottomsheet<T> extends StatefulWidget {
  final List<Choice> titles;
  const ChoiceBottomsheet({super.key, required this.titles});

  @override
  State<ChoiceBottomsheet<T>> createState() => _ChoiceBottomsheetState<T>();
}

class _ChoiceBottomsheetState<T> extends State<ChoiceBottomsheet<T>> {
  T? title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: switch (widget.titles.length) {
        1 || 2 => 200,
        3 || 4 => 300,
        _ => 400,
      },
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: widget.titles
                  .map(
                    (e) => _tile(
                      title: e,
                    ),
                  )
                  .toList(),
            ),
          ),
          19.gap,
          AppButton(
            onPressed: title == null
                ? null
                : () {
                    pop(widget.titles
                        .firstWhere((element) => element.value == title));
                  },
            label: 'Select',
          ),
        ],
      ),
    );
  }

  @widgetFactory
  Widget _tile({
    required Choice title,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          this.title = title.value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title.title,
                style: CustomTextStyle.subtitleMedium,
              ),
            ),
            Radio<T>(
              value: title.value,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              splashRadius: 0,
              visualDensity: VisualDensity.compact,
              groupValue: this.title,
              onChanged: (v) => setState(() {
                this.title = v;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
