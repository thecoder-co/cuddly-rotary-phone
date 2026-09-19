import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores credentials outside of SharedPreferences.
///
/// Keeping this interface small makes the migration and session lifecycle
/// testable without a platform channel. User profile data remains in local
/// preferences; only bearer credentials belong in secure storage.
abstract interface class CredentialStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

class PlatformCredentialStore implements CredentialStore {
  static const _storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  const PlatformCredentialStore();

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);
}
