# loading-dialog 加载弹窗组件

## 简介

loadingDialog 是一个简单易用的 Loading 组件，支持 Loading，success，failure，info，warn, toast，progress 等样式

## 详细介绍

### LoadingDialog 介绍

简单易用的 Harmony LoadingDialog

### 安装教程

执行安装命令

```bash
ohpm install @lyb/loading-dialog
```

### 重要提醒

请勿在 EntryAbility.ets 文件中调用本库任何方法，不然会导致 dialog 显示不出来

如果连续调用 dialog，最好加上 await

2.1.0 之后换了实现可以在任意地方调用

支持加载、更新、关闭自定义视图

### SDK Support

| SDK 版本 | Support |
| :--- | :--- |
| 2.0.0 | 5.0.0(12) |
| 1.2.0 | 4.1.0(11) |

### 默认样式预览

样式预览效果

- loading
- success
- failure
- info
- warn
- toast
- progress

### 使用说明

#### 基础用法

**显示 loading**

```typescript
LoadingDialog.showLoading('这是一个 loading')
```

**显示 success**

```typescript
LoadingDialog.showSuccess('这是一个 success dialog')
```

**显示 failure**

```typescript
LoadingDialog.showFailure('这是一个 failure dialog')
```

**显示 info**

```typescript
LoadingDialog.showInfo('这是一个 info dialog')
```

**显示 progress**

```typescript
LoadingDialog.showProgress('正在下载...', this.progress)
```

**隐藏**

```typescript
LoadingDialog.hide()
```

#### 进阶用法

深色代码主题复制

```typescript
LoadingDialog.showLoading({
    msg: '这是一个 loading',
    tintColor: Color.Red,
    textColor: Color.Yellow,
    ...
})
```

### 全局参数定义

深色代码主题复制

```typescript
LoadingDialog.setGlobalSettings((setting) => {
    setting.tintColor = Color.White
    setting.textColor = Color.Orange
    ...
})
```

### 自定义参数

| 参数 | 默认值 | 描述 |
| :--- | :--- | :--- |
| msg | "" | 提示文本 |
| alignment | center | 指示器位置 |
| offset | 0, 0 | 指示器偏移量 |
| tintColor | 白色 | 指示器颜色（图片，progress 等等） |
| textColor | 白色 | 指示器文字颜色 |
| hideDelay | 2000ms | 指示器自动关闭时间（loading，progress 时无效） |
| fontSize | 16 | 文字大小 |
| backgroundColor | #cc000000 | 指示器颜色 |
| maskColor | 透明 | 指示器蒙层的颜色 |
| borderRadius | 10 | 指示器圆角 |
| transition | undefined | 指示器显示/关闭的转场 |
| successSrc | - | 成功图片图片 (最好是 svg 格式) |
| failureSrc | - | 失败图片图片 (最好是 svg 格式) |
| infoSrc | - | 提示图片图片 (最好是 svg 格式) |
| warnSrc | - | 警告图片图片 (最好是 svg 格式) |
| hideOnTouchOutside | false | 点击 dialog 外是否隐藏 |
| hideOnSystemBack | false | 系统侧滑返回时是否隐藏 |
| isModal | true | 是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层 |

### 开源协议

MIT License

### 更新记录

2.1.7 (2025-09-15) 暂无权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

### 兼容性

| HarmonyOS 版本 |
| :--- |
| 5.0.0 |

Created with Pixso.

### 应用类型

应用

Created with Pixso.

### 元服务

Created with Pixso.

### 设备类型

手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

### DevEcoStudio 版本

DevEco Studio 5.0.0

Created with Pixso.

## 安装方式

```bash
ohpm install @lyb/loading-dialog
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2f97288eb95e43eeb200e3333c5e756e/PLATFORM?origin=template