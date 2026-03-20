# DanmakuFlameMaster 弹幕组件

## 简介

支持发送纯文本弹幕、设置弹幕在屏幕的显示区域、控制弹幕播放状态等功能

## 详细介绍

### 简介

DanmakuFlameMaster 是一款弹幕框架，支持发送纯文本弹幕、设置弹幕在屏幕的显示区域、控制弹幕播放状态等功能。

### 下载安装

```bash
ohpm install @ohos/danmakuflamemaster
```

### 使用说明

#### 初始化：并设置弹幕显示相关属性

```ets
this.model.setWidth(lpx2px(720))
this.model.setHeight(lpx2px(720))
let maxLinesPair: Map<number, number> = new Map();
maxLinesPair.set(BaseDanmaku.TYPE_SCROLL_RL, 5);
let overlappingEnablePair: Map<number, boolean> = new Map();
overlappingEnablePair.set(BaseDanmaku.TYPE_SCROLL_RL, true);
overlappingEnablePair.set(BaseDanmaku.TYPE_FIX_TOP, true);
this.mContext = DanmakuContext.create();
this.mContext.setDanmakuStyle(DANMAKU_STYLE_STROKEN, 3)
  .setDuplicateMergingEnabled(false)
  .setScrollSpeedFactor(1.2)
  .setScaleTextSize(1.2)
  .setCacheStuffer(new SpannedCacheStuffer(), this.mCacheStufferAdapter) // 图文混排使用 SpannedCacheStuffer
  .setMaximumLines(maxLinesPair)
  .preventOverlapping(overlappingEnablePair)
  .setDanmakuMargin(40);
let that = this
if (this.model != null) {
  this.mParser = this.createParser();
  this.model.setCallback(new Call(that));
  this.model.setOnDanmakuClickListener(new OnDanMu(that))
  this.model.prepare(this.mParser, this.mContext);
  this.model.showFPS(true);
}
class Call implements Callback {
  private that: ESObject;

  constructor(that: ESObject) {
    this.that = that
  }

  public updateTimer(timer: DanmakuTimer): void {
  }

  public drawingFinished(): void {

  }

  public danmakuShown(danmaku: BaseDanmaku): void {
  }

  public prepared(): void {
    this.that.model.start();
  }
}
class OnDanMu implements OnDanmakuClickListener {
  private that:ESObject;
  constructor(that :ESObject) {
    this.that = that
  }
  onDanmakuClick(danmakus: IDanmakus): boolean{
    console.log('DFM onDanmakuClick: danmakus size:'  danmakus.size())
    let latest: BaseDanmaku = danmakus.last()
    if (null != latest) {
      console.log('DFM onDanmakuClick: text of latest danmaku:'  latest.text)
      return true
    }
    return false
  };

  onDanmakuLongClick(danmakus: IDanmakus): boolean{
    return false
  };

  onViewClick(view: IDanmakuView): boolean{
    this.that.isVisible = true
    return false
  };
}
```

#### 添加弹幕

```ets
let danmaku: BaseDanmaku = this.mContext.mDanmakuFactory.createDanmaku(BaseDanmaku.TYPE_SCROLL_RL);
danmaku.text = "这是一条弹幕"  SystemClock.uptimeMillis();
danmaku.padding = 5;
danmaku.priority = 0; // 可能会被各种过滤器过滤并隐藏显示
danmaku.isLive = isLive.valueOf();
danmaku.setTime(this.model.getCurrentTime()  1200);
danmaku.textSize = 25 * (this.mParser.getDisplayer().getDensity() * 0.8);
danmaku.textColor = 0xffff0000;
danmaku.textShadowColor = 0xffffffff;
danmaku.borderColor = 0xff00ff00;
this.model.addDanmaku(danmaku);
```

#### 添加 gif 弹幕

