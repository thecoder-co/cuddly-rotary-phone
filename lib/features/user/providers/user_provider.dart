import 'package:calorie_tracker/features/user/models/profile_dto.dart';
import 'package:calorie_tracker/features/user/repo/user_repo.dart';
import 'package:calorie_tracker/packages/packages.dart';

final userProvider = FutureProvider<User?>((ref) async {
  final res = await UserRepo().getMe();
  if (res.valid && res.data != null) return res.data!.user;
  return null;
});
