
Language: [English](README.md) | [中文](README_ZH.md)

# json_to_dart_generator

通过注解Dart class 生成json 解析文件
#### 1.添加配置
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
#### 2.创建一个文件address_info.dart 
```
import 'dart:convert';

import 'package:json_to_dart_generator/json_to_dart_generator.dart';
part 'address_info.g.dart';
@JsonObject(copyWith: true)
class AddressInfo {
  final String province;
  final String city;
  final String area;
  final String address;
   }
```
#### 3.运行

```
flutter pub run build_runner build
```
#### 4.生成文件 address_info.g.dart
```
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
```
