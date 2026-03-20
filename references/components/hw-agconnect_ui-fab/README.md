# 悬浮按钮组件 UIFab

## 简介

UIFab 是基于 open harmony 基础组件开发的悬浮按钮组件，点击可展开一个或多个按钮菜单。

## 详细介绍

### 简介

UIFab 是基于 open harmony 基础组件开发的悬浮按钮组件，点击可展开一个或多个按钮菜单。支持跟手拖动。

### 约束与限制

#### 环境

- **DevEco Studio 版本**：DevEco Studio 5.0.0 Release 及以上
- **HarmonyOS SDK 版本**：HarmonyOS 5.0.0 Release SDK 及以上
- **设备类型**：华为手机（包括双折叠和阔折叠）、平板
- **系统版本**：HarmonyOS 5.0.0(12) 及以上

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 使用

#### 安装组件

```bash
ohpm install @hw-agconnect/ui-fab
```

当前组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请参考以下命令获取 1.0.0 版本组件。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。

```bash
ohpm install @hw-agconnect/ui-fab@1.0.0
```

#### 引入组件

```typescript
import { PopMenuContent, TypeFab, TypeClick, UIFab } from '@hw-agconnect/ui-fab';
```

#### 调用组件

详细参数配置说明参见 API 参考。

```typescript
UIFab({
     fabPosition: { x: 16, y: 16 },
     fabColor: Color.Blue,
     darkIcon: false,
     clickChange: TypeClick.NONE,
     content: [
       {
         id: '1',
         iconPath: $r('app.media.app_icon'),
         iconSelectedPath: $r('app.media.ic_add'),
         text: 'text1',
         popClick: () => {
           console.info('text1: success')
         }
       }
     ],
   })
```

### API 参考

#### 子组件

无

#### 接口

`UIFab(options: UIFabOptions)`

悬浮按钮组件。

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| options | UIFabOptions | 否 | 配置悬浮按钮组件的参数。 |

##### UIFabOptions 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| fabPosition | Position \| Edges \| LocalizedEdges | 否 | fab 按钮的位置，默认值 `{left:16,bottom:16}`，在左下角 |
| enableDrag | boolean | 否 | 是否支持跟手拖动，默认 false |
| fabColor | ResourceStr | 否 | fab 按钮颜色 |
| darkIcon | boolean | 否 | 图标颜色为深色还是浅色，默值 false，为浅色 |
| iconImage | ResourceStr | 否 | fab 按钮中的图标 |
| showIconImage | ResourceStr | 否 | fab 按钮展开后的图标 |
| clickChange | TypeClick | 否 | 展开菜单选项点击后的效果，默认无效果，TypeClick.NONE |
| isVertical | boolean | 否 | 展开的菜单是横向还是纵向，默认为 false，横向 |
| maxWidth | number | 否 | 当展开菜单横向时，最大宽度，默认值为 280vp |
| maxHeight | number | 否 | 当展开菜单纵向时，最大高度，默认值为 280vp |
| popMenuStyle | TypeFab | 否 | 展开菜单的展开方向，默认向上和向右展开，TypeFab.RIGHT_UP |
| content | popMenuContent[] | 否 | 展开菜单的内容 |

##### TypeClick 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| NONE | 禁用图标点击发生改变的效果 |
| ICON_CHANGE | 点击后图标发生变化 |
| BACKGROUND_CHANGE | 点击后背景发生变化 |
| ALL | 点击后图标和背景都发生变化 |

##### TypeFab 枚举说明

| 名称 | 说明 |
| :--- | :--- |
| RIGHT_UNDER | 展开菜单向右和向下展开 |
| RIGHT_UP | 展开菜单向右和向上展开 |
| LEFT_UNDER | 展开菜单向左和向下展开 |
| LEFT_UP | 展开菜单向左和向上展开 |

##### PopMenuContent 对象说明

| 名称 | 类型 | 是否必填 | 说明 |
| :--- | :--- | :--- | :--- |
| id | string | 是 | 分类 id，唯一索引，不能重复 |
| iconPath | ResourceStr | 是 | 菜单图标点击前的路径 |
| iconSelectedPath | ResourceStr | 是 | 菜单图标点击后的路径 |
| text | string | 是 | 菜单文本内容。菜单纵向展开时，text 文本内的中文最大字数为 3，英文最大字数为 6，超出则不显示。菜单横向展开时，text 文本内的中文最大字数为 10，英文最大字数为 20，超出以省略号显示。 |
| popClick | () => void | 是 | 菜单图标点击事件 |

### 示例代码

