# json_to_dart_generator

### 添加配置

### 注解
#### 1.枚举
```

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

```
#### 2.类
```

```

