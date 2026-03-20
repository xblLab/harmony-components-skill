# elegant-spinner 命令行工具组件

## 简介

Elegant spinner for interactive CLI apps

## 详细介绍

### 简介

基于 elegant-spinner 原库 3.0.0 版本进行适配，所有功能代码已经转换为 ArkTS 文件

### 安装

深色代码主题复制

```bash
ohpm install elegant-spinner
```

### 使用

深色代码主题复制

```typescript
import elegantSpinner from 'elegant-spinner';
import logUpdate from 'log-update';

const frame = elegantSpinner();

setInterval(() => {
    logUpdate(frame());
}, 50);
```

### 相关

- **log-update**: Log by overwriting the previous output in the terminal. Useful for rendering progress bars, animations, etc.

### 更新记录 [v1.0.0] 2024.10

- 基于 elegant-spinner 原库 3.0.0 版本进行适配
- 更新 homepage 和 repository 的链接

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

| 项目 | 说明 |
| :--- | :--- |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |

#### 应用类型

应用

Created with Pixso.

#### 元服务

Created with Pixso.

#### 设备类型

手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

#### DevEcoStudio 版本

DevEco Studio 5.0.0

Created with Pixso.

## 安装方式

```bash
ohpm install elegant-spinner
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c17cc955f8234c04b1fce19bbce04a1f/PLATFORM?origin=template