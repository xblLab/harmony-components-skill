# 竖屏滑动视频组件

## 简介

本组件提供了展示短剧滑动视频、上下滑动切换短剧视频、切换到指定索引短剧视频等相关的能力，可以帮助开发者快速集成滑动短剧视频相关的能力。

## 详细介绍

### 简介

本组件提供了展示短剧竖屏滑动视频、上下滑动切换短剧视频、切换到指定索引短剧视频等相关的能力，可以帮助开发者快速集成滑动短剧视频相关的能力。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（直板机、双折叠）、平板
- **HarmonyOS 版本**：HarmonyOS 5.0.0 Release 及以上

#### 权限

- **网络权限**：`ohos.permission.INTERNET`

### 使用

#### 安装组件

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 `XXX` 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `video_swiper` 模块。
   > 在项目根目录 `build-profile.json5` 填写 `video_swiper` 路径。其中 `XXX` 为组件存放的目录名。

   ```json5
   "modules": [
     {
       "name": "video_swiper",
       "srcPath": "./XXX/video_swiper"
     },
     {
       "name": "module_cast",
       "srcPath": "./XXX/module_cast"
     }
   ]
   ```

3. 在项目根目录 `oh-package.json5` 中添加依赖。
   > `XXX` 为组件存放的目录名称。

   ```json5
   "dependencies": {
     "video_swiper": "file:./XXX/video_swiper"
   }
   ```

#### 引入组件

```typescript
import { VideoSwiper, PlayController } from 'video_swiper';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
import {
   PlayController,
   PlaySession,
   VideoPlayData,
   VideoPlayDataSource,
   VideoSwiper
} from 'video_swiper';
import { media } from '@kit.MediaKit';
import common from '@ohos.app.ability.common';

class EpisodeData implements VideoPlayData {
   url: media.AVFileDescriptor | string

   constructor(url: media.AVFileDescriptor | string) {
      this.url = url;
   }

   getName(): string {
      return 'name'
   }

   getId(): string {
      return 'id'
   }

   getDuration(): number {
      return 0
   }

   getUrl(): media.AVFileDescriptor | string {
      return this.url
   }

   getPlayTime(): number {
      return 0;
   }

   getPic(): string {
      return '';
   }
   isLocked():boolean{
      return false;
   }
}

@ComponentV2
struct VideoDetail {
   build() {
      Stack({ alignContent: Alignment.Bottom }) {
         Text('Hello Video Swiper')
            .fontSize(40)
            .fontColor($r('sys.color.white'))
      }.height('100%')

   }
}

@Entry
@ComponentV2
struct Index {
   data: VideoPlayDataSource = new VideoPlayDataSource()
   httpUrls: Array<string> = []
   rawUrls: Array<string> = []
   private context: common.UIAbilityContext | undefined = undefined;

   aboutToAppear() {
   //初始化数据
   this.httpUrls = ['https://agc-storage-drcn.platform.dbankcloud.cn/v0/app-d45y3/drama_video/2.m3u8','https://agc-storage-drcn.platform.dbankcloud.cn/v0/app-d45y3/drama_video/3.m3u8']
   this.httpUrls.forEach((item:string)=>{
     let videoData: EpisodeData =
       new EpisodeData(item)
     this.data.pushData(videoData);
   })

   this.rawUrls = ['XX.mp4','XX.mp4']//1、将本地视频放在模块的 resources/rawfile 文件夹下 2、数组中填写本地视频文件名称 (本地视频必须为 mp4 格式)
   this.context = this.getUIContext().getHostContext() as common.UIAbilityContext;
   this.rawUrls.forEach(async (item:string)=> {
     let fileName = item; 
     let fileDescriptor = await this.context!.resourceManager.getRawFd(fileName);
     let avFileDescriptor: media.AVFileDescriptor =
       { fd: fileDescriptor.fd, offset: fileDescriptor.offset, length: fileDescriptor.length };
     let videoData: EpisodeData =
       new EpisodeData(avFileDescriptor)
     this.data.pushData(videoData);
     })
   }

   build() {
      Column() {
         // 视频切换组件
         VideoSwiper({
            videoPlayDataSource: this.data, // 视频数据
            contentBuilder: wrapBuilder(videoDetailComponent), // 自定义播放视频上的浮层界面
         })
      }
   }
}

@Builder
function videoDetailComponent(videoData: VideoPlayData, playControl: PlayController,
   playerSession: PlaySession) {

   VideoDetail()
}
```

