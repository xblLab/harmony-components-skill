# 短视频滑动组件

## 简介

本组件实现短视频切换场景，提供了短视频上下滑动、横竖屏切换、长按倍速、播放进度条拖动等能力。

## 详细介绍

### 简介

本组件实现短视频切换场景，提供了短视频上下滑动、横竖屏切换、长按倍速、播放进度条拖动、音量和亮度调节等能力。

### 竖屏横屏

### 约束与限制

#### 环境

*   **DevEco Studio 版本**：DevEco Studio 6.0.0 Release 及以上
*   **HarmonyOS SDK 版本**：HarmonyOS 6.0.0 Release SDK 及以上
*   **设备类型**：华为手机（包括双折叠和阔折叠）、平板
*   **系统版本**：HarmonyOS 5.0.1(13) 及以上

#### 权限

*   **网络权限**：`ohos.permission.INTERNET`、`ohos.permission.GET_NETWORK_INFO`

#### 使用

**安装组件。**

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1.  解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2.  在项目根目录 `build-profile.json5` 添加 `module_swipeplayer`、`module_transition` 模块。

```json5
// 项目根目录下 build-profile.json5 填写 module_swipeplayer、module_transition 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_swipeplayer",
    "srcPath": "./XXX/module_swipeplayer"
  },
  {
    "name": "module_transition",
    "srcPath": "./XXX/module_transition"
  },
]
```

