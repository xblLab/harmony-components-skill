# ohos/yoga 布局引擎工具组件

## 简介

Yoga 是一个实现了 Flexbox 的跨平台布局引擎。它能够构建在不同平台和屏幕尺寸上一致工作的响应式用户界面。

## 详细介绍

### 概述

Yoga 是一个实现了 Flexbox 的跨平台布局引擎。它能够构建在不同平台和屏幕尺寸上一致工作的响应式用户界面。这个 OpenHarmony 版本通过 NAPI 添加了 ArkTS 绑定，使得在 OpenHarmony 应用中轻松使用 Yoga 强大的布局功能。

### 主要特性

- **跨语言属性传递**：支持在不同编程语言间传递布局属性；
- **基础布局计算**：支持基本的布局计算功能；
- **Flexbox 容器规则**：完整实现 Flexbox 容器布局规则；
- **树节点管理**：支持树形结构节点的管理与操作；
- **尺寸测量功能**：支持组件尺寸的精确测量与计算。

### 下载安装

```bash
ohpm install @ohos/yoga
```

### 使用说明

#### 1. 导入 Yoga 库

```typescript
import { Yoga, YogaNode, YogaFlexDirection, YogaJustify } from '@ohos/yoga';
```

#### 2. 创建 Yoga 节点

```typescript
const root = Yoga.createNode();
```

#### 3. 配置布局属性

```typescript
// 设置宽度和高度
root.setWidth(200);
root.setHeight(200);
// 设置 flex 方向
root.setFlexDirection(YogaFlexDirection.ROW);
// 设置 justifyContent
root.setJustifyContent(YogaJustify.SPACE_BETWEEN);
```

#### 4. 创建子节点

```typescript
const child = Yoga.createNode();
child.setWidth(100);
child.setHeight(100);
root.insertChild(child, 0);
```

#### 5. 计算布局

```typescript
root.calculateLayout(500, 300);
```

#### 6. 获取布局结果

```typescript
console.log("Root 布局 - Width:", root.getLayoutWidth(), "Height:", root.getLayoutHeight());
console.log("Child 布局 - X:", child.getLayoutX(), "Y:", child.getLayoutY());
root.free();
child.free();
```

### 可用接口

详细的 API 实现，请参阅：

- **YogaNode** - 主要 Yoga 节点 API 实现；
- **YogaConfig** - 配置 API 实现；
- **YogaEnum** - Yoga 常量、枚举定义。

### 源码下载

本项目依赖 yoga 库，通过 git submodule 引入。下载代码时需要添加 `--recursive` 参数。

```bash
git clone --recursive https://gitcode.com/openharmony-tpc/openharmony_tpc_samples.git
```

### 开始项目构建

### 约束条件

在下述版本验证通过：

- **IDE**: DevEco Studio 5.1.0 Release - 5.1.0.849
- **SDK**: API12

### 目录结构

```text
|---- yoga
|     |---- entry # 示例代码文件夹
|     |---- library
|           |---- cpp # c/c++和 napi 代码
|                 |---- core # 核心 Yoga C++ 代码
|                 |---- thirdparty # 三方依赖
|                 |---- utils # 工具函数
|                 |---- napi_init.cpp # NAPI 初始化
|                 |---- yoga_napi.cpp # NAPI 绑定实现
|           |---- ets # ArkTS API
|                 |---- Yoga.ets # 主静态 API 入口点
|                 |---- YogaConfig.ets # 配置实现
|                 |---- yogaEnum.ets # 枚举和常量
|                 |---- yogaNode.ets # 节点实现
|     |---- README.md  # 说明文件
```

### 关于混淆

代码混淆，请查看代码混淆简介。如果希望 yoga 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```text
-keep
./oh_modules/@ohos/yoga
```

### 开源协议

本项目基于 MIT LICENSE，请自由地享受和参与开源。

### 更新记录

#### v1.0.1 - 2025-12-08

- **Fixed**: Modify the optimization level of dynamic libraries.

#### v1.0.0 - 2025-09-30

- **Added**: Initial release of Yoga layout engine for OpenHarmony
- **Ported**: Facebook's Yoga Flexbox layout engine to OpenHarmony platform
- **Added**: ArkTS bindings via NAPI for easy integration with OpenHarmony applications
- **Implemented**: Core Yoga functionality:
    - Flexbox layout calculations
    - Node hierarchy management
    - Style property configuration
    - Layout configuration options
    - Measure and baseline functions support
- **Provided**: Complete API for layout operations in OpenHarmony applications
- **Added**: Demo application showcasing Yoga layout capabilities
- **Included**: Comprehensive documentation and usage examples

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| 项目 | 详情 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | 是 |
| **设备类型** | 手机、平板、PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/yoga
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/397524654ff44c7a816b4d25a250fd7c/PLATFORM?origin=template