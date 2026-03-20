# 房贷计算器组件

## 简介

本模块提供了商业贷款、公积金贷款和组合贷款的还款计划计算功能。

## 详细介绍

### 简介

本模块提供了商业贷款、公积金贷款和组合贷款的还款计划计算功能。

### 代码结构

本组件工程代码结构如下所示：

```text
mortgage_calculator/src/main/ets                  // 房贷计算器 (har)
  |- common                                       // 模块常量定义   
  |- components                                   // 模块组件
  |- types                                        // 模型定义  
  |- pages                                        // 页面
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

如果是从生态市场下载组件，请参考以下步骤安装组件：

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `xxx` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `mortgage_calculator` 模块。

```json5
"modules": [
   {
   "name": "mortgage_calculator",
   "srcPath": "./xxx/mortgage_calculator",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "mortgage_calculator": "file:./xxx/mortgage_calculator",
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
            // MortgageCalculationHome 为房贷计算路由入口页面名称
            this.pageStack.pushPathByName('MortgageCalculationHome', null);
         });
      }.hideTitleBar(true);
   }
}
```

### 更新记录

- **1.0.2 (2026-01-13)**
  - 下载该版本
  - 废弃 api 修改替换
- **1.0.1 (2025-11-06)**
  - 下载该版本
  - 修复组合贷款计算时，由于精度丢失导致贷款总额的小数位数显示异常的问题。
- **1.0.0 (2025-11-03)**
  - 下载该版本
  - 初始版本

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

- **隐私政策**：不涉及
- **SDK 合规**：不涉及

### 兼容性

| 项目 | 支持列表 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d6a45eb86acb482bb243b74a9568700e/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%88%BF%E8%B4%B7%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/mortgage_calculator1.0.2.zip