如需播放网络视频，需申请网络访问权限：`ohos.permission.INTERNET`

## API 参考

### 接口

#### VideoSwiper(options: VideoSwiperOptions)

竖屏滑动视频组件。

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | VideoSwiperOptions | 是 | 配置竖屏滑动视频的参数。 |

#### VideoSwiperOptions 对象说明

| 名称 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| videoPlayDataSource | VideoPlayDataSource | 是 | 视频数据源 |
| playController | PlayController | 否 | 滑动播放控制器 |
| contentBuilder | WrappedBuilder<[VideoPlayData, PlayController, PlaySession]> | 是 | 播放视频的上层自定义视图组件 |
| currentVideoIndex | number | 否 | 要播放的索引，默认 0 |

#### VideoPlayDataSource

竖屏滑动视频组件的视频数据源。支持网络链接和本地资源，本地资源文件放在模块的 `resources/rawfile` 文件夹下。

| 方法 | 说明 |
| :--- | :--- |
| totalCount | totalCount(): number<br>获取总长度 |
| getData | getData(index: number): VideoPlayData<br>获取索引数据 |
| addData | addData(index: number, data: VideoPlayData): void<br>增加视频到指定索引 |
| pushData | pushData(data: VideoPlayData): void<br>添加数据 |

#### PlayController

VideoSwiper 组件的控制器，用于播放控制，剧集选集等交互。

| 方法 | 说明 |
| :--- | :--- |
| constructor | constructor()<br>PlayController 的构造函数。 |
| play | play()<br>播放视频 |
| pause | pause()<br>停止播放视频 |
| seek | seek(timeMs: number)<br>设置播放进度，单位 ms（跳转到指定时间的前一个关键帧视频） |
| setSpeed | setSpeed(speed: media.PlaybackSpeed)<br>设置播放速度（单视频生效） |
| changeIndex | changeIndex(index: number)<br>播放指定索引视频 |

#### WrappedBuilder

WrappedBuilder<[VideoPlayData, PlayController, PlaySession]>

竖屏滑动视频组件自定义播放上层视图接口，用于开发者自定义显示内容，并和播放视频交互，例如播放控制、事件监听、剧集选集等。

#### VideoPlayData

视频数据抽象接口，开发者在满足此接口定义情况下可以继承实现扩展。

| 方法 | 说明 |
| :--- | :--- |
| getUrl | getUrl(): string \| media.AVFileDescriptor<br>获取播放资源，需开发者实现 |
| getPlayTime | getPlayTime():number<br>获取当前播放进度，需开发者实现 |
| getPic | getPic(): ResourceStr<br>获取封面图片用于视频加载时显示，需开发者实现 |

#### PlaySession

单个播放视频的会话管理，封装 avplayer 实现单视频播控和事件监听。

| 方法 | 说明 |
| :--- | :--- |
| onStateChange | onStateChange(key: string, callback: (state: string) => void): void<br>状态变化事件监听，支持"stateChange"监听 |
| onTimeUpdate | onTimeUpdate(key: string, callback: (time: number) => void): void<br>播放时间进度更新事件监听 |

## 示例代码

### 示例 1（剧集播放页播放视频）

本示例通过 `video_swiper` 实现播放视频。

