# cclyric 音乐播放器歌词组件

## 简介

音乐歌词组件库，支持逐字歌词、逐行歌词、滑动 seek 操作、歌词滚动显示、歌词自定义显示等。

## 详细介绍

### 简介

cclyric 是一个为 OpenHarmony 和 HarmonyOS 设计的音乐歌词组件库。

### 功能特性

- 支持逐字歌词 (卡拉 ok 效果)
- 支持逐行歌词
- 支持滑动 seek 操作
- 支持歌词滚动显示
- 支持歌词左对齐和居中显示模式
- 支持自定义 seek 界面
- 支持自定义歌词样式，包括歌词行距，字体大小/颜色，聚焦大小/颜色等

### 示例效果

- 居中对齐
- 左对齐
- 自定义样式
- 自定义 seek 界面

### 注意事项

- 从 1.1.1 版本开始，重构逐字动画逻辑，动效更加平滑和精准，因为采用了部分高版本接口，因此后续版本仅支持 Api14 以上。
- 从 1.0.8 版本开始，新增逐字歌词能力，新增了 CcLyricView 组件和 CcLrcController 控制器，取替之前的 LyricView（不再维护）。
- 从 1.0.8 版本开始，不再提供默认的歌词解析器，建议提供数据源格式和 Lrc 数据结构，使用 AI 工具编写解析代码。

### 依赖方式

```bash
ohpm install @seagazer/cclyric
```

## 接口能力

cclyric 提供视图组件 CcLyricView，用户可以通过 CcLyricController 来操作组件。

### CcLyricView

歌词组件

| 属性 | 类型 | 属性说明 | 必填 |
| :--- | :--- | :--- | :--- |
| controller | CcLyricController | 歌词组件控制器 | 是 |
| supportSeek | boolean | 是否开启滑动 seek 能力，默认 false | 否 |
| onSeekAction(position: number) => void | - | seek 回调 | 否 |
| onScrollChanged(centerLine: LrcLine \| undefined) => void | - | 滑动时中间歌词信息回调，用于自定义 seekui | 否 |
| onScrollStateChanged(scrolling: boolean) => void | - | 用户手动滑动状态回调，用于自定义 seekui | 否 |
| onDataSourceReady() => void | - | 歌词数据加载完成回调 | 否 |

### CcLyricController

CcLyricView 组件控制器，通过接口控制歌词状态，样式。

#### setDebugger(debug: boolean): void

设置是否开启调试日志，默认 false

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| debug | boolean | 是否开启调试日志 |

#### setLyric(lyric: Lrc \| undefined): CcLyricController

设置歌词数据。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| lyric | Lrc \| undefined | 歌词，没有歌词设置 undefined |

#### setAlignMode(mode: AlignMode): CcLyricController

设置歌词显示的对齐模式，当前支持左对齐和居中对齐，默认居中显示。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| mode | AlignMode | 歌词显示的对齐模式 |

#### setEmptyHint(hint: ResourceStr): CcLyricController

设置无歌词时的提示语，默认为--。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| hint | ResourceStr | 无歌词时的提示语 |

#### setFadeColor(color: ResourceColor): CcLyricController

设置歌词上下边缘渐变颜色，默认为#00ffffff，1.1.1 版本开始废弃。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| color | ResourceColor | 歌词边缘渐变颜色 |

#### setFadeEnable(enable: boolean): CcLyricController

设置歌词上下边缘是否渐变显示，默认 true

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| enable | boolean | 歌词上下边缘是否渐变显示 |

#### setFadePercent(percent: number): CcLyricController

设置歌词上下边缘渐变占比，默认 0.2，取值范围为 [0,1]。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| percent | number | 上下边缘渐变占比 |

#### setTextSize(textSize: number): CcLyricController

设置歌词文本尺寸，默认为 20vp。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| textSize | number | 歌词文本尺寸 (单位 vp) |

#### setTextColor(color: number): CcLyricController

设置歌词文本普通颜色，默认为 0xff000000。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| color | number | 文本普通颜色 |

#### setHighlightColor(color: number): CcLyricController

设置歌词文本聚焦颜色，当前播放的歌词属于聚焦状态，默认为 0xffff0000。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| color | number | 文本聚焦颜色 |

#### setKrcTextBgColor(color: number): CcLyricController

设置逐字歌词聚焦行文本背景颜色（前景色设置为 setHighlightColor），默认和歌词文本普通颜色保持一致：0xff000000。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| color | number | 逐字歌词聚焦行文本颜色 |

#### setTopOffset(offset: number): CcLyricController

设置歌词首行距离顶部的距离，单位 vp，默认为 100vp。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| offset | number | 歌词首行距离顶部的距离 |

