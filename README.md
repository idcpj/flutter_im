
# 项目简介

一个基于Flutter的IM应用，支持Web、iOS、Android。


## 目录 说明

```
packages
 - client_example 用于测试相关库是否能在鸿蒙中运行
 - client_mobile  移动端客户(Android,IOS,Harmony,Web)
 - core 核心库,用于封装 sdk
```


# workspace 使用

暂不支持 worksapce ,但是写法上先按 workspace,之后等 fltter harmony 更新到 dart>3.5

# 鸿蒙

flutter: https://gitee.com/harmonycommando_flutter/flutter

## 注意
- 检查 `ohos/build-profile.json5` 中的 `compatibleSdkVersion` 是否与虚拟机中鸿蒙版本一致
- FloatingActionButton 在`flutter run --debug` 鸿蒙中使用会报错,需要移除


## TODO
-  验证 flutter 是否支持给 Android 调用
-  验证 flutter 是否支持给 IOS 调用