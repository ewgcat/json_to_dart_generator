import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:source_gen/source_gen.dart';

import 'json_enum.dart';

Set<String> _partFiles = Set<String>();

class JsonEnumCollector {
  static const String enumMapPrefix = '_\$';
  static const String enumMapSuffix = 'EnumMap';

  static const String enumTypeKey = 'enum';
  static const String enumTextKey = 'text';
  static const String enumCodeKey = 'code';

  static Set<String> allEnums = Set<String>();

  final String fileName;

  JsonEnumCollector(this.fileName);

  String collect(ClassElement element, ConstantReader annotation) {
    final enumName = element.displayName;
    allEnums.add(enumName);
    StringBuffer sb = StringBuffer();
    if (!_partFiles.contains(fileName)) {
      sb.writeln("part of '$fileName';\n");
      _partFiles.add(fileName);
    }
    sb.writeln("""
    // **************************************************************************
    // $enumName
    // **************************************************************************
    """);
    ConstantReader? defaultValueReader = annotation.peek('defaultValue');
    String? defaultValueVarName;
    if (defaultValueReader != null) {
      dynamic defaultValue;
      if (defaultValueReader.isInt) {
        defaultValue = defaultValueReader.intValue;
      } else if (defaultValueReader.isString) {
        defaultValue = "'${defaultValueReader.stringValue}'";
      }
      if (defaultValue != null) {
        defaultValueVarName = "$enumMapPrefix${enumName}DefaultValue";
        sb.writeln("const $defaultValueVarName = $defaultValue;");
        sb.writeln();
      }
    }
    final enumVarName = '$enumMapPrefix$enumName$enumMapSuffix';
    sb.writeln("const $enumVarName = {");
    final enumValueChecker = TypeChecker.fromRuntime(EnumValue);
    for (FieldElement field in element.fields) {
      if (field.name == 'index' || field.name == 'values') {
        continue;
      }
      final enumAnnotation = enumValueChecker.firstAnnotationOf(field);
      if (enumAnnotation == null) {
        continue;
      }
      DartObject valueObject = enumAnnotation.getField('value')!;
      final valueType = valueObject.type!;
      if (!valueType.isDartCoreString && !valueType.isDartCoreInt) {
        continue;
      }
      if (valueType.isDartCoreString) {
        sb.writeln("'${valueObject.toStringValue()}'");
      } else {
        sb.writeln("${valueObject.toIntValue()}");
      }
      int? code = enumAnnotation.getField('code')?.toIntValue();
      sb.write(
          ":{'$enumTypeKey':$enumName.${field.name},'$enumTextKey':'${enumAnnotation.getField('text')?.toStringValue() ?? field.name}'");
      if (code != null) {
        sb.write(",'$enumCodeKey':$code");
      }
      sb.write("},");
    }
    sb.writeln("};");
    sb.writeln();
    sb.writeln("""
    String? ${enumMapPrefix}getTextFor$enumName($enumName that) {
      for (dynamic key in $enumVarName.keys) {
        Map<String, dynamic> enumInfo = $enumVarName[key]!;
        if (enumInfo['$enumTypeKey'] == that) {
          return enumInfo['$enumTextKey'];
        }
      }
      return null;
    }
    """);
    sb.writeln("""
    int? ${enumMapPrefix}getCodeFor$enumName($enumName that) {
      for (dynamic key in $enumVarName.keys) {
        Map<String, dynamic> enumInfo = $enumVarName[key]!;
        if (enumInfo['$enumTypeKey'] == that) {
          return enumInfo['$enumCodeKey'];
        }
      }
      return null;
    }
    """);
    sb.writeln("""
    dynamic ${enumMapPrefix}getValueFor$enumName($enumName that) {
      for (dynamic key in $enumVarName.keys) {
        Map<String, dynamic> enumInfo = $enumVarName[key]!;
        if (enumInfo['$enumTypeKey'] == that) {
          return key;
        }
      }
      return null;
    }
    """);
    sb.writeln("""
    $enumName ${enumMapPrefix}get${enumName}WithNonnull(dynamic value, {${defaultValueVarName != null ? '' : 'required '} Object defaultValue${defaultValueVarName != null ? ' = $defaultValueVarName' : ''}}) {
      assert(value is String || value is int);
      assert(defaultValue is String || defaultValue is int);
      final enumInfo = $enumVarName[value] ?? $enumVarName[defaultValue];
      assert(enumInfo != null);
      return enumInfo!['$enumTypeKey'] as $enumName;
    }
    """);
    sb.writeln("""
    $enumName? ${enumMapPrefix}get$enumName(dynamic value, {Object? defaultValue}) {
      assert(value is String || value is int);
      var enumInfo = $enumVarName[value];
      if (enumInfo == null && defaultValue != null) {
        assert(defaultValue is String || defaultValue is int);
        enumInfo = $enumVarName[defaultValue];
      }
      return enumInfo?['$enumTypeKey'] as $enumName?;
    }
    """);
    return sb.toString();
  }
}
