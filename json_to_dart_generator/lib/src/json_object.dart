/// 标识需要JSON转换的类
class JsonObject {
  /// 生成方法`toJson`
  final bool toJson;

  /// 生成方法`copyWith`
  final bool copyWith;

  /// 生成方法`toJsonString`
  final bool toJsonString;

  const JsonObject(
      {this.toJson = true, this.copyWith = false, this.toJsonString = false});
}
