# 手持弹幕组件

## 简介

本组件提供了手持弹幕、荧光棒及历史记录管理功能。

## 详细介绍

### 简介

本组件提供了手持弹幕、荧光棒及历史记录管理功能。

### 工程代码结构

本组件工程代码结构如下所示：

```text
handheld_bullet/src/main/ets                      // 手持弹幕 (har)
  |- constant                                     // 模块常量定义
  |- components                                   // 模块组件  
  |- model                                        // 模型定义
  |- util                                         // 模块工具类
  |- viewmodel                                    // 与页面一一对应的 vm 层 
  |- pages                                        // 模块页面 
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.1.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.1.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.1.0(18) 及以上

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。

如果是从生态市场下载组件，请参考以下步骤安装组件：

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `handheld_bullet` 模块。

```json5
"modules": [
   {
   "name": "handheld_bullet",
   "srcPath": "./xxx/handheld_bullet",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "handheld_bullet": "file:./xxx/handheld_bullet",
}
```

### 示例代码

```ets
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // BulletPage 为手持弹幕路由入口页面名称
            this.pageStack.pushPathByName('BulletPage', null);
         });
      }.hideTitleBar(true).mode(NavigationMode.Stack);
   }
}
```

## 更新记录

- **1.0.2 (2026-01-13)**
  - 下载该版本接入 `@hw-agconnect/util-log` 组件。
- **1.0.1 (2025-11-24)**
  - 下载该版本修复了部分使用体验问题。
- **1.0.0 (2025-11-06)**
  - 下载该版本初始版本。

## 基本信息

### 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

- 不涉及

### SDK 合规使用指南

- 不涉及

### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/20444f6d475c4e0da28b3d3b8f17d36b/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%89%8B%E6%8C%81%E5%BC%B9%E5%B9%95%E7%BB%84%E4%BB%B6/handheld_bullet1.0.2.zip