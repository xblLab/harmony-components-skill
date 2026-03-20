# 投屏组件

## 简介

本组件支持视频投屏能力。

## 详细介绍

### 简介

本组件支持视频投屏能力。

### 约束与限制

#### 环境

DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上  
HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上  
设备类型：华为手机（直板机、双折叠）、平板  
系统版本：HarmonyOS 5.0.0(12) 及以上

#### 权限

后台任务权限：ohos.permission.KEEP_BACKGROUND_RUNNING

### 调试

进行投屏调试时，需保证两端的设备同时打开蓝牙和 Wifi，并且可以访问网络。

### 使用

安装组件。

如果是在 DevEco Studio 使用插件集成组件，则无需安装组件，请忽略此步骤。  
如果是从生态市场下载组件，请参考以下步骤安装组件。

1. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的 XXX 目录下。
2. 在项目根目录 `build-profile.json5` 添加 `module_cast`。

```json5
// 项目根目录下 build-profile.json5 填写 module_cast 路径。其中 XXX 为组件存放的目录名
"modules": [
  {
    "name": "module_cast",
    "srcPath": "./XXX/module_cast"
  }
]
```

3. 在项目根目录 `oh-package.json5` 添加依赖。

```json5
// XXX 为组件存放的目录名称
"dependencies": {
  "module_cast": "file:./XXX/module_cast"
}
```

引入组件。

```typescript
import { CastingLayer, CastPicker, CastService, CastSessionListener, VideoData } from 'module_cast';
```

调用组件，详细参数配置说明参见 API 参考。

```typescript
import { CastingLayer, CastService, CastSessionListener, VideoData } from 'module_cast'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { common } from '@kit.AbilityKit'

const TAG = 'CastDemo'

@Entry
@ComponentV2
struct Index {
  @Local castService: CastService = CastService.getInstance()
  @Local listener: CastSessionListenerImpl = new CastSessionListenerImpl()

  aboutToAppear(): void {
    this.castService.init(this.getUIContext().getHostContext() as common.UIAbilityContext)
    this.castService.registerSessionListener(this.listener)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      CastingLayer({
        castService: this.castService,
        title: `第${this.listener.currentIndex + 1}集`,
        onBack: () => {
          this.castService.endCasting()
        },
        onPlayNext: () => {
          this.listener.onPlayNext()
        },
        onPlayPre: () => {
          this.listener.onPlayPre()
        }
      })
    }.width('100%')
    .height('100%')
  }
}

@ObservedV2
class CastSessionListenerImpl implements CastSessionListener {
  @Trace isPlay: boolean = false
  @Trace public currentIndex: number = 0
  public videoList: VideoData[] = [{
    index: 1,
    url: 'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4',
    name: '第 1 集',
    head: 'https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/0603public/APPICON.png'
  }, {
    index: 2,
    url: 'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/plp/new-phones/video/mate-series.mp4',
    name: '第 2 集',
    head: 'https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/0603public/sj-next-pc.jpeg'
  }, {
    index: 3,
    url: 'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/design-intro-pop.mp4',
    name: '第 3 集',
    head: 'https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/0603public/APPICON.png'
  }]

  onStartCasting(): void {
  }

  onEndCasting(): void {
  }

  onPlay(): void {
  }

  onPause(): void {
  }

  onPlayNext(): void {
  }

  onPlayPre(): void {
  }

  onSeek(time: number): void {
  }

  onFastForward(time: number): void {
  }

  onRewind(time: number): void {
  }
}
```

## API 参考

### 接口

#### CastingLayer(options: CastingLayerOptions)

投屏组件。

**参数：**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | CastingLayerOptions | 是 | 配置投屏组件的参数。 |

**CastingLayerOptions 对象说明**

| 参数名 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| castService | CastService | 是 | 投屏服务实例 |
| title | string | 否 | 投屏名称 |
| onPlayNext | Function | 否 | 上一曲通知 |
| onPlayPre | Function | 否 | 下一曲通知 |
| onBack | Function | 否 | 退出界面通知 |

#### CastService 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| getInstance() => CastService | 方法 | 获取 CastService 单实例对象 |
| init(context: common.UIAbilityContext) => Promise | 方法 | 初始化 CastService |
| registerSessionListener(listener: CastSessionListener) => void | 方法 | 注册会话监听 |
| unregisterSessionListener(ilistener: CastSessionListener) => void | 方法 | 取消会话监听 |
| play(position?: avSession.PlaybackPosition, duration?: number) => Promise | 方法 | 播放 |
| pause(position?: avSession.PlaybackPosition, duration?: number) => Promise | 方法 | 暂停 |
| seek(timeMs: number) => void | 方法 | 设置视频跳转到某个时间位置播放 |
| setVolume(value: number) => void | 方法 | 设置远端播放音量 |
| setVolumeByOffset(value: number) => void | 方法 | 设置远端播放音量 |
| setAVMetadata(videoData: VideoData, duration?: number) => void | 方法 | 设置当前播放媒体信息 |
| endCasting() => void | 方法 | 停止投屏 |
| castStatusModel | CastStatusModel | 投屏状态 |
| deinit() => void | 方法 | 销毁 CastService |
| reInit() => void | 方法 | 重新初始化 CastService |

