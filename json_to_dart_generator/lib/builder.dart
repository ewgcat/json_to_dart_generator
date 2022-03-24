import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'generator.dart';

Builder jsonObjectBuilder(BuilderOptions options) =>
    LibraryBuilder(JsonToDartGenerator(), generatedExtension: '.g.dart');

Builder jsonEnumBuilder(BuilderOptions options) =>
    LibraryBuilder(JsonEnumGenerator(), generatedExtension: '.enum.dart');
