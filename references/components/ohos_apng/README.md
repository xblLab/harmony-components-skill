# APNG 格式动画组件

## 简介

一款适配 OH 的 APNG 格式动画三方应用，调用后 OH 就可支持 APNG 格式图片的编解码。

## 详细介绍

### 简介

ohos_apng 是以开源库 apng-js 为参考，基于 1.1.2 版本，通过重构解码算法，拆分出 apng 里各个帧图层的数据；使用 arkts 能力，将每一帧数据组合成 imagebitmap，使用定时器调用每一帧数据 通过 canvas 渲染，从而达到帧动画效果。对外提供解码渲染能力。

效果图如下：

### 安装

```bash
ohpm install @ohos/apng
```

### 使用说明

#### 1. 上下文对象传入（HSP 模块）

如果是在 HSP 模块中使用，可以使用两种方式传入 Context 上下文对象。

1. 在 EntryAbility 文件引入 `import { GlobalContext } from '@ohos/apng'`，在 onCreate 函数中调用，传入上下文对象，用作后续读取本地的图片资源文件。
   示例：
   ```typescript
   GlobalContext.getContext().setObject('MainContext', this.context);
   ```

2. 在使用组件的时候通过参数传入 Context 对象：
   示例：
   ```typescript
   apngV2({
       src: $r('app.media.stack'),
       speedRate: this.speedRate,
       context: this.getUIContext().getHostContext()
   })
   apng({
       src: $r('app.media.stack'),
       speedRate: this.speedRate,
       context: this.getUIContext().getHostContext()
   })
   ```

#### 2. 引入组件

引入 `import { apng, ApngController } from '@ohos/apng'`。

**示例 1：**
```typescript
apngV2({
    src: $r('app.media.stack'), // 图片资源
    speedRate: 1 // 动画倍速
})
apng({
    src: $r('app.media.stack'), // 图片资源
    speedRate: 1 // 动画倍速
})
```

**示例 2：**
```typescript
apngV2({
    src: 'https://gitcode.com/openharmony-sig/ohos_apng/blob/master/entry/src/main/resources/base/media/stack.png', // 网络资源连接
    speedRate: 1 // 动画倍速
})
apng({
    src: 'https://gitcode.com/openharmony-sig/ohos_apng/blob/master/entry/src/main/resources/base/media/stack.pngg', // 网络资源连接
    speedRate: 1 // 动画倍速
})
```

**示例 3：**
```typescript
apngV2({
    src: this.srcUint8Array, // Uint8Array 对象资源
    speedRate: 1 // 动画倍速
})
apng({
    src: this.srcUint8Array, // Uint8Array 对象资源
    speedRate: 1 // 动画倍速
})
```

**示例 4：**
```typescript
apngV2({
    src: this.getUIContext().getHostContext()?.filesDir + '/stack.png', // 沙箱路径
    speedRate: 1 // 动画倍速
})
apng({
    src: this.getUIContext().getHostContext()?.filesDir + '/stack.png', // 沙箱路径
    speedRate: 1 // 动画倍速
})
```

**示例 5：**
```typescript
apngV2({
    src: $r('app.media.stack'),  // 设置图片资源
    speedRate: this.speedRate, // 设置动画倍速
    apngWidth: 200,  // 设置动图的宽度
    apngHeight: 200  // 设置动图的高度
})
apng({
    src: $r('app.media.stack'),  // 设置图片资源
    speedRate: this.speedRate, // 设置动画倍速
    apngWidth: 200,  // 设置动图的宽度
    apngHeight: 200  // 设置动图的高度
})
```

**示例 6：**
```typescript
controller: ApngController = new ApngController();

apngV2({
    src: $r('app.media.stack'),  // 设置图片资源
    speedRate: this.speedRate, // 设置动画倍速
    apngWidth: 200,  // 设置动图的宽度
    apngHeight: 200  // 设置动图的高度
    controller: this.controller
})
apng({
    src: $r('app.media.stack'),  // 设置图片资源
    speedRate: this.speedRate, // 设置动画倍速
    apngWidth: 200,  // 设置动图的宽度
    apngHeight: 200  // 设置动图的高度
    controller: this.controller
})    

this.controller.pause();
this.controller.stop();
```

**示例 7：**
```typescript
aboutToAppear() {
    emitter.on("ohos-apng", (data) => {
        console.log('data', JSON.stringify(data));
    })
}
```

**示例 8：**
```typescript
apngV2({
    src: $r('app.media.stack'),  // 设置图片资源
    speedRate: this.speedRate, // 设置动画倍速
    apngWidth: 200,  // 设置动图的宽度
    apngHeight: 200,  // 设置动图的高度
    loadingText: this.loadingText  // 加载中提示文字
})
apng({
    src: $r('app.media.stack'),  // 设置图片资源
    speedRate: this.speedRate, // 设置动画倍速
    apngWidth: 200,  // 设置动图的宽度
    apngHeight: 200,  // 设置动图的高度
    loadingText: this.loadingText   // 加载中提示文字
})
```