#### 示例 1

```typescript
import { PopMenuContent, TypeFab, UIFab } from '@hw-agconnect/ui-fab';

@Entry
@ComponentV2
struct FabChangePosition {
 @Local fabColor: ResourceColor = Color.Blue;
 @Local isVertical: boolean = false;
 @Local enableDrag: boolean = false;
 @Local popMenuStyle: TypeFab = TypeFab.RIGHT_UNDER;
 @Local iconColor: boolean = false;
 @Local positionFab: Position | Edges | LocalizedEdges = { left: 16, top: 16 };
 @Local center: Edges = { left: 0, top: 0 };

 build() {
   Column() {
     Column({ space: 4 }) {
       Button(this.isVertical ? '纵向菜单' : '横向菜单')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.isVertical = !this.isVertical;
         })

       Button(this.enableDrag ? '支持拖动' : '不支持拖动')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.enableDrag = !this.enableDrag;
         })

       Button('fab 放在左上角')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.positionFab = { left: 16, top: 16 };
           this.popMenuStyle = TypeFab.RIGHT_UNDER;
         })
       Button('fab 放在右上角')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.positionFab = { right: 16, top: 16 };
           this.popMenuStyle = TypeFab.LEFT_UNDER;
         })
       Button('fab 放在左下角')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.positionFab = { left: 16, bottom: 16 };
           this.popMenuStyle = TypeFab.RIGHT_UP;
         })
       Button('fab 放在右下角')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.positionFab = { right: 16, bottom: 16 };
           this.popMenuStyle = TypeFab.LEFT_UP;
         })
       Button('fab 放在中间')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.positionFab = { top: this.center.top, left: this.center.left };
         })
       Button('菜单展开方向为右和下')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.popMenuStyle = TypeFab.RIGHT_UNDER;
         })
       Button('菜单展开方向为左和下')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.popMenuStyle = TypeFab.LEFT_UNDER;
         })
       Button('菜单展开方向为右和上')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.popMenuStyle = TypeFab.RIGHT_UP;
         })
       Button('菜单展开方向为左和上')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.popMenuStyle = TypeFab.LEFT_UP;
         })
       Button('更改图标颜色')
         .type(ButtonType.Capsule)
         .onClick(() => {
           if (this.fabColor == Color.Red) {
             this.fabColor = Color.Blue;
           } else if (this.fabColor == Color.Blue) {
             this.fabColor = Color.Red;
           }
         })
       Button('更改 icon 深浅色')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.iconColor = !this.iconColor;
         })
     }
     .backgroundColor(Color.Gray)
     .justifyContent(FlexAlign.Center)
     .height('100%')
     .width('100%')

     UIFab({
       fabColor: this.fabColor,
       popMenuStyle: this.popMenuStyle,
       fabPosition: this.positionFab,
       enableDrag: this.enableDrag,
       darkIcon: this.iconColor,
       isVertical: this.isVertical,
       content: [
         new PopMenuContent(
           '1',
           $r('app.media.icon_image'),
           $r('app.media.icon_image'),
           '文字文字文字文字文字文字',
           () => {
             console.info('text1: success');
           }),
         new PopMenuContent(
           '2',
           $r('app.media.icon_image'),
           $r('app.media.icon_image'),
           'text12345',
           () => {
             console.info('text2: success');
           }),
         new PopMenuContent(
           '3',
           $r('app.media.icon_image'),
           $r('app.media.icon_image'),
           'text3',
           () => {
             console.info('text3: success');
           }),
         new PopMenuContent(
           '4',
           $r('app.media.icon_image'),
           $r('app.media.icon_image'),
           'text4',
           () => {
             console.info('text4: success');
           }),
         new PopMenuContent(
           '5',
           $r('app.media.icon_image'),
           $r('app.media.icon_image'),
           'text5',
           () => {
             console.info('text5: success');
           }),
         new PopMenuContent(
           '6',
           $r('app.media.icon_image'),
           $r('app.media.icon_image'),
           'text6',
           () => {
             console.info('text6: success');
           }),
       ],
     })
   }
   .height('100%')
   .width('100%')
   .onSizeChange((_, n) => {
     this.center.left = (n.width as number) / 2 - 20;
     this.center.top = (n.height as number) / 2;
   })
 }
}
```

#### 示例 2

