# hadss/adaptive_video 上下滑动切换视频组件

## 简介

Adaptive ArkUI support for video scenarios: immersive mode、rotation、higher-order components.

## 详细介绍

### 简介

为视频播放场景提供自适应 ArkUI 框架，包括：

1.  **自适应视频沉浸式**：用于布局视频页面沉浸式体验，针对不同尺寸的窗口和不同尺寸的视频，本框架会为视频的非全屏页面提供沉浸建议。
2.  **自适应视频旋转**：用于布局视频页面旋转体验，针对不同尺寸的窗口和不同尺寸的视频，本框架会自动设置视频的旋转属性，并提供布局变化的监听。
3.  **视频自适应沉浸高阶组件**：用于极简开发短视频滑动页面，并自动提供沉浸式效果。

### 预览

### 工程目录

```text
├── adaptive_video   // adaptive_video 库
│   ├── Index.ets      // 接口声明文档
│   ├── src
│   │   └── main
│   │       └── ets
│   │           ├── video  // 视频自适应沉浸高阶组件
│   │           │   ├── api // 沉浸式
│   │           │   │   ├── AdaptiveVideoController.ets  // 视频控制器
│   │           │   │   └── AdaptiveVideoListener.ets  // 视频监听器
│   │           │   ├── common // 沉浸式
│   │           │   │   └── CommonConstants.ets  // 常量
│   │           │   ├── components // 组件
│   │           │   │   ├── AdaptiveVideoComponent.ets  // 视频自适应沉浸高阶组件
│   │           │   │   └── ProgressBar.ets  // 进度条
│   │           │   ├── player // 播放器
│   │           │   │   ├── AdaptiveVideoPlayer.ets  // 播放器类
│   │           │   │   ├── AVPlayerCallbackManager.ets  // 播放器回调管理类
│   │           │   │   ├── AVPlayerManager.ets  // 播放器会话管理类
│   │           │   │   ├── AVPlayerSession.ets  // 播放器会话
│   │           │   │   └── AVPlayerState.ets  // 播放器状态枚举类
│   │           │   └── utils
│   │           │       ├── TimeUtil.ets   // 时间工具类
│   │           │       └── LayoutUtil.ets   // 布局工具类
│   │           ├── immersion // 沉浸式
│   │           │   ├── api     // 对外接口
│   │           │   │   └── AdaptiveImmersion.ets  // 自适应沉浸单例类
│   │           │   ├── common
│   │           │   │   └── ImmersionConstants.ets  // 常量
│   │           │   └── rule
│   │           │       ├── ImmersionManager.ets   // 沉浸式管理类
│   │           │       └── ImmersionRules.ets  // 沉浸规则
│   │           └── rotation // 旋转
│   │               ├── api     // 对外接口
│   │               │   ├── AdaptiveRotation.ets  // 自适应旋转单例类
│   │               │   └── ScreenModeNotifier.ets  // 屏幕模式通知器
│   │               ├── common
│   │               │   └── ImmersionConstants.ets  // 常量
│   │               ├── rule
│   │               │   ├── BreakPoint.ets  // 断点规则
│   │               │   └── RotationRuleSet.ets  // 旋转规则
│   │               └── utils
│   │                   ├── DisplayUtil.ets  // 布局工具
│   │                   ├── WindowUtil.ets  // 窗口工具
│   │                   └── SensorUtil.ets  // 传感器工具
│   └── README.md      // 使用方法
```

### 下载安装

说明：  
```bash
ohpm install @hadss/adaptive_video
```

## 自适应沉浸/旋转规则说明

### 沉浸规则

#### 自适应沉浸式规则

适用于视频滑动播放页面，为用户提供沉浸式视频播放效果。

*   沉浸状态下视频播放组件的尺寸大小、窗口位置及沉浸建议基于当前应用窗口大小计算，因此使用沉浸建议的视频播放组件需要与其他组件进行合理的布局适配。
*   沉浸规则适用于所有宽高比的视频，特别对 9:16 区间 (9:16.1 ~ 9:15.9) 的视频做了特殊的自适应与裁剪处理。
*   沉浸规则适用于窗口宽大于 320vp 的设备。