#### 3. 自定义内存缓存使用

支持自定义内存缓存策略，支持设置内存缓存的大小 (默认 LRU 策略)：

```typescript
Apng.getInstance().initMemoryCache();
```

内存缓存默认关闭，开启/关闭内存缓存：
```typescript
Apng.getInstance().setEnableCache(enableCache: boolean);
```

清空全部内存缓存：
```typescript
Apng.getInstance().removeAllMemoryCache();
```

清空指定内存缓存：
```typescript
Apng.getInstance().removeMemoryCache(src); 
```

自定义内存缓存大小：
```typescript
Apng.getInstance().initMemoryCache(new MemoryLruCache(200, 128 * 1024 * 1024));
```

## 接口说明

| 接口 | 参数及功能说明 |
| :--- | :--- |
| **apng** | `src: Resource/Uint8Array/string, speedRate: number, apngWidth: string/number/Resource, apngHeight: string/number/Resource, context: Context, loadingText: string, numPlays: number, alignItems: HorizontalAlign, justifyContent: FlexAlign`<br>• `src`：图片资源，支持本地资源，网络图片以及 Uint8Array 三种格式<br>• `speedRate`：动画倍速，默认值为 1，取值范围 (0.1~2)<br>• `apngWidth`：图片宽度，默认原图宽度 (支持 vp 及 px 单位，默认 vp)<br>• `apngHeight`：图片高度，默认原图高度 (支持 vp 及 px 单位，默认 vp)<br>• `context`：上下文对象，默认为 null<br>• `numPlays`：循环次数，必须设置 controller，numPlays 才会生效<br>• `alignItems`：子组件在水平方向的对齐格式<br>• `justifyContent`：子组件在垂直方向的对齐格式<br>• `loadingText`：加载提示文本，默认为"加载中"<br>• `apng` 图片展示 (@Component 实现) |
| **apngV2** | `src: Resource/Uint8Array/string, speedRate: number, apngWidth: string/number/Resource, apngHeight: string/number/Resource, context: Context, loadingText: string, numPlays: number, alignItems: HorizontalAlign, justifyContent: FlexAlign`<br>• `src`：图片资源，支持本地资源，网络图片以及 Uint8Array 三种格式<br>• `speedRate`：动画倍速，默认值为 1，取值范围 (0.1~2)<br>• `apngWidth`：图片宽度，默认原图宽度 (支持 vp 及 px 单位，默认 vp)<br>• `apngHeight`：图片高度，默认原图高度 (支持 vp 及 px 单位，默认 vp)<br>• `context`：上下文对象，默认为 null<br>• `numPlays`：循环次数，必须设置 controller，numPlays 才会生效<br>• `alignItems`：子组件在水平方向的对齐格式<br>• `justifyContent`：子组件在垂直方向的对齐格式<br>• `loadingText`：加载提示文本，默认为"加载中"<br>• `apng` 图片展示 (@ComponentV2 实现) |
| **GlobalContext** | `getContext().setObject(key: string, objectClass: Object)`<br>• `key`：上下文对象对应的 key，固定值 "MainContext"<br>• `objectClass`：上下文对象 (this.context)，在 EntryAbility 文件设置上下文对象 |
| **Apng** | `getInstance().setEnableCache(enableCache: boolean)`<br>• `enableCache`：是否开启内存缓存，默认 false。开启或关闭内存缓存。<br><br>`getInstance().removeAllMemoryCache()`<br>• 清空全部内存缓存。<br><br>`getInstance().removeMemoryCache(src?: ResourceStr / Uint8Array)`<br>• `src`：图片资源，支持本地资源，网络图片以及 Uint8Array 三种格式。清除指定图片的内存缓存。<br><br>`getInstance().initMemoryCache(newMemoryCache: IMemoryCache)`<br>• 自定义内存缓存策略，支持设置内存缓存的大小。 |
| **ApngController** | `play()`<br>• Apng 播放控制，播放 Apng 图片，默认开启播放。<br><br>`pause()`<br>• Apng 播放控制，暂停播放 Apng 图片。<br><br>`stop()`<br>• Apng 播放控制，停止播放 Apng 图片。 |

## 关于混淆

代码混淆，请查看代码混淆简介。
如果希望 apng 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 `obfuscation-rules.txt` 中添加相应的排除规则：

```properties
-keep
./oh_modules/@ohos/apng
```

## 约束与限制

