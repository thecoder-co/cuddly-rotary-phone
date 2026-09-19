import 'package:calorie_tracker/core/services/local_data/local_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Invalidates account-owned repositories when the active account changes.
final accountScopeProvider = NotifierProvider<AccountScope, String?>(
  AccountScope.new,
);

class AccountScope extends Notifier<String?> {
  @override
  String? build() {
    final subscription = LocalData.accountChanges.stream.listen((accountId) {
      if (accountId != state) state = accountId;
    });
    ref.onDispose(subscription.cancel);
    return LocalData.userId;
  }
}
