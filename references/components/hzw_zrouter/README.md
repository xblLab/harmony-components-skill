# ZRouter

## 简介

ZRouter 是一款轻量级且非侵入性的鸿蒙动态路由框架，可解决 HAR/HSP 业务模块间的耦合与通信问题。

## 详细介绍

> 视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 1:27 加载完毕：100.00%0:00 媒体流类型 直播 Seek to live, currently behind live 直播剩余时间 -1:27 1x 播放速度 2x1.75x1.5x1.25x1x, 选择 0.5x 节目段落节目段落描述关闭描述，选择字幕字幕设定，开启字幕设置弹窗关闭字幕，选择音轨画中画全屏 This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50%75%100%125%150%175%200%300%400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗

### 组件介绍

本组件基于 ArkTS 构建，适配 HarmonyOS API 12。

ZRouter 是一款轻量级且非侵入性的鸿蒙动态路由框架，可解决 HAR/HSP 业务模块间的耦合与通信问题。主要特性：

- 简化 Navigation 使用，无需关注路由表的配置，对 Navigation 及 NavDestination 组件保持零侵入；
- 支持 API 链式调用，让 API 更简洁直观；
- 为了进一步简化使用，支持 NavDestination 页面模板化，是一个可选项；
- 注解参数支持使用静态常量，可跨模块定义；
- 支持自定义与全局拦截器，可设优先级及中断逻辑，可实现页面重定向、登录验证等业务场景；
- 支持服务路由，可实现 Har/Hsp 模块间的通信；
- 支持全局及单个页面的生命周期函数管理，可使任意类都能享有与组件相同的生命周期特性，可实现页面埋点统计等业务场景；
- 支持跨多级页面参数携带返回监听；
- 支持自定义 URL 路径跳转，可在拦截器内自行解析 URL 实现业务逻辑；
- 内置多种转场动画效果（平移、旋转、渐变、缩放、高斯模糊），并支持自定义动画；
- 支持启动模式、混淆、嵌套 Navigation、Hap；
- 支持第三方 Navigation 的使用本库 API；
- 支持与您现有项目中的 Navigation 无缝融合，实现零成本向本库迁移；
- 支持 ArkUI-X 跨平台上使用；

### 约束与限制

在下述版本通过验证：

| DevEco Studio 版本号 | HarmonyOS SDK 版本号 | 手机操作系统 ROM 版本号 |
| :--- | :--- | :--- |
| DevEco Studio 5.0.3.100 | 【API12】HarmonyOS SDK 5.0.0.13(SP4) | 3.0.0.13(SP6DEVC00E13R6P1) |

### 更新记录

**1.5.0 (2025-07-11)**
- 新增一镜到底动画；
- 修复路由注解类型提示问题；
- 支持工程级 (全局配置) 和模块级 (模块独立配置) 两种方式配置；
- 支持项目 clean 时自动删除编译产物；
- 优化构建效率，减少不必要的场景扫描构建生成；
- 新增配置项 ignoredModules，工程级配置可设置忽略模块，避免扫描所有模块；
- 新增配置项 enableUiPreviewBuild，避免在 ui 预览构建时生成，影响 ui 预览效率。

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

| 隐私政策 | 不涉及 |
| :--- | :--- |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| HarmonyOS 版本 | 5.0.0 |
| :--- | :--- |
| Created with Pixso. | |

| HarmonyOS 版本 | 5.0.1 |
| :--- | :--- |
| Created with Pixso. | |

| HarmonyOS 版本 | 5.0.2 |
| :--- | :--- |
| Created with Pixso. | |

| HarmonyOS 版本 | 5.0.3 |
| :--- | :--- |
| Created with Pixso. | |

| HarmonyOS 版本 | 5.0.4 |
| :--- | :--- |
| Created with Pixso. | |

| HarmonyOS 版本 | 5.0.5 |
| :--- | :--- |
| Created with Pixso. | |

| 应用类型 | 应用 |
| :--- | :--- |
| Created with Pixso. | |

| 应用类型 | 元服务 |
| :--- | :--- |
| Created with Pixso. | |

| 设备类型 | 手机 |
| :--- | :--- |
| Created with Pixso. | |

| 设备类型 | 平板 |
| :--- | :--- |
| Created with Pixso. | |

| 设备类型 | PC |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.1 |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.2 |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.3 |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.4 |
| :--- | :--- |
| Created with Pixso. | |

| DevEcoStudio 版本 | DevEco Studio 5.0.5 |
| :--- | :--- |
| Created with Pixso. | |

## 安装方式

```bash
ohpm install @hzw/zrouter
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/7b3615ee364d4b36bcdd2549678a63f1/50e449ed4fcd418785706add0c40eab6?origin=template