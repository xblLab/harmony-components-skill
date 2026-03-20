# CollapsingToolbar 折叠动效组件

## 简介

折叠工具栏效果。

## 详细介绍

### 介绍

折叠工具栏效果

### 安装

```bash
ohpm install @jackiehou/collapsing-toolbar
```

### 使用说明

#### 状态管理 V1

```typescript
import { CollapsingToolbar, CollapsingToolbarState} from '@jackiehou/collapsing-toolbar'

// 折叠的状态
@State collapsingState: CollapsingToolbarState = new CollapsingToolbarState()

build() {
  Column() {
    CollapsingToolbar({
        collapseLength:this.param.collapseHeight,//收起来的高度，可以为 0
        expandLength:this.param.expandHeight,//展开的高度，必须大于 0
        state:this.collapsingState,//折叠的状态
        header: this.header,//顶部可折叠的内容
        content: this.content,//您的内容，如 list 等
      })
  }.height('100%')
  .width('100%')
}

@LocalBuilder //组件内部@Builder 建议使用@LocalBuilder，不然会碰到 this 指向的问题
header() {
   //...
}

@LocalBuilder 
content() {
  //...
}
```

#### 状态管理 V2

```typescript
import { CollapsingToolbarStateV2, CollapsingToolbarV2} from '@jackiehou/collapsing-toolbar'

// 折叠的状态
collapsingState: CollapsingToolbarStateV2 = new CollapsingToolbarStateV2()

CollapsingToolbarV2({
   collapseLength:this.param.collapseHeight,//收起来的高度，可以为 0
   expandLength:this.param.expandHeight,//展开的高度，必须大于 0
   state:this.collapsingState,//折叠的状态
   header: this.header,//顶部可折叠的内容
   content: this.content,//您的内容，如 list 等
 })
```

### 注意事项

content 包含 list,grid,WaterFlow 等需要为其设置 nestedScroll 属性

```typescript
List() {
   //...
 }
 .nestedScroll({
   scrollForward: NestedScrollMode.PARENT_FIRST,
   scrollBackward: NestedScrollMode.SELF_FIRST
 })
```

### 折叠工具栏的跟手动画

```typescript
import {
 CollapsingToolbar,
 CollapsingToolbarState,
 lerp,
 lerpColor, lerpPercentage } from '@jackiehou/collapsing-toolbar'

@LocalBuilder
header() {//header 的父组件是 Stack，其 alignContent 属性为 TopStart
  //header 背景色
  Rect({ width: '100%', height: '100%' })
    .fill(this.expandBgColor)
    .opacity(this.collapsingState.progress) //折叠状态透明，展开状态显示
  //返回按钮
  SymbolGlyph($r('sys.symbol.chevron_left'))
    .renderingStrategy(SymbolRenderingStrategy.SINGLE)
    .fontSize(30)
    .fontWeight(FontWeight.Medium)
    .height(this.collapsingState.collapseHeight > 0 ? this.collapsingState.collapseHeight : 56)
    .align(Alignment.Center)
    .margin({ left: 15, })
    .translate({ y: this.collapsingState.yOffset })//pin 效果，组件的 y 轴位置不随 CollapsingToolbar 滑动而变化
      /**
       *颜色插值器
       * lerpColor 方法第一个参数 colorStart：CollapsingToolbar 完全折叠状态下的颜色
       * lerpColor 方法第一个参数 colorEnd：CollapsingToolbar 完全展开状态下的颜色
       * lerpColor 方法第三个参数 this.collapsingState.progress：0 到 1 的小数，0：CollapsingToolbar 完全折叠状态，1：CollapsingToolbar 完全展开状态
       */
    .fontColor([lerpColor(this.collapseFontColor, this.expandFontColor, this.collapsingState.progress)])
    .onClick(() => {
      router.back()
    })
  //标题
  Text('CollapsingToolbar')
    .height(this.collapsingState.collapseHeight > 0 ? this.collapsingState.collapseHeight : 56)
    .textAlign(TextAlign.Center)
    .margin({
      //collapse 状态：居左 40vp，
      //expand 状态：左边距居中
      left: this.collapsingState.lerpX(40, '50%'),
      //collapse 状态：top：折叠状态工具栏到顶部的距离，
      //expand 状态：上边距居中
      top: this.collapsingState.lerpY(this.collapsingState.maxOffset, '50%'),
    })
    .translate({
      //collapse 状态：不位移，
      //expand 状态：加上 margin 的 expand 状态整体居中
      x: lerpPercentage('0%', '-50%', this.collapsingState.progress),
      y: lerpPercentage('0%', '-50%', this.collapsingState.progress),
    })
    .fontSize(lerp(16, 22, this.collapsingState.progress))
    .maxLines(1)
    .fontWeight(FontWeight.Medium)
    .fontColor(lerpColor(this.collapseFontColor, this.expandFontColor, this.collapsingState.progress))//fontColor 颜色插值器

  SymbolGlyph($r('sys.symbol.heart'))
    .renderingStrategy(SymbolRenderingStrategy.SINGLE)
    .fontSize(25)
    .fontWeight(FontWeight.Medium)
    .height(this.collapsingState.collapseHeight > 0 ? this.collapsingState.collapseHeight : 56)
    .align(Alignment.Center)
    .position({ right: 0, bottom: 0 })//修改当前子组件在 Stack 的 align，等同于 BottomEnd
    .margin({ right: 15 })
    .fontColor([lerpColor(this.collapseFontColor, this.expandFontColor, this.collapsingState.progress)])//fontColor 颜色插值器
}
```

