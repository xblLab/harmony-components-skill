# 退休年龄计算器组件

## 简介

本组件提供了退休年龄计算的功能。

## 详细介绍

### 组件简介

本组件提供了退休年龄计算的功能。

### 工程代码结构

本组件工程代码结构如下所示：

```text
retirement_age_calculator/src/main/ets            // 退休年龄计算器(har)
|- common                                       // 模块常量   
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

安装组件。如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 retirement_age_calculator 模块。

```json5
"modules": [
   {
   "name": "retirement_age_calculator",
   "srcPath": "./xxx/retirement_age_calculator",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "retirement_age_calculator": "file:./xxx/retirement_age_calculator",
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
            // RetirementAgePage 为退休年龄计算器路由入口页面名称
            this.pageStack.pushPathByName('RetirementAgePage', null);
         });
      }.hideTitleBar(true);
   }
}
```

### 更新记录

**1.0.0** (2025-11-25)

下载该版本初始版本

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5, 5.1.0, 5.1.1, 6.0.0 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEco Studio 版本 | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/488aaa9d36a24138b2eb3d0ed8be21fc/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E9%80%80%E4%BC%91%E5%B9%B4%E9%BE%84%E8%AE%A1%E7%AE%97%E5%99%A8%E7%BB%84%E4%BB%B6/retirement_age_calculator1.0.0.zip