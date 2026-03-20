# AR 测量组件

## 简介

本组件提供了识别空间立方体和嵌入式立方体空间的长、宽、高的能力，可用于测量立方体体积和嵌入式空间的大小。

## 详细介绍

### 功能概述

本组件提供了识别空间立方体和嵌入式立方体空间的长、宽、高的能力，可用于测量立方体体积和嵌入式空间的大小。

**体积测量 / 空间测量**

### 工程结构

本组件工程代码结构如下所示：

```text
|- ar_measure/src/main/cpp                           // AR 测量能力库
|- ar_measure/src/main/ets                           // AR 测量(har)
     |- constant                                     // 模块常量定义   
     |- component                                    // 模块组件
     |- model                                        // 模型定义  
     |- util                                         // 模块工具类 
     |- pages                                        // 页面
     |- viewmodel                                    // 与页面一一对应的 vm 层  
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 6.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 6.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 6.0.0(20) 及以上

#### 权限

- **相机权限**：`ohos.permission.CAMERA`
- **陀螺仪传感器权限**：`ohos.permission.GYROSCOPE`
- **加速度传感器权限**：`ohos.permission.ACCELEROMETER`

#### 限制

- 本组件中的 AR 测量功能不支持模拟器。
- 本组件使用的 AR Engine 能力具有一定技术局限性，具体请参见 AR Engine 功能技术局限性。

### 使用指南

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件：

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `ar_measure` 模块。

```json5
"modules": [
   {
   "name": "ar_measure",
   "srcPath": "./xxx/ar_measure",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "ar_measure": "file:./xxx/ar_measure",
}
```

#### 调用示例

调用如下代码允许应用使用相机权限，获取相机权限后跳转到 AR 测量页面。

```ets
async requestPermissionsFn(): Promise<void> {
   let atManager = abilityAccessCtrl.createAtManager();
   if (this.context) {
     let res = await atManager.requestPermissionsFromUser(this.context, ['ohos.permission.CAMERA']);
     for (let i = 0; i < res.permissions.length; i++) {
       if ('ohos.permission.CAMERA' === res.permissions[i] && res.authResults[i] === 0) {
         this.pageInfo.clear();
         // ARMeasure 为 AR 测量路由入口页面名称
         this.pageInfo.pushPathByName('ARMeasure', null);
       }
     }
   }
 }
```

### 示例代码

```ets
import { abilityAccessCtrl } from '@kit.AbilityKit';


@Entry
@ComponentV2
struct Index {
   @Local context: Context = this.getUIContext().getHostContext() as Context;
   pageInfo: NavPathStack = new NavPathStack();

   async requestPermissionsFn(): Promise<void> {
      let atManager = abilityAccessCtrl.createAtManager();
      if (this.context) {
        let res = await atManager.requestPermissionsFromUser(this.context, ['ohos.permission.CAMERA']);
        for (let i = 0; i < res.permissions.length; i++) {
          if ('ohos.permission.CAMERA' === res.permissions[i] && res.authResults[i] === 0) {
          this.pageInfo.clear();
          // ARMeasure 为 AR 测量路由入口页面名称
          this.pageInfo.pushPathByName('ARMeasure', null);
      }
    }
  }
}

build() {
   Navigation(this.pageInfo) {
      Button('跳转').onClick(() => {
         this.requestPermissionsFn();
      });
   }
   .hideTitleBar(true).mode(NavigationMode.Stack);
}
}
```

### 更新记录

| 版本 | 日期 | 更新内容 |
| :--- | :--- | :--- |
| 1.0.3 | 2026-01-13 | 下载该版本接入@hw-agconnect/util-log 组件 |
| 1.0.2 | 2025-12-29 | 下载该版本修复切换到空间测量返回上个页面再进入黑屏问题 |
| 1.0.1 | 2025-12-10 | 下载该版本优化结果保存体验，修复测量结束返回首页再进入展示 NAN 的问题 |
| 1.0.0 | 2025-12-02 | 下载该版本初始版本 |

### 权限与隐私基本信息

#### 权限说明

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.CAMERA | 允许应用使用相机。 | 允许应用使用相机。 |
| ohos.permission.GYROSCOPE | 允许应用读取陀螺仪传感器的数据。 | 允许应用读取陀螺仪传感器的数据。 |
| ohos.permission.ACCELEROMETER | 允许应用读取加速度传感器的数据。 | 允许应用读取加速度传感器的数据。 |

#### 合规与隐私

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

#### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | DevEco Studio 6.0.0, DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/dd6e089177ca4489814f67559d071784/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/AR%E6%B5%8B%E9%87%8F%E7%BB%84%E4%BB%B6/ar_measure1.0.3.zip