## 接口说明

### CollapsingToolbar&CollapsingToolbarV2 组件各项属性

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| collapseLength | Dimension | 是 | 折叠工具栏收起来的高度 |
| expandLength | Dimension | 是 | 折叠工具栏展开的高度 |
| state | CollapsingToolbarState\|CollapsingToolbarStateV2 | 否 | 折叠工具栏的状态 |
| immersionProp | ImmersionProp | 否 | 沉浸式状态栏需要的属性 |
| isScrollSnap | boolean | 否 | 是否使用限位滚动 |
| edgeEffect | EdgeEffect | 否 | 设置边缘滑动效果 |
| headerAlign | Alignment | 否 | header 的对齐方式 |
| header() => void | void | 否 | 折叠工具栏的内容 |
| contentBuilder() => void | void | 是 | content 内容 |
| log(tag:string,msg:string) => void) | void | 否 | 打印 log 的 |

### CollapsingToolbarState&CollapsingToolbarStateV2 折叠工具栏的状态

| 方法名/字段名 | 参数/类型 | 说明 |
| :--- | :--- | :--- |
| progress | number | 折叠工具栏 progress，0 到 1 的小数 |
| fraction | number | edgeEffect 设置为 spring，顶部回弹状态下 fraction 会大于 1 |
| yOffset | number | 折叠工具栏的 y 轴偏移量，折叠状态为的值为 expandHeight - collapseHeight，展开状态的值为 0 |
| collapseHeight | number | 折叠工具栏收起来的高度 |
| expandHeight | number | 折叠工具栏展开的高度 |
| width | number | toolbar 的宽度 |
| displayHeight | number | toolbar 显示区域高度，不包含状态栏高度，Scroll 的 edgeEffect 设置为 spring，顶部回弹状态下 displayHeight 会大于 expandHeight |
| statusBarHeight | number | 状态栏高度，如果没有设置 immersionProp 将不会获取状态栏高度 |
| maxOffset | number | 折叠状态工具栏 Y 轴最大的偏移量 |
| isCollapsed | boolean | 工具栏是否收起 |
| isExpanded | boolean | 工具栏是否展开 |
| lerpX(collapse: number \| Percentage, expand: number \| Percentage) => number \| Percentage | - | x 轴长度，偏移量等属性的插值器方法 |
| lerpY(collapse: number \| Percentage, expand: number \| Percentage) => number \| Percentage | - | y 轴长度，偏移量等属性的插值器方法 |
| collapse(animation: ScrollAnimationOptions \| boolean) => void | - | 折叠工具栏 |
| expand(animation: ScrollAnimationOptions \| boolean) => void | - | 展开工具栏 |
| constructor(state: ToolBarState) | - | 构造器参数 state 为工具栏初始的状态 |

### ToolBarState 枚举

| 枚举名称 | 说明 |
| :--- | :--- |
| Collapsed | 收起来 |
| Expanded | 展开 |

### ImmersionProp

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| isLayoutFullScreen | boolean | 是否是全屏 |
| types | Array | 组件的 expandSafeArea 属性的第一个参数 |
| edges | Array | 组件的 expandSafeArea 属性的第二个参数 |

### 线性插值器方法说明

#### lerp 数值插值器

