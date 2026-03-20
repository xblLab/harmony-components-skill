# 离线视频下载组件

## 简介

本组件用于在本地实现视频的下载与播放管理，提供下载进度展示、播放/暂停控制、进度滑条拖拽、横竖屏切换、窗口系统栏控制与自适应尺寸等功能。适用于视频编辑或内容播放场景中的离线缓冲与回放需求。

## 详细介绍

### 简介

本组件用于在本地实现视频的下载与播放管理，提供下载进度展示、播放/暂停控制、进度滑条拖拽、横竖屏切换、窗口系统栏控制与自适应尺寸等功能。适用于视频编辑或内容播放场景中的离线缓冲与回放需求。

### 功能概览

- 展示视频信息卡片（名称、大小、时长）与下载状态
- 下载进度与大小展示（已缓存/总大小）
- 播放控制：播放/暂停、进度滑条拖动跳转
- 横竖屏切换与返回键拦截（横屏时拦截返回）
- 轨道信息面板（MenuBuilderInfo）
- 组件内部使用 XComponent 承载播放器，配合 Slider 控件调节播放进度，并使用 window 能力进行横竖屏与系统栏控制
- 横屏播放时，返回键会被拦截；点击返回图标将恢复竖屏、显示系统栏并退出播放态
- 组件内部处理播放、暂停与进度拖拽，无需显式事件

### 视频下载页面

## 约束与限制

### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.5 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.5 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）
- **系统版本**：HarmonyOS 5.0.3(15) 及以上

### 权限

- **网络权限**：`ohos.permission.INTERNET`

## 使用

### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `offline_video_download` 模块。

```json5
{
  "modules": [
    {
      "name": "offline_video_download",
      "srcPath": "./XXX/offline_video_download"
    },
    {
      "name": "video_common",
      "srcPath": "./XXX/video_common"
    }
  ]
}
```

3. 在项目根目录 `oh-package.json5` 中添加依赖。

```json5
{
  "dependencies": {
    "offline_video_download": "file:./xxx/offline_video_download"
  }
}
```

4. 在使用 `offlineVideo` 模块中的 `module.json5` 增加权限。

```json5
{
  "requestPermissions": [
    {
      "name": "ohos.permission.INTERNET"
    }
  ]
}
```

### Native 库（.so）相关配置

1. 在 `entry` 模块中的 `build-profile.json5` 添加：

```json5
{
    "buildOption": {
        "nativeLib": {
            "debugSymbol": {
                "strip": true,
                "exclude": []
            }
        }
    }
}
```

### 一多适配获取设备数据

1. 在 `entry` 模块的 `entry\src\main\ets\entryability\entryability.ets` 文件中添加依赖。

```ets
import { AppStorageV2 } from '@kit.ArkUI';
import { AiBarHeight, AppStorageKeys, StatusBarHeight } from 'offline_video_download';
```

2. 在 `entry` 模块的 `entry\src\main\ets\entryability\entryability.ets` 文件中添加属性。

```ets
aiBarHeight: AiBarHeight = AppStorageV2.connect(AiBarHeight, AppStorageKeys.AI_BAR_HEIGHT, () => new AiBarHeight())!;
statusBarHeight: StatusBarHeight =
AppStorageV2.connect(StatusBarHeight, AppStorageKeys.STATUS_BAR_HEIGHT, () => new StatusBarHeight())!;
```

3. 在 `entry` 模块的 `entry\src\main\ets\entryability\entryability.ets` 的 `onWindowStageCreate(windowStage: window.WindowStage)` 生命周期方法中添加代码。

```ets
let windowClass: window.Window = windowStage.getMainWindowSync();

windowClass.on('avoidAreaChange', () => {
  let type = window.AvoidAreaType.TYPE_SYSTEM;
  let avoidArea = windowClass.getWindowAvoidArea(type);
  this.statusBarHeight.value = px2vp(avoidArea.topRect.height);
  type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
  avoidArea = windowClass.getWindowAvoidArea(type);
  this.aiBarHeight.value = px2vp(avoidArea.bottomRect.height);
});

// 设置沉浸式
windowStage.getMainWindowSync().setWindowLayoutFullScreen(true);
```

### 引入组件句柄

```ets
import { OfflineVideoDownload } from 'offline_video_download';
// 可选：引入示例数据或类型
import { CommonConstants, VideoInfo } from 'offline_video_download';
```

### 调用组件

详细参数配置说明参见 API 参考。