在下述版本验证通过：
- DevEco Studio NEXT Developer Beta3: 5.0 (5.0.3.530)
- SDK: API12 (5.0.0.35(SP3))

## 目录结构

```text
|---- apng
|     |---- entry # 示例代码文件夹
|     |---- library # apng 库文件夹
|           |---- src
|                 |---- main
|                       |---- ets
|                             |---- components
|                                   |---- apng.ets # 处理 apng 拆解后的每一帧，每一帧通过 canvas 绘制成 apng,apng 的@Component 版本
|                                   |---- apngV2.ets # 处理 apng 拆解后的每一帧，每一帧通过 canvas 绘制成 apng,apng 的@ComponentV2 版本
|                                   |---- crc32.ets # 用作数据传输和存储中的错误检测
|                                   |---- GlobalContext.ets # 创建了一个全局类，用来获取数据对象或者设置对象的值
|                                   |---- manager.ets # 读取本地 apng 文件，获取到文件 buffer 对象
|                                   |---- parser.ets # 对 buffer 对象进行拆解
|                                   |---- structs.ets # 创建了两个类，APNG 类指的是整个 APNG 动画，包括宽度、高度、播放次数、播放时间和帧列表等属性，Frame 类指的是 APNG 动画中的每一帧
|                             |---- utils # 工具类相关
|                             |---- Apng.ets  # Apng 门面，app 持久化类
|                             |---- ApngDispatcher.ets # Apng 图片请求排队分发处理类
|                             |---- ApngRequest.ets # Apng 图片请求参数封装
|     |---- README_zh.MD # 安装使用方法
```

## 开源协议

本项目基于 MIT，请自由地享受和参与开源。

## 更新记录

### 1.1.3

- Fix compilation warning issues.

### 1.1.2

- Released version 1.1.2.

### 1.1.2-rc.8

- Support the function of centering animation display.

### 1.1.2-rc.7

- Optimize the code by replacing deprecated interfaces with the latest and standardized ones.
- Support static image loading and display.

### 1.1.2-rc.6

- Fixed the issue where animations did not automatically stop playing in certain invisible scenes.

### 1.1.2-rc.5

- Modified the compilation and build warning prompt.
- Add confusion instructions to the document.

### 1.1.2-rc.4

- fix: Fixed the issue where the parent component node was hidden while the child component canvas node was visible, causing the animation to still play.
- fix: Fixed the issue where animations are automatically destroyed when their state is not visible in a specific scene.
- Support custom loading prompt text.
- fix: Fixed the issue that the loop playback time is taken from the first frame, which causes the delay time of the first frame to be inconsistent with other frames and the playback is too slow.
- fix: Fixed the issue that animations could not be played according to the specified playNum when the animations were played indefinitely

### 1.1.2-rc.3

- Code refactoring when APNG animation is not visible
- Fixed the issue of abnormal display of some dynamic images during the initialization loading phase when APNG lazily loads multiple dynamic images from small to large
- Log modification

### 1.1.2-rc.2

- Provides the @Component version of apng

### 1.1.2-rc.1

- canvas listening event trigger location replacement.

### 1.1.2-rc.0

- When the APNG animation is not visible, the APNG automatically stops playing the animation to reduce power consumption.
- Fixed a bug where a single APNG component created multiple setInterval timers in the initialization scenario.

### 1.1.1

- Added functions such as control play, including start play, pause play, and stop play
- Add listening events, including play, pause, and stop events
- Modify the problem that apng listening events cannot distinguish images and add a frame listening event
- Modify LogUtils to record logs

### 1.1.0

- V2 decorator adaptation

### 1.0.0-rc.9

- Add the ApngController to add the playback control function of the Apng

### 1.0.0-rc.8

- Add a custom memory caching mechanism to optimize network image download performance

### 1.0.0-rc.7

- Modify the problem that the memory keeps growing when a single image is loaded

### 1.0.0-rc.6

- Optimize the page stalling problem when multiple apng images are loaded

### 1.0.0-rc.5

- Modify the problem that UI does not refresh automatically when src resources change

### 1.0.0-rc.4

- Added the width-height function for apng images
- context Context incoming mode optimization

### 1.0.0-rc.3

- Rectify the problem that the HSP module cannot obtain the resource file

### 1.0.0-rc.2

- Added support for pictures in the sandbox path

### 1.0.0-rc.1

- When apng is implemented with canvas, some residual shadows and graphics are missing
- The double speed does not take effect
- Added the apng support for network images
- Modify the component memory usage problem

### 1.0.0-rc.0

- The third library implements APNG format image loading and display, and supports format image encoding and decoding

## 权限与隐私

| 基本信息 | 详情 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 版本/类型 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/apng
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/36b48848e765401aa48074a99ad9bfa5/PLATFORM?origin=template