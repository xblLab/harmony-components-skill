# ilye/commons 通用型开发数据库组件

## 简介

通用组件库，方便为其他库提供通用公共能力。

## 详细介绍

### 简介

通用组件库，方便为其他库提供通用公共能力。

### 系统 API 要求

HarmonyOS API13 及以上

### 快速开始

在项目根目录执行如下命令安装获得 Common 组件：

```bash
ohpm i @ilye/commons
```

### 使用示例

```typescript
// 缓存存值
CacheStorage.set("key", "value");
// 缓存取值
CacheStorage.get("key");
// 判断缓存中是否存在 key
CacheStorage.has("key"); 
// 以类名作为 key 值，如果存在此对象，返回此对象，否则创建新对象存储后返回，创建失败时返回 undefined
Singleton.getOrCreate<XObject>(XObject)
// 以类名作为 key 值，如果存在此对象，返回此对象，否则创建新对象并存储返回
// 获取 XObject 单例实例
Singleton.of<XObject>(XObject)
```

### 许可证协议

MIT

### 更新记录

- **1.3.5** (DevEco Studio 6.0.1 Release)
  - 优化部分代码细节去除 IDE 警告
- **1.3.4** (DevEco Studio 6.0.1 Release)
  - Singleton 和 SingletonV2 添加 connect 方法，支持通过类类型获取或创建自定义 key 值的实例
- **1.3.3** (DevEco Studio 6.0.1 Release)
  - 优化代码细节与注释，添加 SingletonV2
- **1.3.2** (DevEco Studio 6.0.1 Release)
  - 完善部分细节点
- **1.3.1** (DevEco Studio 6.0.1 Release)
  - 单例添加 replace、of 等方法
  - 优化代码细节
- **1.3.0** (DevEco Studio 5.0.5 Release)
  - 添加部分通用的函数
  - 添加部分通用的 api 定义
- **1.2.3** (DevEco Studio 5.0.5 Release)
  - 完善 Logger 相关，添加 LogLevel 控制
- **1.2.1** (DevEco Studio 5.0.5 Release)
  - 优化代码细节
- **1.2.0**
  - 添加 StringUtil、Singleton、Logger 等
  - 完善部分细节，去除无用的代码
- **1.1.0**
  - 添加部分 Consumer、Supplier、Func 等部分 Function
- **1.0.0** 初版
  - 添加基础功能

## 权限与隐私

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

- **隐私政策**: 不涉及
- **SDK 合规使用指南**: 不涉及

## 兼容性

| 项目类型 | 设备类型 | HarmonyOS 版本 | DevEco Studio 版本 |
| :--- | :--- | :--- | :--- |
| 应用 | 手机 | 5.0.1 | DevEco Studio 5.0.1 |
| 元服务 | 平板 | | |
| | PC | | |

## 安装方式

```bash
ohpm install @ilye/commons
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/91f852f48dfd43c1932887144ed1bedb/PLATFORM?origin=template

---

Created with Pixso.