3.  在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
   "module_swipeplayer": "file:./XXX/module_swipeplayer",
   "module_transition": "file:./XXX/module_transition",
}
```

**引入组件。**

```typescript
import { VideoSwipePlayer, SwipePlayerController, AVPlayerManager, AVPlayerSession, PlayerDataSource } from 'module_swipeplayer';
```

**调用组件，详细参数配置说明参见 API 参考。**

```typescript
VideoSwipePlayer({
  // 数据源
  datasource: this.videoDataSources,
  // 滑动播放控制器
  swipePlayerController: this.swipePlayerController,
  // 视频外层控制层，需要实现一个 WrappedBuilder 组件
  videoLayerBuilder: wrapBuilder(VideoLayerViewBuilder),
  pathStack: this.pathStack,
  isShown: true,
  options: {
    autoPlay: true,
    bottomTabHeight: 56,
    totalCount: 2,
    swiperCallback: {
      onAnimationStart: (_index: number, targetIndex: number, extraInfo: SwiperAnimationEvent) => {
        // TODO 处理切换动画开始的业务逻辑，如：加载更多
      },
      onChange: (index: number) => {
        // TODO 子组件索引变化时的回调
      }
    }
  }
})
```

## API 参考

### 接口

**VideoSwipePlayer(option: VideoSwipePlayerOptions)**
滑动视频组件

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | VideoSwipePlayerOptions | 是 | 滑动视频组件的参数。 |

#### VideoSwipePlayerOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| datasource | IDataSource | 是 | 视频列表的懒加载数据源 |
| swipePlayerController | SwipePlayerController | 是 | 视频滑动播放控制器 |
| options | SwipePlayerOptions | 是 | 配置的信息 |
| videoLayerBuilder | WrappedBuilder<[ESObject, AVPlayerSession, SwipePlayerController, PlayerLayoutSize]> | 否 | 视频外层的操作层，可自定义，如果不传，则只显示进度条 |
| fullBtnBuilder | () => CustomBuilder | 否 | 全屏播放按钮，可以自定义，如果不传，使用默认样式 |
| pathStack | NavPathStack | 是 | 全局 Navigation 的路由栈 |
| playerStateCallback | (state: string, id: string) => void | 否 | 播放状态回调。state：视频播放中"playing"的状态，id：当前播放视频的 id |
| isLandscape | boolean | 否 | 是否横屏 |
| videoNetwork | VideoNetworkModel | 否 | 网络状态 |
| videoNetworkSetting | VideoNetworkSetting | 否 | 网络播放设置 |
| isShown | boolean | 是 | 当前组件所在的页面是否显示 |

#### SwipePlayerController 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| avPlayerMgr | AVPlayerManager | 是 | 播放器管理 |
| curentIndex | number | 是 | 当前播放视频的索引 |
| swiperController | SwiperController | 是 | Swiper 组件的控制器 |

#### SwipePlayerOptions 对象说明

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| cachedCount | number | 否 | 懒加载缓存的个数。默认 2 个 |
| autoPlay | boolean | 否 | 视频是否自动播放 |
| swiperCallback | SwiperCallback | 否 | Swiper 组件的 onChange、onAnimationStart 的回调事件 |
| bottomTabHeight | number | 否 | 底部 tab 栏的高度 |
| totalCount | number | 否 | 视频列表的总数，用来判断是否滑动最后一个 |

#### PlayerLayoutSize 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| updateXComponentWidth | (xComponentWidth: Length) => void | 更新 XComponent 的宽度 |
| getXComponentWidth | () => Length | 获取 XComponent 的宽度 |
| updateXComponentHeight | (xComponentHeight: Length) => void | 更新 XComponent 的高度 |
| getXComponentHeight | () => Length | 获取 XComponent 的高度 |
| updateLayoutSizeChangeFlag | (flag: boolean) => void | 设置尺寸的变化标识 |
| getLayoutSizeChangeFlag | () => boolean | 获取尺寸的变化标识 |

#### SwiperCallback 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| onChange | (index: number) => void | Swiper 组件的 onChange 事件的回调 |
| onAnimationStart | (index: number, targetIndex: number, extraInfo: SwiperAnimationEvent) => void | Swiper 组件的 onAnimationStart 事件的回调 |

#### AVPlayerManager 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| getInstance | () => AVPlayerManager | 获取 AVPlayerManager 单实例对象 |
| createAVPlayer | () => Promise<media.AVPlayer \| undefined> | 创建 AVPlayer 对象 |
| getAVPlayer | (index: number) => media.AVPlayer \| undefined | 根据索引获取 AVPlayer 对象 |
| play | (index: number) => Promise | 播放某个 index 的视频 |
| pause | (index: number) => Promise | 暂停某个 index 的视频 |
| release | (index: number) => Promise | 释放某个 index 的视频 |
| seek | (index: number, timeMs: number) => void | 设置某个 index 视频跳转到某个时间位置播放 |
| setSpeed | (index: number, speed: media.PlaybackSpeed) => void | 设置播放速度 |

#### AVPlayerSession 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| avPlayer | media.AVPlayer \| undefined | AVPlayer 对象 |
| avPlayerCallbackMap | AVPlayer 对象的事件监听回调 | |
| play | () => Promise | 播放 AVplayer |
| pause | () => Promise | 暂停 AVPlayer |

#### VideoNetworkModel 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| hasNet | boolean | 是否有网络 |
| isCellular | boolean | 是否是移动蜂窝网络 |
| isWifi | boolean | 是否是 WiFi 网络 |
| hasOfflineTip | boolean | 无网络时，是否已经提示 |
| canUseMobileData | boolean | 是否可以使用移动流量 |
| hasUseMobileDataTip | boolean | 使用流量播放时，是否已经提示 |
| isNetworkAvailable | boolean | 当前网络是否可用 |

#### VideoNetworkSetting 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| downloadWithoutWlan | boolean | 是否下载大图 |
| remindWithoutWlan | boolean | 非 WLAN 网络播放提醒 |
| autoPlayNext | boolean | 视频自动下滑 |

## 示例代码

该示例由 `Index.ets` 和 `SwipeVideoPage.ets` 两个文件组成，主要演示从 Index 页面使用 Navigation 跳转到 SwipeVideoPage 视频滑动页面。滑动页跳转到横屏页时，通过自定义转场动画，实现一镜到底的效果。
横屏页面是组件内部的页面。不需要自行实现。
示例代码使用 Navigation，运行示例代码之前需要进行系统路由表的配置，具体操作如下：
在 `entry/src/main` 目录下的工程配置文件 `module.json5` 中的 `module` 字段里配置 `"routerMap": "$profile:route_map"`，
在 `entry/src/main/resources/base/profile` 目录下新增 `route_map.json` 文件，文件内容如下：

```json
{
  "routerMap": [
    {
      "name": "SwipeVideoPage",
      "pageSourceFile": "src/main/ets/pages/SwipeVideoPage.ets",
      "buildFunction": "SwipeVideoPageBuilder"
    }
  ]
}
```

由于使用了一镜到底效果，需要在 `entry/src/main/ets/entryability/EntryAbility.ets` 文件的 `onWindowStageCreate` 方法里初始化一镜到底动画：

```typescript
import { window } from '@kit.ArkUI';
import { LoneTakeAnimationsTransition } from 'module_transition';

