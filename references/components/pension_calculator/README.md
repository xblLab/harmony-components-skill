# 养老金计算器组件

## 简介

本组件提供了养老金计算的功能。

## 详细介绍

### 简介

本组件提供了养老金计算的功能。

### 工程代码结构

本组件工程代码结构如下所示：

```text
深色代码主题复制
pension_calculator/src/main/ets                   // 养老金计算器 (har)
  |- common                                       // 模块常量   
  |- components                                   // 模块组件
  |- model                                        // 模型定义  
  |- pages                                        // 页面
  |- utils                                        // 模块工具类
  |- viewmodel                                    // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上
- HarmonyOS SDK 版本：HarmonyOS 5.0.5 Release SDK 及以上
- 设备类型：华为手机（包括双折叠和阔折叠）
- HarmonyOS 版本：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

### 使用

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. b. 在项目根目录 build-profile.json5 添加 pension_calculator 模块。
   深色代码主题复制
   ```json5
   "modules": [
      {
      "name": "pension_calculator",
      "srcPath": "./xxx/pension_calculator",
      },
   ]
   ```
3. c. 在项目根目录 oh-package.json5 中添加依赖
   深色代码主题复制
   ```json5
   "dependencies": {
      "pension_calculator": "file:./xxx/pension_calculator",
   }
   ```

## 示例代码

深色代码主题复制
```typescript
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // PensionPage 为养老金计算器路由入口页面名称
            this.pageStack.pushPathByName('PensionPage', null);
         });
      }.hideTitleBar(true);
   }
}
```

## 更新记录

### 1.0.2 (2026-02-13)

深色代码主题复制
Created with Pixso.

### 1.0.1 (2025-12-29)

深色代码主题复制
Created with Pixso.

### 1.0.0 (2025-11-24)

深色代码主题复制
Created with Pixso.

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.5
  Created with Pixso.
- 5.1.0
  Created with Pixso.
- 5.1.1
  Created with Pixso.
- 6.0.0
  Created with Pixso.
- 6.0.1
  Created with Pixso.
- 6.0.2
  Created with Pixso.

### 应用类型

- 应用
  Created with Pixso.
- 元服务
  Created with Pixso.

### 设备类型

- 手机
  Created with Pixso.
- 平板
  Created with Pixso.
- PC
  Created with Pixso.

### DevEcoStudio 版本

- DevEco Studio 5.0.5
  Created with Pixso.
- DevEco Studio 5.1.0
  Created with Pixso.
- DevEco Studio 5.1.1
  Created with Pixso.
- DevEco Studio 6.0.0
  Created with Pixso.
- DevEco Studio 6.0.1
  Created with Pixso.
- DevEco Studio 6.0.2
  Created with Pixso.

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/cbd77334fb514df98c5faf18c7653e48/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E5%85%BB%E8%80%81%E9%87%91%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/pension_calculator1.0.2.zip