| 参数 | 返回值类型 | 说明 |
| :--- | :--- | :--- |
| start | number | 插值的起始值 |
| stop | number | 插值的结束值 |
| fraction | number | 介于 0 和 1 之间的参数表示插值的位置，包含 0 和 1 |
| return | number | 当 fraction 为 0 时，结果为 start；当 fraction 为 1 时，结果为 stop；当 fraction 介于 0 和 1 之间时，结果是 start 和 stop 之间的某个值。 |

#### lerpInt 整数插值器

| 参数 | 返回值类型 | 说明 |
| :--- | :--- | :--- |
| start | number | 插值的起始值 |
| stop | number | 插值的结束值 |
| fraction | number | 介于 0 和 1 之间的参数表示插值的位置，包含 0 和 1 |
| return | number | 当 fraction 为 0 时，结果为 Math.round(start)；当 fraction 为 1 时，结果为 Math.round(stop)；当 fraction 介于 0 和 1 之间时，结果是 start 和 stop 之间的某个整数值。 |

#### lerpPercentage 百分比插值器

| 参数 | 返回值类型 | 说明 |
| :--- | :--- | :--- |
| startValuePercentage | Percentage | 插值的起始值，百分比类型 例如'20%' |
| endValuePercentage | Percentage | 插值的结束值，百分比类型 例如'80%' |
| fraction | number | 介于 0 和 1 之间的参数表示插值的位置，包含 0 和 1 |
| return | Percentage | 当 fraction 为 0 时，结果为 startValue；当 fraction 为 1 时，结果为 endValue；当 fraction 介于 0 和 1 之间时，结果是 startValue 和 stopValue 之间的某个值。 |

#### lerpPercent 数值/百分比插值器

| 参数 | 返回值类型 | 说明 |
| :--- | :--- | :--- |
| startVal | number \| Percentage | 插值的起始值，为 number 类型或者百分比类型 |
| endVal | number \| Percentage | 插值的结束值，为 number 类型或者百分比类型 |
| fraction | number | 介于 0 和 1 之间的参数表示插值的位置，包含 0 和 1 |
| parentLength | number | 父组件的长度或者宽度 |
| return | number \| Percentage | 当 fraction 为 0 时，startValue；当 fraction 为 1 时，结果为 endValue；当 fraction 介于 0 和 1 之间时，结果是 startValue 和 stopValue 之间的某个值。 |

#### lerpColor 颜色插值器

| 参数 | 返回值类型 | 说明 |
| :--- | :--- | :--- |
| colorStart | number | 插值的起始颜色值 |
| colorEnd | number | 插值的结束颜色值 |
| fraction | number | 介于 0 和 1 之间的参数表示插值的位置，包含 0 和 1 |
| return | number | 当 fraction 为 0 时，结果为 colorStart；当 fraction 为 1 时，结果为 colorEnd；当 fraction 介于 0 和 1 之间时，结果是 start 和 stop 之间的某个颜色值。 |

#### lerpColorAlpha ARGB 颜色的 alpha 通道插值器

| 参数 | 返回值类型 | 说明 |
| :--- | :--- | :--- |
| color | number | 插值的起始颜色值 |
| alpha | number | color 颜色结束的 alpha 值 |
| fraction | number | 介于 0 和 1 之间的参数表示插值的位置，包含 0 和 1 |
| return | number | 当 fraction 为 0 时，结果为 color，当 fraction 为 1 时，结果为 color 的 RGB 颜色 + 参数的 alpha 的得到的 ARGB 颜色值；当 fraction 介于 0 和 1 之间时，结果为 color 的 RGB 颜色+color 的 alpha 到 alpha 直接的某个值得到的 ARGB 颜色值。 |

## 开源协议

本项目基于 Apache License 2.0，请自由的享受和参与开源。

## 更新记录

### v1.0.5

- ColorUtils 新增 lerpArgbColor 和 resourceColor2Number 方法

### v1.0.4

- 修复 expandSafeArea 和固定高度产生的问题

### v1.0.3

- 组件加入 isScrollSnap、edgeEffect、headerAlign 属性
- CollapsingToolbarState 加入 collapse 和 expand 方法
- CollapsingToolbarState 加入 displayHeight 和 statusBarHeight 属性
- 修复 collapseLength 和 expandLength 都是百分比导致位移错误的问题

### v1.0.2

- 组件的 header 属性改为非必填项

### v1.0.1

- 修复 issuesICPYNQ
- 在组件中获取状态栏高度

### v1.0.0

- 发布 1.0.0 初版。

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 无 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @jackiehou/collapsing-toolbar
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c741ded1e79942f7a630ffd66ce6c1cc/PLATFORM?origin=template