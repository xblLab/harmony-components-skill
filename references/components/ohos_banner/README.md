# banner 图片轮播组件

## 简介

适配 OpenHarmony 环境的一款 banner 库，常用于广告图片轮播场景。

## 详细介绍

### 简介

本项目是适配 OpenHarmony 环境的一款 banner 库，常用于广告图片轮播场景，基于 Swiper 进行封装，能力如下:

- 支持自动轮播。
- 支持无限轮播。
- 支持垂直轮播。
- 支持自定义指示器。
- 支持定制的翻页动画效果，目前动画只支持 8 种动效，无法做到不同动效叠加。

### Swiper 组件能力和 Banner 组件能力对比

| 能力列表 | Swiper 组件 | Banner 组件 |
| :--- | :--- | :--- |
| 自动轮播 | 支持 | 支持 |
| 无限轮播 | 支持 | 支持 |
| 垂直轮播 | 支持 | 支持 |
| 自定义指示器 | 部分支持 | 支持 |
| 指示器和 banner 分离 | 不支持 | 支持 |
| 定制翻页动画效果 | 不支持 | 支持 |

## 下载安装

深色代码主题复制
```bash
ohpm install @ohos/banner
```

## 使用说明

1. 提供了自定义轮播组件 Banner 以及自定义指示器 CircleIndicator、PixelMapIndicator、RectFIndicator、RoundLinesIndicator 组件。
2. 以自定义轮播组件 Banner 和自定义指示器 CircleIndicator 举例:

