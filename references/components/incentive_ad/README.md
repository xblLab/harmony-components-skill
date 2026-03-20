# 激励广告组件

## 简介

本组件提供了展示激励广告的相关功能。

## 详细介绍

### 简介

本组件提供了展示激励广告的相关功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.4 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.4 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **HarmonyOS 版本**：HarmonyOS 5.0.4(16) 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 并添加 `incentive_ad` 模块。

```json5
// 在项目根目录的 build-profile.json5 填写 incentive_ad 路径。其中 xxx 为组件存在的目录名
"modules": [
  {
    "name": "incentive_ad",
    "srcPath": "./xxx/incentive_ad"
  }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// xxx 为组件存放的目录名称
"dependencies": {
  "incentive_ad": "file:./xxx/incentive_ad",
}
```

#### 引入组件

```typescript
import { IncentiveAdvertising } from 'incentive_ad';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
IncentiveAdvertising({
   adId: adId,
   adType: adType
})
```

### API 参考

#### 接口

`IncentiveAdvertising(options?: IncentiveAdvertisingOptions)`

展示激励广告页面组件。

**参数：**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | IncentiveAdvertisingOptions | 否 | 激励广告参数。 |

**IncentiveAdvertisingOptions 对象说明：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| adType | number | 是 | 广告类型 |
| adId | string | 是 | 广告位 ID |
| oaid | string | 否 | 开放匿名设备标识符 |

详见：[激励广告](https://developer.huawei.com/consumer/cn/doc/)

### 示例代码

```typescript
import { IncentiveAdvertising } from 'incentive_ad';

@Entry
@ComponentV2
struct Index {

   build() {
      Column() {
         IncentiveAdvertising({
            adId:'testx9dtjwj8hp',
            adType:7
         })
      }
   }
}
```

### 更新记录

- **1.0.2** (2026-01-13)
  - 下载该版本
- **1.0.1** (2025-08-29)
  - 下载该版本
  - 优化 README
- **1.0.0** (2025-07-30)
  - 下载该版本
  - 初始版本

### 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| **权限名称** | ohos.permission.INTERNET |
| **权限说明** | 允许使用 Internet 网络 |
| **使用目的** | 允许使用 Internet 网络 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/79f56199ed464ea49daedf02ac125b41/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%BF%80%E5%8A%B1%E5%B9%BF%E5%91%8A%E7%BB%84%E4%BB%B6/incentive_ad1.0.2.zip