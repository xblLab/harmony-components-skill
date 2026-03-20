# 定位打卡组件

## 简介

本组件提供了定位打卡，查询打卡记录的功能。

## 详细介绍

### 简介

本组件提供了定位打卡，查询打卡记录的功能。

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.3 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.3 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.3(15) 及以上

#### 权限

- 获取位置权限：ohos.permission.APPROXIMATELY_LOCATION、ohos.permission.LOCATION
- 网络权限：ohos.permission.INTERNET
- 震动权限：ohos.permission.VIBRATE

### 使用

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 build-profile.json5 添加 clock_in 模块。

```json5
// build-profile.json5
"modules": [
   {
      "name": "clock_in",
      "srcPath": "./XXX/clock_in",
   }
]
```

3. 在项目根目录 oh-package.json5 中添加依赖。

```json5
// 在项目根目录 oh-package.json5 填写 clock_in 路径。其中 XXX 为组件存放的目录名
"dependencies": {
   "clock_in": "file:./XXX/clock_in"
}
```

引入组件。

```typescript
import { ClockInView } from 'clock_in';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
ClockInView({
   latitude:31.978252425174848,
   longitude:118.76696853313138,
   distance: 50,
   onClockInSuccess:(address:AddressParam) => {
      console.log('打卡成功', JSON.stringify(address))
   },
   onFailed:() => {
      console.log('打卡失败')
   }
})
```

### API 参考

#### 子组件

无

#### 接口

ClockInView(param)

#### param 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| latitude | number | 是 | 打卡中心点纬度坐标 |
| longitude | number | 是 | 打卡中心点经度坐标 |
| distance | number | 是 | 打卡范围半径，单位米 |
| onClockInSuccess | Function | 是 | 打卡成功回调函数 |

### 示例代码

1. 在 module.json5 中配置如下权限。

```json5
"requestPermissions": [
      {
         "name": "ohos.permission.INTERNET"
      },
      {
         "name": 'ohos.permission.LOCATION',
         "reason": '$string:permission_reason_location',
         "usedScene": {
            "abilities": [
            "EntryAbility"
            ],
            "when": "inuse"
         }
      },
      {
         "name": 'ohos.permission.APPROXIMATELY_LOCATION',
         "reason": '$string:permission_reason_location',
         "usedScene": {
            "abilities": [
            "EntryAbility"
            ],
            "when": "inuse"
         }
      },
      {
         "name": 'ohos.permission.VIBRATE',
         "reason": '$string:permission_reason_vibrate',
         "usedScene": {
            "abilities": [
            "EntryAbility"
            ],
            "when": "inuse"
         }
      }
 ]
```

2. 在使用组件的页面添加如下代码。其中，经纬度以及打卡半径（米）请按实际数值填写，不在范围内会提示“打卡不在范围内”。

```typescript
import { ClockInView, AddressParam } from 'clock_in';

@Entry
@ComponentV2
export struct Index {
   @Provider() isPageShow: boolean = false; // 用于打开软件后自动打卡

   onPageShow(): void {
      this.isPageShow = true;
   }

   onPageHide(): void {
      this.isPageShow = false;
   }
   
   build() {
     Column(){
      ClockInView({
        latitude:31.978252425174848,
        longitude:118.76696853313138,
        distance: 50,
        onSuccess:(address:AddressParam) => {
          console.log('打卡成功', JSON.stringify(address))
        },
        onFailed:() => {
          console.log('打卡失败')
        }
      })
     }
     .width('100%')
     .height('100%')
   }
}
```

### 更新记录

#### 1.0.1 (2025-12-19)

Created with Pixso.

下载该版本

#### 1.0.0 (2025-11-25)

Created with Pixso.

下载该版本

#### 初始版本

Created with Pixso.

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.APPROXIMATELY_LOCATION | 允许应用获取设备模糊位置信息 | 允许应用获取设备模糊位置信息 |
| ohos.permission.LOCATION | 允许应用获取设备位置信息 | 允许应用获取设备位置信息 |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.VIBRATE | 允许应用控制马达振动 | 允许应用控制马达振动 |

#### 合规使用指南

不涉及

### 兼容性

| 项目 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.3 <br> Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 <br> Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 <br> Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 <br> Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 <br> Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 <br> Created with Pixso. |
| 应用类型 | 应用 <br> Created with Pixso. |
| 应用类型 | 元服务 <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| 设备类型 | 平板 <br> Created with Pixso. |
| 设备类型 | PC <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 <br> Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6cdddf0c9af2471eb5e71549d5ba69d6/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%AE%9A%E4%BD%8D%E6%89%93%E5%8D%A1%E7%BB%84%E4%BB%B6/clock_in1.0.1.zip