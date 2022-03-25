Language: [English](README.md) | [中文](README_ZH.md)

# json_to_dart_generator
Generate json parsing file by annotating Dart class 

Support Enum
Support class



## Usage

### 1. Use this package as a library
add json_dart_generator to dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  json_to_dart_generator: any

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.0.0
  json_to_dart_generator: any
```

```dart
import 'package:json_to_dart_generator/json_to_dart_generator.dart';


```
###  2.Support class
#### 1. create a dart file school.dart    
```
import 'dart:convert';

import 'package:json_to_dart_generator/json_to_dart_generator.dart';

part 'school.g.dart';
@JsonObject(copyWith: true)
class School{
  final String schoolName;
  final List<Grade>? gradeList;
  School({required this.schoolName, this.gradeList});
  factory School.fromJson(Map<String, dynamic> json) =>
      _$SchoolFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}

@JsonObject(toJsonString: true)
class Grade{
  String gradeName;
  Grade({required this.gradeName});

  factory Grade.fromJson(Map<String, dynamic> json) =>
      _$GradeFromJson(json);

  Map<String, dynamic> toJson() => _$GradeToJson(this);

  Grade copyWith(
      {String? gradeName}) =>
      _$GradeCopyWith(this,gradeName: gradeName);
}
```
             
#### 2. Running    
```
flutter pub run build_runner build
```
#### 3.generate school.g.dart
```
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonToDartGenerator
// **************************************************************************

part of 'school.dart';

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      schoolName: json['schoolName']?.toString() ?? '',
      gradeList: json['gradeList'] != null
          ? DecodeHelper.toList<Map>(json['gradeList'])
              .map((e) => Grade.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : null,
    );

Map<String, dynamic> _$SchoolToJson(School school) {
  return {
    'schoolName': school.schoolName,
    'gradeList': school.gradeList?.cast<Grade>(),
  };
}

School _$SchoolCopyWith(
  School school, {
  String? schoolName,
  List<Grade>? gradeList,
}) {
  return School(
    schoolName: schoolName ?? school.schoolName,
    gradeList: gradeList ?? school.gradeList,
  );
}

Grade _$GradeFromJson(Map<String, dynamic> json) => Grade(
      gradeName: json['gradeName']?.toString() ?? '',
    );

Map<String, dynamic> _$GradeToJson(Grade grade) {
  return {
    'gradeName': grade.gradeName,
  };
}

Grade _$GradeCopyWith(
  Grade grade, {
  String? gradeName,
}) {
  return Grade(
    gradeName: gradeName ?? grade.gradeName,
  );
}

String _$GradeToJsonString(Grade grade) {
  return json.encode(_$GradeToJson(grade));
}

```
###  3.Support Enum

#### 1. create a dart file gender.dart
```
import 'dart:convert';

import 'package:json_to_dart_generator/json_to_dart_generator.dart';
part 'gender.enum.dart';
@JsonEnum()
enum Gender {
  @EnumValue('1', text: '女', code: 101)
  female,
  @EnumValue('2', text: '男', code: 201)
  male,
  @EnumValue('0', text: '未知', code: 301)
  none,
}

extension GenderValues on Gender {
  String get text => _$getTextForGender(this)!;

  String get value => _$getValueForGender(this)!;
}
```

#### 2. Running
```
flutter pub run build_runner build
```
#### 3.generate gender.enum.dart
```
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonEnumGenerator
// **************************************************************************

part of 'gender.dart';

// **************************************************************************
// Gender
// **************************************************************************

const _$GenderEnumMap = {
  '1': {'enum': Gender.female, 'text': '女', 'code': 101},
  '2': {'enum': Gender.male, 'text': '男', 'code': 201},
  '0': {'enum': Gender.none, 'text': '未知', 'code': 301},
};

String? _$getTextForGender(Gender that) {
  for (dynamic key in _$GenderEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$GenderEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return enumInfo['text'];
    }
  }
  return null;
}

int? _$getCodeForGender(Gender that) {
  for (dynamic key in _$GenderEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$GenderEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return enumInfo['code'];
    }
  }
  return null;
}

dynamic _$getValueForGender(Gender that) {
  for (dynamic key in _$GenderEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$GenderEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return key;
    }
  }
  return null;
}

Gender _$getGenderWithNonnull(dynamic value, {required Object defaultValue}) {
  assert(value is String || value is int);
  assert(defaultValue is String || defaultValue is int);
  final enumInfo = _$GenderEnumMap[value] ?? _$GenderEnumMap[defaultValue];
  assert(enumInfo != null);
  return enumInfo!['enum'] as Gender;
}

Gender? _$getGender(dynamic value, {Object? defaultValue}) {
  assert(value is String || value is int);
  var enumInfo = _$GenderEnumMap[value];
  if (enumInfo == null && defaultValue != null) {
    assert(defaultValue is String || defaultValue is int);
    enumInfo = _$GenderEnumMap[defaultValue];
  }
  return enumInfo?['enum'] as Gender?;
}
```