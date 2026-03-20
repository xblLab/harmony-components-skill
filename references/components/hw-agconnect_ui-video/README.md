# 视频 UIVideo

## 简介

UIVideo 是基于 open harmony 基础组件开发的视频组件，支持横屏显示，以及音量、亮度和进度调节。

## 详细介绍

### 简介

UIVideo 是基于 open harmony 基础组件开发的视频组件，支持横屏显示，以及音量、亮度和进度调节。
我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

```bash
ohpm install @hw-agconnect/ui-video
```

#### 使用

```typescript
// 组件在同一页面仅支持单个视频组件使用。
// 引入组件
import { UIVideo } from '@hw-agconnect/ui-video';
```

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。
HarmonyOS 系统：HarmonyOS 5.0.1 Release 及以上。
DevEco Studio 版本：DevEco Studio 5.0.1 Release 及以上。
HarmonyOS SDK 版本：HarmonyOS 5.0.1 Release SDK 及以上。

### 子组件

无

### 接口

#### UIVideo(options: UIVideoOptions)

##### UIVideoOptions 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| videoData | IVideoData[] | 是 | 视频信息 |
| style | VolumnAndBrightStyle | 否 | 音量和亮度进度条类型 |
| controller | VideoController | 否 | 视频控制器，可以控制视频的播放状态 |
| customTopRegion | CustomBuilder | 否 | 视频自定义顶部状态信息栏 |
| customBottomRegion | CustomBuilder | 否 | 视频自定义底部状态信息栏 |
| componentController | ComponentController | 否 | 组件控制器，控制全屏退出 |

##### VideoController 对象说明

| 参数 | 类型 | 说明 |
| :--- | :--- | :--- |
| playerModel | PlayerModel | 播放器音量等数据 |
| release() | void | 销毁播放资源 |
| pause() | void | 暂停播放 |
| setLoop() | void | 设置循环播放，第二次点击时取消 |
| setSpeed(playSpeed: media.PlaybackSpeed) | void | 设置播放速度，同鸿蒙 |
| previousVideo() | void | 播放上一个视频 |
| nextVideo() | void | 播放下一个视频 |
| switchPlayOrPause() | void | 播放切换为暂停、暂停切换为播放 |
| setSeekTime(value: number, mode: SliderChangeMode) | void | 调整播放进度，SliderChangeMode 同鸿蒙 |
| setBright(value: number) | void | 调整亮度，同鸿蒙 |
| setVolume(value: number) | void | 调整音量，同鸿蒙 |

##### ComponentController 对象说明

| 参数 | 类型 | 说明 |
| :--- | :--- | :--- |
| onBack() | boolean | 全屏时，视频退出全屏状态，需要配合 onBackPress 使用 |

##### PlayerModel 对象说明

| 参数 | 类型 | 说明 |
| :--- | :--- | :--- |
| playSpeed | number | 播放速度 |
| volume | number | 播放音量 |
| bright | number | 屏幕亮度 |
| currentTime | string | 当前的播放时间 |
| totalTime | string | 播放总时长 |
| progressValue | number | slider 滑块的进度值 |

##### VolumnAndBrightStyle 枚举说明

| 名称 | 描述 |
| :--- | :--- |
| CIRCLE | 设置音量、亮度、播放进度为圆形 |
| CAPSULE | 设置音量、亮度、播放进度为胶囊 |

##### IVideoData 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| name | string | 是 | 视频名称 |
| type | string | 是 | 视频类型 |
| isLocal | boolean | 是 | 是否为本地视频 |
| src | string | 否 | 网络视频 URL 地址 |
| episode | string | 否 | 视频集数 |

### 使用限制

无

## 示例

### 示例 1