#### setHighlightScale(scale: number): CcLyricController

设置歌词文本聚焦缩放，当前播放的歌词属于聚焦状态，默认为 1.1f。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| scale | number | 文本聚焦缩放比例 |

#### setLineSpace(lineSpace: number): CcLyricController

设置歌词行间距，默认为 12vp。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| lineSpace | number | 歌词行间距 (单位 vp) |

#### updatePosition(position: number)

更新媒体播放进度，组件会自动刷新歌词显示。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| position | number | 媒体播放进度 (单位 ms) |

#### setLrcAnimDuration(duration: number)

设置逐字歌词的动效时间，默认 250ms。1.1.1 版本开始废弃。

| 参数 | 类型 | 参数说明 |
| :--- | :--- | :--- |
| duration | number | 动效时间 (单位 ms) |

### Lrc

歌词数据结构

| 属性 | 类型 | 属性说明 |
| :--- | :--- | :--- |
| artist | string | 艺术家 |
| title | string | 标题 |
| album | string | 专辑 |
| by | string | 作者 |
| offset | number | 时间戳偏移量 |
| lyricList | Array<LrcLine> | 歌词行数组 |

### LrcLine

单行歌词数据结构

| 属性 | 类型 | 属性说明 |
| :--- | :--- | :--- |
| text | string | 歌词内容 |
| beginTime | number | 当前行歌词起始时间戳 |
| endTime | number | 当前行歌词结束时间戳 |
| wordList | LrcWord[] \| undefined | 单个字的时间信息，Lrc 逐行歌词场景为 undefined |

### LrcWord

单个字数据结构

| 属性 | 类型 | 属性说明 |
| :--- | :--- | :--- |
| text | string | 字符文本 |
| beginTime | number | 该字符起始时间戳 |
| endTime | number | 该字符结束时间戳 |

### AlignMode

歌词对齐模式枚举

| 属性 | 属性说明 |
| :--- | :--- |
| CENTER | 居中对齐 |
| START | 左对齐 |

## 场景示例

下面是基础示例和使用方式：

### 基础示例

```typescript
@Entry
@ComponentV2
struct Index {
   @Local lyric?: Lrc = undefined
   // 1.init the controller
   private controller: CcLyricController = new CcLyricController()

   aboutToAppear(): void {
       // 2. setup the attribute
       this.controller.setDebugger(true)
       this.controller.setTextSize(18)
           .setLineSpace(12)
           .setTextColor(0xCC000000)
           .setTextHighlightColor(0xffe7107f)
           .setFadeEnable(true)
       this.lyric = this.parser.parse(MockData.krc1)
       // 3. set the lyric
       this.controller.setLyric(this.lyric)
   }

   build() {
       Column() {
           // 4. init the view
           CcLyricView({
               controller: this.controller,
               // 使用默认的 seekui
               supportSeek: true, // support scroll seek
                   onSeekAction: (position) => {
                       this.mockPlayerSeek(position)
                   }
           })
           .width("100%")
           .height("100%")
       }
       .height('100%')
       .width('100%')
   }

   onPlayerPositionUpdate(position: number) {
       // 5. update the mediaplayer position
       this.controller.updatePosition(position)
   }

   mockPlayerSeek(position: number) {
       // 6. update the mediaplayer position
       this.player.seekTo(position)
   }
}
```

### 自定义滑动 seek 界面

```typescript
@Entry
@ComponentV2
struct Index {
   @Local lyric?: Lrc = undefined
   // 1.init the controller
   private controller: CcLyricController = new CcLyricController()
   // 自定义 ui 数据
   @Local userScrolling: boolean = false
   @Local scrollTargetTime: number = 0

   aboutToAppear(): void {
       // 2. setup the attribute
       this.controller.setDebugger(true)
       this.controller.setTextSize(18)
           .setLineSpace(12)
           .setTextColor(0xCC000000)
           .setTextHighlightColor(0xffe7107f)
       this.lyric = this.parser.parse(MockData.krc1)
       // 3. set the lyric
       this.controller.setLyric(this.lyric)
   }

   build() {
       Column() {
           Stack() {
               Stack() {
                   CcLyricView({
                       controller: this.controller,
                       // custom seek ui: 1.set supportSeek false, 2.get current center duration from onScrollChanged and onScrollStateChanged callback
                       supportSeek: false, //设置默认 seek 属性为 false
                       onScrollChanged: (centerLine) => {
                           if (centerLine !== undefined) {
                               this.scrollTargetTime = centerLine.beginTime
                           }
                       },
                       onScrollStateChanged: (scrolling) => {
                           this.userScrolling = scrolling
                       }
                   })
               }.padding(12)
               // 自定义 seekui，数据从上面的 onScrollChanged 和 onScrollStateChanged 回调获取
               if (this.userScrolling && this.scrollTargetTime >= 0) {
                   Row() {
                       Blank()
                       Text(duration2text(this.scrollTargetTime))
                           .fontSize(18)
                       SymbolGlyph($r("sys.symbol.play_fill"))
                           .fontSize(32)
                           .onClick(() => {
                               this.mockPlayerSeek(this.scrollTargetTime)
                               this.userScrolling = false
                           })
                   }
                   .width("95%")
                   .height(42)
                   .border({ radius: 8 })
                   .backgroundColor("#808d8d8d")
               }
           }
           .width("100%")
           .height('100%')
       }
       .height('100%')
       .width('100%')
   }

   onPlayerPositionUpdate(position: number) {
       // 5. update the mediaplayer position
       this.controller.updatePosition(position)
   }

   mockPlayerSeek(position: number) {
       // 6. update the mediaplayer position
       this.player.seekTo(position)
   }
}
```