#### CastSessionListener 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| onStartCasting() => void | 方法 | 启动投屏通知 |
| onEndCasting() => void | 方法 | 停止投屏通知 |
| onPlay() => void | 方法 | 播放通知 |
| onPause() => void | 方法 | 暂停通知 |
| onPlayNext() => void | 方法 | 下一视频通知 |
| onPlayPre() => void | 方法 | 上一视频通知 |
| onSeek(time: number) => void | 方法 | 调整播放进度通知 |
| onFastForward(time: number) => void | 方法 | 快进通知 |
| onRewind(time: number) => void | 方法 | 快退通知 |

#### VideoData 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| url | string | 投屏链接 (支持网络链接和图库视频的 file://格式) |
| index | number | 投屏 id |
| head | string | 投屏封面 |
| name | string | 投屏名称 |

#### CastStatusModel 对象说明

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| isCasting | boolean | 是否投屏中 |
| isCastPlaying | boolean | 停止投屏处于播放中 |
| castCurrentTime | number | 当前投屏时间 |
| castDuration | number | 当前投屏总时长 |
| castResolution | string | 当前投屏分辨率 |
| currentDeviceName | string | 当前投屏设备名称 |
| castVolume | number | 当前投屏音量 |
| castMaxVolume | number | 当前投屏最大音量 |
| currentDeviceType | avSession.DeviceType | 停止投屏设备类型 |

## 示例代码

```typescript
import { CastingLayer, CastPicker, CastService, CastSessionListener, VideoData } from 'module_cast'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { common } from '@kit.AbilityKit'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { BusinessError } from '@kit.BasicServicesKit'

const TAG = 'CastDemo'
const DOMAIN = 0x0000

@Entry
@ComponentV2
struct Index {
  @Local castService: CastService = CastService.getInstance()
  @Local listener: CastSessionListenerImpl = new CastSessionListenerImpl()
  @Local ready: boolean = false
  private photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();

  playLocalVideo(){
    this.photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.VIDEO_TYPE; // 过滤选择媒体文件类型为 VIDEO。
    this.photoSelectOptions.maxSelectNumber = 5; // 选择媒体文件的最大数目。
    const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
    photoViewPicker.select(this.photoSelectOptions).then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
      photoSelectResult.photoUris.forEach((item:string,index:number)=>{
        let video: VideoData = {
          index: 4+index,
          url: item,
          name: `第${4+index}集`,
          head: 'https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/0603public/APPICON.png'
        }
        this.listener.videoList.push(video)
      })
    }).catch((err: BusinessError) => {
      console.error(`Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
    })
  }

  aboutToAppear(): void {
    this.castService.init(this.getUIContext().getHostContext() as common.UIAbilityContext)
    this.castService.registerSessionListener(this.listener)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (this.castService.castStatusModel.isCasting) {
        CastingLayer({
          castService: this.castService,
          title: `第${this.listener.currentIndex + 1}集`,
          onBack: () => {
            this.castService.endCasting()
          },
          onPlayNext: () => {
            this.listener.onPlayNext()
          },
          onPlayPre: () => {
            this.listener.onPlayPre()
          }
        })
      } else {
        Row() {
           if (this.ready) {
              CastPicker()
                .margin({ left: 12 })
              SymbolGlyph($r('sys.symbol.picture_2'))
                 .fontSize(24)
                 .fontColor([$r('sys.color.font_on_primary')])
                 .onClick(()=>{
                   this.playLocalVideo()
                 })
           }
        }.height(40)
        .width('100%')
        .backgroundColor(Color.Black)

        Stack({ alignContent: Alignment.Center }) {
          SymbolGlyph(this.listener.isPlay ? $r('sys.symbol.pause') : $r('sys.symbol.play'))
            .onClick(() => {
              this.ready = true
              this.listener.isPlay = !this.listener.isPlay
              if (this.listener.isPlay) {
                this.castService.setAVMetadata(this.listener.videoList[this.listener.currentIndex], 100000)
                this.castService.play()
              } else {
                this.castService.pause()
              }

              hilog.info(DOMAIN, TAG, `play:${this.listener.isPlay}`)
            })
            .fontColor([$r('sys.color.black')])
            .fontSize(40)
        }
        .width('100%')
        .height('100%')
        .hitTestBehavior(HitTestMode.Transparent)
      }
    }
    .width('100%')
    .height('100%')
  }
}

