# PullToRefresh 下拉刷新组件

## 简介

PullToRefresh 实现垂直列表下拉刷新，上拉加载，横向列表左拉刷新，右拉加载

## 详细介绍

### 简介

PullToRefresh 实现垂直列表下拉刷新，上拉加载，横向列表左拉刷新，右拉加载

### 下载安装

深色代码主题复制
```bash
ohpm install @zhongrui/pull_to_refresh
```

深色代码主题复制
```typescript
import {
  PullToRefreshLayout,
  RefreshLayout,
  RefreshLayoutConfig,
  PullDown,
  PullStatus,
  RefreshController,
  PullToRefreshConfig,
} from 'PullToRefresh/Index';
```

### 特点

1. 无入侵性，不需要传数据源
2. 不限制组件，支持任意布局 (List, Grid, Web, Scroll, Text, Row, Column 等布局)
3. 支持 header 和 footer 定制 (支持 Lottie 动画)
4. 支持垂直列表和横向列表的刷新和加载
5. 支持下拉 (或者上拉) 打开其他页面

### 组件介绍

提供了 RefreshLayout 和 PullToRefreshLayout

1. RefreshLayout 支持各种定制化
2. PullToRefreshLayout 是在 RefreshLayout 基础上定制的，实现常用刷新和加载功能
3. 如果没有个性化需求，可以直接使用 PullToRefreshLayout

### 效果展示

垂直 List 列表刷新效果
垂直 Grid 列表刷新效果
下拉打开其他页面
自动刷新

Web 视图刷新效果
自定义动画刷新效果
Lottie 动画刷新效果
横向列表刷新

三种横向模式 header 效果图 (footer 同理)

header 正常横向
header 宽度固定，高度撑满
header 布局逆时针旋转 90°
header 宽度撑满，高度固定和垂直列表布局方式一致
header 布局顺时针旋转 90°
header 宽度撑满，高度固定和垂直列表布局方式一致

### 缺省页设置

加载中，空数据，加载失败，无网络

### PullToRefreshLayout 使用说明 (通用方案)

(如需个性化定制，请使用 RefreshLayout)

默认带弹性效果的列表需要关闭弹性滑动，`.edgeEffect(EdgeEffect.None)`

深色代码主题复制
```typescript
@Component
export struct Example {
  /*RefreshLayout 控制器*/
  controller: RefreshController = new RefreshController()
 
  /*RefreshLayout 配置*/
  config: RefreshLayoutConfig = new RefreshLayoutConfig()
 
  /*需要将 scroller 设置给列表组件*/
  scroller: Scroller = new Scroller()
 
  /*webview 配置器*/
  webviewController: web.WebviewController = new web.WebviewController()

  build() {
    PullToRefreshLayout({
      /*非必传，headerloading 动画视图*/
      headerLoadIngView: () => {
        this.loading()
      },
      
      /*非必传，footerloading 动画视图*/
      footerLoadIngView: () => {
        this.loading()
      },
      
      /*必传，记录刷新时间的 key*/
      viewKey: "列表标识",
      
      /*非必传，设置刷新配置，不设置时自动设置默认值*/
      config: this.config,
      
      /*必传，RefreshLayout 控制器*/
      controller: this.controller,
      
      /*必传，设置和列表相关的 Scroller，比如 List,Grid,Scroll,WaterFlow 等组件*/
      scroller: this.scroller,
      
      /*如果 contentView 是 Web 组件时必传，必须设置 WebviewController，不用设置 scroller*/
      webviewController: this.webviewController,
      
      /*设置列表内容布局*/
      contentView: () => {
        this.contentView()
      },
      
      /*根据当前列表滑动距离或者其他业务逻辑判断是否可以下拉，true:可以下拉刷新，false:不能下拉*/
      onCanPullRefresh: () => {
        //判断列表是否滑到顶部
        /*默认带弹性效果的列表需要关闭弹性滑动，.edgeEffect(EdgeEffect.None)*/
        return (this.scroller.currentOffset()?.yOffset ?? 0) <= 0
      },
      
      /*根据当前列表滑动距离或者其他业务逻辑判断是否可以上拉，true:可以上拉加载，false:不能上拉*/
      onCanPullLoad: () => {
        //判断列表是否滑到底部
        return this.scroller.isAtEnd()
      },
      
      /*触发刷新*/
      onRefresh: () => {
        //可以执行刷新数据的操作
      },
      
      /*触发加载*/
      onLoad: () => {
        //可以执行加载数据的操作
      },
      
      /*下拉触发打开页面的通知*/
      onOpenPage: () => {
        //可以执行跳转页面或者其他业务逻辑操作
      },
      
      /*上拉触发打开页面的通知*/
      onLoadOpenPage: () => {
        //可以执行跳转页面或者其他业务逻辑操作
      },
    })
      .width("100%").height("100%")
  }
  
  @Builder
  contentView() {
    List({ scroller: this.scroller }) {
    }.width("100%").height("100%").edgeEffect(EdgeEffect.None)
  }
}
```

