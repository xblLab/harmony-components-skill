# ohos/webrtc 音频传输组件

## 简介

ArkTS interfaces of webrtc for OpenHarmony.

## 详细介绍

### 简介

本目录下提供 WebRTC 的 ArkTS 接口封装，并在 C++ 层适配了视频的采集、渲染及编解码等模块。其中大部分接口的设计遵循 WebRTC 规范，另外也根据实际需要，并参考 Android 平台，额外提供 PeerConnectionFactory 和 AudioDeviceModule 等接口。

### 目录

SDK 目录结构及说明如下：

```text
sdk/ohos/
├── BUILD.gn          # src 编译脚本
├── api               # 存放接口文件
│   ├── ets
│   │   ├── log
│   │   │   └── Logging.ets       # 日志
│   │   └── xcomponent
│   │       └── VideoRenderController.ets # 视频渲染
│   ├── libohos_webrtc
│   │   ├── index.d.ts
│   │   └── webrtc.d.ts           # 接口定义
│   └── libwebrtc.md              # 接口文档
├── har_hap         # Deveco Studio 工程目录，包含一个 HAR 模块，和一个示例 HAP 模块
└── src
    ├── node-addon-api      # 三方库，辅助 NAPI 开发
    └── ohos_webrtc         # 实现源码
        ├── async_work      # 一些用于处理异步任务的辅助类
        ├── audio_device    # 音频相关模块
        ├── camera          # 相机相关模块
        ├── desktop_capture # 桌面采集
        ├── helper          # 一些 NDK 接口辅助类
        ├── logging         # 日志接口适配
        ├── render          # 视频渲染相关模块
        ├── user_media      # 媒体约束相关的辅助类，如根据指定的分辨率筛选合适的相机配置参数
        ├── utils           # 工具
        ├── video           # 视频相关模块
        ├── video_codec     # 视频编解码相关模块
        ├── peer_connection.cpp # RTPPeerConnection 实现
        ├── peer_connection.h     # RTPPeerConnection 实现
        └── ...             # 其它接口实现
```

### 下载安装

```bash
ohpm install @ohos/webrtc
```

### 其它

接口说明及使用方法请参阅文档，实现代码在 `src/ohos_webrtc` 目录下，其中 NAPI 接口的使用借助了开源项目 `node-addon-api`。

通过 `BUILD.gn` 可编译得到动态库 `libohos_webrtc.so`，之后可用于构建 HAR 包以供其它应用模块使用，完整的 HAR 及示例工程在 `har_hap` 目录下。动态库的编译方法请参阅文档。

**SDK 要求：** 12 及以上

**许可证协议：** Apache 2.0

### 更新记录

#### 1.0.0（2025-01-08）

- Fix datachannel destructor BUG

#### 1.0.0-rc3（2025-08-20）

- 支持音轨录制/播放的开启关闭

#### 1.0.0-rc2（2025-03-27）

- 支持系统声音分享

#### 1.0.0-rc1（2025-02-22）

- 发布 ohpm

#### 1.0.0-rc0（2025-02-14）

- webrtc 适配 openharmony，包括：
  - arkts 接口
  - openharmony 相机
  - openharmony 桌面捕获
  - openharmony 音频捕获

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

### 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/webrtc
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/941849e6808f41a7b49b46a3becf144a/PLATFORM?origin=template