```ets
let file = fs.openSync(, fs.OpenMode.READ_ONLY)
const imageSource = image.createImageSource(file.fd);
imageSource.createPixelMapList().then((pixelMapListParam: Array<image.PixelMap>)=> {
  let danmaku: BaseDanmaku = this.mContext.mDanmakuFactory.createDanmaku(BaseDanmaku.TYPE_SCROLL_RL);
  //设置 gif 弹幕的帧数据，用于 canvas 的绘制
  danmaku.setPixelMapList(pixelMapListParam)
  //判断是否是 gif 格式，当传入 gif 格式图片时需要设置为 true，默认是 false
  danmaku.setIsAnimation(true)
  danmaku.text = "<img src=    "" width=  99  "" height=  99  ""/>";
  danmaku.padding = 0;
  danmaku.priority = 1;
  danmaku.isLive = islive;
  danmaku.setTime(this.model.getCurrentTime()  1200);
  danmaku.textShadowColor = 0;
  this.model.addDanmaku(danmaku);
})
```

### 使用注意

```ets
// V1 装饰器下的使用方式
import { DanmakuView } from '@ohos/danmakuflamemaster'

@State model: DanmakuView.Model = new DanmakuView.Model()

DanmakuView({ model: $model }).backgroundColor(Color.Gray)

// V2 装饰器下的使用方式
import { DanmakuViewV2 } from '@ohos/danmakuflamemaster'

@Local model: DanmakuViewV2.Model = new DanmakuViewV2.Model()

DanmakuViewV2({ model: this.model!! }).backgroundColor(Color.Gray)
```

## 接口说明

### Model

V1 装饰器下使用：`model: DanmakuView.Model = new DanmakuView.Model()`
V2 装饰器下使用：`model: DanmakuViewV2.Model = new DanmakuViewV2.Model()`

| 方法 | 描述 |
| :--- | :--- |
| `model.addDanmaku(danmaku)` | 添加弹幕 |
| `model.getCurrentTime()` | 获取当前弹幕时间 |
| `model.hide()` | 弹幕隐藏 |
| `model.show()` | 弹幕显示 |
| `model.pause()` | 弹幕暂停播放 |
| `model.resume()` | 弹幕继续播放 |
| `model.setWidth(lpx2px(1280))` | 设置弹幕显示区域宽度 |
| `model.setHeight(lpx2px(720))` | 设置弹幕显示区域高度 |
| `model.prepare(this.mParser, this.mContext)` | 启动弹幕播放 |
| `model.showFPS(true)` | 显示弹幕播放的 fps |
| `model.setOnDanmakuClickListener()` | 设置弹幕点击回调 |
| `setIsAnimation(boolean)` | 判断弹幕是否是 gif 格式 |
| `setPixelMapList(pixelMapListParam)` | 设置 gif 弹幕的帧数据，用于 canvas 的绘制 |

### DanmakuContext

