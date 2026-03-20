# 应用内可视化日志查看工具组件

## 简介

app_log 是一个支持应用内和控制台双向日志查看的工具，使用简单，可视化操作，满足多种场景化需求，让查看日志变得直观简单。

## 详细介绍

### 功能介绍

app_log 是一个支持应用内和控制台双向日志查看的工具，使用简单，可视化操作，满足多种场景化需求，让查看日志变得直观简单。

### 环境要求

Api 适用版本：>=12

### 示例效果

- 应用端
- IDE 控制台

### 主要特点

- 支持三种模式：
    1. 单一控制台日志输出
    2. 单一应用内日志输出
    3. 控制台和应用内同时日志输出
- 使用简单：应用内悬浮按钮形式，想拖动到哪就拖动到哪，查看日志时，轻触即达。
- 应用内日志可复制，不仅方便查看也方便日志分享。

### 目前功能

1. 支持应用内可视化查看日志。
2. 支持控制台格式化查看日志。
3. 支持应用内日志背景样式切换。
4. 支持应用内悬浮按钮查看日志。
5. 支持应用内半模态和全模态查看。
6. 支持一键清空日志。
7. 支持按颜色区分不同类型下的日志内容。

### 快速入门

#### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

> 建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/app_log
```

#### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/app_log": "^1.0.1"}
```

## 使用样例

### 初始化

可在 AbilityStage 或者主入口时进行初始化，主要配置全局参数，初始化不是必须的！有需要可设置，不需要可不设置！

```typescript
AppLog.getAppLog().init({

})
```

### 属性配置

| 属性 | 类型 | 概述 |
| :--- | :--- | :--- |
| logOutputType | LogOutputType | 日志输出类型，默认 LogOutputType.DEFAULT，控制台和应用内同时输出 |
| globalTag | string | 全局 Tag，默认为 HarmonyOSLog |
| isHiLog | boolean | 控制台输出类型，默认 true，为 hiLog 形式，false 为 console |
| closeLog | boolean | 日志输出开关，默认 false 为打开，可根据测试或正式进行动态设置 |
| showLogLocation | boolean | 控制台日志输出是否需要位置，默认 true 为需要 |

### 应用内开启悬浮日志入口

可单页面设置，也可全局设置。

```typescript
AppLog.getAppLog().showLog(() => {
  //这里可配置页面返回，可以在关闭日志的同时，返回页面，根据自己需要进行配置。比如，我使用的是 router
  this.getUIContext().getRouter().back()
})
```

### 应用内关闭悬浮日志入口

```typescript
AppLog.getAppLog().hideLog()
```

### 日志打印

支持数字，字符串，数组，对象，json 等等类型数据打印，并且支持格式化形式输出。

#### 打印普通的一条日志

```typescript
AppLog.log("我是一条普通的字符串")
```

#### 各个类型输出

```typescript
AppLog.debug("我是 debug 信息")
AppLog.info("我是 info 信息")
AppLog.warn("我是 warn 信息")
AppLog.error("我是 error 信息")
AppLog.fatal("我是 fatal 信息")
```

#### 各个数据输出

```typescript
//数字
AppLog.debug(888990008888, "testTag")
//数组  
AppLog.error(["条目一", "条目二", "条目三", "条目四"], "tag_001")
//对象  
let bean = new TestBean()
bean.name = "我是测试对象"
bean.age = 18
AppLog.error(bean)
//json 串
let json = "{\"name\":\"程序员一鸣\",\"age\":18}"
AppLog.warn(json)
```

#### 单独设置 tag

```typescript
AppLog.debug("我是单独设置的 tag", "testTag")
```

## API 说明

Api 适用版本：>=12

## 配置说明

暂无配置说明

## 权限要求

纯组件，无权限要求

## 技术支持

在 Github 中的 Issues 中提问题，定期解答。

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

### 1.0.1 (2026-01-21)

1. 解决日志开启隐藏后，无法重新打开问题。

### 1.0.0 (2025-12-27)

1. 可视化日志工具首次上传
2. 支持应用内可视化查看日志
3. 支持控制台格式化查看日志
4. 支持悬浮按钮手势移动

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

## 隐私政策

不涉及

## SDK 合规使用指南

不涉及

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |
| 应用类型 | 应用，元服务 |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1 |

## 安装方式

```bash
ohpm install @abner/app_log
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a085f91630a04dbb85daf9aab948e78a/b6a17875746941e0b5606c9b1eb174f8?origin=template