export default class EntryAbility extends UIAbility {
     onWindowStageCreate(windowStage: window.WindowStage): void {
        ...
        LoneTakeAnimationsTransition.init(windowStage);
        ...
     }
}
```

### 入口页

```typescript
// Index.ets
import { LoneTakeAnimationsTransition } from 'module_transition';

@Entry
@ComponentV2
struct Index {
  // 全局 navigation 的路由栈
  pageStack: NavPathStack = new NavPathStack();
  @Local isEnabled: boolean = true;
  aboutToAppear(): void {
    this.pageStack.pushPathByName('SwipeVideoPage', '')
  }

  build() {
    Navigation(this.pageStack) {
    }
    .hideNavBar(true)
    .hideTitleBar(true)
    .enabled(this.isEnabled)
    .customNavContentTransition((from: NavContentInfo, to: NavContentInfo, operation: NavigationOperation) => {
        // 自定义转场动画
      return LoneTakeAnimationsTransition.customNavContentTransition(from, to, operation, {
        // 自定义转场过程中禁用手势，避免出现体验问题
        onTransitionStart: () => {
          this.isEnabled = false;
        },
        onTransitionEnd: () => {
          this.isEnabled = true;
        }
      });
    })
  }
}
```

### 滑动视频页

需要在工程的 `entry\src\main\ets\pages` 目录下新建滑动视频页：`SwipeVideoPage.ets`

```typescript
// SwipeVideoPage.ets
import {
  VideoSwipePlayer,
  AVPlayerManager,
  AVPlayerSession,
  PlayerDataSource,
  SwipePlayerController,
  PlayerLayoutSize,
  VideoPlayerData,
} from 'module_swipeplayer';
import { LongTakeAnimationProperties } from 'module_transition';

interface VideoInfo {
  // 视频 id
  id: string
  // 标题
  title: string
  // 视频 url
  videoUrl: string
  // 封面图
  coverUrl: string
  // 视频时长 (单位：毫秒)
  videoDuration: number
}

class VideoData implements VideoInfo, VideoPlayerData {
  // 视频 id
  id: string = ''
  // 标题
  title: string = ''
  // 视频 url
  videoUrl: string = ''
  // 封面图
  coverUrl: string = ''
  // 视频时长 (单位：毫秒)
  videoDuration: number = 0

  constructor(data: VideoInfo) {
    this.id = data.id
    this.title = data.title
    this.videoUrl = data.videoUrl
    this.coverUrl = data.coverUrl
    this.videoDuration = data.videoDuration
  }

  getVideoId(): string {
    return this.id;
  }

  getVideoUrl(): string {
    return this.videoUrl;
  }

  getCoverUrl(): string {
    return this.coverUrl;
  }

  getVideoTitle(): string {
    return this.title;
  }

  getVideoDuration(): number {
    return this.videoDuration;
  }
}

// 视频外层控制层视图
@ComponentV2
struct VideoLayer {
  // 视频数据
  @Param @Require videoData: ESObject;
  // 播放会话
  @Param @Require playerSession: AVPlayerSession;
  // 滑动播放控制器
  @Param @Require swipePlayerController: SwipePlayerController
  // 评论页面出现时，改变播放页面的尺寸
  @Param @Require playerLayoutSize: PlayerLayoutSize

  // 播放、暂停切换
  switchPlayOrPause() {
    let avPlayer = this.swipePlayerController.getAVPlayer()
    let state = avPlayer?.state
    if (state === 'playing') {
      avPlayer?.pause()
    } else {
      avPlayer?.play()
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('这是自定义的外层操作层')
        .fontSize(30)
        .fontColor($r('sys.color.white'))
    }.height('100%')
    .width('100%')
    .onClick(() => {
      this.switchPlayOrPause()
    })
  }
}

@Builder
function VideoLayerViewBuilder(
  videoData: ESObject,
  playerSession: AVPlayerSession,
  swipePlayerController: SwipePlayerController,
  playerLayoutSize: PlayerLayoutSize
) {
  VideoLayer({
    videoData,
    playerSession,
    swipePlayerController,
    playerLayoutSize,
  })
}

