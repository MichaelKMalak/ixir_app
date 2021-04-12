class StringUtils {
  static bool isEmpty(String s) => s == null || s.trim().isEmpty;
  static bool isNotEmpty(String s) => !isEmpty(s);

  static bool isEmail(String value) {
    if (isEmpty(value)) return false;
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  static bool isPhoneNumber(String value) {
    if (isEmpty(value)) return false;
    return RegExp(r'^[0-9]{10,12}$').hasMatch(value);
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static bool hasNonAlphabet(String s) {
    return RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(s);
  }

  static double toDoubleWithDecimalPlaces(String s, {int decimalPlaces = 2}) {
    if (!isNumeric(s)) return 0;
    return double.parse(double.parse(s).toStringAsFixed(decimalPlaces));
  }

  /// Gracefully handles null values, and skips the suffix when null
  static String safeGet(String value, [String suffix]) {
    return (value ?? '') + (!isEmpty(value) ? suffix ?? '' : '');
  }

  static String titleCaseSingle(String s) =>
      '${s[0].toUpperCase()}${s.substring(1)}';
  static String titleCase(String s) =>
      s.split(' ').map(titleCaseSingle).join(' ');

  static String defaultOnEmpty(String value, String fallback) =>
      isEmpty(value) ? fallback : value;
}