@ObservedV2
class CastSessionListenerImpl implements CastSessionListener {
  @Trace isPlay: boolean = false
  @Trace public currentIndex: number = 0
  public videoList: VideoData[] = [{
    index: 1,
    url: 'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/kv-intro-pop.mp4',
    name: '第 1 集',
    head: 'https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/0603public/APPICON.png'
  }, {
    index: 2,
    url: 'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/plp/new-phones/video/mate-series.mp4',
    name: '第 2 集',
    head: 'https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/0603public/sj-next-pc.jpeg'
  }, {
    index: 3,
    url: 'https://consumer.huawei.com/content/dam/huawei-cbg-site/cn/mkt/pdp/phones/ah-ultra/video/design-intro-pop.mp4',
    name: '第 3 集',
    head: 'https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/0603public/APPICON.png'
  }]

  onStartCasting(): void {
    hilog.info(DOMAIN, TAG, 'onStartCasting')
  }

  onEndCasting(): void {
    hilog.info(DOMAIN, TAG, 'onStopCasting')
  }

  onPlay(): void {
    hilog.info(DOMAIN, TAG, 'onPlay')
  }

  onPause(): void {
    hilog.info(DOMAIN, TAG, 'onPause')
  }

  onPlayNext(): void {
    hilog.info(DOMAIN, TAG, 'onPlayNext')
    this.currentIndex = (this.currentIndex + 1) % this.videoList.length
    CastService.getInstance().setAVMetadata(this.videoList[this.currentIndex], 100000)
    CastService.getInstance().play()
  }

  onPlayPre(): void {
    hilog.info(DOMAIN, TAG, 'onPlayPre')
    if(this.currentIndex > 0){
      this.currentIndex = this.currentIndex - 1
    }else {
      this.currentIndex = this.videoList.length - 1 
    }  
    CastService.getInstance().setAVMetadata(this.videoList[this.currentIndex], 100000)
    CastService.getInstance().play()
  }

  onSeek(time: number): void {
    hilog.info(DOMAIN, TAG, 'onSeek')
  }

  onFastForward(time: number): void {
    hilog.info(DOMAIN, TAG, 'onFastForward')
  }

  onRewind(time: number): void {
    hilog.info(DOMAIN, TAG, 'onRewind')
  }
}
```

## 更新记录

- **1.0.2 (2026-01-22)**
  - Created with Pixso.
  - 下载该版本修复投屏当前集数显示错误的问题。
- **1.0.1 (2025-12-02)**
  - Created with Pixso.
  - 下载该版本本组件支持了本地视频的投屏能力。
- **1.0.0 (2025-09-25)**
  - Created with Pixso.
  - 下载该版本初始版本

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| | ohos.permission.KEEP_BACKGROUND_RUNNING | 允许 Service Ability 在后台持续运行。 | 允许 Service Ability 在后台持续运行。 |

## 合规使用指南

不涉及

## 兼容性

| 兼容性项 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| | 5.0.1 | Created with Pixso. |
| | 5.0.2 | Created with Pixso. |
| | 5.0.3 | Created with Pixso. |
| | 5.0.4 | Created with Pixso. |
| | 5.0.5 | Created with Pixso. |
| | 5.1.0 | Created with Pixso. |
| | 5.1.1 | Created with Pixso. |
| | 6.0.0 | Created with Pixso. |
| | 6.0.1 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| | 平板 | Created with Pixso. |
| | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| | DevEco Studio 5.0.1 | Created with Pixso. |
| | DevEco Studio 5.0.2 | Created with Pixso. |
| | DevEco Studio 5.0.3 | Created with Pixso. |
| | DevEco Studio 5.0.4 | Created with Pixso. |
| | DevEco Studio 5.0.5 | Created with Pixso. |
| | DevEco Studio 5.1.0 | Created with Pixso. |
| | DevEco Studio 5.1.1 | Created with Pixso. |
| | DevEco Studio 6.0.0 | Created with Pixso. |
| | DevEco Studio 6.0.1 | Created with Pixso. |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/2c98814198e549faacfb465f3f0f7562/2adce9bbd4cb42d58a87e6add45594b3?origin=template

## OSS 下载链接

- https://xiaobaili-0921.oss-cn-beijing.aliyuncs.com/harmony-skill-factory/components/%E6%8A%95%E5%B1%8F%E7%BB%84%E4%BB%B6/module_cast1.0.2.zip