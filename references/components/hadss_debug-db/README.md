# debug db 数据库调试组件

## 简介

一款极简的数据库可视化调试工具，支持可视化操作 RdbStore、KVStore、Preferences、AppStorage 等多种类型数据。

## 详细介绍

### 项目概述

**HarmonyOS Debug Database (debug-db)**
一款功能强大的鸿蒙应用数据库可视化调试工具，开发者可通过浏览器来查看和操作多种 HarmonyOS 数据库，大幅提升数据库调试效率。

支持关系型数据库 (RdbStore)、用户首选项 (Preferences)、键值数据库 (KVStore)、AppStorage。

### 功能特性

以下所有的功能都可以在不需要对设备进行 Root 操作（无需 Root 设备）的情况下使用：

#### RdbStore

- 查看指定 UIAbilityContext 以及 ApplicationContext（APP__前缀）的所有 RdbStore 数据库 (包括加密数据库)
- 支持自定义路径，递归扫描对应 context 下的 rdb 目录
- 查看指定 RdbStore 数据库中的所有表
- 查看 RdbStore 数据库中指定表的所有数据
- 在指定的 RdbStore 数据库上运行任何 SQL 查询来创建、删除数据库，或增删改查数据库数据
- 直接对 RdbStore 数据进行增删改查
- 下载指定 RdbStore 对应的数据库文件

#### KVStore

- 查看指定 UIAbilityContext 以及 ApplicationContext 下所有的 KVStore (包括加密 KV 数据库)，storeId 要唯一
- 查看指定 KVStore 中所有键值对数据
- 直接对 KVStore 数据进行增删改查

#### Preferences

- 查看指定 UIAbilityContext 以及 ApplicationContext（APP__前缀）下所有的 Preferences
- 查看指定 Preferences 中所有首选项数据
- 直接对 Preferences 数据进行增删改查

#### AppStorage

- 直接对 AppStorage 进行增删改查

## 使用说明

### 安装依赖

添加依赖配置，然后同步。

```json5
{
  "dependencies": {
    "@hadss/debug-db": "^1.0.0-rc.7"
  }
}
```

### 基础用法

```typescript
// EntryAbility.ets

// 导入 BuildProfile，编译期自动生成
import BuildProfile from 'BuildProfile';

onWindowStageCreate(windowStage: window.WindowStage): void {
  // Main window is created, set main page for this ability
  hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

  windowStage.loadContent('pages/Index', (err) => {
    if (err.code) {
      ...
      return;
    }
    
    // 推荐在 DEBUG 模式下使用 - 动态加载。
    if (BuildProfile.DEBUG) {
      import('@hadss/debug-db').then(async (ns: ESObject) => {
        await ns.DebugDB.initialize(this.context, { port: 8080, defaultStart: true });
      });
    }
  });
}
```

当开发者启动应用程序后，应用后台会自动启动 DebugDB 服务，若成功启动，则可以在 DevEco Studio 的 Log 界面查看到以下日志：

```text
You can access DebugDB through http://xxx.xxx.xxx.xxx:8080/index.html
```

日志中的网址即为 DebugDB 运行时的界面首页，直接在浏览器中访问即可。

### 高级用法

只在 debug 包中集成 debug-db，打 release 包时去掉相关代码和配置。

详情请参考 demo 工程：[debug-database](https://github.com/hadss/debug-database) (示例链接，请根据实际替换)。

### 模拟器使用

1. debug-db 服务开启后，模拟器需转发端口，才能访问。（以 8080 端口为例）

```bash
# 查看模拟器设备
> hdc list targets   # 输出：127.0.0.1:5555

# 转发端口 fport tcp:<localPort> tcp:<serverPort>
hdc -t 127.0.0.1:5555 fport tcp:8080 tcp:8080

# 输出：Forwardport result:OK 表示成功
```

转发成功后，访问：`127.0.0.1:8080/index.html`，如果无法访问，请排查下是否有开启网络代理工具，建议关闭后再试试看。

2. 也可直接使用模拟器自带的浏览器来访问，建议选择屏幕大点的设备（例如：折叠机或平板）体验更好。

## 实现说明

本项目采用开源库 polka 实现 http 服务，UI 界面基于 Android-Debug-Database 修改。

## 相关权限

由于需要通过浏览器直接访问服务端获取数据库信息，因此 debug-db 使用了以下权限：

```json5
"requestPermissions": [{
    "name": "ohos.permission.GET_WIFI_INFO"
  },{
    "name": "ohos.permission.INTERNET"
  }],
```

## 约束与限制

在下述版本通过验证：

- DevEco Studio 5.0.1 Release (5.0.5.306)
- API 12 Release

## 开源协议

本项目基于 Apache License 2.0，请自由地享受与参与开源。

## 更新记录

### [1.0.0-rc.11] 2025.10.20

- 关系型数据库支持不同的 SecurityLevel，从 S1->S4 依次尝试

### [1.0.0-rc.10] 2025.09.29

- 支持向量数据库可视化查看

### [1.0.0-rc.9] 2025.09.18

- 完善 web 页面加载失败场景的报错日志和 response 内容

### [1.0.0-rc.8] 2025.09.05

- fix：移除废弃 API getContext()，改从入参获取 context

### [1.0.0-rc.7] 2025.07.21

- fix bug：将 rawfile 下的资源统一放到 debug_db 目录下，和应用的其它资源区分开，避免冲突。
- release 版本运行时默认不支持该能力，避免应用将调试功能带到 release 版本。
- 更新依赖 @ohos/polka 到 1.0.3 版本。

### [1.0.0-rc.6] 2025.01.07

- 更新 readme，补充模拟器场景使用 debug-db 的指导，补充手机开热点场景的 IP 地址信息。
- 完善 getDebugDBAddress 方法，连 wifi 返回 wifi 地址，否则返回 127.0.0.1。

### [1.0.0-rc.5] 2024.12.10

- 支持 AppStorage 可视化增删改查
- 支持初始化时设置默认启动或者关闭

### [1.0.0-rc.4] 2024.11.26

- 修复 ApplicationContext 下 db 文件下载失败的 bug

### [1.0.0-rc.3] 2024.11.19

- 支持查看指定 UIAbilityContext 以及 ApplicationContext 下的数据库
- 支持查看自定义路径的 rdb 数据库，递归扫描对应 context 下的 rdb 目录

### [1.0.0-rc.2] 2024.11.11

- 修正了 README 中关于安装 debug-db 的示例说明

### [1.0.0-rc.1] 2024.10.21

- 新增查看加密 rdb 数据库和加密 KV 数据库功能
- 新增刷新当前表数据功能

### [1.0.0-rc.0] 2024.9.23

- 发布 1.0.0-rc.0 初始版本

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| 属性 | 值 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

## 安装方式

```bash
ohpm install @hadss/debug-db
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0de13f383f8b4ef0a6adb3abf841771b/PLATFORM?origin=template