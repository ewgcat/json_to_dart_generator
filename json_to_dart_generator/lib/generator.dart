import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:json_to_dart_generator/src/json_enum.dart';
import 'package:json_to_dart_generator/src/json_object.dart';
import 'package:source_gen/source_gen.dart';
import 'package:path/path.dart' as Path;


import 'src/json_object_collector.dart';
import 'src/json_enum_collector.dart';

class JsonToDartGenerator extends GeneratorForAnnotation<JsonObject> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element.isEnum) {
      throw InvalidGenerationSourceError(
        '`@JsonObject` can only be used on classes.',
        element: element,
      );
    }
    return JsonObjectCollector(Path.basename(buildStep.inputId.path))
        .collect(element, annotation);
  }
}

class JsonEnumGenerator extends GeneratorForAnnotation<JsonEnum> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || !element.isEnum) {
      throw InvalidGenerationSourceError(
        '`@JsonEnum` can only be used on enum.',
        element: element,
      );
    }
    return JsonEnumCollector(Path.basename(buildStep.inputId.path))
        .collect(element, annotation);
  }
}
