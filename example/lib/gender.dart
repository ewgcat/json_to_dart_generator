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