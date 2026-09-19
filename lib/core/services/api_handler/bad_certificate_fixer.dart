import 'package:dio/dio.dart';

/// Leaves Dio on the platform's default TLS validation path.
///
/// The previous implementation accepted every certificate and made public
/// authentication calls vulnerable to a network attacker. The parameter is
/// retained so existing API-service construction stays source compatible.
void fixBadCertificate({required Dio dio}) {
  // Intentionally empty: Dio validates certificates using the platform trust
  // store when no custom adapter is installed.
}
