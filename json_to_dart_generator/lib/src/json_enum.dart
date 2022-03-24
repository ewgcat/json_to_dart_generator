/// 标识枚举类型
class JsonEnum {
  /// 枚举默认值，只支持String和int
  final dynamic defaultValue;

  const JsonEnum([this.defaultValue]);
}

/// 标识枚举成员
class EnumValue {
  /// 描述
  final String? text;

  /// code
  final int? code;

  /// 枚举值，只支持String和int
  final Object value;

  const EnumValue(this.value, {this.code, this.text});
}