```typescript
import { UIVideo, VideoController, IVideoData, ComponentController } from '@hw-agconnect/ui-video';

@Entry
@ComponentV2
struct FullVideoSample {
  @Local controller: VideoController = new VideoController();
  @Local componentController: ComponentController = new ComponentController();
  @Local speedText: string = "";
  @Local brightText: string = "";
  @Local volumeText: string = "";
  @Local SliderChangeModeNumber: number = SliderChangeMode.Begin;
  @Local SeekTimeNumber: number = 0;
  @Local styleNumber: number = 1;
  @Local scroller: Scroller = new Scroller;
  @Local videoData: IVideoData[] = [
    {
      name: 'video',
      type: 'mp4',
      isLocal: true
    }
  ]

  onBackPress() {
    return this.componentController.onBack()
  }

  build() {
    Column() {
      UIVideo({
        videoData: this.videoData,
        controller: this.controller,
        componentController: this.componentController,
      })
      Scroll(this.scroller) {
        Column() {
          Row() {
            Button('pause')
              .onClick(() => {
                this.controller.pause()
              })
            Button('setLoop')
              .onClick(() => {
                this.controller.setLoop()
              })
            Button('previousVideo')
              .onClick(() => {
                this.controller.previousVideo()
              })
          }.padding({ top: 5 })

          Row() {
            Button('nextVideo')
              .onClick(() => {
                this.controller.nextVideo()
              })
            Button('switchPlayOrPause')
              .onClick(() => {
                this.controller.switchPlayOrPause()
              })
          }.padding({ top: 5 })

          Row() {
            Column() {
              Text("设置播放速度")
              Text("setspeed")
            }

            Text("：")
            TextInput()
              .width(100)
              .height(50)
              .onChange((value: string) => {
                this.speedText = value

              })
              .cancelButton({
                style: CancelButtonStyle.CONSTANT,
                icon: {
                  size: 30,
                  src: $r('app.media.ic_public_expand'),
                  color: Color.Blue
                }
              })
            Button('确定')
              .onClick(() => {
                this.controller.setSpeed(Number(this.speedText))
              }).width(60)

          }.justifyContent(FlexAlign.Start).padding({ top: 5 })

          Row() {
            Column() {
              Text("设置音量")
              Text("setVolume")
            }

            Text("：")
            TextInput()
              .width(100)
              .height(50)
              .onChange((value: string) => {
                this.volumeText = value
              })
              .cancelButton({
                style: CancelButtonStyle.CONSTANT,
                icon: {
                  size: 30,
                  src: $r('app.media.ic_public_expand'),
                  color: Color.Blue
                }
              })
            Button('确定')
              .onClick(() => {
                this.controller.setVolume(Number(this.volumeText))
              }).width(60)

          }.justifyContent(FlexAlign.Start).padding({ top: 5 })

          Row() {
            Column() {
              Text("设置亮度")
              Text("setBright")
            }

            Text("：")
            TextInput()
              .width(100)
              .height(50)
              .onChange((value: string) => {
                this.brightText = value
              })
              .cancelButton({
                style: CancelButtonStyle.CONSTANT,
                icon: {
                  size: 30,
                  src: $r('app.media.ic_public_expand'),
                  color: Color.Blue
                }
              })
            Button('确定')
              .onClick(() => {
                this.controller.setBright(Number(this.brightText))
              }).width(60)

          }.justifyContent(FlexAlign.Start).padding({ top: 5 })
        }
        .height('100%')
        .width('100%')
      }
    }
  }
}
```

## 更新记录

- **1.0.2** (2025-12-15)
- **1.0.0** (2025-09-30) 下载该版本内部资源更新

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

### 隐私政策

不涉及

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.1
- 5.0.2
- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.0.1
- DevEco Studio 5.0.2
- DevEco Studio 5.0.3
- DevEco Studio 5.0.4
- DevEco Studio 5.0.5
- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 安装方式

```bash
ohpm install @hw-agconnect/ui-video
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/572e5e2bce7e40cd91f03bb3bc06292b/2adce9bbd4cb42d58a87e6add45594b3?origin=template