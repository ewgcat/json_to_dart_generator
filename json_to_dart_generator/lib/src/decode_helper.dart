class DecodeHelper {
  static final List<String> boolTrueValues = [
    'TRUE',
    'true',
    'YES',
    'yes',
    '1'
  ];

  static int toInt(dynamic value, int defaultValue) {
    return tryToInt(value) ?? defaultValue;
  }

  static double toDouble(dynamic value, double defaultValue) {
    return tryToDouble(value) ?? defaultValue;
  }

  static bool toBool(dynamic value, bool defaultValue) {
    return tryToBool(value) ?? defaultValue;
  }

  static Map<K, V> toMap<K, V>(dynamic value, {Map<K, V>? defaultValue}) {
    if (value == null || value is! Map) {
      return defaultValue ?? Map<K, V>.identity();
    }
    return Map<K, V>.from(value);
  }

  static List<T> toList<T>(dynamic value, {List<T>? defaultValue}) {
    if (value == null || value is! List) {
      return defaultValue ?? List<T>.empty(growable: true);
    }
    return  value.cast<T>();
  }

  static DateTime toDateTime(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is String) {
      try {
        final timestamp = num.tryParse(value);
        if (timestamp != null) {
          return DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
        }
        return DateTime.parse(value);
      } catch (e) {}
    }
    return DateTime(1970);
  }

  static int? tryToInt(dynamic value) {
    if (value == null) {
      return null;
    }
    return num.tryParse(value.toString())?.toInt();
  }

  static double? tryToDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    return num.tryParse(value.toString())?.toDouble();
  }

  static bool? tryToBool(dynamic value) {
    if (value == null) {
      return null;
    }
    return boolTrueValues.contains(value.toString());
  }
}