#### 具体沉浸式规则

| 序号 | 视频宽高比 r | 窗口宽高比 x | 窗口宽 w (vp) | 沉浸规则描述 |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 9:16.1 <= r < 9:15.9 | x < 9:20 | 320 <= w < 600 | 窗口高度减去底部导航栏高度，状态栏高度后，等比例缩放视频至视频可视区域宽高比为 9:17.8，并居中显示在剩余区域，左右超出窗口部分自适应裁剪;状态栏、底部 tab 都不沉浸 |
| 2 | 9:16.1 <= r < 9:15.9 | 9:20 <= x < 9:18 | 320 <= w < 600 | 窗口高度减去底部导航栏高度后，视频内容自适应缩放至剩余区域高撑满，左右超出部分自适应裁剪;状态栏沉浸、底部 tab 不沉浸 |
| 3 | 9:16.1 <= r < 9:15.9 | 9:18 <= x < 9:14.4 | 320 <= w < 600 | 1、9:18 <= x < r：视频自适应缩放至窗口高撑满，左右超出窗口部分自适应裁剪；2、r < x < 9:14.4：视频自适应缩放至将窗口宽撑满，上下超出窗口部分自适应裁剪; 状态栏和底部 tab 都沉浸 |
| 4 | 9:16.1 <= r < 9:15.9 | 9:14.4 <= x < 9:10.8 | 320 <= w < 600 | 视频将窗口高撑满，视频宽自适应等比例缩放状态栏和底部 tab 都沉浸 |
| 5 | 9:16.1 <= r < 9:15.9 | x <= 9:10.8 | 600 <= w | 视频将窗口高撑满，视频宽自适应等比例缩放状态栏和底部 tab 都沉浸 |
| 6 | 9:16.1 <= r < 9:15.9 | 9:10.8 <= x | 320 <= w | 视频将窗口高撑满，视频宽自适应等比例缩放状态栏和底部 tab 都沉浸 |
| 7 | r >= 9:15.9 或 r < 9:16.1(即非 9:16 区间的视频) | x < 9:20 | 320 <= w | 窗口高度减去底部导航栏高度，状态栏高度后，视频自适应放大至撑满剩余区域状态栏、底部 tab 都不沉浸 |
| 8 | r >= 9:15.9 或 r < 9:16.1(即非 9:16 区间的视频) | 9:18 <= x < 9:20 | 320 <= w | 窗口高度减去底部导航栏高度、后，视频自适应放大至撑满剩余区域 状态栏沉浸、底部 tab 不沉浸 |
| 9 | r >= 9:15.9 或 r < 9:16.1(即非 9:16 区间的视频) | x < 9:18 | 320 <= w | 视频自适应放大至撑满剩余区域状态栏沉浸、底部 tab 根据视频区域大小决定是否沉浸 |

### 旋转规则

#### 自适应旋转规则

适用于视频滑动播放页面、视频全屏播放页面，可自动设置全屏、非全屏页面下的窗口旋转属性。

*   `AdaptiveRotation`、`ScreenModeNotifier` 为单例类，使用前需要使用 init 方法初始化，否则会报错。
*   本框架接口在被调用时将会根据传入的视频宽高自动判定视频类型：**横屏视频 (宽>高)、竖屏视频 (宽<=高)**。
*   视频页面的旋转属性基于视频所在窗口的屏幕类型 (根据断点区间判定)、视频类型 (横向视频、竖向视频)、屏幕方向 (重力判定) 综合判定。
*   使用时可选择是否自动监听可折叠设备的形态变化，如选择监听，可自动适配可折叠设备在播放视频时设备形态改变后的旋转属性。
*   2in1、PC、TV、车机暂定不支持旋转。

#### 具体规则如下

##### 断点区间图

依据断点区间判定屏幕类型

