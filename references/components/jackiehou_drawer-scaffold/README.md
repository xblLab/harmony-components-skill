# DrawerScaffold 抽屉组件

## 简介

DrawerScaffold 是一个左右侧抽屉类型的组件。

## 详细介绍

### 介绍

DrawerScaffold 是一个左右侧抽屉类型的组件。它允许您在内容之上放置一个可滑动的左右侧的抽屉，也可以让您的内容区域跟随这个抽屉滑动，也可以让您内容区的宽度跟随抽屉滑动而变化。

**默认样式背景模糊 Content 跟随抽屉滑动**

**宽度自适应**

### 安装教程

深色代码主题复制
```bash
ohpm install @jackiehou/drawer-scaffold
```

### 使用说明

深色代码主题复制
```typescript
import { DrawerScaffold, DrawerModifier} from '@jackiehou/drawer-scaffold'
```

深色代码主题复制
```typescript
@LocalBuilder //组件内部@Builder 建议使用@LocalBuilder，不然会碰到 this 指向的问题
 leftBuilder(modifier: DrawerModifier) {
   Column() {//也可以替换成 Stack、RelativeContainer 等其它容器组件
     //...
   }
   .attributeModifier(modifier)//一定要加上这个，不然就没效果
   .width('70%')//抽屉的宽度，自行设置
   .height('100%')
 }

 @LocalBuilder 
 contentBuilder() {
   //...
 }

 build() {
   Column() {
     DrawerScaffold({
       leftDrawerBuilder: this.leftBuilder,//左侧抽屉，如果没有则可以不填
       //rightDrawerBuilder:this.rightBuilder,//右侧抽屉，如果没有则可以不填
       contentBuilder:this.contentBuilder//您的内容，必填
     })
   }
   .height('100%')
   .width('100%')
 }
```

### DrawerScaffold 组件各项属性

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| drawerController | DrawerController | 否 | DrawerScaffold 控制器，控制开启、关闭左/右侧抽屉 |
| drawerStyle | DrawerStyle | 否 | DrawerScaffold 样式，默认是 NORMAL：在内容之上放置一个可滑动的左右侧的抽屉 |
| maskProp | Mask\|undefined | 否 | 遮罩颜色、透明度等属性 |
| dragArea | DragArea | 否 | 关闭/开启状态下可以拖动打开 drawer 的区域 |
| leftDrawerBuilder | (modifier: DrawerModifier) => void | 否 | 左侧抽屉 |
| rightDrawerBuilder | (modifier: DrawerModifier) => void | 否 | 右侧抽屉 |
| contentBuilder | () => void | 是 | content 内容 |
| onStateChanged | (oldState: number, newState: number) => void | 否 | 左/右抽屉开启关闭状态的回调函数 |

### DrawerController 控制器

| 方法名/字段名 | 参数/类型 | 说明 |
| :--- | :--- | :--- |
| LEFT_DRAWER_ID | string | 左侧 drawer 组件的 id |
| RIGHT_DRAWER_ID | string | 右侧 drawer 组件的 id |
| CONTENT_ID | string | content 的组件 id |
| state | DrawerState | DrawerModifier 组件左右侧抽屉的开启关闭状态，改变会刷新 UI（兼容 V1 和 V2 组件）） |
| animParam | AnimatorParam | 动画属性 |
| fractionChange | (old: number, now: number) => void | fraction 改变监听 |
| fraction | number | 从 Collapsed(关闭):0 到 Expanded(开启):1 |
| isOpen | isLeft:boolean (true:左侧，false：右侧) | isLeft 对应侧 drawer 是否打开，状态改变会刷新 UI（兼容 V1 和 V2 组件） |
| isClosed | -(左右侧 drawer 不能同时打开，因此无参) | 左侧或者右侧的 drawer 是否关闭，状态改变会刷新 UI（兼容 V1 和 V2 组件） |
| toggle | isLeft: boolean(true:左侧，false：右侧) , anim?:boolean(是否播放动画) | 关闭或打开对应侧的 drawer |
| openLeftDrawer | anim?:boolean(是否播放动画) | 打开左侧 drawer |
| openRightDrawer | anim?:boolean(是否播放动画) | 打开右侧 drawer |
| release | - | 释放资源 |
| create | state,animParam,fractionChange | 静态构造器方法 |

### DrawerStyle 枚举

| 枚举名称 | 说明 |
| :--- | :--- |
| NORMAL | 默认样式，Drawer 覆盖在 content 之上，并且 content 和 Drawer 之间覆盖一层蒙版 |
| CONTENT_TRANSLATE | content 跟随 drawer 平移 |
| CONTENT_AUTO_WIDTH | content 的宽度随着 parent 宽度-drawer 显示宽度变化发生改变 |
| CONTENT_TRANSLATE_WITHOUT_DRAWER | drawer 在 content 的背后，只有 content 平移，drawer 不移动 |

### Mask

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| maskOpacity | number | 抽屉彻底打开后，遮罩的透明度 |
| maskColor | ResourceColor | 遮罩颜色 |
| maskBlur | number\|undefined | 高斯模糊半径，maskOpacity>0 且 maskBlur>0 高斯模糊才生效 |

