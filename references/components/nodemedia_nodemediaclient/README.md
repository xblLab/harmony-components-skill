# NodePlayer 低延迟直播播放组件

## 简介

低延迟直播播放组件。

## 详细介绍

### 简介

NodePlayer 组件
OpenHarmony_5.0 / HarmonyOS_NEXT 平台的低延迟直播播放组件

### 特性

- 支持 RTSP,RTMP(S),HTTP(S)_FLV,HLS,KMP,UDP_MPEGTS 等协议。
- 支持 H.264/H.265 视频硬件解码渲染
- 支持 AAC/G.711 音频解码播放
- 毫秒级低延迟

### 延迟消除

### 安装依赖

使用 DevEco 打开项目后，点击下方 Terminal，输入命令安装依赖

```bash
ohpm install @nodemedia/nodemediaclient
```

### 引用播放组件

```typescript
import { router } from '@kit.ArkUI';
import { NodePlayer, NodePlayerController } from '@nodemedia/nodemediaclient';

@Entry
@Component
struct VideoViewPage {
  @State src: string = 'rtmp://192.168.0.2/live/bbb';
  // @State src: string = 'https://192.168.0.2:8443/live/bbb.flv';
  // @State src: string = 'rtsp://admin:admin@192.168.0.11:554/Streaming/channels/101';
  @State volume: number = 1.0;
  @State muted: boolean = false;
  @State bufferTime: number = 1000;
  @State scaleMode: number = 0;
  private license: string = '';
  private controller: NodePlayerController = new NodePlayerController();

  build() {
    Column() {
      Button("Back").onClick(() => {
        router.back()
      })
      NodePlayer({
        license: this.license,
        src: this.src,
        scaleMode: this.scaleMode,
        bufferTime: this.bufferTime,
        controller: this.controller,
        muted: this.muted,
        volume: this.volume,
        autoplay: true,
        onEvent: (code: number, msg: string) => {
          console.info('NodePlayer on event, code:' + code, 'message:' + msg);
        }
      })
        .width('100%')
        .height('40%')
        .margin({ bottom: '10' })
      TextInput({ text: this.src })
        .onChange((v) => {
          this.src = v;
        })
        .margin({ bottom: '10' })
      Row() {
        Text("Muted")
        Toggle({ type: ToggleType.Switch, isOn: this.muted }).onChange((v) => {
          this.muted = v;
        })
      }

      Row() {
        Text("Volume")
        Slider({
          max: 1.0,
          min: 0.0,
          step: 0.1,
          value: this.volume
        }).onChange((v, mode) => {
          this.volume = v;
          this.muted = false;
        }).width('60%')
        Text(this.volume.toString().slice(0, 3))
      }.margin(10)

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Text("ScaleMode")
        Column() {
          Text('0')
          Radio({ value: 'Radio1', group: 'radioGroup' }).checked(this.scaleMode == 0)
            .height(30)
            .width(30)
            .onChange((isChecked: boolean) => {
              this.scaleMode = 0;
            })
        }

        Column() {
          Text('1')
          Radio({ value: 'Radio2', group: 'radioGroup' }).checked(this.scaleMode == 1)
            .height(30)
            .width(30)
            .onChange((isChecked: boolean) => {
              this.scaleMode = 1;
            })
        }

        Column() {
          Text('2')
          Radio({ value: 'Radio3', group: 'radioGroup' }).checked(this.scaleMode == 2)
            .height(30)
            .width(30)
            .onChange((isChecked: boolean) => {
              this.scaleMode = 2;
            })
        }
      }.margin({ bottom: '10' })

      Row() {
        Button("开始播放")
          .onClick(() => {
            this.controller.start()
          })
        Button("停止播放")
          .onClick(() => {
            this.controller.stop()
          })
        Button("暂停播放")
          .onClick(() => {
            this.controller.pause()
          })
      }
    }
    .padding('10')
  }
}
```

### 申请网络权限

```json
{
  "requestPermissions": [
    {
      "name": "ohos.permission.INTERNET"
    }
  ]
}
```

### NodePublisher 组件 (待实现)

OpenHarmony_5.0 / HarmonyOS_NEXT 平台的低延迟直播推流组件

### 更新记录

#### [1.0.13] 2026-01-16

新增 api 可设置 rtsp 的传输协议，默认 udp，可设置为 tcp

#### [1.0.11] 2025-12-07

增加 x86_64 架构的 so

#### [1.0.10] 2025-11-29

优化播放缓存

#### [1.0.9] 2025-10-21

新增硬件解码加速开关

#### [1.0.8] 2025-07-11

start() 播放方法可以传流地址作为主动设置 src 的情况下使用

#### [1.0.7] 2025-04-02

提升程序稳定性

#### [1.0.6] 2025-03-31

规范变量定义
提升程序稳定性

#### [1.0.4] 2025-03-13

rebuild

#### [1.0.3] 2024-11-25

完善事件回调

#### [1.0.2] 2024-11-19

增加 referer 属性参数
增加 ua 属性参数
增加 cryptoKey 属性参数
增加 autoplay 属性参数
muted,volume,scaleMode,bufferTime 参数可通过@State 修饰，在播放过程中实时修改

#### [1.0.1] 2024-11-14

增加 pause 控制

#### [1.0.0] 2024-11-13

初版发布

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限与隐私基本信息 | 权限名称 权限说明 使用目的 暂无暂无暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 Created with Pixso. |
| 元服务 |  Created with Pixso. |
| 设备类型 | 手机 Created with Pixso. |
| 平板 |  Created with Pixso. |
| PC |  Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 Created with Pixso. |

## 安装方式

```bash
ohpm install @nodemedia/nodemediaclient
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/f409657f1f964305b098b12d7f6aeb06/PLATFORM?origin=template