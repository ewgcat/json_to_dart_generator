class TypeHelper {
  static RegExp listChecker = RegExp(r'^List(<.*>)?$');

  static bool isCustomClass(String type) {
    if (isListType(type) ||
        isMapType(type) ||
        isSetType(type) ||
        isFutureOrType(type)) {
      return false;
    }
    return ![
      'String',
      'int',
      'double',
      'num',
      'bool',
      'Null',
      'Object',
      'Iterable',
      'Function',
      'Symbol',
      'dynamic',
      'void',
      'Future',
      'DateTime',
      'BigInt'
    ].contains(type);
  }

  static bool isListType(String type) => type.startsWith(listChecker);

  static bool isMapType(String type) =>
      type.startsWith(RegExp(r'^Map(<\w+,\s?\w+>)?$'));

  static bool isSetType(String type) =>
      type.startsWith(RegExp(r'^Set(<.*>)?$'));

  static bool isFutureOrType(String type) =>
      type.startsWith(RegExp(r'^FutureOr(<.*>)?$'));
}
