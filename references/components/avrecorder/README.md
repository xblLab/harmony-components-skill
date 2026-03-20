# AVRecorder 录像功能组件

## 简介

本示例通过 CameraKit 自定义相机，并通过 AVRecorder 进行录像。

## 详细介绍

### 介绍

基于 CameraKit 通过 AVRecorder 录像。本示例通过 CameraKit 自定义相机，并通过 AVRecorder 进行录像。

### 效果图预览

- 获取权限
- 录制页
- 录制中
- 主页

## 使用说明

1. **获取权限**：点击“录制视频”按钮，判断授权权限，若权限均已授权，则跳转录制页面，否则需按提示开启所有权限后重新点击“录制视频”按钮。
2. **开始录制**：点击开始录制按钮，开始录制视频。
3. **停止录制**：点击停止录制按钮，停止录制视频，并返回首页，在“录制视频”按钮上方显示录制的视频，视频可手动播放。

## 工程目录

```text
├───entry/src/main/ets
│   ├───common
│   │   └───CommonConstants.ets            // 常量
│   ├───entryability                        
│   │   └───EntryAbility.ets               // Ability 的生命周期回调内容
│   ├───pages    
│   │   ├───Index.ets                      // 主页
│   │   └───Record.ets                     // 录制页
│   └───utils                               
│       ├───FileUtil.ets                   // 文件工具类
│       ├───Logger.ets                     // 日志工具类
│       └───RouterParams.ets               // 路由参数类
└───entry/src/main/resources     
```

## 实现思路

1. 通过 `cameraInput`，获取相机采集数据，创建相机输入。
2. 创建 `previewOutput`，获取预览输出流，通过 XComponent 的 `surfaceId` 连接，送显 XComponent。
3. 通过 `AVRecorder` 的 `surfaceId` 创建录像输出流 `VideoOutput` 输出到文件中。

## 相关权限

- 允许应用使用相机：`ohos.permission.CAMERA`
- 允许应用使用麦克风：`ohos.permission.MICROPHONE`
- 允许应用访问用户媒体文件中的地理位置信息：`ohos.permission.MEDIA_LOCATION`

## 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。

- **HarmonyOS 系统**：HarmonyOS 5.1.0 Release 及以上。
- **DevEco Studio 版本**：DevEco Studio 5.1.0 Release 及以上。
- **HarmonyOS SDK 版本**：HarmonyOS 5.1.0 Release SDK 及以上。

## 下载

如需单独下载本工程，执行如下命令：

```bash
git init
git config core.sparsecheckout true
echo HDRVivid/AVRecorder/ > .git/info/sparse-checkout
git remote add origin https://gitee.com/harmonyos_samples/BestPracticeSnippets.git
git pull origin master
```

## 更新记录

| 版本 | 变更内容 |
| :--- | :--- |
| 1.0.4 | 更新 readme 内容 |
| 1.0.3 | 更新 readme 内容 |
| 1.0.2 | API level 升级为 16<br>增加.gitignore 文件 |
| 1.0.1 | 新增“热量计算”模块 |
| 1.0.0 | 初始版本 |

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 HarmonyOS 版本 | 5.1.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 |

## 来源

- 原始 URL: [https://developer.huawei.com/consumer/cn/market/prod-detail/571cb7a0d8ed4b64b0dba7286fdbd6e7/PLATFORM?origin=template](https://developer.huawei.com/consumer/cn/market/prod-detail/571cb7a0d8ed4b64b0dba7286fdbd6e7/PLATFORM?origin=template)