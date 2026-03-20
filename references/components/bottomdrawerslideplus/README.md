# 底部抽屉分段滑动 + 浮动按钮与旋转齿轮动效组件

## 简介

本示例基于 [底部抽屉滑动效果案例](https://gitee.com/harmonyos-cases/cases/tree/master/CommonAppDevelopment/feature/bottomdrawerslidecase) 开发，在利用 List 实现底部抽屉滑动效果场景，界面沉浸式（全屏）显示的基础上加上了浮动按钮与旋转齿轮动效。

## 详细介绍

视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 0:05 加载完毕：100.00%0:00 媒体流类型 直播 Seek to live, currently behind live 直播剩余时间 -0:05 1x 播放速度 2x1.75x1.5x1.25x1x, 选择 0.5x 节目段落节目段落描述关闭描述，选择字幕字幕设定，开启字幕设置弹窗关闭字幕，选择音轨画中画全屏 This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50%75%100%125%150%175%200%300%400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗

### 功能介绍

本示例基于底部抽屉滑动效果案例开发，在利用 List 实现底部抽屉滑动效果场景，界面沉浸式（全屏）显示的基础上加上了浮动按钮与旋转齿轮动效。

### 环境要求

HarmonyOS 5.0.5 以上

### 快速入门

运行 ohpm 安装本组件。

```bash
ohpm install bottomdrawerslideplus
```

ets 文件 import 自定义视图实现抽屉视图。

```typescript
import { BottomDrawer, BottomDrawerHeight, TopTitle } from 'bottomdrawerslideplus';
```

## 使用样例

```typescript
build() {
  Stack({ alignContent: Alignment.TopStart }) {
    RelativeContainer() {
      // 自定义底部组件
      BasementView()
        .id('map')

      /**
       * 抽屉视图
       * @param { ()=>void } searchAddress - 搜索视图
       * @param {()=>void} listBuilder - 列表视图
       * @param { boolean } isShow - 控制标题栏是否显示
       * @param {BottomDrawerHeight} BottomDrawerHeight - 列表阶段高度属性
       */
      BottomDrawer({
        searchAddress: this.searchAddress,
        listBuilder: ()=>{
          this.listBuilder();
        },
        isShow: this.isShow,
        bottomDrawerHeight: this.bottomDrawerHeight,
        listHeight: this.listHeight
      })
    }

    /**
     * 顶部标题
     * @param {boolean} isShow - 顶部遮蔽导航栏区域是否显示
     */
    TopTitle({
      isShow: this.isShow,
      bottomDrawerHeight: this.bottomDrawerHeight,
      listHeight: this.listHeight,
      windowHeight: this.windowHeight,
      windowWidth: this.windowWidth,
      floatIcon: $r("app.media.icon"),
      settingIcon: $r("app.media.setting"),
      onFloatClick: () => {
        promptAction.showToast({
          message: $r("app.string.bottomdrawerslidecase_promotion"),
          duration: 2000
        })
      },
      onSettingClick: () => {
        promptAction.showToast({
          message: $r("app.string.bottomdrawerslidecase_promotion"),
          duration: 2000
        })
      }
    })
      .id('title_bar')
  }.width(CommonConstants.FULL_SIZE)
    .height(CommonConstants.FULL_SIZE)
}
```

## 示例效果

实际效果演示可自行下载 APP：喵屿下载链接

## 属性 (接口) 说明

### BottomDrawer 视图属性

| 属性 | 类型 | 释义 | 默认值 |
| :--- | :--- | :--- | :--- |
| searchBuilder | ()=>void | 搜索视图 | - |
| listBuilder | ()=>void | 列表视图 | - |
| isShow | boolean | 控制标题栏是否显示 | false |
| bottomDrawerHeight | BottomDrawerHeight | 控制标题栏是否显示 | false |

### TopTitle 视图属性

| 属性 | 类型 | 释义 | 默认值 |
| :--- | :--- | :--- | :--- |
| windowHeight | number | 窗口高度 | - |
| windowWidth | number | 窗口宽度 | - |
| isShow | boolean | 控制顶部标题栏是否显示 | false |
| listHeight | number | 列表高度 | - |
| bottomDrawerHeight | BottomDrawerHeight | 抽屉组件阶段高度属性 | - |
| floatIcon | Resource | 浮动按钮图标资源 | - |
| settingIcon | Resource | 设置按钮图标资源 | - |
| onFloatClick | ()=>void | 浮动按钮点击事件 | - |
| onSettingClick | ()=>void | 设置按钮点击事件 | - |

## 实现思路

本例涉及的关键特性和实现方案如下：

1. 使用 RelativeContainer 和 Stack 布局，实现可滑动列表在页面在底部，且在列表滑动到页面顶部时，显示页面顶部标题栏。

```typescript
Stack({ alignContent: Alignment.TopStart }) {
  RelativeContainer() {
    // Image 地图
    ImageMapView()
    // 底部可变分阶段滑动列表
    BottomDrawer({
      searchAddress: this.searchAddress,
      listBuilder: this.listBuilder,
      isShow: this.isShow,
      bottomDrawerHeight: this.bottomDrawerHeight
    }).id('scrollPart')
      .alignRules({
        'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
        'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
        'right': { 'anchor': '__container__', 'align': HorizontalAlign.End },
      })
  }
  TopTitle({
    isShow: this.isShow
  })
    .id('title_bar')
}
```

2. 通过对 List 设置组合手势，记录手指按下和离开屏幕纵坐标，判断手势是上/下滑。

```typescript
Column() {
  List(){
    ...
  }
}.gesture(
  // 以下组合手势为顺序识别，当长按手势事件未正常触发时则不会触发拖动手势事件
   GestureGroup(GestureMode.Sequence,
     PanGesture()
       .onActionStart((event: GestureEvent) => {
         this.yStart = event.offsetY;
      })
       .onActionUpdate((event: GestureEvent) => {
         const yEnd = event.offsetY; // 手指离开屏幕的纵坐标
         const height = Math.abs(Math.abs(yEnd) - Math.abs(this.yStart)); // 手指在屏幕上的滑动距离
         if (yEnd < this.yStart) {
           this.isUp = true;
           const temHeight = this.listHeight + height;
           if (temHeight >= this.bottomDrawerHeight.maxHeight) {
             this.isScroll = true;
             this.isShow = true;
             this.listHeight = this.bottomDrawerHeight.maxHeight;
           } else {
             this.isScroll = false;
             this.listHeight = temHeight;
           }
         }
         // 判断下滑，且 list 跟随手势滑动
         else {
           this.isUp = false;
           const temHeight = this.listHeight - height;
           if (this.itemNumber === 0) {
             // 列表高度随滑动高度变化
             this.listHeight = temHeight;
           } else {
             this.listHeight = this.bottomDrawerHeight.maxHeight;
           }
         }
         this.yStart = event?.offsetY;
      })
       .onActionEnd(() => {
         ...
       })
   )
 )
```

3. 根据手指滑动的长度对列表高度进行改变（以上滑为例）。

```typescript
this.isScroll = false;
this.listHeight = temHeight;
```

4. 在手指滑动结束离开屏幕后，通过判断此时列表高度处于哪个区间，为列表赋予相应的高度（以上滑为例）。

```typescript
.onActionEnd(() => {
  if (this.isUp) {
    // 分阶段滑动，当 list 高度位于第一个 item 和第二个 item 之间时，滑动到第二个 item
    if (this.listHeight > this.bottomDrawerHeight.minHeight &&
      this.listHeight <= this.bottomDrawerHeight.middleHeight + this.bottomAvoidHeight) {
      this.listHeight = this.bottomDrawerHeight.middleHeight;
      this.isScroll = false;
      this.isShow = false;
      return;
    }
    // 分阶段滑动，当 list 高度位于顶部和第二个 item 之间时，滑动到页面顶部
    else if (this.bottomDrawerHeight.middleHeight + this.bottomAvoidHeight < this.listHeight &&
      this.listHeight <= this.bottomDrawerHeight.maxHeight) {
      this.listHeight = this.bottomDrawerHeight.maxHeight;
      this.isShow = true;
      return;
    }
  }
  // 列表下滑时，分阶段滑动
  else {
    if (this.listHeight === this.bottomDrawerHeight.maxHeight) {
      this.isShow = true;
      this.isScroll = true;
      this.listHeight = this.bottomDrawerHeight.maxHeight;
    }
    // 分阶段滑动，当 list 高度位于顶部和第二个 item 之间时，滑动到第二个 item
    else if (this.listHeight >=
    this.bottomDrawerHeight.middleHeight &&
      this.listHeight <= this.bottomDrawerHeight.maxHeight) {
      this.listHeight =
        this.bottomDrawerHeight.middleHeight;
      this.isShow = false;
      this.isScroll = false;
      return;
    }
    // 分阶段滑动，当 list 高度位于第一个 item 和第二个 item 之间时，滑动到第一个 item
    else if (this.listHeight <=
      this.bottomDrawerHeight.middleHeight + this.bottomAvoidHeight ||
      this.listHeight <= this.bottomDrawerHeight.minHeight) {
      this.listHeight = this.bottomDrawerHeight.minHeight;
      this.isShow = false;
      this.isScroll = false;
      return;
    }
  }
})
```

5. 标题栏的浮动按钮移动和跟随抽屉效果

```typescript
Image(this.floatIcon)
  .width(35)
  .height(35)
  //通过标题栏的显示状态控制图片缩放
  .scale({ x: (this.isShow && this.showClaw) ? 1 : 1.7, y: (this.isShow && this.showClaw) ? 1 : 1.7 })
  .draggable(false)
  .clickEffect({ level: ClickEffectLevel.HEAVY, scale: 0.5 })
  .opacity(this.showClaw ? 1 : 0)
  .margin({
    right: $r("app.integer.bottomdrawerslidecase_number_15"),
  })
  //通过跟随 this.listHeight 变化控制图片位置，通过动画时长来实现延迟漂浮效果
  .position((this.isShow || !this.showClaw) ? null :
    { x: this.windowWidth - 50, y: this.windowHeight - this.listHeight - 95 })
  .animation({
    duration: 1000, // 动画持续时间，单位毫秒
    curve: Curve.EaseOut, // 动画曲线
    iterations: 1, // 动画播放次数
    playMode: PlayMode.Normal// 动画播放模式
  })
  .onClick(() => {
    this.onFloatClick()
  })
```

## 权限要求

无

## 技术支持

## 开源许可协议

该代码经过 Apache 2.0 授权许可。

## 获取方式

https://gitee.com/akensx/bottomdrawerslidepluscase.git

## 更新记录

- **1.2.0** (2026-01-27): 优化 README 优化导出组件
- **1.1.0** (2026-01-27): 上架生态市场优化权限与隐私

## 基本信息

| 项目 | 内容 | 备注 |
| :--- | :--- | :--- |
| 权限名称 | 无 | Created with Pixso. |
| 权限说明 | 无 | Created with Pixso. |
| 使用目的 | 无 | Created with Pixso. |
| 隐私政策 | 不涉及 | Created with Pixso. |
| SDK 合规 | 不涉及 | Created with Pixso. |
| 使用指南 | 不涉及 | Created with Pixso. |
| 兼容性 | HarmonyOS 版本 | Created with Pixso. |
| 5.0.5 | | Created with Pixso. |
| 5.1.0 | | Created with Pixso. |
| 5.1.1 | | Created with Pixso. |
| 6.0.0 | | Created with Pixso. |
| 6.0.1 | | Created with Pixso. |
| 6.0.2 | | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 元服务 | | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 平板 | | Created with Pixso. |
| PC | | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | | Created with Pixso. |
| DevEco Studio 5.1.1 | | Created with Pixso. |
| DevEco Studio 6.0.0 | | Created with Pixso. |
| DevEco Studio 6.0.1 | | Created with Pixso. |
| DevEco Studio 6.0.2 | | Created with Pixso. |

## 安装方式

```bash
ohpm install bottomdrawerslideplus
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/cd0956c523ea4ff1bb4b729cf4eb6c00/DEVELOPER?origin=template