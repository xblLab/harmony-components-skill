# ccplayer ijk 网络媒体基础播放组件

## 简介

网络媒体基础播放组件。

## 详细介绍

### 简介

ccplayer-ijk 是基于官方 @ohos/ijkplayer 进行二次开发，为 CcPlayer 服务的一个扩展插件，需要结合 CcPlayer 使用。

支持网络媒体基础播放能力（当前版本仅支持视频，不支持音频）。

### 依赖方式

1. 先安装 ccplayer
   ```bash
   ohpm install @seagazer/ccplayer
   ```

2. 安装 ccplayer-ijk 插件
   ```bash
   ohpm install @seagazer/ccplayer-ijk
   ```

### 注意事项

- 插件基于 @ohos/ijkplayer 2.0.6 版本，无法独立使用，需结合 @seagazer/ccplayer 1.2.6 及以上版本使用，具体使用说明参考 @seagazer/ccplayer。
- 播放前需要申请网络权限。

### 接口能力

**IjkPlayer IJK 播放插件**

### 接口参数返回值说明

| 方法名 | 返回类型 | 参数 | 描述 |
| :--- | :--- | :--- | :--- |
| `construct` | `void` | `IjkPlayer` | 创建 IjkPlayer 插件实例 |
| `getLibrary` | `void` | `string` | Native so 名称 |
| `getXComponentId` | `void` | `string` | XComponent 绑定的 Id |
| `setOption` | `void` | `category: string, key: string, value: string` | 设置 ijk 参数 |

### 场景示例

#### 使用 CcPlayerView 可以无感切换至 IjkPlayer 内核：

```typescript
@Entry
@Component
struct IjkSample {
   // 1.实例化 CcPlayer
   private player: CcPlayer = new CcPlayer(getContext(this))

   aboutToAppear(): void {
       // 2.设置插件
       const ijkPlayer = new IjkPlayer()
       this.player.setPlayer(ijkPlayer)
   }

   build() {
       Column() {
           RelativeContainer() {
               // 3.正常使用 CcPlayerView
               CcPlayerViewV2({
                   player: this.player,
                   asRatio: this.ratio,
                   renderType: XComponentType.SURFACE,
                   onSurfaceCreated: () => {
                       this.playIndex = 0
                       let src = MediaSourceFactory.createUrl("", "https://xx.mp4")
                       this.player.setMediaSource(src, () => {
                           this.player.start()
                       })
                   }
               })
           }
           .width("100%")
           .height("100%")
       }
   }
}
```

#### 使用 CcPlayer 结合 IjkPlayer 插件，使用原生组件进行视频播放：

```typescript
@Entry
@Component
struct IjkSample {
    // 1.实例化 CcPlayer
   private player: CcPlayer = new CcPlayer(getContext(this))
   // 2.实例化 controller
   private controller = new XComponentController()

   aboutToAppear(): void {
       // 3.设置插件
       const ijkPlayer = new IjkPlayer()
       this.player.setPlayer(ijkPlayer)
   }

   build() {
       Column() {
           Stack() {
               XComponent({
                   controller: this.controller,
                   type: XComponentType.SURFACE,
                   id: IjkPlayer.getXComponentId(), //需要绑定插件的 id
                   libraryname: IjkPlayer.getLibrary(), //需要绑定插件的 so 名
               }).onLoad((context) => {
                   Logger.d(TAG, "onLoad= " + context)
                   if (context) {
                       // 4.绑定 surface
                       this.player.bindXComponent(this.controller, context)
                   }
               })  
           }
           .width(400)
           .height(300)
           .clip(true)

           // play actions
           Button("play")
               .onClick(() => {
                   this.play()
               })
       }
       .width("100%")
       .height("100%")
       .justifyContent(FlexAlign.Center)
   }

   private async play() {
       // 5.创建 mediaSource
       const source = MediaSourceFactory.createUrl("", "https:xxx.mp4")
       // 6.设置 source
       this.player.setMediaSource(source)
       // 7.开始播放
       this.player.start()
   }

   aboutToDisappear() {
       // 8.释放资源
       this.player.release()
   }
}
```

## 更新记录

- **1.0.4**
  - 默认开启倍速播放能力，setPlaySpeed 前无需再主动配置
- **1.0.3**
  - 新增 setPlaySpeed 接口实现
  - 修复 MediaSource 请求头未设置问题
- **1.0.2**
  - 修复 START 状态二次失效问题
- **1.0.1**
  - 新增 setOption 参数配置接口
- **1.0.0**
  - 初始版本 (基于 @ohos/ijkplayer 2.0.6 版本)
  - 支持网络视频基础播放能力
  - 需结合 @seagazer/ccplayer 使用

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| **权限名称** | 暂无 |
| **权限说明** | 暂无 |
| **使用目的** | 暂无 |
| **隐私政策** | 不涉及 |
| **SDK 合规使用指南** | 不涉及 |
| **兼容性 HarmonyOS 版本** | 5.0.2 |
| **应用类型** | 应用 |
| **元服务** | - |
| **设备类型** | 手机、平板、PC |
| **DevEcoStudio 版本** | DevEco Studio 5.0.2 |

## 安装方式

```bash
ohpm install @seagazer/ccplayer-ijk
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/763125be060a4778bf4e605520c4b71f/PLATFORM?origin=template