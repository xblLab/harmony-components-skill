# LrcView 歌词组件

## 简介

逐行歌词&逐字歌词组件

## 详细介绍

### 介绍

歌词组件：

- 支持逐句歌词和逐字歌词
- 可以使用逐句歌词模拟逐字歌词动画效果
- 拖动进度条、点击歌词行可跳转到对应的歌词
- 可以设置歌词字体大小、颜色、对齐方式
- 可自定义滑动歌词的居中时间指示器

### 安装

```bash
ohpm install @jackiehou/lyric-view
```

### 使用

```typescript
import { LrcLine, LrcPosition, LrcView, parseLyrics} from '@jackiehou/lyric-view'

@Local lrcLines: LrcLine[] = []
@Local isPlay:boolean = true
player: media.AVPlayer | undefined
//返回负值歌词不和播放器同步，这里为了演示效果，因此 position 函数返回负值，和播放器同步的代码参考 LrcPageV2
lrcPosition : LrcPosition = new LrcPosition(() =>this.player?.currentTime ?? -1)

async aboutToAppear() {
  this.lrcLines = parseLyrics(lrcString)
}

build() {
  Column({space:10}) {
    LrcView({
      lrcLines:this.lrcLines,
      isPlay:this.isPlay,
      lrcPosition:this.lrcPosition,
      normalFontColor:$r('sys.color.font_secondary'),
      selectFontColor:$r('sys.color.font_primary'),
      highlightFontColor:$r('sys.color.font_emphasize'),
      onLrcLineClick:(start) =>{
        this.player?.seek(start)
        this.lrcPosition.seekTo(start)
        return true
      },
    })
      .width('100%')
      .layoutWeight(1)

    SymbolGlyph(this.isPlay ? $r('sys.symbol.pause_circle') :$r('sys.symbol.play_circle'))
      .fontSize(50)
      .fontColor([$r('sys.color.font_primary')])
      .onClick(() =>{
        this.isPlay = !this.isPlay
      })
  }
  .height('100%')
  .width('100%')
  .padding(15)
}
```

基础示例，推荐使用状态管理 V2

### 接口说明

#### LrcView

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| lrcLines | LrcLine[] | 是 | 解析后的逐字&逐行歌词数据 |
| fontText | Font | 否 | 未播放的歌词行的字体大小粗细 |
| maxFontText | Font | 否 | 播放的歌词行的字体大小粗细 |
| normalFontColor | ResourceColor | 否 | 未播放的歌词行的文字颜色 |
| selectFontColor | ResourceColor | 否 | 播放的歌词行的未播放的文字颜色 |
| highlightFontColor | ResourceColor | 否 | 播放的歌词行的已播放的文字颜色 |
| space | number \| string | 否 | 歌词行的间距 |
| itemVerticalPadding | number | 否 | 歌词 item 纵向的间距 |
| itemHorizontalPadding | number | 否 | 歌词 item 横向的间距 |
| fadingEdgeFraction | number | 否 | 边缘渐隐效果，0 到 1 之间，如果为 0 则没有边缘渐隐效果 |
| contentStartOffset | number | 否 | 设置内容区域起始偏移量。列表滚动到起始位置时，列表内容与列表显示区域边界保留指定距离。 |
| animationLyrics | boolean | 否 | 是否播放歌词动态效果，如果 lyricsLine.words 不为空也播放歌词动态效果 |
| lrcAlignCenter | boolean | 否 | 歌词是否居中对齐显示，false：居左对齐 |
| isSingleLine | boolean | 否 | 歌词 item 是否只显示单行 |
| enableScroll | boolean | 否 | 设置是否支持滚动手势 |
| isPlay | boolean | 否 | 是否在播放 |
| lrcPosition | LrcPosition | 否 | 歌曲的播放进度 |
| centerBuilder | (line: LineTime) => void | 否 | 滑动居中的歌词指示器 Builder，不填则为默认样式，为 undefined 则无指示器 |
| onLrcLineClick | (lrcLineStart: number) => boolean | 否 | 歌词行的点击事件 |
| log | (level: hilog.LogLevel, tag: string, msg: string) => void | 否 | 打印 log 的 |

#### parseLyrics

```typescript
parseLyrics(lyricsText: string, isAddFirstEmptyLine:boolean): LrcLine[]
```

歌词解析方法

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| lyricsText | string | 歌词 |
| isAddFirstEmptyLine | boolean | 默认值 true，当首行歌词开始时间大于 0 时是否添加首行空行 |

#### LrcLine

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| start | number | 此行歌词开始的时间，单位毫秒 |
| duration | number | 此行歌词消耗的时间，单位毫秒 |
| words | Array | 此行歌词每个字、单词的内容 |
| text | string | 此行歌词的内容 |

#### LrcWord

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| start | number | 此单词/字开始的时间，单位毫秒 |
| duration | number | 此单词/字消耗的时间，单位毫秒 |
| text | string | 此单词/字的内容 |

#### TextFont

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| textSize | number | 字体大小 |
| textWeight | FontWeight \| number | 字体粗细 |
| lineHeight | number | 字体的行高 |

#### LrcPosition

| 方法名/字段名 | 参数/类型 | 说明 |
| :--- | :--- | :--- |
| position | () => number | 播放器的播放进度，LrcView 组件会调用此函数获取播放进度 |
| seekTo | (number, withoutPlayState) => void | 跳转至对应歌词的时间 |

#### LineTime

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| time | number | 歌词行开始时间，单位毫秒 |
| timeStr | string | mm:ss 格式时间 |

## 开源协议

本项目基于 Apache License 2.0，请自由的享受和参与开源。

## 更新记录

### v1.0.9

从 1.0.9 版本开始，将属性 `font:TextFont` 替换为了 `fontWeight:FontWeight | number`，新增了 `textScale : number` 属性；`normalFontSize` 由 `maxFont` 和 `textScale` 决定（`normalFontSize=maxFont.textSize*textScale`）

从 1.0.9 版本开始，将属性 `fadingEdgeFraction:number` 替换为 `fadingEdgeLength: LengthMetrics | undefined` 边缘渐隐长度，在 api>=14 的设备生效（api>=14 已经覆盖了 99.9% 的设备了）

优化了歌词滑动的丢帧率和歌词行切换动画的丢帧率，见 IDMGZ8

### v1.0.8

修复概率不播放歌词行切换动画的问题

### v1.0.7

修复 bug#IDDFDL

### v1.0.6

修复 bug#ID1GL1

### v1.0.5

优化歌词同步
把逻辑抽到 viewModel 中来，减少组件代码

### v1.0.4

修复歌词同步的 bug
新增 `itemVerticalPadding`, `itemHorizontalPadding`, `enableItem`, `pressedBackgroundColor` 属性
新增 `centerBuilder`

### v1.0.3

修复 bug#ICXA4K
点击歌词行加入动画跳转

### v1.0.2

修复 bug
新增 `isSingleLine` 和 `enableScroll` 属性

### v1.0.1

修复 bug
更新 readme

### v1.0.0

发布 1.0.0 初版。

## 权限与隐私

### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

### 隐私政策

不涉及 SDK 合规使用指南 不涉及

### 兼容性

| 项目 | 详情 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |

Created with Pixso.

## 安装方式

```bash
ohpm install @jackiehou/lyric-view
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/a98844e1db5a46f3ab07dde2e3190ea2/PLATFORM?origin=template