// 滑动视频页
@Builder
export function SwipeVideoPageBuilder() {
  SwipeVideoPage()
}

@ComponentV2
export struct SwipeVideoPage {
  // 数据源
  videoDataSources = new PlayerDataSource<VideoData>()
  // 播放控制器
  swipePlayerController: SwipePlayerController = new SwipePlayerController();
  // 播放管理
  avPlayerManager: AVPlayerManager = new AVPlayerManager();
  // 路由栈
  pathStack = new NavPathStack()
  @Local longTakeSession: LongTakeAnimationProperties = new LongTakeAnimationProperties();

  aboutToAppear() {
    // 设置播放管理
    this.swipePlayerController.setAVPlayerMgr(this.avPlayerManager)

    // 初始化数据
    let data1 = {
      id: 'video1',
      title: '新通话，让每一次连接超越想象',
      videoUrl: 'https://www-file.huawei.com/admin/asset/v1/pro/view/a20e0965e56a4dc498fc33ee23750c0d.mp4',
      coverUrl: 'https://www-file.huawei.com/admin/asset/v1/pro/view/6c813cb0874744f4b54fd61f1f9e8f24.jpg',
      videoDuration: 134506
    } as VideoInfo

    let data2 = {
      id: 'video2',
      title: '星联光模块',
      videoUrl: 'https://e-file.huawei.com/mediares/MarketingMaterial_MCD/EBG/PUBLIC/zh/2025/04/5feb8457-d5e9-4949-a181-795e4d873af9.mp4',
      coverUrl: 'https://e-file.huawei.com/mediares/Video_MCD/EBG/PUBLIC/zh/2025/04/3c04b872-197d-4551-a353-0eb99def6ca2.png',
      videoDuration: 48234
    } as VideoInfo

    let list: VideoData[] = [
      new VideoData(data1),
      new VideoData(data2),
    ]
    this.videoDataSources.setData(list)
  }

  build() {
    NavDestination() {
      Stack() {
        Column() {
          VideoSwipePlayer({
            // 数据源
            datasource: this.videoDataSources,
            // 滑动播放控制器
            swipePlayerController: this.swipePlayerController,
            // 视频外层控制层，需要实现一个 WrappedBuilder 组件
            videoLayerBuilder: wrapBuilder(VideoLayerViewBuilder),
            pathStack: this.pathStack,
            isShown: true,
            options: {
              autoPlay: true,
              bottomTabHeight: 56,
              totalCount: 2,
              swiperCallback: {
                onAnimationStart: (_index: number, targetIndex: number, extraInfo: SwiperAnimationEvent) => {
                  // TODO 处理切换动画开始的业务逻辑，如：加载更多
                },
                onChange: (index: number) => {
                  // TODO 子组件索引变化时的回调
                }
              }
            }
          })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}
```

## 更新记录

### 1.0.3 (2026-01-13)

Created with Pixso.

*   下载该版本
*   修改视频横竖屏切换问题
*   废弃 API 整改
*   修改互动内的视频在页面退出后，会在持续播放的问题
*   修改滑动进度条时不展示总时间的问题

### 1.0.1 (2025-09-10)

Created with Pixso.

*   下载该版本
*   新增平板适配
*   新增新闻直播功能
*   新增音量、亮度调节功能
*   深浅色适配优化

### 1.0.0 (2025-08-30)

Created with Pixso.

*   下载该版本
*   初始版本

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |
| ohos.permission.GET_NETWORK_INFO | 允许应用获取数据网络信息 | 允许应用获取数据网络信息 |

### 隐私政策

不涉及 SDK 合规

### 使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | 兼容性 |
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

| 应用类型 | 兼容性 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

| 设备类型 | 兼容性 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

| DevEcoStudio 版本 | 兼容性 |
| :--- | :--- |
| DevEco Studio 6.0.0 | Created with Pixso. |
| DevEco Studio 6.0.1 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/234d25e1a8ad4f25a659ea7c84e5b5b1/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%9F%AD%E8%A7%86%E9%A2%91%E6%BB%91%E5%8A%A8%E7%BB%84%E4%BB%B6/module_swipeplayer1.0.3.zip