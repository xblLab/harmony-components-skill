# 实名认证组件

## 简介

本组件提供实名认证的功能。

## 详细介绍

### 简介

本组件提供实名认证的功能。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

#### 权限

- 无

### 使用

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_auth` 和 `module_base` 模块。

```json5
// 在项目根目录 build-profile.json5 填写 module_auth 和 module_base 路径。其中 XXX 为组件存放的目录名
"modules": [
    {
    "name": "module_auth",
    "srcPath": "./XXX/module_auth",
    },
   {
    "name": "module_base",
    "srcPath": "./XXX/module_base",
    }
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_auth": "file:./XXX/module_auth"
}
```

调用组件。

```typescript
@Entry
@ComponentV2
struct SampleAuth {
  stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      Column({ space: 10 }) {
        Text('实名认证').fontSize(20).fontWeight(FontWeight.Bold)
        Button('go').width('100%').onClick(() => {
          this.stack.pushPath({
            name: 'RealNameAuthPage',
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

### API 参考

- **子组件**：无
- **接口**：由于本组件内流程闭环，以页面的方式注册并对外提供，不涉及 API 介绍。

### 示例代码

```typescript
@Entry
@ComponentV2
struct Sample {
  stack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.stack) {
      Column({ space: 10 }) {
        Text('实名认证').fontSize(20).fontWeight(FontWeight.Bold)
        Button('go').width('100%').onClick(() => {
          this.stack.pushPath({
            name: 'RealNameAuthPage',
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

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.1 | 2026-02-13 | 下载该版本更新已经废弃的 API |
| 1.0.0 | 2025-11-03 | 下载该版本初始版本 |

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 无 |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规 | 不涉及 |

### 兼容性

#### HarmonyOS 版本

| 版本 |
| :--- |
| 5.0.0 |
| 5.0.1 |
| 5.0.2 |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |
| 6.0.2 |

#### 应用类型

| 类型 |
| :--- |
| 应用 |
| 元服务 |

#### 设备类型

| 类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

#### DevEco Studio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.0 |
| DevEco Studio 5.0.1 |
| DevEco Studio 5.0.2 |
| DevEco Studio 5.0.3 |
| DevEco Studio 5.0.4 |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |
| DevEco Studio 6.0.1 |
| DevEco Studio 6.0.2 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/165dd0c8d79b4fd4aadf0f6d2575250a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%AE%9E%E5%90%8D%E8%AE%A4%E8%AF%81%E7%BB%84%E4%BB%B6/module_auth1.0.1.zip