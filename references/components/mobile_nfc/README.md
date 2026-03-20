# 手机 NFC 组件

## 简介

本组件提供门禁卡、公交卡和银行卡的读取和克隆功能。

## 详细介绍

### 简介

本组件提供门禁卡、公交卡和银行卡的读取和克隆功能。

### 工程结构

本组件工程代码结构如下所示：

```text
mobile_nfc/src/main/ets                           // 手机 NFC(har)
 |- common                                       // 模块常量定义   
 |- components                                   // 模块组件
 |- model                                        // 模型定义  
 |- pages                                        // 页面
 |- db                                           // 模块数据库类
 |- viewmodel                                    // 与页面一一对应的 vm 层  
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

- **NFC 权限**：`ohos.permission.NFC_TAG`

#### 限制

- 本组件当前仅支持 MIFARE Classic 类型卡片的读取及克隆。

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `mobile_nfc` 模块。

```json5
"modules": [
   {
   "name": "mobile_nfc",
   "srcPath": "./xxx/mobile_nfc",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "mobile_nfc": "file:./xxx/mobile_nfc",
}
```

### 初始化

在主工程的 `EntryAbility.ets` 文件中 `onCreate` 的生命周期函数中初始化数据库和 NFC。

```typescript
import { appDB, initNFC } from 'mobile_nfc';

onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  ...
  appDB.initDb(this.context)
  initNFC(want)
  ...
}
```

## 示例代码

```typescript
@Entry
@ComponentV2
export struct Index {
  @Local pageStack: NavPathStack = new NavPathStack();

  build() {
     Navigation(this.pageStack) {
        Button('跳转').onClick(() => {
           // NfcHome 为手机 NFC 路由入口页面名称
           this.pageStack.pushPathByName('NfcHome', null);
        });
     }.hideTitleBar(true);
  }
}
```

## 更新记录

- **1.0.2 (2026-01-13)**
  - 下载该版本接入 `@hw-agconnect/util-log` 组件。
  - 废弃 api 整改。
- **1.0.1 (2025-12-03)**
  - 下载该版本修复克隆卡片时显示检测不到卡片的问题。
- **1.0.0 (2025-09-10)**
  - 下载该版本初始版本。

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| `ohos.permission.NFC_TAG` | 允许应用读写 Tag 卡片。 | 允许应用读写 Tag 卡片。 |

**隐私政策**：不涉及 SDK 合规使用指南。

## 兼容性

### 基本信息

| 项目 | 信息 |
| :--- | :--- |
| **应用类型** | 应用 / 元服务 |
| **设备类型** | 手机 / 平板 / PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.5 / 5.1.0 / 5.1.1 / 6.0.0 / 6.0.1 |

### 系统要求

| HarmonyOS 版本 |
| :--- |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fb4cc925c1ff40f8a890f18f7636b66c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%89%8B%E6%9C%BANFC%E7%BB%84%E4%BB%B6/mobile_nfc1.0.2.zip