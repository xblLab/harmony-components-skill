# 图标 icon 组件

## 简介

icon 是一个图标组件，有着各式各样的常用图标，目前已累计 408 种图标，包体积小，使用简单，支持更改图标颜色，让 App 开发游刃有余。

## 详细介绍

### 功能介绍

icon 是一个图标组件，有着各式各样的常用图标，目前已累计 408 种图标，包体积小，使用简单，支持更改图标颜色，让 App 开发游刃有余。

### 环境要求

Api 适用版本：>=12

### 目前功能

1. 目前支持 408 种业务常见图标。
2. 支持图标颜色更换，满足不同场景需求。
3. 支持大小和边框样式更新。
4. 支持动态更换图标。

### 示例效果

目前是默认颜色，支持颜色和大小自定义。

- 社交相关
- 底部 Tab 相关
- 箭头图标相关
- 编辑器图标
- 通用图标
- 工作相关图标
- 电商图标

## 快速入门

### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

> 建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/icon
```

### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": {
  "@abner/icon": "^1.0.0"
}
```

### 使用样例

```typescript
Icon({ 
  iconModel: IconModel.wei_xin_circle, 
  iconSize: 25 
})
```

## API 说明

Api 适用版本：>=12

### 配置说明

常见属性配置如下：

| 属性名 | 类型 | 概述 |
| :--- | :--- | :--- |
| iconModel | IconModel | 图标类型，传入不同类型就会展示不同图标，目前支持 408 种类型，具体可看上面的图标效果，每个图标下的标识就是图标类型 |
| iconColor | Resource | 图标颜色 |
| iconSize | number/string/Resource | 图标大小，也可在组件外设置 |
| iconBorder | BorderOptions | 图标边框样式 |

### IconModel

目前支持 408 种类型，具体类型，可见上面的效果图，每个图标下的标识就是一种类型，如果查看不清，可见相关 Demo 案例。

## 权限要求

无权限要求。

## 技术支持

在 Github 中的 Issues 中提问题，定期解答。

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 更新记录

### 1.0.0 (2026-01-27)

1. 目前支持 408 种业务常见图标。
2. 支持图标颜色更换，满足不同场景需求。
3. 支持大小和边框样式更新。
4. 支持动态更换图标。

## 兼容性

### HarmonyOS 版本

- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1
- 6.0.2

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEco Studio 版本

- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1
- DevEco Studio 6.0.2

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5ac377b0f3cc47918a35df66b5863382/b6a17875746941e0b5606c9b1eb174f8?origin=template