| 方法 | 描述 |
| :--- | :--- |
| `public static create(): DanmakuContext` | DanmakuContext 构造器 |
| `public getBaseComparator(): BaseComparator` | 获取弹幕排序器 |
| `public setBaseComparator(baseComparator: BaseComparator)` | 设置弹幕排序器 |
| `public getDisplayer(): AbsDisplayer<ESObject, ESObject>` | 获取弹幕显示器 |
| `public setTypeface(font: string): DanmakuContext` | 设置字体样式 |
| `public setDanmakuTransparency(p: number): DanmakuContext` | 设置弹幕透明度 |
| `public setScaleTextSize(p: number): DanmakuContext` | 设置缩放字体大小 |
| `public setDanmakuMargin(m: number): DanmakuContext` | 设置弹幕显示外边距 |
| `public setMarginTop(m: number): DanmakuContext` | 设置弹幕显示上边距 |
| `public getFTDanmakuVisibility(): boolean` | 获取是否显示顶部弹幕 |
| `public setFBDanmakuVisibility(visible: boolean): DanmakuContext` | 设置是否显示底部弹幕 |
| `public getL2RDanmakuVisibility(): boolean` | 获取是否显示左右滚动弹幕 |
| `public setL2RDanmakuVisibility(visible: boolean): DanmakuContext` | 设置是否显示左右滚动弹幕 |
| `public getR2LDanmakuVisibility(): boolean` | 获取是否显示右左滚动弹幕 |
| `public setR2LDanmakuVisibility(visible: boolean): DanmakuContext` | 设置是否显示右左滚动弹幕 |
| `public getSpecialDanmakuVisibility(): boolean` | 获取是否显示特殊弹幕 |
| `public setSpecialDanmakuVisibility(visible: boolean): DanmakuContext` | 设置是否显示特殊弹幕 |
| `public setMaximumVisibleSizeInScreen(maxSize: number): DanmakuContext` | 设置同屏弹幕密度，-1 自动 0 无限制 |
| `public setDanmakuStyle(style: number, ...values: number[]): DanmakuContext` | 设置描边样式 |
| `public setDanmakuBold(bold: boolean): DanmakuContext` | 设置弹幕是否粗体显示 |
| `public setColorValueWhiteList(colors: number[]): DanmakuContext` | 设置色彩过滤弹幕白名单 |
| `public getColorValueWhiteList(): number[]` | 获取色彩过滤弹幕白名单 |
| `public setUserHashBlackList(hashes: string[]): DanmakuContext` | 设置屏蔽特定用户的弹幕 |
| `public removeUserHashBlackList(hashes: string[]): DanmakuContext` | 移除黑名单的用户 |
| `public addUserHashBlackList(hashes: string[]): DanmakuContext` | 增加黑名单的用户 |
| `public getUserHashBlackList(): string[]` | 获取黑名单用户 |
| `public blockGuestDanmaku(block: boolean): DanmakuContext` | 是否屏蔽游客弹幕 |
| `public setScrollSpeedFactor(p: number): DanmakuContext` | 设置滚动弹幕速率 |
| `public setDuplicateMergingEnabled(enable: boolean): DanmakuContext` | 设置是否启用合并重复弹幕 |
| `public isDuplicateMergingEnabled(): boolean` | 获取是否启用合并重复弹幕 |
| `public alignBottom(enable: boolean): DanmakuContext` | 设置底部是否可以有弹幕 |
| `public isAlignBottom(): boolean` | 获取底部是否可以有弹幕的状态 |
| `public setMaximumLines(pairs: Map<number, number>): DanmakuContext` | 设置最大弹幕显示行数 |
| `public setOverlapping(pairs: Map<number, boolean>): DanmakuContext` | 设置防止弹幕重叠 |
| `public isMaxLinesLimited(): boolean` | 获取是否有最大行数限制 |
| `public isPreventOverlappingEnabled(): boolean` | 获取是否开启防止弹幕重叠功能 |
| `public setDanmakuSync(danmakuSync: AbsDanmakuSync): DanmakuContext` | 设置弹幕同步器 |
| `public setCacheStuffer(cacheStuffer: BaseCacheStuffer, cacheStufferAdapter: Proxy): DanmakuContext` | 设置弹幕缓存填充器 |
| `public registerConfigChangedCallback(listener: ConfigChangedCallback): void` | 设置配置信息改变回调接口 |
| `public unregisterConfigChangedCallback(listener: ConfigChangedCallback): void` | 取消配置信息改变回调接口 |
| `public registerFilter(filter: BaseDanmakuFilter<ESObject>): DanmakuContext` | 设置弹幕过滤器 |
| `public unregisterFilter(filter: BaseDanmakuFilter<ESObject>): DanmakuContext` | 取消弹幕过滤器 |
| `public resetContext(): DanmakuContext` | 重置 DanmakuContext |

### Proxy

| 方法 | 描述 |
| :--- | :--- |
| `public abstract prepareDrawing(danmaku: BaseDanmaku, fromWorkerThread: boolean)` | 预绘制缓存弹幕 |
| `public abstract releaseResource(danmaku: BaseDanmaku)` | 释放弹幕资源 |

### DanmakuTimer

| 方法 | 描述 |
| :--- | :--- |
| `public update(curr: number): number` | 更新定时器时间 |
| `public add(mills: number): number` | 增加计时的时间 |
| `public getLastInterval(): number` | 获取距离计时结束剩余的时间 |

### Duration

| 方法 | 描述 |
| :--- | :--- |
| `public setValue(initialDuration: number)` | 设置弹幕初始持续时间 |
| `public setFactor(f: number)` | 设置弹幕初始持续时间系数 |

### SpecialDanmaku

| 方法 | 描述 |
| :--- | :--- |
| `public getLeft(): number` | 获取顶部固定弹幕的左边距 |
| `public getTop(): number` | 获取顶部固定弹幕的上边距 |
| `public getRight(): number` | 获取顶部固定弹幕的右边距 |
| `public getBottom(): number` | 获取顶部固定弹幕的下边距 |
| `public getType(): number` | 获取弹幕的类型 |
| `public setTranslationData(beginX: number, beginY: number, endX: number, endY: number, translationDuration: number, translationStartDelay: number)` | 设置特效弹幕平移数据 |
| `public setAlphaData(beginAlpha: number, endAlpha: number, alphaDuration: number)` | 设置特效弹幕透明度变化数据 |