| 序号 | 横向断点 | 纵向断点 | 屏幕类型 |
| :--- | :--- | :--- | :--- |
| 1 | 0(XSmall) | 0(Small) | XSmall_Landscape |
| 2 | 0(XSmall) | 1(Medium) | XSmall_Square |
| 3 | 0(XSmall) | 2(Large) | XSmall_Portrait |
| 4 | 1(Small) | 0(Small) | Small_Landscape |
| 5 | 1(Small) | 1(Medium) | Small_Square |
| 6 | 1(Small) | 2(Large) | Small_Portrait |
| 7 | 2(Medium) | 0(Small) | Medium_Landscape |
| 8 | 2(Medium) | 1(Medium) | Medium_Square |
| 9 | 2(Medium) | 2(Large) | Medium_Portrait |
| 10 | 3(Large) | 0(Small) | Large_Landscape |
| 11 | 3(Large) | 1(Medium) | Large_Square |
| 12 | 3(Large) | 2(Large) | Large_Portrait |
| 13 | 4(XLarge) | 0(Small) | XLarge_Landscape |
| 14 | 4(XLarge) | 1(Medium) | XLarge_Square |
| 15 | 4(XLarge) | 2(Large) | XLarge_Portrait |

##### 依据屏幕类型、视频类型、屏幕方向判定旋转属性

屏幕方向 (0 - 竖屏，1 - 反向横屏，2 - 反向竖屏，3 - 横屏)

| 序号 | 屏幕类型 | 视频类型 | 进入全屏/退出全屏 | 旋转属性 (视频方向：属性) | 旋转属性描述 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Small_Portrait, Medium_Landscape | 横向视频 | 进入全屏 (横屏) | 0:window.Orientation.USER_ROTATION_LANDSCAPE, 1:window.Orientation.USER_ROTATION_LANDSCAPE_INVERTED, 2:window.Orientation.USER_ROTATION_LANDSCAPE, 3:window.Orientation.USER_ROTATION_LANDSCAPE | USER_ROTATION_LANDSCAPE: 调用时临时旋转到横屏，之后跟随传感器自动旋转，受控制中心的旋转开关控制，且可旋转方向受系统判定 (如在某种设备，可以旋转到竖屏、横屏、反向横屏三个方向，无法旋转到反向竖屏)。USER_ROTATION_LANDSCAPE_INVERTED: 调用时临时旋转到反向横屏，之后跟随传感器自动旋转，受控制中心的旋转开关控制，且可旋转方向受系统判定 (如在某种设备，可以旋转到竖屏、横屏、反向横屏三个方向，无法旋转到反向竖屏)。 |
| 2 | Small_Portrait, Medium_Landscape, Small_Square | 竖向视频 | 进入全屏 (竖屏) | 0:window.Orientation.PORTRAIT, 1:window.Orientation.PORTRAIT, 2:window.Orientation.PORTRAIT, 3:window.Orientation.PORTRAIT | PORTRAIT: 表示竖屏显示模式。 |
| 3 | Small_Portrait, Medium_Landscape | 横向视频 | 非全屏 | 0:window.Orientation.USER_ROTATION_PORTRAIT, 1:window.Orientation.USER_ROTATION_PORTRAIT, 2:window.Orientation.USER_ROTATION_PORTRAIT, 3:window.Orientation.USER_ROTATION_PORTRAIT | USER_ROTATION_PORTRAIT:调用时临时旋转到竖屏，之后跟随传感器自动旋转，受控制中心的旋转开关控制，且可旋转方向受系统判定 (如在某种设备，可以旋转到竖屏、横屏、反向横屏三个方向，无法旋转到反向竖屏)。 |
| 4 | Small_Portrait, Medium_Landscape, Small_Square | 竖向视频 | 非全屏 | 0:window.Orientation.PORTRAIT, 1:window.Orientation.PORTRAIT, 2:window.Orientation.PORTRAIT, 3:window.Orientation.PORTRAIT | PORTRAIT: 表示竖屏显示模式。 |
| 5 | Small_Square | 横向视频 | 非全屏 | 0:window.Orientation.PORTRAIT, 1:window.Orientation.PORTRAIT, 2:window.Orientation.PORTRAIT, 3:window.Orientation.PORTRAIT | PORTRAIT: 表示竖屏显示模式。 |
| 6 | Small_Square | 横向视频 | 全屏 | 0:window.Orientation.PORTRAIT, 1:window.Orientation.PORTRAIT, 2:window.Orientation.PORTRAIT, 3:window.Orientation.PORTRAIT | PORTRAIT: 表示竖屏显示模式。 |
| 7 | Medium_Portrait, Medium_Square, Large_Portrait, Large_Landscape, Large_Square, XLarge_Landscape | 横向视频 | 进入全屏 (横屏) | 0:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 1:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 2:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 3:window.Orientation.AUTO_ROTATION_UNSPECIFIED | AUTO_ROTATION_UNSPECIFIED :跟随传感器自动旋转，受控制中心的旋转开关控制，且可旋转方向受系统判定 (如在某种设备，可以旋转到竖屏、横屏、反向横屏三个方向，无法旋转到反向竖屏)。 |
| 8 | Medium_Portrait, Medium_Square, Large_Portrait, Large_Landscape, Large_Square, XLarge_Landscape | 竖向视频 | 进入全屏 (竖屏) | 0:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 1:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 2:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 3:window.Orientation.AUTO_ROTATION_UNSPECIFIED | AUTO_ROTATION_UNSPECIFIED :跟随传感器自动旋转，受控制中心的旋转开关控制，且可旋转方向受系统判定 (如在某种设备，可以旋转到竖屏、横屏、反向横屏三个方向，无法旋转到反向竖屏)。 |
| 9 | Medium_Portrait, Medium_Square, Large_Portrait, Large_Landscape, Large_Square, XLarge_Landscape | 横向视频 | 非全屏 | 0:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 1:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 2:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 3:window.Orientation.AUTO_ROTATION_UNSPECIFIED | AUTO_ROTATION_UNSPECIFIED :跟随传感器自动旋转，受控制中心的旋转开关控制，且可旋转方向受系统判定 (如在某种设备，可以旋转到竖屏、横屏、反向横屏三个方向，无法旋转到反向竖屏)。 |
| 10 | Medium_Portrait, Medium_Square, Large_Portrait, Large_Landscape, Large_Square, XLarge_Landscape | 竖向视频 | 非全屏 | 0:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 1:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 2:window.Orientation.AUTO_ROTATION_UNSPECIFIED, 3:window.Orientation.AUTO_ROTATION_UNSPECIFIED | AUTO_ROTATION_UNSPECIFIED :跟随传感器自动旋转，受控制中心的旋转开关控制，且可旋转方向受系统判定 (如在某种设备，可以旋转到竖屏、横屏、反向横屏三个方向，无法旋转到反向竖屏)。 |

