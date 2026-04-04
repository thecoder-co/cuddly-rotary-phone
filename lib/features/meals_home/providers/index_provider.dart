import 'package:calorie_tracker/packages/packages.dart';

final indexProvider = NotifierProvider.autoDispose<IndexNotifier, int>(
  IndexNotifier.new,
);

class IndexNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  @override
  set state(int value) {
    super.state = value;
  }
}
