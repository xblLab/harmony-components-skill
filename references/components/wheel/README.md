# 转盘组件

## 简介

本组件提供了通过转盘获取奖励的功能。

## 详细介绍

### 简介

本组件提供了通过转盘获取奖励的功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

无

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 `build-profile.json5` 添加 wheel 模块。

```json5
// 在项目根目录 build-profile.json5 填写 wheel 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
        "name": "wheel",
        "srcPath": "./XXX/wheel",
    }
]
```

c. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "wheel": "file:./XXX/wheel"
}
```

引入组件。

```typescript
import { Wheel } from 'wheel';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { Wheel } from 'wheel';

@Entry
@ComponentV2
struct Index {
  build() {
    Column() {
      Wheel({
             textCOIN: ["福利开奖 888", "福利开奖 124", "福利开奖 248", "福利开奖 68", "福利开奖 268", "福利开奖 8"],
             title: "福利大转盘",
             subTitle: "看广告领福利，惊喜多多"
           })
    }
  }
}
```

## API 参考

### 子组件

无

### 接口

`Wheel(options?: WheelOptions)`

#### 转盘组件参数

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | WheelOptions | 否 | 转盘组件 |

#### WheelOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| textCOIN | string[] | 否 | 转盘奖项 |
| title | string | 否 | 活动名称 |
| subTitle | string | 否 | 活动提示 |
| onWheelSuccess | `(balance: number) => void` | 否 | 定义回调函数，balance 为转盘获得金币数 |

## 示例代码

```typescript
import { Wheel } from 'wheel';

@Entry
@ComponentV2
struct Index {
  bonus: number = 0

  build() {
    Column() {
      Wheel({
               textCOIN: ["福利开奖 888", "福利开奖 124", "福利开奖 248", "福利开奖 68", "福利开奖 268", "福利开奖 8"],
               title: "福利大转盘",
               subTitle: "看广告领福利，惊喜多多",
               onWheelSuccess: (balance: number) => this.bonus += balance
             })
    }
  }
}
```

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2026-01-22 | 更改了背景颜色和圆角 |
| 1.0.0 | 2025-11-03 | 初始版本 |

## 权限与隐私

| 基本信息 | 说明 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 支持范围 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 ~ 6.0.1 |
| **应用类型** | 应用、元服务 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | 5.0.0 ~ 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/94fdc46e12c844c2a59e69248012d68d/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%BD%AC%E7%9B%98%E7%BB%84%E4%BB%B6/wheel1.0.1.zip