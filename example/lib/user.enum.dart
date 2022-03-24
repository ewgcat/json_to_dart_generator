// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonEnumGenerator
// **************************************************************************

part of 'user.dart';

// **************************************************************************
// UserState
// **************************************************************************

const _$UserStateDefaultValue = 3;

const _$UserStateEnumMap = {
  1: {'enum': UserState.lock, 'text': '锁定', 'code': 101},
  2: {'enum': UserState.active, 'text': '正常', 'code': 201},
  3: {'enum': UserState.disable, 'text': '禁用', 'code': 301},
};

String? _$getTextForUserState(UserState that) {
  for (dynamic key in _$UserStateEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$UserStateEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return enumInfo['text'];
    }
  }
  return null;
}

int? _$getCodeForUserState(UserState that) {
  for (dynamic key in _$UserStateEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$UserStateEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return enumInfo['code'];
    }
  }
  return null;
}

dynamic _$getValueForUserState(UserState that) {
  for (dynamic key in _$UserStateEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$UserStateEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return key;
    }
  }
  return null;
}

UserState _$getUserStateWithNonnull(dynamic value,
    {Object defaultValue = _$UserStateDefaultValue}) {
  assert(value is String || value is int);
  assert(defaultValue is String || defaultValue is int);
  final enumInfo =
      _$UserStateEnumMap[value] ?? _$UserStateEnumMap[defaultValue];
  assert(enumInfo != null);
  return enumInfo!['enum'] as UserState;
}

UserState? _$getUserState(dynamic value, {Object? defaultValue}) {
  assert(value is String || value is int);
  var enumInfo = _$UserStateEnumMap[value];
  if (enumInfo == null && defaultValue != null) {
    assert(defaultValue is String || defaultValue is int);
    enumInfo = _$UserStateEnumMap[defaultValue];
  }
  return enumInfo?['enum'] as UserState?;
}

// **************************************************************************
// UserGender
// **************************************************************************

const _$UserGenderEnumMap = {
  '1': {'enum': UserGender.female, 'text': '女'},
  '2': {'enum': UserGender.male, 'text': '男'},
  '0': {'enum': UserGender.none, 'text': '未知'},
};

String? _$getTextForUserGender(UserGender that) {
  for (dynamic key in _$UserGenderEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$UserGenderEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return enumInfo['text'];
    }
  }
  return null;
}

int? _$getCodeForUserGender(UserGender that) {
  for (dynamic key in _$UserGenderEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$UserGenderEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return enumInfo['code'];
    }
  }
  return null;
}

dynamic _$getValueForUserGender(UserGender that) {
  for (dynamic key in _$UserGenderEnumMap.keys) {
    Map<String, dynamic> enumInfo = _$UserGenderEnumMap[key]!;
    if (enumInfo['enum'] == that) {
      return key;
    }
  }
  return null;
}

UserGender _$getUserGenderWithNonnull(dynamic value,
    {required Object defaultValue}) {
  assert(value is String || value is int);
  assert(defaultValue is String || defaultValue is int);
  final enumInfo =
      _$UserGenderEnumMap[value] ?? _$UserGenderEnumMap[defaultValue];
  assert(enumInfo != null);
  return enumInfo!['enum'] as UserGender;
}

UserGender? _$getUserGender(dynamic value, {Object? defaultValue}) {
  assert(value is String || value is int);
  var enumInfo = _$UserGenderEnumMap[value];
  if (enumInfo == null && defaultValue != null) {
    assert(defaultValue is String || defaultValue is int);
    enumInfo = _$UserGenderEnumMap[defaultValue];
  }
  return enumInfo?['enum'] as UserGender?;
}
