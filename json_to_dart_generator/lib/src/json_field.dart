/// 标识类属性
class JsonField {
  /// JSON Key
  final String? name;

  /// 默认值
  final dynamic defaultValue;

  /// 是否忽略
  final bool ignore;

  const JsonField({this.name, this.defaultValue, this.ignore = false});
}