深色代码主题复制
```typescript
import { Banner,BannerOptions,AnimatedEnum,IndicatorConfig, CircleIndicator,SwiperIndicator,IData,BannerMargin,AnimatedConfig } from '@ohos/banner'

export class Data implements IData{
 str:string = '';
}

@Entry
@ComponentV2
struct BannerSamplePage {
 private swiperController: SwiperController = new SwiperController()
 private touTiaoSwiperController: SwiperController = new SwiperController()
 @Local data: IData[] = []

 @Local indicatorConfig: IndicatorConfig = new IndicatorConfig(10, 0, '#5CB85C', '#FFFFFF')
 @Local bannerSize:number = 10;

 @Local autoPlay?:boolean = true // 自定播放
 @Local indicator?:SwiperIndicator = { bool:false } // 系统的指示器配置 不启用设置 false
 @Local loop?:boolean = true // 是否开启循环
 @Local vertical?:boolean = false // 是否纵向滑动


 @Local interval?:number = 3000 // 当前 item 停滞时间
 @Local duration?:number = 800 // 子组件切换动画时长
 @Local bannerMargin:BannerMargin = {left:40, right:40};// 水平是左右的 margin，垂直为上下的 margin

 @Local animatedEnum?:AnimatedEnum = AnimatedEnum.MZScaleIn// 魅族 动画效果

 animatedSelect:number | number[] = 0
 animatedSupports:AnimatedEnum[] = [
   AnimatedEnum.NonePage,
   AnimatedEnum.AlphaPage,
   AnimatedEnum.DepthPage,
   AnimatedEnum.MZScaleIn ,
   AnimatedEnum.RotateDownPage ,
   AnimatedEnum.RotateUpPage,
   AnimatedEnum.RotateY ,
   AnimatedEnum.ScaleIn ,
   AnimatedEnum.ZoomOutPage
 ]
 animatedTypes:string[] = [
   'NonePage',
   'AlphaPage',
   'DepthPage',
   'MZScaleIn' ,
   'RotateDownPage' ,
   'RotateUpPage',
   'RotateY' ,
   'ScaleIn' ,
   'ZoomOutPage'
 ]

 @Local currentPos1:number = 0

 @Local curve?:Curve = Curve.Linear // 动画曲率

 @Local bannerOptions:BannerOptions = {
   swiperController: this.swiperController,
   autoPlay:this.autoPlay, // 自定播放
   interval:this.interval, // 当前 item 停滞时间
   indicator:this.indicator, // 系统的指示器配置 不启用设置 false
   loop:this.loop, // 是否开启循环
   duration:this.duration, // 子组件切换动画时长
   vertical:this.vertical, // 是否纵向滑动
   curve:Curve.Linear, // 动画曲率

   bannerMargin: {left:this.bannerMargin.left, right:this.bannerMargin.right},// 水平是左右的 margin，垂直为上下的 margin
   animatedEnum: AnimatedEnum.ZoomOutPage,// 动画效果

   onChange: (index:number)=>{
     console.log('dodo BannerConfigPage onChange 当前页面 index='+index)
     this.indicatorConfig.setCurrentPosition(index)
     this.itemIndex = index;
   },

   onGestureSwipe:(index: number, extraInfo: SwiperAnimationEvent)=>{
     console.log('dodo BannerConfigPage onGestureSwipe 当前页面 index='+index + ' extraInfo='+JSON.stringify(extraInfo))
   },

   onAnimationStart:(index: number, targetIndex: number, extraInfo: SwiperAnimationEvent)=>{
     console.log('dodo BannerConfigPage onAnimationStart 当前页面 index='+index + '   targetIndex='+targetIndex + ' extraInfo='+JSON.stringify(extraInfo))
   },

   onAnimationEnd:(index: number, extraInfo: SwiperAnimationEvent)=>{
     console.log('dodo BannerConfigPage onAnimationStart 当前页面 index='+index +  ' extraInfo='+JSON.stringify(extraInfo))
   }
 }
 aboutToDisappear() {

 }

 @Local itemIndex: number = 0

 aboutToAppear(): void {
   this.createNewDataList();
 }

 createNewDataList(){
   let list = new Array<IData>()
   for (let i = 1; i <= this.bannerSize; i++) {
     let data = new Data();
     data.str = '数字'+i.toString()
     list.push(data)
   }
   this.data = list
   this.indicatorConfig.setIndicatorSize(this.data.length)
 }

 createNewBannerConfig(){
   this.bannerOptions = {
     swiperController: this.swiperController,
     autoPlay:this.autoPlay, // 自定播放
     interval:this.interval, // 当前 item 停滞时间
     indicator:this.indicator, // 系统的指示器配置 不启用设置 false
     loop:this.loop, // 是否开启循环
     duration:this.duration, // 子组件切换动画时长
     vertical:this.vertical, // 是否纵向滑动
     curve:Curve.Linear, // 动画曲率

     bannerMargin: {left:this.bannerMargin.left, right:this.bannerMargin.right},// 水平是左右的 margin，垂直为上下的 margin
     animatedEnum: this.animatedSupports[this.animatedSelect as number],// 动画效果

     onChange: (index:number)=>{
       console.log('dodo BannerConfigPage onChange 当前页面 index='+index)
       this.indicatorConfig.setCurrentPosition(index)
       this.itemIndex = index;
     },

     onGestureSwipe:(index: number, extraInfo: SwiperAnimationEvent)=>{
       console.log('dodo BannerConfigPage onGestureSwipe 当前页面 index='+index + ' extraInfo='+JSON.stringify(extraInfo))
     },

     onAnimationStart:(index: number, targetIndex: number, extraInfo: SwiperAnimationEvent)=>{
       console.log('dodo BannerConfigPage onAnimationStart 当前页面 index='+index + '   targetIndex='+targetIndex + ' extraInfo='+JSON.stringify(extraInfo))
     },

     onAnimationEnd:(index: number, extraInfo: SwiperAnimationEvent)=>{
       console.log('dodo BannerConfigPage onAnimationStart 当前页面 index='+index +  ' extraInfo='+JSON.stringify(extraInfo))
     }
   }
 }

 // Banner 页面内容设置，可自定义任意内容
 BACKGROUND_COLORS = [Color.Red, Color.Orange,  Color.Pink, Color.Grey]
 IMAGE_RESOURCES = [$r('app.media.jpg1'),$r('app.media.jpg2'),$r('app.media.png3'),$r('app.media.webp5')]

 @Builder
 bannerContent(data:IData[]|Record<string,Object>[], index:number) {
   Stack({ alignContent: Alignment.Center }){
     Image(this.IMAGE_RESOURCES[index % this.IMAGE_RESOURCES.length])
       .objectFit(ImageFit.Fill)
       .width('100%')
       .height('100%')

     Flex({direction:FlexDirection.Row,justifyContent:FlexAlign.Start, alignItems:ItemAlign.Center}){
       Text(`这是第${index}个页面，用户数据为:${(data[index] as Record<string,Object>)['str']}`).fontColor(Color.White)
     }
     .position({x:0,y:200})
       .height(40).width('100%')
       .backgroundColor('#44000000')
   }
   .width('100%')
     .height(240)
 }

 build() {
   Scroll(){
     Column() {

       Text('缩放渐变动效展示 + 指示器与 banner 分离').margin({top:20,bottom:20})

       Stack() {

         Banner({
           bannerOptions: this.bannerOptions,
           currentPosition: $currentPos1,
           data: this.data,
           bannerContent: (item, index) => {
             this.bannerContent(item, index)
           }
         }).width('100%')
           .height(240)

         Flex({direction:FlexDirection.RowReverse,justifyContent:FlexAlign.Start, alignItems:ItemAlign.Center}){
         }
         .width('100%')
           .height(40)
           .position({x:0,y:200})

       }.width('100%')
         .height(240)

       Flex({direction:FlexDirection.RowReverse,justifyContent:FlexAlign.Start, alignItems:ItemAlign.Center}){
         Text(`${(this.itemIndex+1)}/${this.data.length}`).fontColor(Color.White).margin({left:20,right:40})

         CircleIndicator({ indicatorConfig: this.indicatorConfig })
       }
       .width('100%')
         .height(40)
         .backgroundColor(Color.Gray)

     }.width('100%')
   } .width('100%')
     .height('100%')

 }
```

