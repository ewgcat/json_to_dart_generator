import 'package:analyzer/dart/element/element.dart';
import 'package:json_to_dart_generator/src/type_helper.dart';
import 'package:source_gen/source_gen.dart';

import 'json_field_collector.dart';
import 'json_enum_collector.dart';

Set<String> _partFiles = Set<String>();

class JsonObjectCollector {
  final String fileName;
  late JsonFieldCollector _fieldCollector;

  JsonObjectCollector(this.fileName);

  String collect(Element element, ConstantReader annotation) {
    StringBuffer sb = StringBuffer();
    if (!_partFiles.contains(fileName)) {
      sb.writeln("part of '$fileName';");
      _partFiles.add(fileName);
    }
    _fieldCollector = JsonFieldCollector();
    _fieldCollector.collect(element as ClassElement, annotation);
    final className = element.displayName;
    // fromJson
    sb.writeln(_makeFromJson(className, annotation));
    // toJson
    final enableToJsonMethod = annotation.peek('toJson')?.boolValue ?? false;
    if (enableToJsonMethod) {
      sb.writeln(_makeToJson(className));
    }
    // copyWith
    final enableCopyWithMethod =
        annotation.peek('copyWith')?.boolValue ?? false;
    // toJsonString
    final enableToJsonStringMethod =
        annotation.peek('toJsonString')?.boolValue ?? false;
    if (enableCopyWithMethod || enableToJsonStringMethod) {
      sb.writeln(_makeCopyWith(className));
    }
    if (enableToJsonStringMethod) {
      sb.writeln(_makeToJsonString(className));
    }
    return sb.toString();
  }

  String _makeFromJson(String className, ConstantReader annotation) {
    StringBuffer sb = StringBuffer();
    sb.writeln(
        "$className _\$${className}FromJson(Map<String, dynamic> json) => $className(");
    _fieldCollector.fields.forEach((field) {
      String valueConvertText;
      if (field.typeName == 'String') {
        valueConvertText = "json['${field.jsonKey}']?.toString()";
        if (!field.hasNullSuffix) {
          valueConvertText += " ?? ${field.defaultValue ?? '\'\''}";
        }
      } else if (field.typeName == 'int') {
        if (!field.hasNullSuffix) {
          valueConvertText =
              "DecodeHelper.toInt(json['${field.jsonKey}'], ${field.defaultValue ?? 0})";
        } else {
          valueConvertText = "DecodeHelper.tryToInt(json['${field.jsonKey}'])";
        }
      } else if (field.typeName == 'double') {
        if (!field.hasNullSuffix) {
          valueConvertText =
              "DecodeHelper.toDouble(json['${field.jsonKey}'], ${field.defaultValue ?? 0.0})";
        } else {
          valueConvertText =
              "DecodeHelper.tryToDouble(json['${field.jsonKey}'])";
        }
      } else if (field.typeName == 'bool') {
        if (!field.hasNullSuffix) {
          valueConvertText =
              "DecodeHelper.toBool(json['${field.jsonKey}'], ${field.defaultValue ?? false})";
        } else {
          valueConvertText = "DecodeHelper.tryToBool(json['${field.jsonKey}'])";
        }
      } else if (field.typeName == 'DateTime') {
        String parseDateTime =
            "DecodeHelper.toDateTime(json['${field.jsonKey}'])";
        valueConvertText = field.hasNullSuffix
            ? "json['${field.jsonKey}'] != null ? $parseDateTime : null"
            : parseDateTime;
      } else if (TypeHelper.isListType(field.typeName)) {
        String parseList;
        if (field.genericType == 'DateTime') {
          parseList =
              "DecodeHelper.toList(json['${field.jsonKey}']).map((e) => DecodeHelper.toDateTime(e)).toList()";
        } else if (field.isEnum) {
          parseList =
              "DecodeHelper.toList(json['${field.jsonKey}']).where((element) => ${JsonEnumCollector.enumMapPrefix}${field.genericType}${JsonEnumCollector.enumMapSuffix}.keys.contains(element)).map((e) => ${_convertEnumSetter(field, 'e')}!).toList()";
        } else if (TypeHelper.isCustomClass(field.genericType!)) {
          parseList =
              "DecodeHelper.toList<Map>(json['${field.jsonKey}']).map((e) => ${field.genericType}.fromJson(Map<String, dynamic>.from(e))).toList()";
        } else {
          parseList =
              "DecodeHelper.toList<${field.genericType}>(json['${field.jsonKey}'])";
        }
        valueConvertText = field.hasNullSuffix
            ? "json['${field.jsonKey}'] != null ? $parseList : null"
            : parseList;
      } else if (TypeHelper.isMapType(field.typeName)) {
        String parseMap;
        if (field.genericValueType == 'DateTime') {
          parseMap =
              "DecodeHelper.toMap<${field.genericKeyType}, dynamic>(json['${field.jsonKey}']).map((key, value) => MapEntry(key, DecodeHelper.toDateTime(value)))";
        } else if (field.isEnum) {
          parseMap = """
          (arg) {
              var map =
                  DecodeHelper.toMap<String, dynamic>(arg);
              map.removeWhere(
                  (key, value) => ${JsonEnumCollector.enumMapPrefix}${field.genericValueType}${JsonEnumCollector.enumMapSuffix}.keys.contains(value));
              return map
                  .map((key, value) => MapEntry(key, ${_convertEnumSetter(field, 'value', enumType: field.genericValueType)}!));
            }(json['${field.jsonKey}'])
          """;
        } else if (TypeHelper.isCustomClass(field.genericValueType!)) {
          parseMap =
              "DecodeHelper.toMap<${field.genericKeyType}, dynamic>(json['${field.jsonKey}']).map((key, value) => MapEntry(key, ${field.genericValueType}.fromJson(Map<String, dynamic>.from(value))))";
        } else {
          parseMap =
              "DecodeHelper.toMap<${field.genericType}>(json['${field.jsonKey}'])";
        }
        valueConvertText = field.hasNullSuffix
            ? "json['${field.jsonKey}'] != null ? $parseMap : null"
            : parseMap;
      } else if (field.isEnum) {
        String parseEnum =
            _convertEnumSetter(field, "json['${field.jsonKey}']");
        valueConvertText = field.hasNullSuffix
            ? "json['${field.jsonKey}'] != null ? $parseEnum : null"
            : parseEnum;
      } else if (field.isCustomClass) {
        String parseCustomClass =
            "${field.typeName}.fromJson(DecodeHelper.toMap<String, dynamic>(json['${field.jsonKey}']))";
        valueConvertText = field.hasNullSuffix
            ? "json['${field.jsonKey}'] != null ? $parseCustomClass : null"
            : parseCustomClass;
      } else {
        valueConvertText = "json['${field.jsonKey}']";
      }
      sb.writeln("${field.fieldName}: $valueConvertText,");
    });
    sb.writeln(");");
    return sb.toString();
  }

