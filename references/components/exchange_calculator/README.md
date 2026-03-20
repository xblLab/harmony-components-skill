# 汇率计算器组件

## 简介

本组件提供了多种币种之间实时汇率计算的功能。

## 详细介绍

### 简介

本组件提供了多种币种之间实时汇率计算的功能。

### 工程结构

本组件工程代码结构如下所示：

```text
exchange_calculator/src/main/ets                  // 汇率计算器 (har)
 |- apis                                         // 公共路由
 |- common                                       // 公共路由
 |- constants                                    // 模块常量     
 |- mocks                                        // mock 数据 
 |- model                                        // 模型定义  
 |- pages                                        // 页面
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

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 exchange_calculator 模块。
3. 在项目根目录 `oh-package.json5` 中添加依赖。

**添加模块配置：**

```json5
"modules": [
   {
   "name": "exchange_calculator",
   "srcPath": "./xxx/exchange_calculator",
   },
]
```

**添加依赖配置：**

```json5
"dependencies": {
   "exchange_calculator": "file:./xxx/exchange_calculator",
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
           // ExchangeRateCalculatorPage 为汇率计算路由入口页面名称
           this.pageStack.pushPathByName('ExchangeRateCalculatorPage', null);
        });
     }.hideTitleBar(true);
  }
}
```

### 更新记录

- **1.0.2 (2026-01-16)**
  - 下载该版本接入 @hw-agconnect/util-log 和 @hw-agconnect/axios-mock-adapter 组件
  - Created with Pixso.

- **1.0.1 (2025-12-29)**
  - 下载该版本更新已经废弃的 API
  - Created with Pixso.

- **1.0.0 (2025-11-03)**
  - 下载该版本初始版本
  - Created with Pixso.

### 权限与隐私

#### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

#### 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 (Created with Pixso.) |
| **应用类型** | 应用，元服务 (Created with Pixso.) |
| **设备类型** | 手机，平板，PC (Created with Pixso.) |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 (Created with Pixso.) |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/ea56b88873204c87ac6513a3f770d14a/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%B1%87%E7%8E%87%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/exchange_calculator1.0.2.zip