```ets
// 使用方式：传入组件内置示例数据
OfflineVideoDownload({ videoInfo: CommonConstants.VIDEO_HTTPS_LISTS[0]})
```

## API 参考

### 子组件

无

### 接口

#### OfflineVideoDownload

`OfflineVideoDownload(options: OfflineVideoDownloadOptions)`

离线视频下载组件。

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | OfflineVideoDownloadOptions | 是 | 组件调用的入参对象 |

##### OfflineVideoDownloadOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| videoInfo | VideoInfo | 是 | 视频信息对象 |

###### VideoInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 视频名称 |
| url | string | 是 | 视频源地址（支持 http/https） |
| size | number | 是 | 视频大小（单位：字节） |
| duration | number | 是 | 视频时长（单位：秒） |

**构造函数：**
`new VideoInfo(name: string, url: string, size: number, duration: number)`

**方法：**

| 方法名 | 入参 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| getFormattedSize | 无 | string | 返回格式化大小（KB/MB） |
| getFormattedDuration | 无 | string | 返回格式化时长（mm:ss） |

### 组件

#### OfflineVideoDownload

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | OfflineVideoDownloadOptions | 是 | 组件调用的入参对象。 |

##### OfflineVideoDownloadOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| videoInfo | VideoInfo | 是 | 视频信息对象。 |

###### VideoInfo 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 视频名称。 |
| url | string | 是 | 视频源地址（支持 http/https）。 |
| size | number | 是 | 视频大小（单位：字节）。 |
| duration | number | 是 | 视频时长（单位：秒）。 |

**构造函数：**
`new VideoInfo(name: string, url: string, size: number, duration: number)`

**方法：**

| 方法名 | 入参 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| getFormattedSize | 无 | string | 返回格式化大小（KB/MB）。 |
| getFormattedDuration | 无 | string | 返回格式化时长（mm:ss）。 |

## 示例代码

```ets
import { AppStorageV2 } from '@kit.ArkUI';
import { BarVM, OfflineVideoDownload, VideoModel } from 'offline_video_download';
// 可选：引入示例数据或类型
import { CommonConstants, VideoInfo } from 'offline_video_download';

@Entry
@ComponentV2
struct Index {
  @Local videoState: VideoModel = AppStorageV2.connect<VideoModel>(VideoModel, () => new VideoModel())!;
  // 方式一：使用组件内置示例数据
  @Local videoInfo1: VideoInfo = CommonConstants.VIDEO_HTTPS_LISTS[0];
  // 方式二：手动构造 VideoInfo
  @Local videoInfo2: VideoInfo = new VideoInfo(
    '0002',
    '视频 2',
    $r('app.string.video2_url'),
    2580421,
    9,
    '0K',
    $r('app.media.cover_video2'),
    false,
    0,
    false
  );

  build() {
    Column() {
      if (!this.videoState.isPlaying) {
        Text('离线视频下载')
          .fontSize(16)
          .fontColor('rgba(255, 255, 255, 0.80)')
          .lineHeight(30)
        Blank().height(16)
      }
      List() {
        ListItem() {
          Row() {
            OfflineVideoDownload({ videoInfo: this.videoInfo1, isDarkMode: true })
              .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }

        ListItem() {
          Row() {
            OfflineVideoDownload({ videoInfo: this.videoInfo2, isDarkMode: true })
              .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: false })
    }
    .padding({
      top: this.videoState.isPlaying ? 0 : BarVM.instance.staBarH,
      left: this.videoState.isPlaying ? 0 : 16,
      bottom: this.videoState.isPlaying ? 0 : BarVM.instance.aiBarH,
      right: this.videoState.isPlaying ? 0 : 16
    })
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .backgroundColor('#000')
  }
}
```

## 更新记录与兼容性

### 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.0 | 2026-02-03 | 初始版本 |

### 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | ohos.permission.INTERNET |
| **权限说明** | 允许使用 Internet 网络 |
| **使用目的** | 允许使用 Internet 网络 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |

### 兼容性

| 项目 | 支持情况 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |
| **应用类型** | 应用 |
| **元服务** | 支持 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | 5.0.5, 5.1.0, 5.1.1, 6.0.0, 6.0.1, 6.0.2 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/fe096d6d2f6648b9a63a3be30ef24221/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%A6%BB%E7%BA%BF%E8%A7%86%E9%A2%91%E4%B8%8B%E8%BD%BD%E7%BB%84%E4%BB%B6/offline_video_download1.0.0.zip