### DanmakuUtils

| 方法 | 描述 |
| :--- | :--- |
| `public static compare(obj1: BaseDanmaku, obj2: BaseDanmaku): number` | 比较两个弹幕是否相同 |
| `public static isDuplicate(obj1: BaseDanmaku, obj2: BaseDanmaku): boolean` | 弹幕是否重复 |
| `public static create(): DanmakuFactory` | 创建弹幕工厂 |

```ets
-keep
./oh_modules/@ohos/danmakuflamemaster
```

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Release-5.0.3.901, SDK: API12 Release(5.0.0.71)
- DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release(5.0.0.66)
- DevEco Studio 版本：4.1 Canary(4.1.3.317), OpenHarmony SDK:API11 (4.1.0.36)

## 目录结构

```text
|---- DanmakuFlameMaster  
|     |---- entry  # 示例代码文件夹
|     |---- library  # DanmakuFlameMaster 库文件夹
|           |---- srcmainetscomponentscommonmasterflamedanmaku  # 源代码文件夹
|           		|---- control   # 弹幕状态控制实现
|           		|---- danmaku 	# 弹幕基础类库
|           		|---- ui 		# 弹幕自定义显示控件
|           |---- index.ets  # 对外接口
|     |---- README.md  # 安装使用方法                    
|     |---- README_zh.md  # 安装使用方法                    
```

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。

## 更新记录

### 2.1.2

Release version 2.1.2

#### 2.1.2-rc.1

- Fix hide method

#### 2.1.2-rc.0

- fix: frame drop issue
- fix(ESObject): resolve warning messages 
- feat(demo): add barrage filtering capability test

### 2.1.1

Update code repository address

#### 2.1.1-rc.1

- The issue that the onDanmakuLongClick event cannot be listened to is fixed
- Fixed an issue where danmakuflamemaster was incompatible with V1 and V2 decorators
- The DanmakuViewV2 interface is added for use in the v2 decorator

#### 2.1.1-rc.0

- Added support for GIF barrage

### 2.1.0

发布 2.1.0 正式版本

#### 2.1.0-rc.1

- 修复图文弹幕的下划线绘制异常
- 修复图文弹幕的边框绘制异常
- 修复图文弹幕直接出现在屏幕中央的异常

#### 2.1.0-rc.0

- 适配 V2 装饰器

### 2.0.2

发布 2.0.2 正式版本

#### 2.0.2-rc.0

- 修复发送弹幕重叠的问题

### 2.0.1

1. 将 FA 模型中的 API 替换为 Stage 模型 API

### 2.0.0

1. DevEco Studio 版本：4.1 Canary(4.1.3.317), OpenHarmony SDK:API11 (4.1.0.36)
2. ArkTs 语法适配

### v1.0.4

- 适配 DevEco Studio 版本：3.1 Beta1（3.1.0.200），OpenHarmony SDK:API9（3.2.10.6）

### v1.0.3

- 添加数据源加载接口

### v1.0.1

- api8 升级到 api9

### v1.0.0

#### 已实现功能

- 支持顶部弹幕
- 支持底部弹幕
- 支持左右滚动弹幕
- 支持特殊弹幕
- 支持弹幕播放暂停继续
- 支持纯文本弹幕
- 支持弹幕隐藏显示
- 支持设置弹幕显示区域大小

#### 未实现功能

- 不支持弹幕缓存
- 不支持旋转屏幕
- 不支持 xml 弹幕数据解析
- 图文混排不支持自定义复杂布局 (spannable 富文本)

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 基本信息 | 暂无 |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 5.0.0 |
| 应用类型 | 应用 |
| 元服务 |  |
| 设备类型 | 手机 |
| 平板 |  |
| PC |  |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 |

## 安装方式

```bash
ohpm install @ohos/danmakuflamemaster
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6f4fb1ec67834f2fbe2544a7d137e31c/PLATFORM?origin=template