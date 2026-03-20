# 地图定位的地址管理组件

## 简介

提供地址管理组件，支持新增、编辑、删除地址。

## 详细介绍

### 简介

本组件提供新增、编辑、删除地址相关功能。

### 地址列表地址编辑

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.0(12) 及以上

#### 前提

选择地点需要使用地图选点 Button，参考开发前提。

### 快速入门

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。

b. 在项目根目录 build-profile.json5 添加 module_address_manage、module_base、module_form 模块。

> 深色代码主题复制
```json5
// 项目根目录下 build-profile.json5 填写 module_address_manage、module_base、module_form 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_address_manage",
    "srcPath": "./XXX/module_address_manage"
  },
  {
    "name": "module_base",
    "srcPath": "./XXX/module_base"
  },
  {
    "name": "module_form",
    "srcPath": "./XXX/module_form"
  }
]
```

c. 在项目根目录 oh-package.json5 添加依赖。

> 深色代码主题复制
```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_base": "file:./XXX/module_base",
  "module_address_manage": "file:./XXX/module_address_manage"
}
```

引入组件。

> 深色代码主题复制
```typescript
import { RouterMap } from 'module_base';
```

选择地点将使用地图服务，所以需开通地图服务。

### API 参考

**接口**

由于本组件内流程闭环，以页面的方式注册并对外提供，不涉及 API 介绍。

### 示例代码

> 深色代码主题复制
```typescript
import { RouterMap } from 'module_base'

@Entry
@ComponentV2
struct AddrSample {
  stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      Column({ space: 10 }) {
        Text('地址管理').fontSize(20).fontWeight(FontWeight.Bold)
        Button('go').width('100%').onClick(() => {
          this.stack.pushPath({
            name: RouterMap.ADDRESS_MANAGE,
          })
        })
      }
      .padding(10)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}
```

### 更新记录

- **1.0.1 (2025-10-31)**
  - Created with Pixso.
  - 下载该版本优化 README
- **1.0.0 (2025-08-29)**
  - Created with Pixso.
  - 下载该版本初始版本

### 权限与隐私

| 项目 | 详情 |
| :--- | :--- |
| 基本信息 | 权限名称：无，权限说明：无，使用目的：无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c1baaf84c6f84c82bed02cf1572623ca/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%9C%B0%E5%9B%BE%E5%AE%9A%E4%BD%8D%E7%9A%84%E5%9C%B0%E5%9D%80%E7%AE%A1%E7%90%86%E7%BB%84%E4%BB%B6/module_address_manage1.0.1.zip