### RefreshLayout 使用说明 (可自定义扩展各种交互效果)

默认带弹性效果的列表需要关闭弹性滑动，`.edgeEffect(EdgeEffect.None)`

深色代码主题复制
```typescript
@Component
export struct Example {
  /*RefreshLayout 控制器*/
  controller: RefreshController = new RefreshController()
 
  /*RefreshLayout 配置*/
  config: RefreshLayoutConfig = new RefreshLayoutConfig()
 
  /*需要将 scroller 设置给列表组件*/
  scroller: Scroller = new Scroller()
 
  /*webview 需要配置的控制器*/
  webviewController: web.WebviewController = new web.WebviewController()

  build() {
    RefreshLayout({
      /*非必传，设置刷新配置，不设置时自动设置默认值*/
      config: this.config,
      
      /*必传，RefreshLayout 控制器*/
      controller: this.controller,
      
      /*必传，设置和列表相关的 Scroller，比如 List,Grid,Scroll,WaterFlow 等组件*/
      scroller: this.scroller,
      
      /*如果 contentView 是 Web 组件时必传，必须设置 WebviewController，不用设置 scroller*/
      webviewController: this.webviewController,
      
      /*1:设置 header 布局*/
      headerView: () => {
        this.headerView()
      },
      
      /*2：设置列表内容布局*/
      contentView: () => {
        this.contentView()
      },
      
      /*3：设置 footer 布局*/
      loadView: () => {
        this.loadView()
      },
      
      /*根据当前列表滑动距离或者其他业务逻辑判断是否可以下拉，true:可以下拉刷新，false:不能下拉*/
      onCanPullRefresh: () => {
        //判断列表是否滑到顶部
        /*默认带弹性效果的列表需要关闭弹性滑动，.edgeEffect(EdgeEffect.None)*/
        return (this.scroller.currentOffset()?.yOffset ?? 0) <= 0
      },
      
      /*根据当前列表滑动距离或者其他业务逻辑判断是否可以上拉，true:可以上拉加载，false:不能上拉*/
      onCanPullLoad: () => {
        //判断列表是否滑到底部
        return this.scroller.isAtEnd()
      },
      
      /*触发刷新*/
      onRefresh: () => {
        //可以执行刷新数据的操作
      },
      
      /*触发加载*/
      onLoad: () => {
        //可以执行加载数据的操作
      },
      
      /*下拉触发打开页面的通知*/
      onOpenPage: () => {
        //可以执行跳转页面或者其他业务逻辑操作
      },
      
      /*上拉触发打开页面的通知*/
      onLoadOpenPage: () => {
        //可以执行跳转页面或者其他业务逻辑操作
      },
      
      /*下拉或上拉过程状态监听，可以根据 onPullListener 实现自定义 header 和 footer 交互效果*/
      onPullListener: (pullDown: PullDown) => {

      }
    })
      .clip(true)//必须设置 clip:true
      .width("100%").height("100%")
  }

  @Builder
  headerView() {
  }
  
  @Builder
  contentView() {
    List({ scroller: this.scroller }) {
    }.width("100%").height("100%").edgeEffect(EdgeEffect.None)
  }
  
  @Builder
  loadView() {
  }
}
```

### RefreshController 说明