如设备不在上述断点区间，则旋转属性默认为：`window.Orientation.UNSPECIFIED`。窗口旋转属性详情可见：https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-window-V5#orientation9

## 使用说明

### 自适应沉浸

```arkts
import { AdaptiveImmersion, ImmersionInfo } from '@hadss/adaptive_video';
import { common } from '@kit.AbilityKit';

// 方式一：使用 context 初始化，使用视频宽高和底部 tab 栏高度获取沉浸信息
// 获取 UIAbilityContext
const context = getContext() as common.UIAbilityContext;

// 获取单例对象并初始化
const adaptiveImmersion = AdaptiveImmersion.getInstance();
adaptiveImmersion.init(context);

// ...
// 非全屏获取沉浸信息 - 进入视频播放页面时调用或退出全屏时调用
const immersionInfo: ImmersionInfo = adaptiveImmersion.getImmersionInfo(
  videoSize, bottomTabHeight
);

// 方式二：使用 AdaptiveImmersion 直接获取沉浸信息
const immersionInfo: ImmersionInfo = AdaptiveImmersion.getImmersionInfo(
  videoSize, windowSize, statusBarHeight, bottomTabHeight
);

// 设置播放组件的宽高
this.videoComponentWidth = immersionInfo.videoSize.width;
this.videoComponentHeight = immersionInfo.videoSize.height;

// 设置播放组件的布局位置
this.videoPosition = immersion.position;

// 设置状态栏沉浸时逻辑
if (immersionInfo.immersionSetting.isStatusBarImmersive) {
  // 状态栏沉浸时逻辑
  // ...
}
// 设置下 tab 栏沉浸时逻辑
if (immersionInfo.immersionSetting.isBottomTabImmersive) {
  // 下 tab 栏沉浸时逻辑
  // ...
}

// ...
// 视频播放组件 (以 XComponent 作为渲染组件为例)
XComponent({
  id: 'player',
  type: XComponentType.SURFACE,
  controller: this.xComponentController
})
  .position(this.videoPosition)
  .width(this.videoComponentWidth)
  .height(this.videoComponentHeight)
// ...
```