  String _makeToJson(String className) {
    String mClassName="${className.toLowerCase().substring(0,1)+className.substring(1,className.length)}";
    StringBuffer sb = StringBuffer();
    sb.writeln("Map<String, dynamic> _\$${className}ToJson($className $mClassName) {");
    sb.writeln("return {");
    _fieldCollector.fields.forEach((field) {
      String key = "'${field.jsonKey}'";
      String value = "$mClassName.${field.fieldName}";
      String valueSuffix = field.hasNullSuffix ? '?' : '';
      if (field.typeName == 'DateTime') {
        sb.writeln("$key: $value$valueSuffix.millisecondsSinceEpoch,");
      } else if (TypeHelper.isListType(field.typeName)) {
        if (field.genericType == 'DateTime') {
          sb.writeln(
              "$key: $value$valueSuffix.map((e) => e.millisecondsSinceEpoch).toList(),");
        } else if (field.isEnum) {
          sb.writeln("$key: $value$valueSuffix.map((e) => e.value).toList(),");
        } else if (TypeHelper.isCustomClass(field.genericType!)) {
          sb.writeln(
              "$key: $value?.cast<${field.genericType}>(),");
        } else {
          sb.writeln("$key: $value,");
        }
      } else if (TypeHelper.isMapType(field.typeName)) {
        if (field.genericValueType == 'DateTime') {
          sb.writeln(
              "$key: $value$valueSuffix.map((key, value) => MapEntry(key, value.millisecondsSinceEpoch)),");
        } else if (field.isEnum) {
          sb.writeln(
              "$key: $value$valueSuffix.map((key, value) => MapEntry(key, value.value)),");
        } else if (TypeHelper.isCustomClass(field.genericValueType!)) {
          sb.writeln(
              "$key: $value$valueSuffix.map((key, value) => MapEntry(key, value.toJson())),");
        } else {
          sb.writeln("$key: $value,");
        }
      } else if (field.isEnum) {
        sb.writeln("$key: $value$valueSuffix.value,");
      } else if (field.isCustomClass) {
        sb.writeln("$key: $value$valueSuffix.toJson(),");
      } else {
        sb.writeln("$key: $value,");
      }
    });
    sb.writeln("};");
    sb.writeln("}");
    return sb.toString();
  }

  String _makeCopyWith(String className) {
    String mClassName="${className.toLowerCase().substring(0,1)+className.substring(1,className.length)}";
    StringBuffer sb = StringBuffer();
    sb.write("$className _\$${className}CopyWith($className $mClassName, {");
    _fieldCollector.fields.forEach((field) {
      sb.writeln("${field.typeName}? ${field.fieldName},");
    });
    sb.writeln("}) {");
    sb.writeln("return $className(");
    _fieldCollector.fields.forEach((field) {
      sb.writeln(
          "${field.fieldName}: ${field.fieldName} ??  $mClassName.${field.fieldName},");
    });
    sb.writeln(");");
    sb.writeln("}");
    return sb.toString();
  }

  String _makeToJsonString(String className) {
    String mClassName="${className.toLowerCase().substring(0,1)+className.substring(1,className.length)}";

    return """
    String _\$${className}ToJsonString($className $mClassName) {
      return json.encode(_\$${className}ToJson($mClassName));
    }
    """;
  }

  String _convertEnumSetter(JsonFieldNode field, String getter,
      {String? enumType}) {
    String defaultEnum =
        "${field.defaultValue is String ? "'${field.defaultValue}'" : field.defaultValue}";
    String parseEnum;
    String typeName = enumType ?? field.genericType ?? field.typeName;
    if (field.defaultValue != null) {
      parseEnum =
          "${JsonEnumCollector.enumMapPrefix}get${typeName}WithNonnull($getter, defaultValue: $defaultEnum)";
    } else {
      parseEnum = "${JsonEnumCollector.enumMapPrefix}get$typeName($getter)";
    }
    return parseEnum;
  }
}