## 接口说明

### Banner 轮播自定义组件

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| Banner | `{bannerOptions: $bannerOptions,data: $data,bannerContent: (item, index) => {this.bannerContent(item, index)}}` | `bannerOptions`: BannerOptions, `data`: IData[], `bannerContent`: (item, index) => void<br>自定义轮播组件 Banner 构造器 |

### CircleIndicator 指示器自定义组件

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| CircleIndicator | `{ indicatorConfig: $indicatorConfig }` | `indicatorConfig`: IndicatorConfig<br>圆角指示器构造器 |

### PixelMapIndicator 指示器自定义组件

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| PixelMapIndicator | `{ indicatorConfig: $indicatorConfig }` | `indicatorConfig`: IndicatorConfig<br>图像指示器构造器 |

### RectFIndicator 指示器自定义组件

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| RectFIndicator | `{ indicatorConfig: $indicatorConfig }` | `indicatorConfig`: IndicatorConfig<br>矩形指示器构造器 |

### RoundLinesIndicator 指示器自定义组件

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| RoundLinesIndicator | `{ indicatorConfig: $indicatorConfig }` | `indicatorConfig`: IndicatorConfig<br>圆角线条指示器构造器 |

### IndicatorConfig 自定义组件配置

| 使用方法 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| getNormalPixelMap() | - | 获取普通图像指示器未选中图像 |
| setNormalPixelMap(normal) | `normal`: PixelMap | 设置普通图像指示器未选中图像 |
| getSelectPixelMap() | - | 获取普通图像指示器选中图像 |
| setSelectPixelMap(select) | `select`: PixelMap | 设置普通图像指示器选中图像 |
| getHeight() | - | 获取指示器的高度 |
| setHeight(height) | `height`: number | 设置指示器的高度 |
| getRadius() | - | 获取指示器的圆角 |
| setRadius(radius) | `radius`: number | 设置指示器的圆角 |
| getSelectedWidth() | - | 获取指示器选中宽度 |
| setSelectedWidth(selectedWidth) | `selectedWidth`: number | 设置指示器选中宽度 |
| getNormalWidth() | - | 获取指示器未选中宽度 |
| setNormalWidth(normalWidth) | `normalWidth`: number | 设置指示器未选中宽度 |
| getCurrentPosition() | - | 获取指示器当前位置 |
| setCurrentPosition(currentPosition: number) | `currentPosition`: number | 设置指示器当前位置 |
| getIndicatorSpace() | - | 获取指示器间距 |
| setIndicatorSpace(indicatorSpace: number) | `indicatorSpace`: number | 设置指示器间距 |
| getSelectedColor() | - | 获取指示器选中颜色 |
| setSelectedColor(selectedColor: string) | `selectedColor`: string | 设置指示器选中颜色 |
| getNormalColor() | - | 获取指示器未选中颜色 |
| setNormalColor(normalColor: string) | `normalColor`: string | 设置指示器未选中颜色 |
| getIndicatorSize() | - | 获取指示器总数 |
| setIndicatorSize(indicatorSize: number) | `indicatorSize`: number | 设置指示器总数 |

