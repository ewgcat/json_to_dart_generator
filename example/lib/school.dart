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