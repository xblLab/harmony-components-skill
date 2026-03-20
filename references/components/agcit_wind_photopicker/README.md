# 作品发布组件

## 简介

系统相册、相机、当前位置获取功能实现

## 详细介绍

### 作品发布组件

### 介绍

该组件使用 @kit.CoreFileKit、@ohos.file.PhotoPickerComponent、@kit.LocationKit 等接口，实现了拉起系统相册，唤起系统相机，拍照，选择图片/视频、图片预览、视频预览播放、当前位置获取的功能。

### 效果预览

#### 图片效果



### 使用说明

1. 点击选择进入到图片选择页面
2. 选择要发布的图片/视频；拍摄照片
3. 进入到发布页面，填写相应的作品信息
4. 点击标记地点，同意获取当前位置
5. 点击发布，发布成功后将清空页面内容并返回首页

### 工程目录

深色代码主题复制
```text
├───entry/src/main/ets                     // 代码区
│   ├───entryability
│   │       EntryAbility.ets
│   │       
│   ├───entrybackupability
│   │       EntryBackupAbility.ets       
│   │
│   ├───model
│   │       MediaModel.ets                  // 媒体 model
│   │       PermissionModel.ets             // 权限 model
│   │
│   ├───pages
│   │       Index.ets                       // 首页
│   │       PhotoPickerPage.ets             // 图片/视频选择页
│   │       PhotoPreviewPage.ets            // 图片/视频预览页
│   │       PublishPage.ets                 // 发布页
│   │
│   ├───utils
│   │       Logger.ets                      // 日志工具嘞
│   │       permissionManager.ets           // 权限申请工具类
│   │       SandboxUtils.ets                // 沙箱工具类
│   │
│   └───view
│           PublishTop.ets                  // 发布页 title
│
└───entry/src/main/resources                // 应用资源目录                   
```

### 具体实现

- 通过 requestPermissionsFromUser 函数动态授权申请获取相关权限
- 配置选择器 PickerOptions 参数，创建选择控制器 PickerController，使用 PhotoPickerComponent 组件实现图片/视频选择效果
- 通过 getCurrentLocation 获取当前所在位置信息

### 相关权限

不涉及

### 依赖

不涉及

### 约束与限制

- 本示例仅支持标准系统上运行，支持设备：华为手机。
- HarmonyOS 系统：HarmonyOS 5.0.5 Release 及以上。
- DevEco Studio 版本：DevEco Studio 5.0.5 Release 及以上。
- HarmonyOS SDK 版本：HarmonyOS 5.0.5 Release SDK 及以上。

### 更新记录

- 1.0.2 (2025-12-09) 添加 ohpm 仓库下载
- 1.0.1 (2025-11-12) 修改自述文件中图片大小
- 1.0.0 (2025-11-10) 第一次发布

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### SDK 合规使用指南

不涉及

### 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 Created with Pixso.<br>5.0.1 Created with Pixso.<br>5.0.2 Created with Pixso.<br>5.0.3 Created with Pixso.<br>5.0.4 Created with Pixso.<br>5.0.5 Created with Pixso.<br>5.1.0 Created with Pixso.<br>5.1.1 Created with Pixso.<br>6.0.0 Created with Pixso. |
| 应用类型 | 应用 Created with Pixso.<br>元服务 Created with Pixso. |
| 设备类型 | 手机 Created with Pixso.<br>平板 Created with Pixso.<br>PC Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 Created with Pixso.<br>DevEco Studio 5.1.0 Created with Pixso.<br>DevEco Studio 6.0.0 Created with Pixso. |

## 安装方式

```bash
ohpm install agcit_wind_photopicker
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/694c2189619a45218221ce7da2836cba/b3808349ddc943cc9997845b8f81d72c?origin=template