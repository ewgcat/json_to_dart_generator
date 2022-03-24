Language: [English](README.md) | [中文](README_ZH.md)

# json_to_dart_generator
Generate json parsing file by annotating Dart class 

Support enum
Support multiple formats(array root / multiple array)



## Usage

#### 1. Use this package as a library
add json_dart_generator to dependencies

```yaml
dev_dependencies:
  json_to_dart_generator: any
```

```dart
import 'package:json_to_dart_generator/json_to_dart_generator.dart';


```
#### 2. create a dart file address_info.dart    
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
             
#### 3. Running    
```
flutter pub run build_runner build
```
#### 4.generate address_info.g.dart
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
