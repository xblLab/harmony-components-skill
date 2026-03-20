# 快递信息模板管理组件

## 简介

本组件提供模板管理的功能，可以生成一个固定物品信息的寄件模板，方便用户多次寄送同一类快递。

## 详细介绍

### 简介

本组件提供模板管理的功能，可以生成一个固定物品信息的寄件模板，方便用户多次寄送同一类快递。

### 模板列表与编辑

## 约束与限制

### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

### 权限

无

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_template`、`module_address`、`module_address_card` 和 `module_base` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 module_template、module_address、module_address_card 和 module_base 路径。其中 XXX 为组件存放的目录名
{
  "modules": [
    {
      "name": "module_template",
      "srcPath": "./XXX/module_template",
    },
    {
      "name": "module_address",
      "srcPath": "./XXX/module_address",
    },
    {
      "name": "module_address_card",
      "srcPath": "./XXX/module_address_card",
    },
    {
      "name": "module_base",
      "srcPath": "./XXX/module_base",
    }
  ]
}
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
{
  "dependencies": {
    "module_template": "file:./XXX/module_template"
  }
}
```

### 调用组件

详细参数配置说明参见 API 参考。

```typescript
import { TemplateManage } from 'module_template'
import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Sample {
  stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      Column({ space: 10 }) {
        TemplateManage({
          navPathStack: this.stack,
          onPushPath: (id: number) => {
            this.getUIContext().getPromptAction().showToast({ message: '可自定义' })
          },
        }) {
          Button('模板管理')
        }
      }
      .padding(10)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

## API 参考

### 子组件

无

### 接口

`TemplateManage(option: TemplateManageOptions)`

模板管理组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | TemplateManageOptions | 否 | 配置模板管理组件的参数。 |

**TemplateManageOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| navPathStack | NavPathStack | 是 | Navigation 路由栈实例 |
| onBeforeNavigate | () => boolean | 否 | 页面跳转前的回调，返回 false 将取消跳转 |
| onPushPath | (id: number) => void | 否 | 去寄件按钮的回调 |

### 示例代码

```typescript
import { promptAction } from '@kit.ArkUI'
import { TemplateManage } from 'module_template'

@Entry
@ComponentV2
struct Sample {
  stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      Column({ space: 10 }) {
        TemplateManage({
          navPathStack: this.stack,
          onPushPath: (id: number) => {
            this.getUIContext().getPromptAction().showToast({ message: '可自定义' })
          },
        }) {
          Button('模板管理')
        }
      }
      .padding(10)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

## 更新记录

- **1.0.2** (2026-02-13)
  - Created with Pixso.
  - 下载该版本更新已经废弃的 API
- **1.0.0** (2025-11-03)
  - Created with Pixso.
  - 下载该版本初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| 类别 | 详情 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| | 5.0.1 | Created with Pixso. |
| | 5.0.2 | Created with Pixso. |
| | 5.0.3 | Created with Pixso. |
| | 5.0.4 | Created with Pixso. |
| | 5.0.5 | Created with Pixso. |
| | 5.1.0 | Created with Pixso. |
| | 5.1.1 | Created with Pixso. |
| | 6.0.0 | Created with Pixso. |
| | 6.0.1 | Created with Pixso. |
| | 6.0.2 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| | 平板 | Created with Pixso. |
| | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| | DevEco Studio 5.0.1 | Created with Pixso. |
| | DevEco Studio 5.0.2 | Created with Pixso. |
| | DevEco Studio 5.0.3 | Created with Pixso. |
| | DevEco Studio 5.0.4 | Created with Pixso. |
| | DevEco Studio 5.0.5 | Created with Pixso. |
| | DevEco Studio 5.1.0 | Created with Pixso. |
| | DevEco Studio 5.1.1 | Created with Pixso. |
| | DevEco Studio 6.0.0 | Created with Pixso. |
| | DevEco Studio 6.0.1 | Created with Pixso. |
| | DevEco Studio 6.0.2 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/802446aa79274c388820b93877c1f114/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%BF%AB%E9%80%92%E4%BF%A1%E6%81%AF%E6%A8%A1%E6%9D%BF%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/module_template1.0.2.zip