### AnimatedEnum 动画类型支持

| 动画类型 | 展示 | 动画类型描述 |
| :--- | :--- | :--- |
| AnimatedEnum.NonePage | - | 无动画效果 |
| AnimatedEnum.AlphaPage | - | alpha 渐变 |
| AnimatedEnum.DepthPage | - | 叠层 |
| AnimatedEnum.MZScaleIn | - | 魅族效果 通常配合画廊 |
| AnimatedEnum.RotateDownPage | - | 圆形旋转翻页 中心点在下方 |
| AnimatedEnum.RotateUpPage | - | 圆形旋转翻页 中心点在上方 |
| AnimatedEnum.RotateY | - | 3D 旋转翻页 旋转轴 Y |
| AnimatedEnum.ScaleIn | - | 缩放进入 |
| AnimatedEnum.ZoomOutPage | - | 缩放 alpha 进入 |

### BannerOptions Banner 配置参数

深色代码主题复制
```typescript
export class BannerOptions{
 swiperController:SwiperController = new SwiperController();
 autoPlay?:boolean = false // 自定播放
 interval?:number = 3000 // 当前 item 停滞时间
 indicator?:SwiperIndicator = { bool: false} // 系统的指示器配置 不启用设置 false
 loop?:boolean = true // 是否开启循环
 duration?:number = 400 // 子组件切换动画时长
 vertical?:boolean = false // 是否纵向滑动
 curve?:Curve = Curve.Linear // 动画曲率
 disableSwipe?:boolean = false; // 禁止触摸

 bannerMargin?:BannerMargin = {left:0, right:0};// 水平是左右的 margin，垂直为上下的 margin
 animatedEnum?:AnimatedEnum = AnimatedEnum.NonePage// 动画效果
 animatedConfig?:AnimatedConfig = {}

 onChange?: (index:number)=>void = undefined; // swiper 当前 index 回调
 onGestureSwipe?:(index: number, extraInfo:SwiperAnimationEvent)=>void = undefined // swiper 手势回调
 onAnimationStart?:(index: number, targetIndex: number, extraInfo:SwiperAnimationEvent)=>void = undefined // swiper 动画开始回调
 onAnimationEnd?:(index: number, extraInfo:SwiperAnimationEvent)=>void = undefined // swiper 动画结束回调

}
```

## 约束与限制

在下述版本验证通过：
DevEco Studio NEXT Developer Beta3: (5.0.3.530), SDK: API12 (5.0.0.35(SP3))

## 目录结构

