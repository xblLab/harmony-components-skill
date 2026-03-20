# 看广告领奖励组件

## 简介

本组件提供了看广告领奖励的功能，其中看广告功能暂未对接三方广告位，所展示广告均为调测广告，实际开发中可以做借鉴使用，具体广告位请对接实际业务。

## 详细介绍

### 简介

本组件提供了看广告领奖励的功能，其中看广告功能暂未对接三方广告位，所展示广告均为调测广告，实际开发中可以做借鉴使用，具体广告位请对接实际业务。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

#### 调试

本组件支持模拟器和真机调试。模拟器调试时，无法实现广告播放功能。

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 look_ad 模块。

```json5
// 在项目根目录 build-profile.json5 填写 look_ad 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
        "name": "look_ad",
        "srcPath": "./XXX/look_ad",
    }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "look_ad": "file:./XXX/look_ad"
}
```

d. 在 entry 模块的 `EntryAbility.ets` 文件下，EntryAbility 类的 `onWindowStageCreate` 方法中添加状态存储。

```typescript
onWindowStageCreate(windowStage: window.WindowStage): void {
   AppStorage.setOrCreate('windowStage', windowStage);
   ......
}
```

引入组件。

```typescript
import { LookAD } from 'look_ad';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { LookAD } from 'look_ad';

@Entry
@ComponentV2
struct Index {

  build() {
    Column() {
      LookAD({award:"领现金"})
    }
  }
}
```

### API 参考

#### 子组件

无

#### 接口

`LookAD(options?: LookADOptions)`

看广告领奖励组件

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | LookADOptions | 否 | 看广告领奖励组件 |

**LookADOptions 对象说明：**

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| award | string | 否 | 奖励名称 |
| onLookSuccess | `(balance:number)=>void` | 否 | 定义回调函数，balance 为看广告获得金币数 |

#### 示例代码

```typescript
import { LookAD } from 'look_ad';

@Entry
@ComponentV2
struct Index {
  bonus: number = 0

  build() {
    Column() {
      LookAD({ award: "领现金", onLookSuccess: (balance: number) => this.bonus += balance })
    }
  }
}
```

### 更新记录

- **1.0.2 (2026-01-21)**
  - 下载该版本更改了背景颜色和圆角。
- **1.0.1 (2025-11-25)**
  - 下载该版本修复 README 示例代码闪退的问题。
- **1.0.0 (2025-11-03)**
  - 下载该版本初始版本。

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

#### 隐私政策

- 隐私政策：不涉及
- SDK 合规使用指南：不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3e6da56afae047d1a9e63042d5975325/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%9C%8B%E5%B9%BF%E5%91%8A%E9%A2%86%E5%A5%96%E5%8A%B1%E7%BB%84%E4%BB%B6/look_ad1.0.2.zip