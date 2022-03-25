import 'dart:convert';

import 'package:json_to_dart_generator/json_to_dart_generator.dart';

part 'student.g.dart';

@JsonObject(copyWith: true)
class Student{
  final String name;
  final  String sex;
  final  int age;
  Student(
      {required this.name,
        required this.sex,
        required this.age});
  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  Student copyWith(
      {String? name, String? sex, int? age}) =>
      _$StudentCopyWith(this,
          name: name, sex: sex, age: age);
}