```typescript
import {
   PlayController,
   PlaySession,
   VideoPlayData,
   VideoPlayDataSource,
   VideoSwiper
} from 'video_swiper';
import { media } from '@kit.MediaKit';
import common from '@ohos.app.ability.common';

class EpisodeData implements VideoPlayData {
   id: string
   url: media.AVFileDescriptor | string

   constructor(url: media.AVFileDescriptor | string, id: string) {
      this.url = url;
      this.id = id;
   }

   getName(): string {
      return 'name'
   }

   getId(): string {
      return this.id
   }

   getDuration(): number {
      return 0
   }

   getUrl(): media.AVFileDescriptor | string {
      return this.url
   }

   getPlayTime(): number {
      return 0;
   }

   getPic(): string {
      return '';
   }
   isLocked():boolean{
      return false;
   }
}

@ComponentV2
struct VideoDetail {
   build() {
      Stack({ alignContent: Alignment.Bottom }) {
         Text('Hello Video Swiper')
            .fontSize(40)
            .fontColor($r('sys.color.white'))
      }.height('100%')

   }
}

@Entry
@ComponentV2
struct Index {
   data: VideoPlayDataSource = new VideoPlayDataSource()
   httpUrls: Array<string> = []
   rawUrls: Array<string> = []
   private context: common.UIAbilityContext | undefined = undefined;
   private videoIndex:number = 0;

   aboutToAppear() {
   //初始化数据
   this.httpUrls = ['https://agc-storage-drcn.platform.dbankcloud.cn/v0/app-d45y3/drama_video/2.m3u8','https://agc-storage-drcn.platform.dbankcloud.cn/v0/app-d45y3/drama_video/3.m3u8']
   this.httpUrls.forEach((item:string)=>{
      let videoData: EpisodeData =
         new EpisodeData(item,String(this.videoIndex++))
      this.data.pushData(videoData);
   })

   this.rawUrls = ['XX.mp4','XX.mp4']//1、将本地视频放在模块的 resources/rawfile 文件夹下 2、数组中填写本地视频文件名称 (本地视频必须为 mp4 格式)
   this.context = this.getUIContext().getHostContext() as common.UIAbilityContext;
   this.rawUrls.forEach(async (item:string)=> {
      let fileName = item;
      let fileDescriptor = await this.context!.resourceManager.getRawFd(fileName);
      let avFileDescriptor: media.AVFileDescriptor =
         { fd: fileDescriptor.fd, offset: fileDescriptor.offset, length: fileDescriptor.length };
      let videoData: EpisodeData =
         new EpisodeData(avFileDescriptor,String(this.videoIndex++))
      this.data.pushData(videoData);
     })
   }

   build() {
      Column() {
         // 视频切换组件
         VideoSwiper({
            videoPlayDataSource: this.data, // 视频数据
            contentBuilder: wrapBuilder(videoDetailComponent), // 自定义播放视频上的浮层界面
         })
      }
   }
}

@Builder
function videoDetailComponent(videoData: VideoPlayData, playControl: PlayController,
   playerSession: PlaySession) {

   VideoDetail()
}
```

### 示例 2（自定义组件使用，播放/暂停/更改播放剧集等）

```typescript
import {
   PlayController,
   PlaySession,
   VideoPlayData,
   VideoPlayDataSource,
   VideoSwiper
} from 'video_swiper';
import { media } from '@kit.MediaKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import common from '@ohos.app.ability.common';

class EpisodeData implements VideoPlayData {
   id: string;
   desc: string;
   url:media.AVFileDescriptor | string;

   constructor(url:media.AVFileDescriptor | string, desc: string, id: string) {
      this.desc = desc
      this.url = url
      this.id = id
   }

   getName(): string {
      return 'name'
   }

   getId(): string {
      return this.id
   }

   getDuration(): number {
      return 0
   }

   getUrl(): media.AVFileDescriptor | string {
      return this.url
   }

   getPlayTime(): number {
      return 0;
   }

   getPic(): string {
      return '';
   }

   getDesc(): string {
      return this.desc
   }
   isLocked():boolean{
      return false;
   }
}

let index: number = 0
let length: number = 0

@ComponentV2
struct VideoDetail {
   @Param @Require playSession: PlaySession
   @Param @Require playControl: PlayController
   @Param @Require episodeData: EpisodeData

   aboutToAppear(): void {
      this.playSession.onStateChange('stateChange', (state: string) => {
      // 进入详情播放页播放下一集
      if (state === 'completed') {
      hilog.info(0x000, 'VideoDetail', 'play complete, will play next')
      this.changeIndex()
   }
})
}

build() {
   Stack({ alignContent: Alignment.Bottom }) {
      Column() {
         Text(this.episodeData.getDesc())
            .fontColor($r('sys.color.white'))
         Button('play')
            .onClick(() => {
               this.playControl.play()
            })
         Button('pause')
            .onClick(() => {
               this.playControl.pause()
            })
         Button('changeIndex')
            .onClick(() => {
               this.changeIndex()
         })
      }
   }.height('100%')
}

changeIndex() {
   if (index === length - 1) {
      index = 0
   } else {
      index ++
   }
   this.playControl.changeIndex(index)
}
}

@Entry
@ComponentV2
struct Index {
   data: VideoPlayDataSource = new VideoPlayDataSource()
   httpUrls: Array<string> = []
   rawUrls: Array<string> = []
   private context: common.UIAbilityContext | undefined = undefined;
   private videoIndex:number = 0;

   aboutToAppear() {
   //初始化数据
   this.httpUrls = ['https://agc-storage-drcn.platform.dbankcloud.cn/v0/app-d45y3/drama_video/2.m3u8','https://agc-storage-drcn.platform.dbankcloud.cn/v0/app-d45y3/drama_video/3.m3u8']
   this.httpUrls.forEach((item:string,index:number)=>{
      let videoData: EpisodeData =
         new EpisodeData(item,`this is episode for http ${index}`, String(this.videoIndex++))
      this.data.pushData(videoData);
   })
   length = this.data.totalCount()

   this.rawUrls = ['XX.mp4','XX.mp4']//1、将本地视频放在模块的 resources/rawfile 文件夹下 2、数组中填写本地视频文件名称 (本地视频必须为 mp4 格式)
   this.context = this.getUIContext().getHostContext() as common.UIAbilityContext;
   this.rawUrls.forEach(async (item:string,index:number)=> {
      let fileName = item;
      let fileDescriptor = await this.context!.resourceManager.getRawFd(fileName);
      let avFileDescriptor: media.AVFileDescriptor =
         { fd: fileDescriptor.fd, offset: fileDescriptor.offset, length: fileDescriptor.length };
      let videoData: EpisodeData =
         new EpisodeData(avFileDescriptor,`this is episode for rawfile ${index}`, String(this.videoIndex++))
      this.data.pushData(videoData);
      length = this.data.totalCount()
     })
   }

   build() {
      Column() {
         // 视频切换组件
         VideoSwiper({
            videoPlayDataSource: this.data, // 视频数据
            contentBuilder: wrapBuilder(videoDetailComponent), // 自定义播放视频上的浮层界面
         })
      }
   }
}

@Builder
function videoDetailComponent(videoData: VideoPlayData, playControl: PlayController,
   playerSession: PlaySession) {

   VideoDetail({
      episodeData: videoData as EpisodeData,
      playControl: playControl,
      playSession: playerSession
   })
}
```