## 许可证协议

Apache 2.0

## 更新记录

### 1.1.3

- 修复歌词切换会延迟显示问题
- 删除 1.1.2 遗留的非关键调试日志
- 绘制逐字歌词性能优化

### 1.1.2

- 支持动态调整字体大小，行距，缩放等尺寸参数
- 基于新版本 Api 进行 LyricView 重构
- 新增 setKrcTextBgColor 接口可以单独设置高亮行的字体颜色
- 新增 setTopOffset 接口可以设置首行歌词距离顶部距离
- 修复英文单词和字符带空格时逐字歌词断行异常问题
- 修复 seek 后概率停留在 seek 前位置显示的问题
- 修复 seek 滑动指示器部分场景显示异常问题

### 1.1.1

- 修复 CcLyricView 组件在播放进度非 0 时初次显示也会从顶部开始显示问题
- 重构逐字歌词动画逻辑，动效更加平滑精准
- 歌词边缘渐变修改为使用 blendMode 实现 (仅支持 api12+)
- CcLyricController 废弃 setFadeColor 接口，新增 setFadeEnable 接口
- CcLyricController 新增 setFadePercent 接口设置渐变高度占比
- CcLyricController 废弃 setLrcAnimDuration 接口，动画时长由库内部动态修改
- 兼容版本提升至 14，编译版本提升至 21

### 1.1.0

- 新增 setLrcAnimDuration 接口，设置逐字歌词动效时长
- 优化部分细节

### 1.0.9

- 重构动画，增加动画缓存池，性能提升
- 新增 setAlignMode 接口，支持歌词左对齐和居中显示模式
- 新增 onScrollChanged 和 onScrollStateChanged 接口，支持自定义 seek 界面
- CcLyricView 新增 onDataSourceReady 数据加载完成回调
- 修复 updatePosition 在数据未加载完成前调用可能发生异常问题
- 完善接口注释，增加接口注意事项

### 1.0.8

- 新增 CcLyricView 组件和 CcLrcController 控制器
- 新增 Lrc 数据结构，配合 CcLyricView 使用
- 支持卡拉 ok 逐字歌词效果
- 歌词组件性能大幅增强
- 废弃 LyricView 和 LyricView2

### 1.0.7

- 适配 OpenHarmony 5.0-Release 和 HarmonyOS Next

### 1.0.6

- 性能优化
- LyricView2 增加设置滑动 seek 样式选择接口
- LyricView2 增加抖音汽水音乐 seek 样式效果

### 1.0.5

- 修复 FileParser 接口对外未暴露问题

### 1.0.4

- 新增 seek 定位线条颜色设置
- 新增歌词文件解析器 FileParser
- 动效优化
- 适配 4.1release-Api11

### 1.0.3

- 新增 seek 定位按钮和文本颜色设置
- 修改默认属性值

### 1.0.2

- 新增 LyricView2 组件
- LyricView2 支持歌词滑动查看
- LyricView2 支持歌词滑动 seek 视图
- LyricView2 支持歌词滑动快进快退至目标时间戳
- 修复一些问题

### 1.0.1

- 新增实时动态刷新能力
- 修复一些问题

### 1.0.0

- 支持歌词解析
- 支持歌词滚动显示
- 支持自定义样式，包括歌词字体大小/颜色，聚焦大小/颜色，显示模式等

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

**隐私政策**: 不涉及  
**SDK 合规使用指南**: 不涉及

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.1 |
| 应用类型 | 应用 |
| 元服务 |  |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 |

Created with Pixso.

## 安装方式

```bash
ohpm install @seagazer/cclyric
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/53448d4efa7a4e868856e1d3683f7431/PLATFORM?origin=template