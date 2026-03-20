# 记账组件

## 简介

本组件提供记账、查看账单列表和统计图表的功能。

## 详细介绍

### 目录结构

本组件工程代码结构如下所示：

```text
money_track/src/main/ets                          // 记账 (har)
 |- commons                                      // 模块常量定义   
 |- components                                   // 模块组件
 |- dialogs                                      // 模型弹窗  
 |- views                                        // 页面
 |- utils                                        // 模块工具类
 |- viewmodels                                   // 与页面一一对应的 vm 层 
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **HarmonyOS 版本**：HarmonyOS 5.0.5(17) 及以上

#### 权限

- 无

### 使用

安装组件。

1. 如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
2. 如果是从生态市场下载组件，请参考以下步骤安装组件：
   - a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
   - b. 在项目根目录 `build-profile.json5` 添加 money_track 模块。

   ```json5
   "modules": [
     {
       "name": "money_track",
       "srcPath": "./xxx/money_track",
     },
   ]
   ```

   - c. 在项目根目录 `oh-package.json5` 中添加依赖。

   ```json5
   "dependencies": {
     "money_track": "file:./xxx/money_track",
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
           // MoneyTrackPage 为记账路由入口页面名称
           this.pageStack.pushPathByName('MoneyTrackPage', null);
        });
     }.hideTitleBar(true);
  }
}
```

### 更新记录

- **1.0.3** (2025-12-29)
  - 下载该版本
  - 更新已经废弃的 API

- **1.0.2** (2025-11-06)
  - 下载该版本
  - 修复平板横屏的展示问题

- **1.0.1** (2025-10-23)
  - 下载该版本
  - 修复点击备注将支出和收入清空的问题

- **1.0.0** (2025-09-25)
  - 下载该版本
  - 初始版本

### 兼容性说明

| 项目 | 内容 |
| :--- | :--- |
| **基本信息** | |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| **兼容性** | |
| HarmonyOS 版本 | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| **应用类型** | |
| 应用 | 支持 |
| 元服务 | 支持 |
| **设备类型** | |
| 手机 | 支持 |
| 平板 | 支持 |
| PC | 支持 |
| **DevEco Studio 版本** | |
| DevEco Studio 5.0.5 | 支持 |
| DevEco Studio 5.1.0 | 支持 |
| DevEco Studio 5.1.1 | 支持 |
| DevEco Studio 6.0.0 | 支持 |
| DevEco Studio 6.0.1 | 支持 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/137ccc305bf3490db7ea7c09fa25ab00/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E8%AE%B0%E8%B4%A6%E7%BB%84%E4%BB%B6/money_track1.0.3.zip