### 自适应旋转

```arkts
import { AdaptiveRotation, ScreenModeNotifier, ScreenMode } from '@hadss/adaptive_video';
import { common } from '@kit.AbilityKit';

// 获取 UIAbilityContext
const context = getContext() as common.UIAbilityContext;

// 获取单例对象并初始化
const adaptiveRotation = AdaptiveRotation.getInstance();
adaptiveRotation.init(context);
const screenModeNotifier = ScreenModeNotifier.getInstance();
screenModeNotifier.init(context);

// ...
// 非全屏设置旋转属性 - 进入视频播放页面时调用或退出全屏时调用
adaptiveRotation.setOrientationNotFullScreen({
  width: this.videoWidth,
  height: this.videoHeight
});

// ...
// 全屏设置旋转属性 - 进入全屏时调用
adaptiveRotation.setOrientationFullScreen({
  width: this.videoWidth,
  height: this.videoHeight
});

// ... 
// 重置窗口旋转属性 - 退出视频播放页时调用
adaptiveRotation.reset();

// ...
// 使用布局切换通知器
const callback = (data: ScreenMode) => {
  if (data === ScreenMode.FULL_SCREEN) {
    // 当非全屏进入到全屏时的 ui 布局切换逻辑 (如在直板机上，横向视频进入全屏播放时)
    // ...
  } else {
    // 当全屏退出到非全屏时的 ui 布局切换逻辑 (如在直板机上，横向视频退出全屏时)
    // ...
  }
}

// ...
// 注册屏幕模式监听器
screenModeNotifier.onScreenModeChange(callback);

// ...
// 注销屏幕模式监听器
screenModeNotifier.offScreenModeChange(callback);

// ...
// 销毁监听 - 离开视频播放页面时调用
screenModeNotifier.destroy();
```

### 视频自适应沉浸高阶组件

#### 短视频滑动场景使用 AdaptiveVideoComponent

```arkts
import { AdaptiveVideoController, AdaptiveVideoComponent, ProgressBar, ViewMode } from '@hadss/adaptive_video';
import { ImmersionInfo } from '@hadss/adaptive_video';

// ...
@Component
struct ShortVideoView{
  // ...
  private context = getContext() as common.UIAbilityContext;
  private swiperController: SwiperController = new SwiperController();
  // 实例化一个 adaptiveVideoController 对象，用于控制当前播放视频播放/暂停等行为。
  private adaptiveVideoController?: AdaptiveVideoController = new AdaptiveVideoController(this.context);
  // 实例化 adaptiveVideoListener 对象，用于监听视频状态/事件。
  private adaptiveVideoListener?: AdaptiveVideoListener = new AdaptiveVideoListener();
  // 数据源
  private avDataSource = new AVDataSource(Const.VIDEO_SOURCE);
  // 当前正在播放的视频的 index
  @State curIndex: number = 0;
  // 状态栏沉浸状态
  @State isStatusBarImmersive: boolean = false;
  // 短视频页面底部 tab 沉浸状态
  @State isBottomTabImmersive: boolean = false;
  // 当前进度条是否滑动
  @State isSliderMoving: boolean = false;

  // ...
  build(){
    Column(){
      Stack(){
        Swiper(this.swiperController){
          LazyForEach(this.avDataSource, (item: media.AVFileDescriptor | string, index: number) => {
            AdaptiveVideoComponent({
              dataSource: item,
              adaptiveVideoController: this.adaptiveVideoController,
              adaptiveVideoListener: this.adaptiveVideoListener,
              isAutoPlay: true,
              isLoop: true,
              viewMode: ViewMode.SWIPER,
              curIndex: this.curIndex,
              index: index,
              bottomTabHeight: 56,
            })
          }, (item: media.AVFileDescriptor | string, index: number) => JSON.stringify(item) + index)
        }
        .cachedCount(2)
        //...
        Row()
        {
          ProgressBar({
            isSliderMoving: this.isSliderMoving,
            adaptiveVideoListener: this.adaptiveVideoListener
          })
        }
      }
    }
  }

  // ...
  // 在页面隐藏时暂停视频
  onPageHide(): void {
    this.adaptiveVideoController?.pause();
  }

  // 在页面显示时播放视频
  onPageShow(): void {
    this.adaptiveVideoController?.play();
  }
}
```