```typescript
import { PopMenuContent, TypeClick, UIFab } from '@hw-agconnect/ui-fab';

@Entry
@ComponentV2
struct FabChangeMenu {
 @Local isVertical: boolean = false;
 @Local iconImage: ResourceStr = $r('app.media.ic_public_menu')
 @Local showIconImage: ResourceStr = $r('app.media.ic_public_expand')
 @Local clickChange: TypeClick = TypeClick.NONE

 build() {
   Column() {
     Column({ space: 4 }) {
       Button(this.isVertical ? '纵向菜单' : '横向菜单')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.isVertical = !this.isVertical;
         })
       Button('更换 fab 按钮的图标')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.iconImage = $r('app.media.ic_public_add');
           this.showIconImage = $r('app.media.ic_public_favor_filled');
         })
       Button('展开菜单的点击样式：无样式')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.clickChange = TypeClick.NONE;
         })
       Button('展开菜单的点击样式：更换图标')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.clickChange = TypeClick.ICON_CHANGE;
         })
       Button('展开菜单的点击样式：点击后背板颜色变深')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.clickChange = TypeClick.BACKGROUND_CHANGE;
         })
       Button('展开菜单的点击样式：全部样式')
         .type(ButtonType.Capsule)
         .onClick(() => {
           this.clickChange = TypeClick.ALL;
         })
     }
     .backgroundColor(Color.Gray)
     .justifyContent(FlexAlign.Center)
     .height('100%')
     .width('100%')

     UIFab({
       iconImage: this.iconImage,
       showIconImage: this.showIconImage,
       clickChange: this.clickChange,
       isVertical: this.isVertical,
       content: [
         new PopMenuContent(
           '1',
           $r('app.media.icon_image'),
           $r('app.media.ic_public_favor_filled'),
           '文字文字文字文字文字',
           () => {
             console.info('text1: success');
           }),
         new PopMenuContent(
           '2',
           $r('app.media.icon_image'),
           $r('app.media.ic_public_favor_filled'),
           'text2345',
           () => {
             console.info('text2: success');
           }),
         new PopMenuContent(
           '3',
           $r('app.media.icon_image'),
           $r('app.media.ic_public_favor_filled'),
           'text3',
           () => {
             console.info('text3: success');
           }),
         new PopMenuContent(
           '4',
           $r('app.media.icon_image'),
           $r('app.media.ic_public_favor_filled'),
           'text4',
           () => {
             console.info('text4: success');
           }),
         new PopMenuContent(
           '5',
           $r('app.media.icon_image'),
           $r('app.media.ic_public_favor_filled'),
           'text5',
           () => {
             console.info('text5: success');
           }),
         new PopMenuContent(
           '6',
           $r('app.media.icon_image'),
           $r('app.media.ic_public_favor_filled'),
           'text6',
           () => {
             console.info('text6: success');
           }),
       ],
     })
   }
   .height('100%')
   .width('100%')
 }
}
```

### 更新记录

#### 2.0.0 (2025-11-03)

Created with Pixso.

下载该版本

1. 从 V2.0.* 版本开始，组件已使用状态管理 V2 版本，如果您开发工程使用 V1 版本，请下载 1.0.0 版本。关于状态管理 V1 和 V2 版本的区别，请参见"状态管理版本介绍"。
2. 支持跟手拖动

#### 1.0.0 (2025-09-30)

Created with Pixso.

下载该版本

初始版本

### 权限与隐私

#### 基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

#### 隐私政策

不涉及

#### SDK 合规使用指南

不涉及

### 兼容性

#### HarmonyOS 版本

| 版本 | 备注 |
| :--- | :--- |
| 5.0.0 | Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |

#### 应用类型

| 类型 | 备注 |
| :--- | :--- |
| 应用 | Created with Pixso. |
| 元服务 | Created with Pixso. |

#### 设备类型

| 类型 | 备注 |
| :--- | :--- |
| 手机 | Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |

#### DevEcoStudio 版本

| 版本 | 备注 |
| :--- | :--- |
| DevEco Studio 5.0.0 | Created with Pixso. |
| DevEco Studio 5.0.1 | Created with Pixso. |
| DevEco Studio 5.0.2 | Created with Pixso. |
| DevEco Studio 5.0.3 | Created with Pixso. |
| DevEco Studio 5.0.4 | Created with Pixso. |
| DevEco Studio 5.0.5 | Created with Pixso. |
| DevEco Studio 5.1.0 | Created with Pixso. |
| DevEco Studio 5.1.1 | Created with Pixso. |
| DevEco Studio 6.0.0 | Created with Pixso. |

## 安装方式

```bash
ohpm install @hw-agconnect/ui-fab
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/0df9a6706a834803af87da9f26e65412/2adce9bbd4cb42d58a87e6add45594b3?origin=template