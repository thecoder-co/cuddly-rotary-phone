import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalyticsPlaceholderScreen extends ConsumerStatefulWidget {
  const AnalyticsPlaceholderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnalyticsPlaceholderScreenState();
}

class _AnalyticsPlaceholderScreenState
    extends ConsumerState<AnalyticsPlaceholderScreen> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Analytics')),
      child: SafeArea(
        child: Center(child: Text('Global Analytics Placeholder')),
      ),
    );
  }
}