深色代码主题复制
```text
|---- banner
|     |---- entry  # 示例代码文件夹
        |----pages # 页面测试代码
            |----index.ets #测试文件列表
            |----BannerConfigPage.ets 		#Banner 配置展示页面
            |----IndicatorConfigPage.ets 	#Indicator 指示器配置展示页面
            |----BannerSamplePage.ets		#一些常用场景指导
|     |---- screenshots #截图
|     |---- banner  # banner 库文件夹
|           |---- src  # banner 库核心代码
            |----component
                 |----Banner.ets 			#自定义组件 Banner
                 |----BannerOptions.ets  	#自定义组件 Banner 的配置参数
                 |----TransformerBanner.ets #自定义 Banner 内容变换核心
            |---- config 					#指示器默认配置
            |---- indicator   				#指示器默认配置
                 |----CircleIndicator.ets 				#自定义指示器组件 CircleIndicator
                 |----PixelMapIndicator.ets 			#自定义指示器组件 PixelMapIndicator
                 |----RectFIndicator.ets 				#自定义指示器组件 RectFIndicator
                 |----RoundLinesIndicator.ets 			#自定义指示器组件 RoundLinesIndicator
            |---- transformer   			#动画枚举以及自定义数据传递
|           |---- index.ets  # banner 对外暴露接口
|     |---- README.MD  # 安装使用方法
|     |---- README_zh.MD  # 安装使用方法
```

## 关于混淆

代码混淆，请查看代码混淆简介
如果希望 banner 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

深色代码主题复制
```text
-keep
./oh_modules/@ohos/banner
```

## 贡献代码

使用过程中发现任何问题都可以提 issue 给组件，当然，也非常欢迎发 PR 共建。

## 开源协议

本项目基于 Apache License 2.0，请自由的享受和参与开源。

## 更新记录

### 1.1.3

Release version 1.1.3

#### 1.1.3-rc.0

fix: Fixed the issue of abnormal motion effects after switching sliding motion effects

### 1.1.2

Release 1.1.2

#### 1.1.2-rc.0

Code obfuscation

### 1.1.1

Chore:Added supported device types

### 1.1.0

发布 1.1.0 正式版本

#### 1.1.0-rc.0

ComponentV2 装饰器适配

### 1.0.1

发布 1.0.1 正式版本

#### 1.0.1-rc.7

修复使用 RectFIndicator 时出现的像素融合问题

#### 1.0.1-rc.6

修复重设 data 数据源时闪退的问题

#### 1.0.1-rc.5

修复 ScaleIn,RotateDown,RotateUp 等动效初始化时显示异常的问题

#### 1.0.1-rc.4

修改 None,Alpha,Depth,MZScaleIn,RotateY,ZoomOut 等动效初始化时显示异常的问题

#### 1.0.1-rc.3

修改预设场景下出现的组件显示异常问题

#### 1.0.1-rc.2

修改设置 currentPosition 后 UI 显示异常的问题

#### 1.0.1-rc.1

ArkTs 语法适配
适配 DevEco Studio: 4.1 Canary (4.1.3.213), SDK: API11 (4.1.2.5)

#### 1.0.1-rc.0

修复不兼容 API9 问题。

### 1.0.0

本项目是 OpenHarmony 系统的一款 banner 库，基于 Swiper 进行封装，能力如下:

- 支持自动轮播。
- 支持无限轮播。
- 支持画廊效果。
- 支持自定义指示器。
- 支持定制的翻页动画效果，目前动画只支持 8 种动效，无法做到不同动效叠加。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 隐私政策

不涉及

## SDK 合规使用指南

不涉及

## 兼容性

| HarmonyOS 版本 | 5.0.0 |
| :--- | :--- |
| Created with Pixso. | |
| 应用类型 | 应用 |
| Created with Pixso. | |
| 元服务 | |
| Created with Pixso. | |
| 设备类型 | 手机 |
| Created with Pixso. | |
| 平板 | |
| Created with Pixso. | |
| PC | |
| Created with Pixso. | |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |
| Created with Pixso. | |

## 安装方式

```bash
ohpm install @ohos/banner
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/d0a961557e424313983f7886d465f176/PLATFORM?origin=template