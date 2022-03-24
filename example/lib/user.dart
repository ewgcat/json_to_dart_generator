import 'dart:convert';

import 'package:json_to_dart_generator/json_to_dart_generator.dart';


part 'user.g.dart';

part 'user.enum.dart';

const int UserStateDisableValue = 3;

@JsonEnum(UserStateDisableValue)
enum UserState {
  @EnumValue(1, text: '锁定', code: 101)
  lock,
  @EnumValue(2, text: '正常', code: 201)
  active,
  @EnumValue(UserStateDisableValue, text: '禁用', code: 301)
  disable,
}

extension UserStateValues on UserState {
  String? get text => _$getTextForUserState(this);

  String get value => _$getValueForUserState(this)!;

  int? get code => _$getCodeForUserState(this);
}

@JsonEnum()
enum UserGender {
  @EnumValue('1', text: '女')
  female,
  @EnumValue('2', text: '男')
  male,
  @EnumValue('0', text: '未知')
  none,
}

extension UserGenderValues on UserGender {
  String get text => _$getTextForUserGender(this)!;

  String get value => _$getValueForUserGender(this)!;
}

@JsonObject(copyWith: true)
class UserInfo {
  final String userName;
  final int age;
  @JsonField(defaultValue: 170.0)
  final double height;
  final int? workYear;
  final String? job;
  final bool isVIP;
  final bool? isBoss;

  final List<String> images;

  final Map attr;

  final AddressInfo? addressInfo;

  final DateTime? lastLoginTime;

  @JsonField(defaultValue: '0')
  final UserGender gender;

  @JsonField(ignore: true)
  String get photo => images.first;

  final List<PhoneNumber>? phoneNumbers;

  final List<DateTime>? signDate;

  final Map<String, DateTime>? verifyDate;

  final Map<String, PhoneNumber>? primaryPhoneNumber;

  final List<UserState>? modifyStateRecord;

  final Map<String, UserGender>? availableGender;

  UserInfo(
      {required this.userName,
      required this.age,
      required this.height,
      this.workYear,
      this.job,
      required this.isVIP,
      this.isBoss,
      required this.images,
      required this.attr,
      this.addressInfo,
      this.lastLoginTime,
      required this.gender,
      this.phoneNumbers,
      this.signDate,
      this.verifyDate,
      this.primaryPhoneNumber,
      this.modifyStateRecord,
      this.availableGender});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonObject(copyWith: true)
class AddressInfo {
  final String province;
  final String city;
  final String area;
  final String address;

  AddressInfo(
      {required this.province,
      required this.city,
      required this.area,
      required this.address});

  factory AddressInfo.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInfoToJson(this);

  AddressInfo copyWith(
          {String? province, String? city, String? area, String? address}) =>
      _$AddressInfoCopyWith(this,
          province: province, city: city, area: area, address: address);
}

@JsonObject(toJsonString: true)
class PhoneNumber {
  final String phone;
  final String type;

  PhoneNumber({required this.phone, required this.type});

  factory PhoneNumber.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberToJson(this);
}
