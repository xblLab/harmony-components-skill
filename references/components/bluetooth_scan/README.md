# 蓝牙扫描组件

## 简介

本组件模块提供了 2 个单独的组件分别提供蓝牙扫描、扫描信息展示的能力，可以帮助开发者快速集成蓝牙相关的能力，开发者可以按需取用。

## 详细介绍

### 简介

本组件模块提供了 2 个单独的组件分别提供蓝牙扫描、扫描信息展示的能力，可以帮助开发者快速集成蓝牙相关的能力，开发者可以按需取用。

---

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（直板机）
- **HarmonyOS 版本**：HarmonyOS 5.0.4 Release 及以上

#### 权限要求

- **蓝牙权限**：ohos.permission.ACCESS_BLUETOOTH

#### 调试

本组件不支持使用模拟器调试，请使用真机进行调试。

### 快速入门

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
b. 在项目根目录 build-profile.json5 并添加 bluetooth_scan 和 base_apis 模块。

```json5
// 在项目根目录 build-profile.json5 填写 bluetooth_scan 和 base_apis 路径，其中 xxx 为组件存在的目录名
"modules": [
   {
     "name": "base_apis",
     "srcPath": "./xxx/base_apis",
   },
   {
     "name": "bluetooth_scan",
     "srcPath": "./xxx/bluetooth_scan"
   }
]
```

c. 在项目根目录 oh-package.json5 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
   "bluetooth_scan": "file:../xxx/bluetooth_scan"
}
```

#### 引入组件

```typescript
import { BleScannedDevicesView, BleScanView, BleScanViewModel } from 'bluetooth_scan';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
import { BleScannedDevicesView, BleScanView, BleScanViewModel } from 'bluetooth_scan';

@Entry
@Component
struct Index {
   pathStack: NavPathStack = new NavPathStack()
   bleScanViewModel: BleScanViewModel = new BleScanViewModel()

   build() {
     Column(){
       BleScanView({ pathStack: this.pathStack, bleScanViewModel: this.bleScanViewModel })
       BleScannedDevicesView({ pathStack: this.pathStack, bleScanViewModel: this.bleScanViewModel })
     }
     .width('100%')
     .height('100%')
   }
}
```

## API 参考

### 子组件

无

### 接口

- **BleScanView(options?: BleScanViewOptions)**
  蓝牙扫描组件。
- **BleScannedDevicesView(options?: BleScanViewOptions)**
  扫描信息展示组件。

### 参数

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | BleScanViewOptions | 是 | 配置蓝牙扫描组件的参数。 |

### BleScanViewOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| pathStack | NavPathStack | 是 | Navigation 路由栈 |
| bleScanViewModel | BleScanViewModel | 是 | 蓝牙扫描类，构建时可传入过滤信息，内置参数接收扫描信息 |

### BleScanViewModel 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| deviceNamesToScan | string[] | 否 | 非必填，扫描时过滤的设备名 |

### 示例代码

#### 示例 1（设置设备过滤名称）

本示例通过设置设备过滤名称实现只扫描发现需要的组件。

```typescript
import { BleScannedDevicesView, BleScanView, BleScanViewModel } from 'bluetooth_scan';

@Entry
@Component
struct Index {
   pathStack: NavPathStack = new NavPathStack()
   // 周边有"HUAWEI Band 7-E09"名称的蓝牙设备才能搜到
   bleScanViewModel: BleScanViewModel = new BleScanViewModel(['HUAWEI Band 7-E09'])

   build() {
      Column(){
         BleScanView({ pathStack: this.pathStack, bleScanViewModel: this.bleScanViewModel })
         BleScannedDevicesView({ pathStack: this.pathStack, bleScanViewModel: this.bleScanViewModel })
      }
      .width('100%')
      .height('100%')
   }
}
```

## 更新记录

### 1.0.0 (2025-11-03)

- Created with Pixso.

## 权限与隐私

### 基本信息

- **下载该版本**：初始版本
- **SDK 合规使用指南**：不涉及

### 权限名称与说明

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.ACCESS_BLUETOOTH | 允许应用接入蓝牙并使用蓝牙能力，例如配对、连接外围设备等。 | 允许应用接入蓝牙并使用蓝牙能力，例如配对、连接外围设备等。 |
| ohos.permission.PRIVACY_WINDOW | 允许应用将窗口设置为隐私窗口，禁止截屏录屏。 | 允许应用将窗口设置为隐私窗口，禁止截屏录屏。 |
| ohos.permission.GET_WIFI_INFO | 允许应用获取 Wi-Fi 信息。 | 允许应用获取 Wi-Fi 信息。 |

### 隐私政策

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 | 支持状态 |
| :--- | :--- |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |

### 应用类型

| 类型 | 支持状态 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

### 设备类型

| 类型 | 支持状态 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

### DevEco Studio 版本

| 版本 | 支持状态 |
| :--- | :--- |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f6bf602fb1224791ae5874a45e292728/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%93%9D%E7%89%99%E6%89%AB%E6%8F%8F%E7%BB%84%E4%BB%B6/bluetooth_scan1.0.0.zip