# 罗盘组件

## 简介

提供了罗盘方向的指引功能。

## 详细介绍

### 简介

提供了罗盘方向的指引功能。

### 目录结构

本组件工程代码结构如下所示：

```text
compass/src/main/ets                              // 罗盘 (har)
  |- common                                       // 公共常量
  |- components                                   // 模块组件
  |- controller                                   // 罗盘控制类
  |- model                                        // 模型定义
  |- pages                                        // 页面      
  └- utils                                        // 模块工具类
```

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.5(17) 及以上

### 使用

安装组件。
如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 xxx 目录下。
2. 在项目根目录 `build-profile.json5` 添加 compass 模块。

```json5
"modules": [
   {
   "name": "compass",
   "srcPath": "./xxx/compass",
   },
]
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
"dependencies": {
   "compass": "file:./xxx/compass",
}
```

在主工程的 `EntryAbility.ets` 文件中 `onBackground` 的生命周期函数中释放传感器资源。

```typescript
import { sensor } from '@kit.SensorServiceKit';

onBackground(): void {
   ...
   sensor.off(sensor.SensorId.ORIENTATION);
   ...
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
            // CompassPage 为罗盘路由入口页面名称
            this.pageStack.pushPathByName('CompassPage', null);
         });
      }.hideTitleBar(true);
   }
}
```

### 更新记录

- **1.0.3 (2026-02-13)**：接入 @hw-agconnect/util-log 组件。
- **1.0.2 (2025-12-10)**：应用退到后台时，释放传感器资源。
- **1.0.1 (2025-11-06)**：补充横屏滚动展示。
- **1.0.0 (2025-09-25)**：初始版本。

### 基本信息

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | 无 |
| **权限说明** | 无 |
| **使用目的** | 无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

**兼容性**

- **HarmonyOS 版本**：5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2
- **应用类型**：应用、元服务
- **设备类型**：手机、平板、PC
- **DevEco Studio 版本**：5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0b7370b08e39411da45a577a16010b11/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%BD%97%E7%9B%98%E7%BB%84%E4%BB%B6/compass1.0.3.zip