| 方法名 | 说明 | 返回值 |
| :--- | :--- | :--- |
| refreshSuccess() | 通知 RefreshLayout 刷新成功 | 无 |
| refreshError() | 通知 RefreshLayout 刷新失败 | 无 |
| refreshComplete(true or false) | 通知 RefreshLayout 刷新成功或者失败 | 无 |
| loadSuccess() | 通知 RefreshLayout 加载成功 | 无 |
| loadError() | 通知 RefreshLayout 加载失败 | 无 |
| loadComplete(true or false) | 通知 RefreshLayout 加载成功或者失败 | 无 |
| getStatus() | 获取 RefreshLayout 当前状态 | PullStatus |
| refresh() | 手动触发 RefreshLayout 刷新 | 无 |
| load() | 手动触发 RefreshLayout 加载 | 无 |
| refreshIsEnable() | 刷新开关是否打开 | boolean |
| loadIsEnable() | 加载开关是否打开 | boolean |
| setConfig(config: RefreshLayoutConfig) | RefreshLayout 配置 | 无 |
| getConfig() | 获取 RefreshLayout 配置 | RefreshLayoutConfig |
| onWebviewScroll(xOffset: number, yOffset: number) | webview 专用 (监听滑动距离) | 无 |

### RefreshLayoutConfig 说明

| 属性 | 说明 | 默认值 |
| :--- | :--- | :--- |
| isVertical | 是否是垂直列表，true:垂直，false:横向 | true |
| horizontalMode | 横向模式 0：正常横向布局，1：header 和 footer 逆时针旋转 90 度，2：header 和 footer 顺时针旋转 90 度 | 0 |
| pullRefreshEnable | 是否打开刷新开关 | true |
| pullLoadEnable | 是否打开加载更多开关 | true |

#### 刷新相关配置

| 属性 | 说明 | 默认值 |
| :--- | :--- | :--- |
| releaseRefresh | 下拉达到刷新条件，是否需要释放才触发刷新 | true |
| pullMaxDistance | 下拉最大距离 | 500vp |
| pullRefreshResistance | 下拉阻力，取值范围 (0,1] | 0.5 |
| pullHeaderHeightRefresh | 下拉距离超过多少时达到刷新条件小于等于 0 时，自动设置为 header 高度或者宽度的 1.5 倍 | 0 |
| pullRefreshOpenPageEnable | 是否开启下拉打开其他页面开关 | false |
| pullHeaderHeightOpenPage | 下拉距离超过多少时达到打开其他页面条件小于等于 0 时，自动设置为 header 高度或者宽度的 2.6 倍 | 0 |
| durationToHeader | 释放刷新时，回弹至 headerView 高度的时间 | 250ms |
| durationCloseHeader | headerView 刷新结束时回弹的时间 | 200ms |
| durationCloseForOpenPage | 打开其他页面时，布局的回弹时间 | 180ms |
| refreshKeepHeader | 刷新时是否显示 headerView | true |
| refreshShowSuccess | 是否显示刷新成功状态的 view | true |
| refreshShowError | 是否显示刷新失败状态的 view | true |
| refreshResultDurationTime | 刷新结果 view 显示持续时间 | 600ms |

#### 加载相关配置

| 属性 | 说明 | 默认值 |
| :--- | :--- | :--- |
| releaseLoad | 上拉达到加载条件，是否需要释放才触发加载 | true |
| pullLoadMaxDistance | 上拉最大距离 | 500vp |
| pullLoadResistance | 上拉阻力，取值范围 (0,1] | 0.5 |
| pullFooterHeightLoad | 上拉距离超过多少时达到刷新条件小于等于 0 时，自动设置为 footer 高度或者宽度的 1.1 倍 | 0 |
| pullLoadOpenPageEnable | 上拉打开其他页面开关 | false |
| pullFooterHeightOpenPage | 上拉距离超过多少时达到打开其他页面条件小于等于 0 时，自动设置为 footer 高度或者宽度的 2.6 倍 | 0 |
| durationToFooter | 释放刷新时，回弹至 footerView 高度的时间 | 250ms |
| durationCloseFooter | footer 布局刷新结束时回弹的时间 | 200ms |
| durationCloseLoadForOpenPage | 打开其他页面时，布局的回弹时间 | 180ms |
| loadKeepFooter | 加载时是否显示 footerView | true |
| loadShowSuccess | 是否显示加载成功状态的 view | true |
| loadShowError | 是否显示加载失败状态的 view | true |
| loadResultDurationTime | 加载结果 view 显示持续时间 | 600 |