第一集第二集

## 更新记录

| 版本 | 日期 | 说明 |
| :--- | :--- | :--- |
| 1.0.4 | 2026-01-22 | 下载该版本修复示例代码中 changeIndex 按钮。修复短视频切换起播时延高的问题。 |
| 1.0.3 | 2025-11-25 | 下载该版本本组件支持了本地视频的播放。 |
| 1.0.2 | 2025-10-31 | 下载该版本修复了部分 bug |
| 1.0.1 | 2025-08-29 | 下载该版本修复了 LazyForeach 重复重建导致 app 卡顿问题。 |
| 1.0.0 | 2025-08-06 | 下载该版本本组件提供了展示短剧滑动视频、上下滑动切换短剧视频、切换到指定索引短剧视频等相关的能力，可以帮助开发者快速集成滑动短剧视频相关的能力。 |

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| ohos.permission.INTERNET | 允许使用 Internet 网络 | 允许使用 Internet 网络 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

| 版本 |
| :--- |
| 5.0.0 |
| 5.0.1 |
| 5.0.2 |
| 5.0.3 |
| 5.0.4 |
| 5.0.5 |
| 5.1.0 |
| 5.1.1 |
| 6.0.0 |
| 6.0.1 |

### 应用类型

| 类型 |
| :--- |
| 应用 |
| 元服务 |

### 设备类型

| 类型 |
| :--- |
| 手机 |
| 平板 |
| PC |

### DevEcoStudio 版本

| 版本 |
| :--- |
| DevEco Studio 5.0.0 |
| DevEco Studio 5.0.1 |
| DevEco Studio 5.0.2 |
| DevEco Studio 5.0.3 |
| DevEco Studio 5.0.4 |
| DevEco Studio 5.0.5 |
| DevEco Studio 5.1.0 |
| DevEco Studio 5.1.1 |
| DevEco Studio 6.0.0 |
| DevEco Studio 6.0.1 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9088d8b9060e4f76a3fc0f9935f89e3c/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E7%AB%96%E5%B1%8F%E6%BB%91%E5%8A%A8%E8%A7%86%E9%A2%91%E7%BB%84%E4%BB%B6/video_swiper1.0.4.zip