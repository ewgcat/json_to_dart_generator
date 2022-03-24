// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonToDartGenerator
// **************************************************************************

part of 'user.dart';

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      userName: json['userName']?.toString() ?? '',
      age: DecodeHelper.toInt(json['age'], 0),
      height: DecodeHelper.toDouble(json['height'], 170.0),
      workYear: DecodeHelper.tryToInt(json['workYear']),
      job: json['job']?.toString(),
      isVIP: DecodeHelper.toBool(json['isVIP'], false),
      isBoss: DecodeHelper.tryToBool(json['isBoss']),
      images: DecodeHelper.toList<String>(json['images']),
      attr: DecodeHelper.toMap<dynamic, dynamic>(json['attr']),
      addressInfo: json['addressInfo'] != null
          ? AddressInfo.fromJson(
              DecodeHelper.toMap<String, dynamic>(json['addressInfo']))
          : null,
      lastLoginTime: json['lastLoginTime'] != null
          ? DecodeHelper.toDateTime(json['lastLoginTime'])
          : null,
      gender: _$getUserGenderWithNonnull(json['gender'], defaultValue: '0'),
      phoneNumbers: json['phoneNumbers'] != null
          ? DecodeHelper.toList<Map>(json['phoneNumbers'])
              .map((e) => PhoneNumber.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : null,
      signDate: json['signDate'] != null
          ? DecodeHelper.toList(json['signDate'])
              .map((e) => DecodeHelper.toDateTime(e))
              .toList()
          : null,
      verifyDate: json['verifyDate'] != null
          ? DecodeHelper.toMap<String, dynamic>(json['verifyDate']).map(
              (key, value) => MapEntry(key, DecodeHelper.toDateTime(value)))
          : null,
      primaryPhoneNumber: json['primaryPhoneNumber'] != null
          ? DecodeHelper.toMap<String, dynamic>(json['primaryPhoneNumber']).map(
              (key, value) => MapEntry(
                  key, PhoneNumber.fromJson(Map<String, dynamic>.from(value))))
          : null,
      modifyStateRecord: json['modifyStateRecord'] != null
          ? DecodeHelper.toList(json['modifyStateRecord'])
              .where((element) => _$UserStateEnumMap.keys.contains(element))
              .map((e) => _$getUserState(e)!)
              .toList()
          : null,
      availableGender: json['availableGender'] != null
          ? (arg) {
              var map = DecodeHelper.toMap<String, dynamic>(arg);
              map.removeWhere(
                  (key, value) => _$UserGenderEnumMap.keys.contains(value));
              return map
                  .map((key, value) => MapEntry(key, _$getUserGender(value)!));
            }(json['availableGender'])
          : null,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo userInfo) {
  return {
    'userName': userInfo.userName,
    'age': userInfo.age,
    'height': userInfo.height,
    'workYear': userInfo.workYear,
    'job': userInfo.job,
    'isVIP': userInfo.isVIP,
    'isBoss': userInfo.isBoss,
    'images': userInfo.images,
    'attr': userInfo.attr,
    'addressInfo': userInfo.addressInfo?.toJson(),
    'lastLoginTime': userInfo.lastLoginTime?.millisecondsSinceEpoch,
    'gender': userInfo.gender.value,
    'phoneNumbers': userInfo.phoneNumbers?.cast<PhoneNumber>(),
    'signDate':
        userInfo.signDate?.map((e) => e.millisecondsSinceEpoch).toList(),
    'verifyDate': userInfo.verifyDate
        ?.map((key, value) => MapEntry(key, value.millisecondsSinceEpoch)),
    'primaryPhoneNumber': userInfo.primaryPhoneNumber
        ?.map((key, value) => MapEntry(key, value.toJson())),
    'modifyStateRecord':
        userInfo.modifyStateRecord?.map((e) => e.value).toList(),
    'availableGender': userInfo.availableGender
        ?.map((key, value) => MapEntry(key, value.value)),
  };
}

UserInfo _$UserInfoCopyWith(
  UserInfo userInfo, {
  String? userName,
  int? age,
  double? height,
  int? workYear,
  String? job,
  bool? isVIP,
  bool? isBoss,
  List<String>? images,
  Map<dynamic, dynamic>? attr,
  AddressInfo? addressInfo,
  DateTime? lastLoginTime,
  UserGender? gender,
  List<PhoneNumber>? phoneNumbers,
  List<DateTime>? signDate,
  Map<String, DateTime>? verifyDate,
  Map<String, PhoneNumber>? primaryPhoneNumber,
  List<UserState>? modifyStateRecord,
  Map<String, UserGender>? availableGender,
}) {
  return UserInfo(
    userName: userName ?? userInfo.userName,
    age: age ?? userInfo.age,
    height: height ?? userInfo.height,
    workYear: workYear ?? userInfo.workYear,
    job: job ?? userInfo.job,
    isVIP: isVIP ?? userInfo.isVIP,
    isBoss: isBoss ?? userInfo.isBoss,
    images: images ?? userInfo.images,
    attr: attr ?? userInfo.attr,
    addressInfo: addressInfo ?? userInfo.addressInfo,
    lastLoginTime: lastLoginTime ?? userInfo.lastLoginTime,
    gender: gender ?? userInfo.gender,
    phoneNumbers: phoneNumbers ?? userInfo.phoneNumbers,
    signDate: signDate ?? userInfo.signDate,
    verifyDate: verifyDate ?? userInfo.verifyDate,
    primaryPhoneNumber: primaryPhoneNumber ?? userInfo.primaryPhoneNumber,
    modifyStateRecord: modifyStateRecord ?? userInfo.modifyStateRecord,
    availableGender: availableGender ?? userInfo.availableGender,
  );
}

AddressInfo _$AddressInfoFromJson(Map<String, dynamic> json) => AddressInfo(
      province: json['province']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      area: json['area']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
    );

Map<String, dynamic> _$AddressInfoToJson(AddressInfo addressInfo) {
  return {
    'province': addressInfo.province,
    'city': addressInfo.city,
    'area': addressInfo.area,
    'address': addressInfo.address,
  };
}

AddressInfo _$AddressInfoCopyWith(
  AddressInfo addressInfo, {
  String? province,
  String? city,
  String? area,
  String? address,
}) {
  return AddressInfo(
    province: province ?? addressInfo.province,
    city: city ?? addressInfo.city,
    area: area ?? addressInfo.area,
    address: address ?? addressInfo.address,
  );
}

PhoneNumber _$PhoneNumberFromJson(Map<String, dynamic> json) => PhoneNumber(
      phone: json['phone']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
    );

Map<String, dynamic> _$PhoneNumberToJson(PhoneNumber phoneNumber) {
  return {
    'phone': phoneNumber.phone,
    'type': phoneNumber.type,
  };
}

PhoneNumber _$PhoneNumberCopyWith(
  PhoneNumber phoneNumber, {
  String? phone,
  String? type,
}) {
  return PhoneNumber(
    phone: phone ?? phoneNumber.phone,
    type: type ?? phoneNumber.type,
  );
}

String _$PhoneNumberToJsonString(PhoneNumber phoneNumber) {
  return json.encode(_$PhoneNumberToJson(phoneNumber));
}