### PullDown 说明 (通过该数据可以实现个性化交互)

| 属性 | 说明 |
| :--- | :--- |
| isPullDown | 是否是下拉 |
| isPullUp | 是否是上拉 |
| isTouch | 是否触摸 |
| distance | 下拉距离 vp |
| distanceLoad | 上拉距离 vp |
| headerViewSize | headerView 高度 vp<br>headerView 宽度 vp(如果是横向模式，且 horizontalMode==0) |
| footerViewSize | footerView 高度 vp<br>headerView 宽度 vp(如果是横向模式，且 horizontalMode==0) |
| status | 当前 PullStatus 状态 |

### PullStatus 说明

| 属性 | 说明 |
| :--- | :--- |
| DEF | 默认状态 (无下拉或上拉距离) |

#### 刷新相关状态

| 属性 | 说明 |
| :--- | :--- |
| PullDown | 下拉状态 |
| PreRefresh | 下拉达到刷新条件的状态 |
| Refresh | 正在刷新 |
| PreOpenPage | 下拉达到打开其他页面条件 |
| OpenPage | 打开其他页面 |
| RefreshSuccess | 刷新成功 |
| RefreshError | 刷新失败 |

#### 加载相关状态

| 属性 | 说明 |
| :--- | :--- |
| PullUp | 上拉状态 |
| PreLoad | 上拉达到加载条件的状态 |
| Load | 加载中 |
| PreLoadOpenPage | 上拉达到打开其他页面条件 |
| LoadOpenPage | 打开其他页面 |
| LoadOpenPage | 加载成功 |
| LoadError | 加载失败 |

## 开源协议

本项目基于 MIT license，请自由地享受和参与开源。

## 更新记录

### 1.1.7

1. 修复 PullToRefreshLayout 获取 resourceManager 崩溃问题

### 1.1.6

RefreshLayoutConfig 增加 contentParentAlign、viewLoadingParentAlign、viewEmptyParentAlign、viewErrorParentAlign、viewNoNetworkParentAlign 属性控制内容视图、正在加载中视图、空数据视图、数据加载失败视图、无网络视图的父组件 Stack 设置 alignContent

### 1.1.5

1. 修复 header 出现横线问题
2. PullToRefreshLayout 默认根据传入的 Scroller 自动计算是否可以下拉

### 1.1.4

1. 修复视图回弹或触摸过程中禁止下拉或上拉再次触摸视图和视图回弹异常问题

### 1.1.3

1. RefreshController 新增 setRefreshEnable(enable) 设置开启或禁止下拉刷新 api
2. RefreshController 新增 setLoadEnable(enable) 设置开启或禁止上拉加载 api

### 1.1.2

1. 新增属性支持外部设置 PullToRefreshLayout 的 clip 属性

### 1.1.1

1. 修复 context is invalid 问题

### 1.1.0

1. 组件挂载之前可以设置页面状态

### 1.0.9

1. 解决刷新成功缺省页面无法切换问题

### 1.0.8

1. 增加自定义缺省页方法 (刷新中、数据为空、刷新失败、无网络)

### 1.0.7

1. RefreshController 增加取消刷新、取消加载方法

### 1.0.6

1. PullToRefreshConfig 增加下拉刷新上拉加载箭头颜色配置

### 1.0.5

1. RefreshLayout 刷新成功后默认不修改是否还有更多状态

### 1.0.4

1. PullToRefreshLayout 增加简单的自定义配置

### 1.0.3

1. 触发刷新成功失败或加载成功失败之前增加是否是刷新中或者加载中状态判断

### 1.0.2

1. 补充 README 说明

### 1.0.1

1. 解决 release 包获取资源崩溃问题

### 1.0.0 初版

发布 1.0.0 初版。

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

## 兼容性

| HarmonyOS 版本 | 5.0.0 |
| :--- | :--- |

| 应用类型 | 应用 | Created with Pixso. |
| :--- | :--- | :--- |
| 元服务 | | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 平板 | | Created with Pixso. |
| PC | | Created with Pixso. |

| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |

## 安装方式

```bash
ohpm install @zhongrui/pull_to_refresh
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/13e61ac180334a87a2f21e3a0ba70dfc/PLATFORM?origin=template