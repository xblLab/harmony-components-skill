# vap 动效渲染组件

## 简介

腾讯 vap 的 OpenHarmony 版本，提供高性能，炫酷视频动画播放。

## 安装方式

```bash
ohpm install @ohos/vap
```

## 详细介绍

### 简介

腾讯 vap 的 OpenHarmony 版本，提供高性能，炫酷视频动画播放。

### 接口列表

| 接口功能 | 描述 |
| :--- | :--- |
| play | 播放 |
| pause | 暂停 |
| stop | 停止 |
| on | 监听生命周期/手势 |
| setFitType | 设置视频对齐方式 |
| setVideoMode | 设置视频格式（兼容老视频） |
| getVideoInfo | 获取融合动画配置信息 |

详细使用可参考 demo 工程。

## 详细使用

### 头文件引入

在应用文件中添加头文件：

```typescript
import { VAPPlayer, MixData } from '@ohos/vap';
```

### 定义 VAPPlayer 组件

```typescript
private vapPlayer: VAPPlayer | undefined = undefined;
@State buttonEnabled: boolean = true; // 该状态为控制按钮是否可以点击
@State src: string = "/storage/Users/currentUser/Documents/1.mp4"; // 该路径可为网络路径
```

### 配置网络资源下载路径

```typescript
// 具体使用可参考示例代码
// 获取沙箱路径
let context: Context = getContext(this) as Context
let dir = context.filesDir
```

### 界面

```typescript
XComponent({
  id: 'xcomponentId', // 唯一标识
  type: 'surface',
  libraryname: 'vap'
})
.onLoad((xComponentContext?: object | Record<string, () => void>) => {
  if (xComponentContext) {
    this.vapPlayer = new VAPPlayer
    this.vapPlayer.setContext(xComponentContext)
    this.vapPlayer.sandDir = dir // 设置存储路径
  }
})
.backgroundColor(Color.Transparent)
.height('100%')
.visibility(this.buttonEnabled ? Visibility.Hidden : Visibility.Visible)
.width('80%')
```

### 设置视频对齐方式

通过 `setFitType` 这个接口设置视频对齐方式（支持 FIT_XY, FIT_CENTER, CENTER_CROP）。接口需要在 `play` 之前使用。

```typescript
this.vapPlayer?.setFitType(fitType)
```

### 播放接口 Play 的使用

融合动画信息顺序自定义，需要指定 tag，tag 为视频制作时指定，该信息可通过 `this.vapPlayer.getVideoInfo(uri)`。当融合信息为字体时，可配置字体的对齐，颜色，大小。

```typescript
let opts: Array<MixData> = [{
  tag: 'sImg1',
  imgUri: getContext(this).filesDir + '/head1.png'
}, {
  tag: 'abc',
  txt: "星河 Harmony NEXT",
  imgUri: getContext(this).filesDir + '/head1.png'
}, {
  tag: 'sTxt1',
  txt: "星河 Harmony NEXT",
  textAlign: this.textAlign,
  fontWeight: this.fontWeight,
  color: this.color
}];
this.buttonEnabled = false;

this.vapPlayer?.play(getContext(this).filesDir + "/vapx.mp4", opts, () => {
  this.buttonEnabled = true;
});
```

### 暂停的使用

```typescript
this.vapPlayer?.pause()
```

### 停止的使用

```typescript
this.vapPlayer?.stop()
```

### 异步停止的使用

新增异步停止方法，支持 Promise 方式，解决 stop 操作完成时机不确定的问题。

**使用 Promise**

```typescript
// 使用 await 等待停止完成
await this.vapPlayer?.stopAsync();
console.log('停止完成，可以开始新的播放');

// 或者使用 then 方法
this.vapPlayer?.stopAsync().then(() => {
  console.log('停止完成，可以开始新的播放');
});
```

**可选参数**

```typescript
// 指定目标 ID 和超时时间
await this.vapPlayer?.stopAsync('targetId', 5000);
```

### 监听手势

在动画播放过程中点击播放区域，如果点击到融合动画资源，回调会返回该资源（字符串）。接口需要在 `play` 之前使用。

```typescript
this.vapPlayer?.on('click', (state)=>{
  if(state) {
    console.log('js get onClick: ' + state)
  }
})
```

### 监听播放生命周期变化

接口需要在 `play` 之前使用。

```typescript
this.vapPlayer?.on('stateChange', (state, ret)=>{
  if(state) {
    console.log('js get on: ' + state)
    if(ret)
      console.log('js get on frame: ' + JSON.stringify(ret))
  }
})
```

#### 回调参数

**state** 反应当前播放的状态：

