# lodash(JS 对象处理) 组件

## 简介

移植 lodash.js 到 HarmonyOS，针对 HarmonyOS 做了优化，内置 TS 类型，仅保留了必要的文件以减少包体积。

## 详细介绍

### 项目信息
**wolfx/lodash**
简介：lodash for ArkTS. Built-in types, only necessary files are kept to reduce package size.
移植 lodash.js 到 HarmonyOS，针对 HarmonyOS 做了优化，内置 TS 类型，仅保留了必要的文件以减少包体积。

### 安装
```bash
ohpm install @wolfx/lodash
```

### Example
深色代码主题复制
```typescript
import _ from '@wolfx/lodash';

@Entry
@Component
struct TestLodash {
  @State message: string = _.max([1, 2, 3]).toString();

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}
```

### 更新记录
- **[4.17.21-rc.3]** 2025.12.09
  - 更新到 API 17
- **[4.17.21-rc.2]** 2024.03.06
  - 补充 example，无功能修改。
- **[4.17.21-rc.1]** 2024.02.22
  - 初始版本，移植 lodash.js 到 HarmonyOS，针对 HarmonyOS 做了优化，内置 TS 类型，仅保留了必要的文件以减少包体积。

### 权限与隐私
| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性
| HarmonyOS 版本 | 5.0.0 |
| :--- | :--- |

Created with Pixso.

| 应用类型 | 应用 |
| :--- | :--- |
| Created with Pixso. | |

| 元服务 | |
| :--- | :--- |
| Created with Pixso. | |

| 设备类型 | 手机 |
| :--- | :--- |
| Created with Pixso. | |

| 平板 | |
| :--- | :--- |
| Created with Pixso. | |

| PC | |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| :--- | :--- |
| Created with Pixso. | |

## 安装方式

```bash
ohpm install @wolfx/lodash
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/be0df4b52b1a462fa20ae87adabe1812/PLATFORM?origin=template