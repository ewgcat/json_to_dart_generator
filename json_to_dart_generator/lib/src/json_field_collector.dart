import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:json_to_dart_generator/src/type_helper.dart';
import 'package:source_gen/source_gen.dart';

import 'json_enum.dart';
import 'json_enum_collector.dart';
import 'json_field.dart';
import 'json_object.dart';

class JsonFieldNode {
  final String fieldName;
  final String fieldType;
  final String typeName;
  final String jsonKey;
  final bool hasNullSuffix;
  final dynamic defaultValue;
  final bool isCustomClass;
  final String? genericType;
  final String? genericKeyType;
  final String? genericValueType;
  final bool isEnum;

  JsonFieldNode({
    required this.fieldName,
    required this.fieldType,
    required this.typeName,
    required this.jsonKey,
    required this.hasNullSuffix,
    this.defaultValue,
    required this.isCustomClass,
    this.genericType,
    this.genericKeyType,
    this.genericValueType,
    required this.isEnum,
  });
}

class JsonFieldCollector {
  List<JsonFieldNode> fields = [];

  void collect(ClassElement element, ConstantReader annotation) {
    final jsonFieldChecker = TypeChecker.fromRuntime(JsonField);
    final jsonObjectChecker = TypeChecker.fromRuntime(JsonObject);
    final jsonEnumChecker = TypeChecker.fromRuntime(JsonEnum);
    for (FieldElement field in element.fields) {
      if (field.isStatic || !field.isPublic || field.getter == null) {
        continue;
      }
      DartObject? fieldAnnotation =
          jsonFieldChecker.firstAnnotationOf(field, throwOnUnresolved: false);
      if (fieldAnnotation == null) {
        fieldAnnotation = jsonFieldChecker.firstAnnotationOf(field.getter!);
      }
      if (fieldAnnotation != null) {
        bool ignore =
            fieldAnnotation.getField('ignore')?.toBoolValue() ?? false;
        if (ignore) {
          continue;
        }
      }
      String fieldName = field.displayName;
      DartType fieldType = field.type;
      bool isEnum = fieldType.element?.kind == ElementKind.ENUM;
      String typeName = fieldType.getDisplayString(withNullability: false);
      String? genericType, genericKeType, genericValueType;
      if (TypeHelper.isListType(typeName)) {
        int startIndex = typeName.indexOf('<');
        int endIndex = typeName.lastIndexOf('>');
        if (startIndex != -1 && endIndex != -1) {
          genericType = typeName.substring(startIndex + 1, endIndex);
        } else {
          genericType = 'dynamic';
        }
        if (JsonEnumCollector.allEnums.contains(genericType)) {
          isEnum = true;
        }
      } else if (TypeHelper.isMapType(typeName)) {
        int startIndex = typeName.indexOf('<');
        int endIndex = typeName.lastIndexOf('>');
        if (startIndex != -1 && endIndex != -1) {
          genericType = typeName.substring(startIndex + 1, endIndex);
        } else {
          genericType = 'dynamic, dynamic';
        }
        final values = genericType.split(',');
        genericKeType = values.first.trim();
        genericValueType = values.last.trim();
        if (JsonEnumCollector.allEnums.contains(genericValueType)) {
          isEnum = true;
        }
      } else if (field.type.element?.kind == ElementKind.ENUM) {
        if (jsonEnumChecker.firstAnnotationOf(fieldType.element!) == null) {
          print('`$typeName` has no annotation `@JsonEnum`');
          continue;
        }
      } else if (TypeHelper.isCustomClass(typeName) &&
          jsonObjectChecker.firstAnnotationOf(fieldType.element!) == null) {
        print('`$typeName` has no annotation `@JsonObject`');
        continue;
      }
      DartObject? defaultValueObject =
          fieldAnnotation?.getField('defaultValue');
      dynamic defaultValue;
      if (defaultValueObject != null) {
        if (fieldType.isDartCoreString) {
          defaultValue = defaultValueObject.toStringValue();
        } else if (fieldType.isDartCoreBool) {
          defaultValue = defaultValueObject.toBoolValue();
        } else if (fieldType.isDartCoreDouble || fieldType.isDartCoreNum) {
          defaultValue = defaultValueObject.toDoubleValue();
        } else if (fieldType.isDartCoreInt) {
          defaultValue = defaultValueObject.toIntValue();
        } else if (isEnum) {
          defaultValue = defaultValueObject.toStringValue() ??
              defaultValueObject.toIntValue();
        }
      }
      fields.add(JsonFieldNode(
        fieldName: fieldName,
        fieldType: fieldType.getDisplayString(withNullability: true),
        typeName: typeName,
        jsonKey:
            fieldAnnotation?.getField('name')?.toStringValue() ?? fieldName,
        hasNullSuffix:
            fieldType.nullabilitySuffix == NullabilitySuffix.question,
        defaultValue: defaultValue,
        isCustomClass: TypeHelper.isCustomClass(typeName),
        genericType: genericType,
        genericKeyType: genericKeType,
        genericValueType: genericValueType,
        isEnum: isEnum,
      ));
    }
  }
}