#### 长视频场景使用 AdaptiveVideoComponent(以当前窗口全屏显示视频，非沉浸式)

```arkts
import { AdaptiveVideoController, AdaptiveVideoComponent, ProgressBar, ViewMode } from '@hadss/adaptive_video';
import { media } from '@kit.MediaKit';

// ...
@Component 
struct LongVideoView{
  // ...
  private context = getContext() as common.UIAbilityContext;
  // 实例化一个 adaptiveVideoController 对象，用于控制当前播放视频播放/暂停等行为。
  private adaptiveVideoController?: AdaptiveVideoController = new AdaptiveVideoController(this.context);
  // 实例化 adaptiveVideoListener 对象，用于监听视频状态/事件。
  private adaptiveVideoListener?: AdaptiveVideoListener = new AdaptiveVideoListener();
  // 数据源
  private avDataSource: media.AVFileDescriptor | string = '';
  // 当前进度条是否滑动
  @State isSliderMoving: boolean = false;

  build(){
    Column(){
      Stack(){
        AdaptiveVideoComponent({
          dataSource: this.avDataSource,
          adaptiveVideoController: this.adaptiveVideoController,
          adaptiveVideoListener: this.adaptiveVideoListener,
          isAutoPlay: true,
          isLoop: true,
          viewMode: ViewMode.FullScreen,
        })
        //...
        Row()
        {
          ProgressBar({
            isSliderMoving: this.isSliderMoving,
            adaptiveVideoListener: this.adaptiveVideoListener
          })
        }
      }
    }
  }

  // ...
  // 在页面隐藏时暂停视频
  onPageHide(): void {
    this.adaptiveVideoController?.pause();
  }

  // 在页面显示时播放视频
  onPageShow(): void {
    this.adaptiveVideoController?.play();
  }
}
```

## 相关权限

如需播放网络视频，需要依赖以下权限：

*   ohos.permission.INTERNET

## 约束与限制

在下述版本验证通过：DevEco Studio 5.0.1 Beta3(5.0.5.200) --SDK:API13(5.0.1.168)。

## 开源协议

Apache License 2.0

## 更新记录

### [1.0.3] - 2025-12-10

修复跳转到指定时间点精确位置问题

### [1.0.2] - 2025-8-25

修改新增沉浸式函数的函数名为：AdaptiveImmersion.getImmersionInfo

### [1.0.1] - 2025-8-22

去掉 har 中的图片
根据新沉浸规则更新 README

### [1.0.0] - 2025-8-21

发布 v1.0.0 正式版本
更新沉浸式规则：当前沉浸规则可兼容所有机型和视频大小
自适应沉浸式工具 AdaptiveImmersion 新增静态接口：getImmersionInfo

### [1.0.0-rc.2] - 2025-7-2

Fix
移除并替换废弃 API：[getContext、px2vp]

### [1.0.0-rc.1] - 2025-6-5

Fix
修复视频高阶组件在 pc 上按空格后无法暂停/播放视频的 bug

### [1.0.0-rc.0] - 2025-6-3

Add
新增多设备短视频自适应沉浸工具 - AdaptiveImmersion
新增多设备短视频自适应旋转工具 - AdaptiveRotation
新增视频自适应沉浸高阶组件 - AdaptiveVideoComponent

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 HarmonyOS 版本 | 5.0.0 |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| 应用类型 | 应用 |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| 元服务 | |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| 设备类型 | 手机 |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| 平板 | |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| PC | |

Created with Pixso.

| 项目 | 内容 |
| :--- | :--- |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

Created with Pixso.

## 安装方式

```bash
ohpm install @hadss/adaptive_video
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/89430d192d5b465787162afca805823f/PLATFORM?origin=template