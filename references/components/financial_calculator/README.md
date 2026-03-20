# 理财计算器组件

## 简介

本组件提供了银行理财、复利理财、定投理财等功能。

## 详细介绍

### 简介

本组件提供了银行理财、复利理财、定投理财等功能。

### 工程代码结构

本组件工程代码结构如下所示：

```text
financial_calculator/src/main/ets                 // 理财计算器(har)
  |- common                                       // 模块常量   
  |- components                                   // 模块组件
  |- model                                        // 模型定义  
  |- pages                                        // 页面
  |- utils                                        // 模块工具类
  |- viewmodel                                    // 与页面一一对应的 vm 层
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

无

### 使用

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `financial_calculator` 模块。

```json5
"modules": [
   {
   "name": "financial_calculator",
   "srcPath": "./xxx/financial_calculator",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "financial_calculator": "file:./xxx/financial_calculator",
}
```

### 示例代码

```typescript
@Entry
@ComponentV2
export struct Index {
   @Local pageStack: NavPathStack = new NavPathStack();

   build() {
      Navigation(this.pageStack) {
         Button('跳转').onClick(() => {
            // FinancialPage 为理财计算器路由入口页面名称
            this.pageStack.pushPathByName('FinancialPage', null);
         });
      }.hideTitleBar(true);
   }
}
```

### 更新记录

- **1.0.2** (2026-02-13)
  - 下载该版本
  - 修复部分规范性问题
- **1.0.1** (2025-12-29)
  - 下载该版本
  - 更新已经废弃的 API
- **1.0.0** (2025-11-24)
  - 下载该版本
  - 初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规使用指南**：不涉及

### 兼容性

- **HarmonyOS 版本**：5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2
- **应用类型**：应用、元服务
- **设备类型**：手机、平板、PC
- **DevEco Studio 版本**：
  - DevEco Studio 5.0.5
  - DevEco Studio 5.1.0
  - DevEco Studio 5.1.1
  - DevEco Studio 6.0.0
  - DevEco Studio 6.0.1
  - DevEco Studio 6.0.2

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f1acd889a78f421aa3b78dfdaede2b55/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%90%86%E8%B4%A2%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/financial_calculator1.0.2.zip