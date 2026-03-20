# 获得场景播放 UI 组件

## 简介

需要结合 CCVOD 使用，可快速实现播放视频功能。

## 详细介绍

### 简介

需要结合 CCVOD 使用，可快速实现播放视频功能

### 安装

深色代码主题复制

```bash
ohpm install @changjing/player
```

### 使用说明

依赖播放器库@changjing/vod 使用，不可单独使用

### 约束和限制

1. 仅支持标准系统上运行，支持设备：华为手机。
2. HarmonyOS 系统：HarmonyOS NEXT Developer Preview1 及以上。
3. DevEco Studio 版本：DevEco Studio NEXT Developer Preview1 及以上。
4. HarmonyOS SDK 版本：HarmonyOS NEXT Developer Preview1 SDK 及以上。

### 依赖

```json
{
  "场景视频基础库": "@changjing/common": "1.0.1",
  "ijk 播放器": "@ohos/ijkplayer": "2.0.3-rc.0",
  "视频解密库": "@changjing/drm": "1.1.0"
}
```

### 更新记录

- **[v1.2.6]**
  - 移除 rts 证书和 key
- **[v1.2.5]**
  - 升级 rts
- **[v1.2.4]**
  - 升级 ijk，新增 rts
- **[v1.2.3]**
  - 优化加密视频
- **[v1.2.1]**
  - 优化加密视频起播和流量消耗
- **[v1.2.0]**
  - 支持离线视频播放
- **[v1.1.0]**
  - 支持加密
- **[v1.0.1]**
  - 适配 API12
- **[v1.0.0]**
  - 首次提交

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

#### HarmonyOS 版本

| 版本 | 备注 |
| :--- | :--- |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 5.1.0 | Created with Pixso. |
| 5.1.1 | Created with Pixso. |
| 6.0.0 | Created with Pixso. |
| 6.0.1 | Created with Pixso. |

#### 应用类型

| 类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

#### 设备类型

| 类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

#### DevEcoStudio 版本

| 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 安装方式

```bash
ohpm install @changjing/player
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/bb6d72bd7d6d4c77b395318c78010c10/PLATFORM?origin=template