```typescript
enum VapState {
  UNKNOWN,
  READY,
  START,
  RENDER,
  COMPLETE,
  DESTROY,
  FAILED
}
```

**ret** 参数：
- 当 `state` 为 `RENDER` 或 `START` 返回 `AnimConfig` 对象。
- 当 `state` 为 `FAILED` 反应当前的错误码。
- 其余状态为 `undefined`。

### 应用退出后台

可在页面的生命周期中调用 `onPageHide` 方法。

```typescript
onPageHide(): void {
  console.log('[LIFECYCLE-Page] onPageHide');
  this.vapPlayer?.stop()
}
```

### 兼容老视频（alphaplayer 对称的视频）

对于老视频推荐调用这个接口，接口需要在 `play` 之前使用。

```typescript
this.vapPlayer?.setVideoMode(VideoMode.VIDEO_MODE_SPLIT_HORIZONTAL)
```

## 约束与限制

在下述版本通过：

- DevEco Studio 5.0 (5.0.3.810)
- SDK: API12 (5.0.0.60)

## 权限设置

如果确定视频文件在沙箱中则不必配置。在应用模块的 `module.json5` 中添加权限，例如：`entry\src\main\module.json5`。

- `READ_MEDIA`：读取用户目录下的文件（比如 文档）；
- `WRITE_MEDIA`：下载到用户目录下；
- `INTERNET`：下载网络文件。

```json5
"requestPermissions": [
  {
    "name": 'ohos.permission.READ_MEDIA',
    "reason": '$string:read_file',
    "usedScene": {
      "abilities": [
        "EntryAbility"
      ],
      "when": "always"
    }
  },
  {
    "name": 'ohos.permission.WRITE_MEDIA',
    "reason": '$string:read_file',
    "usedScene": {
      "abilities": [
        "EntryAbility"
      ],
      "when": "always"
    }
  },
  {
    "name": "ohos.permission.INTERNET"
  }
]
```

## 许可证协议

Apache-2.0

## 更新记录

### 1.1.7

Release the official version 1.1.7

#### 1.1.7-rc.2

- 'MixData' add optional parameter 'fontSize' and 'maxLines' for adjusting text font size and limiting maximum line.
- Add 'setStopAtLast' to support stopping at the last frame of animation without destroying the screen and sending the 'Vapstate.ATLAST' event. After manually calling 'stop', the screen will be destroyed.
- 'MixData' add optional parameter 'textHeightMarginRatio' for adjusting text height margin ratio which is 0.95 defaultly.

#### 1.1.7-rc.1

- Fixed the color issue at the edge of the picture.
- Fixed the issue where color blocks automatically appeared when not filled.
- Fixed the issue where emojis were not displayed.
- Fixed the issue of json parsing crash.
- Fixed the issue of incorrect data length reading.
- Fixed the crash issue when the stop interface and XComponent destruction occurred simultaneously.
- Fix the issue where callback scenarios have a probability of crashing.

### 1.1.6

Optimized Shared Library Compilation: O3 and LTO Support

#### 1.1.6-rc.3

- Fixed the issue of incorrect reading of vapc information.
- Fix the issue of incomplete video information acquisition.
- Fix the issue of long text being truncated.

#### 1.1.6-rc.2

- Add asynchronous stop functionality with Promise pattern and callback separation mechanism
- Optimize error handling for stop operations

#### 1.1.6-rc.1

- Fixed the issue of incorrect rendering when starting to play the animation after rotating the screen.
- Supports obtaining online video information and filling vap videos with byte streams.
- Fixed the issue where the video fill element ended prematurely.

### 1.1.5

Fix rendering error after screen rotation.

#### 1.1.5-rc.1

Fix the crash problem when multiple animations play continuously at the same time.

### 1.1.4

- Fixed the abnormal stop of multiple animations playing at the same time.
- Fix the crash problem when stop.

### 1.1.3

Fix loop bug.

### 1.1.2

Fix the memory leak.

### 1.1.1

- 增强 vap 视频融合的通用性以及填充模式
- 同步上游社区代码，修复在快速创建销毁 xcomponent 组件时出现的 crash 问题

### 1.1.0

- 兼容部分 MP4 文件
- 优化监听逻辑
- 修复特定场景下的闪退

### 1.0.0

发布 1.0.0 初版

## 兼容性信息

| 项目 | 详情 |
| :--- | :--- |
| **权限与隐私基本信息** | |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| **兼容性** | |
| HarmonyOS 版本 | 5.0.0 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.3 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/3571ccda0cdd4c8489c1d38293718d46/PLATFORM?origin=template