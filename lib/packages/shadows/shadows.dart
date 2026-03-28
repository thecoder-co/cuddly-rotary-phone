import '../packages.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> focusShadow(Color color) => [
        BoxShadow(
          color: color,
          spreadRadius: 4,
          blurRadius: 0,
          offset: const Offset(0, 0),
        ),
      ];

  static const def = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      spreadRadius: 0,
      blurRadius: 24,
      offset: Offset(0, 4),
    ),
  ];

  static const xs = [
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.05),
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  static const sm = [
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.06),
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.1),
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  static const md = [
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.06),
      spreadRadius: -2,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.1),
      spreadRadius: -2,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const lg = [
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.03),
      spreadRadius: -2,
      blurRadius: 6,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.08),
      spreadRadius: -4,
      blurRadius: 16,
      offset: Offset(0, 12),
    ),
  ];

  static const xl = [
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.03),
      spreadRadius: -4,
      blurRadius: 8,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.08),
      spreadRadius: -4,
      blurRadius: 24,
      offset: Offset(0, 20),
    ),
  ];

  static const xl2 = [
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.18),
      spreadRadius: -12,
      blurRadius: 48,
      offset: Offset(0, 24),
    ),
  ];

  static const xl3 = [
    BoxShadow(
      color: Color.fromRGBO(16, 24, 40, 0.14),
      spreadRadius: -12,
      blurRadius: 64,
      offset: Offset(0, 32),
    ),
  ];
}