### DragArea

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| leftDragWidthInClosedLength | Length\|undefined | 在 drawer 关闭状态下，从屏幕左边的可拖动的宽度，undefined 或者为 0 不能拖动 |
| rightDragWidthInClosedLength | Length\|undefined | 在 drawer 关闭状态下，从屏幕右边的可拖动的宽度，undefined 或者为 0 不能拖动 |
| dragTypeInOpened | DragAreaType | 在 drawer 开启状态下，可拖动的区域 |

### DrawerState 枚举

| 枚举名称 | 说明 |
| :--- | :--- |
| CLOSED | 左右的 drawer 都关闭了 |
| LEFT_OPENED | 左侧 drawer 打开了 |
| RIGHT_OPENED | 右侧 drawer 打开了 |

### AnimatorParam

| 名称 | 类型 | 说明 |
| :--- | :--- | :--- |
| duration | number | 动画播放的时长，单位毫秒 |
| easing | string | 动画插值曲线，参考 AnimatorOptions 的 easing 属性 |

### DragAreaType 枚举

| 枚举名称 | 说明 |
| :--- | :--- |
| ALL | 整个 DrawerScaffold 区域，都可以拖动 |
| DRAWER | 只有 drawer 区域可以拖动 |
| NONE | 不能拖动 |
| CONTENT | 只有 Content 区域可以拖动 |

## 使用示例

上图 2 示例：
深色代码主题复制
```typescript
drawerController: DrawerController = DrawerController.create()

build() {
 Column() {
   DrawerScaffold({
     drawerController: this.drawerController, //drawer 控制器，控制开启、关闭抽屉
     drawerStyle: DrawerStyle.NORMAL, //默认遮罩效果
     dragArea: {
       leftDragWidthInClosed: '30%',//拖动左侧'30%'的区域可以打开左侧的 drawer
       rightDragWidthInClosed: '30%',//拖动右侧'30%'的区域可以打开右侧的 drawer
       dragTypeInOpened: DragAreaType.DRAWER//打开 drawer 后，拖动 drawer 区域可以关闭，其他区域拖动不能关闭
     },
     maskProp: {
       maskOpacity: 1,//遮罩透明度
       maskColor: Color.Transparent,//遮罩颜色
       maskBlur: 30 //遮罩高斯模糊半径（maskOpacity>0 && maskBlur>0）模糊才生效
     },
     leftDrawerBuilder: this.leftBuilder, //左侧抽屉，如果没有则可以不填
     rightDrawerBuilder: this.rightBuilder, //右侧抽屉，如果没有则可以不填
     contentBuilder: this.contentBuilder//您的内容，必填
   })
 }
 .height('100%')
 .width('100%')
}
```

上图 4 示例：
深色代码主题复制
```typescript
drawerController: DrawerController = DrawerController.create()

build() {
 Column() {
   DrawerScaffold({
     drawerController: this.drawerController, //drawer 控制器，控制开启、关闭抽屉
     drawerStyle: DrawerStyle.CONTENT_AUTO_WIDTH,//content 宽度自适应
     maskProp:undefined,//为 undefined 则没有遮罩
     leftDrawerBuilder: this.leftBuilder, //左侧抽屉，如果没有则可以不填
     rightDrawerBuilder: this.rightBuilder, //右侧抽屉，如果没有则可以不填
     contentBuilder: this.contentBuilder//您的内容，必填
   })
 }
 .height('100%')
 .width('100%')
}
```

## 开源协议

本项目基于 Apache License 2.0，在拷贝和借鉴代码时，请大家务必注明出处。

## 更新记录

### v1.0.7

修复 bugID4Y6Z

### v1.0.6

修复 bugICX4RD

### v1.0.5

新增 ILogger 接口，由使用方传给组件来打印 DrawerScaffold 的 log

### v1.0.4

修复在切换深色模式导致模糊效果消失的问题

### v1.0.3

修复在切换深色模式导致蒙版消失的问题

### v1.0.2

新增 DrawerStyle.CONTENT_TRANSLATE_WITHOUT_DRAWER 样式：content 平移，drawer 不移动
新增 DragAreaType.CONTENT 枚举：只有 CONTENT 区域可以拖动

### v1.0.1

修改 compatibleSdkVersion 为 5.0.0(12)

### v1.0.0

发布 1.0.0 初版。

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |
| 隐私政策 | 不涉及 | SDK 合规使用指南 | 不涉及 |
| 兼容性 | HarmonyOS 版本 | 5.0.0 | |

| 项目 | 内容 |
| :--- | :--- |
| 应用类型 | 应用<br><br>Created with Pixso. |
| 元服务 | <br><br>Created with Pixso. |
| 设备类型 | 手机<br><br>Created with Pixso. |
| 平板 | <br><br>Created with Pixso. |
| PC | <br><br>Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0<br><br>Created with Pixso. |

## 安装方式

```bash
ohpm install @jackiehou/drawer-scaffold
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/9d6e340786094d9483eafa5d1b78dd7e/PLATFORM?origin=template