# 骨架屏组件 UISkeleton

## 简介

UISkeleton 是基于 open harmony 的基础组件和动画系统开发的骨架屏组件。内置“头像、图片、文本和段落”四种基础样式；并提供高级设置参数，自定义排列方式、边距、宽高圆角等能力。

## 详细介绍

### 简介

UISkeleton 是基于 open harmony 的基础组件和动画系统开发的骨架屏组件。内置“头像、图片、文本和段落”四种基础样式；并提供高级设置参数，自定义排列方式、边距、宽高圆角等能力。

我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

```bash
ohpm install @hw-agconnect/ui-skeleton
```

#### 使用

```typescript
// 业务页面导入组件，比如 xxx.ets
import { UISkeleton, SkeletonTheme, AnimateType } from '@hw-agconnect/ui-skeleton'

// 页面布局，合理传参
UISkeleton({
    /** 切换显示 **/
    loading: true,
    ui: () => { this.childBuilder() },

    /** 动画控制 **/
    animate: AnimateType.GRADIENT,
    duration: 1500,
    delay: 500,

    /** 内置样式 **/
    theme: SkeletonTheme.AVATAR,

    /** 高级设置 **/
    options: [1],
    spaceRow: 10,
    spaceCol: 10,
    alignRow: FlexAlign.SpaceBetween,
    alignCol: FlexAlign.Start
})
```

### 约束

1. 本示例仅支持标准系统上运行，支持设备：华为手机。
2. HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
3. DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
4. HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

可以通过尾随闭包的形式写入，也可以通过传入 ui 参数实现覆盖。

### 接口

**UISkeleton(options: UISkeletonOptions)**

**UISkeletonOptions 对象说明**

| 参数名 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| loading | boolean | 否 | true 时显示骨架屏，false 时显示子组件。默认为 true。 |
| ui | CustomBuilder | 否 | 子组件接收参数。默认为空。 |
| animate | AnimateType | 否 | 动画类型。默认渐变。 |
| duration | number | 否 | 动画时长。默认 2000 毫秒。 |
| delay | number | 否 | 动画延时。防止加载过快造成的闪烁。默认为 0。 |
| theme | SkeletonTheme | 否 | 骨架屏内置主题样式。优先级低于自定义设置。 |
| options | SkeletonOptions | 否 | 自定义高级设置。 |
| spaceRow | number \| string | 否 | 行内不同列之间的距离。 |
| spaceCol | number \| string | 否 | 多行之间的距离。 |
| alignRow | FlexAlign | 否 | 骨架屏 X 轴上的排列方式。 |
| alignCol | FlexAlign | 否 | 骨架屏 Y 轴上的排列方式。 |

**AnimateType 枚举说明**

| 参数名 | 说明 |
| :--- | :--- |
| NONE | 无动画 |
| GRADIENT | 渐变 |
| FLASHED | 闪烁 |

**SkeletonTheme 枚举说明**

| 参数名 | 说明 |
| :--- | :--- |
| AVATAR | 头像 |
| IMAGE | 图片 |
| TEXT | 文本 |
| PARAGRAPH | 段落 |

以上两种枚举效果，见示例 1。

**SkeletonOptions 类型说明**

```typescript
type SkeletonOptions = Array<number | SkeletonOptionsObj | Array<SkeletonOptionsObj>>
```

原则：数组中的每一项都对应组件内的一行。

- `number`: 等于 1 时，表示当前行只有一个骨架屏；大于 1 时，表示当前行有若干个骨架屏。
- `SkeletonOptionsObj`: 表示当前行只有一个自定义设置的骨架屏。
- `Array<SkeletonOptionsObj>`: 表示当前行有若干个自定义设置的骨架屏。

**SkeletonOptionsObj 类型说明**

| 参数名 | 类型 | 说明 |
| :--- | :--- | :--- |
| type | SkeletonType | 形状。 |
| size | Length | 尺寸。覆盖宽高。 |
| width | Length | 宽度。 |
| height | Length | 高度。 |
| radius | Length | 圆角。 |
| margin | Length \| Padding | 外边距。同鸿蒙保持一致。 |

**SkeletonType 枚举说明**

| 参数名 | 说明 |
| :--- | :--- |
| CIRCLE | 圆形。圆角固定为 50%。行高的一半。 |
| RECT | 矩形。 |
| TEXT | 文本。默认圆角较小。 |

具体自定义设置效果，见示例 2。

### 事件

无

### 注意事项

- 组件使用需要在外层嵌套一层容器使用，并占满宽高。
- 【theme】参数提供固定样式，不支持修改。当设置【options】时失效。
- 【spaceRow】和【spaceCol】提供基础的行间距和列间距，如不需要，请手动设置为 0。凸出某一项，可以通过【margin】实现分隔。
- 部分参数不支持动态修改，请在初始化确定好。比如动画时长。

## 相关示例

### 示例 1: 内置样式

**示例效果**

**完整代码**

```typescript
import { UISkeleton, SkeletonTheme as ThemeType, AnimateType } from '@hw-agconnect/ui-skeleton';

@Entry
@ComponentV2
struct SkeletonTheme {
 // 切换动画
 @Local animate: AnimateType = AnimateType.GRADIENT;

 build() {
   Navigation() {
     Text('基础样式')
       .width('100%')
       .fontSize(18)
       .fontColor('rgba(0,0,0,0.9)')
       .fontWeight(FontWeight.Medium)
       .padding({
         left: 24,
         right: 24,
         top: 20,
         bottom: 16,
       });
     List({ space: 24 }) {
       /** 头像 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('头像骨架屏')
             .fontColor($r('sys.color.ohos_id_color_text_secondary'))
             .lineHeight(19);
           Column() {
             UISkeleton({ theme: ThemeType.AVATAR, animate: this.animate });
           }.width('100%').height(48);
         }.alignItems(HorizontalAlign.Start);
       };

       /** 图片 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('图片骨架屏')
             .fontColor($r('sys.color.ohos_id_color_text_secondary'))
             .lineHeight(19);
           Column() {
             UISkeleton({ theme: ThemeType.IMAGE, animate: this.animate });
           }.width('100%').height(96);
         }.alignItems(HorizontalAlign.Start);
       };

       /** 文本 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('文本骨架屏')
             .fontColor($r('sys.color.ohos_id_color_text_secondary'))
             .lineHeight(19);
           Column() {
             UISkeleton({ theme: ThemeType.TEXT, animate: this.animate });
           }.width('100%').height(50);
         }.alignItems(HorizontalAlign.Start);
       };

       /** 段落 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('段落骨架屏')
             .fontColor($r('sys.color.ohos_id_color_text_secondary'))
             .lineHeight(19);
           Column() {
             UISkeleton({ theme: ThemeType.PARAGRAPH, animate: this.animate });
           }.width('100%').height(120);
         }.alignItems(HorizontalAlign.Start);
       };

       /** 动画 **/
       ListItem() {
         Row({ space: 5 }) {
           Text('切换动画:');
           Text('关闭').margin({ left: 5 });
           Radio({ value: '0', group: 'group' }).checked(false)
             .onClick(() => {
               this.animate = AnimateType.NONE;
             });
           Text('渐变').margin({ left: 5 });
           Radio({ value: '1', group: 'group' }).checked(true)
             .onClick(() => {
               this.animate = AnimateType.GRADIENT;
             });
           Text('闪烁');
           Radio({ value: '2', group: 'group' }).checked(false)
             .onClick(() => {
               this.animate = AnimateType.FLASHED;
             });
         };
       }.margin({ top: 10 });
     }
     .padding({ left: 24, right: 24 });
   }
   .title('Skeleton 骨架屏')
   .mode(NavigationMode.Stack)
   .titleMode(NavigationTitleMode.Mini)
   .width('100%')
   .height('100%');
 }
}
```

### 示例 2: 自定义设置

**示例效果**

**完整代码**

```typescript
import { SkeletonType, UISkeleton } from '@hw-agconnect/ui-skeleton';

@Entry
@ComponentV2
struct SkeletonCustom {
 // 切换显示 - 骨架屏 or 子组件
 @Local loading: boolean = true
 // 是否显示动画
 @Local animate: boolean = true
 // 动画时长
 @Local duration: number = 1500

 build() {
   Navigation() {
     List({ space: 30 }) {
       /** 数字 **/
       ListItemGroup({ header: this.headerBuilder('数字数组'), space: 10 }) {
         ListItem() {
           Column({ space: 5 }) {
             Text('[ 1 ]').fontSize(18)
             Column() {
               UISkeleton({ options: [1] })
             }.width('100%').height(18)
           }.alignItems(HorizontalAlign.Start)
         }

         ListItem() {
           Column({ space: 5 }) {
             Text('[ 2 ]').fontSize(18)
             Column() {
               UISkeleton({ options: [2] })
             }.width('100%').height(18)
           }.alignItems(HorizontalAlign.Start)
         }

         ListItem() {
           Column({ space: 5 }) {
             Text('[ 1 , 2 ]').fontSize(18)
             Column() {
               UISkeleton({ options: [1, 2] })
             }.width('100%').height(60)
           }.alignItems(HorizontalAlign.Start)
         }
       }.padding({ left: 10, right: 10 })

       /** 对象 **/
       ListItemGroup({ header: this.headerBuilder('对象数组'), space: 10 }) {
         ListItem() {
           Column({ space: 5 }) {
             Text('[ ⚫ 50×50 ]').fontSize(18)
             Column() {
               UISkeleton({ options: [{ size: 50, type: SkeletonType.CIRCLE }] })
             }.width('100%').height(50)
           }.alignItems(HorizontalAlign.Start)
         }

         ListItem() {
           Column({ space: 5 }) {
             Text('[ □ 180×30 ]').fontSize(18)
             Column() {
               UISkeleton({ options: [{ width: 180, height: 30 }] })
             }.width('100%').height(30)
           }.alignItems(HorizontalAlign.Start)
         }

         ListItem() {
           Column({ space: 5 }) {
             Text('[ ⚫ 50×50 , □ 180×30 ]').fontSize(18)
             Column() {
               UISkeleton({ options: [{ size: 50, type: SkeletonType.CIRCLE }, { width: 180, height: 30 }] })
             }.width('100%').height(100)
           }.alignItems(HorizontalAlign.Start)
         }
       }.padding({ left: 10, right: 10 })

       /** 对象数组的数组 **/
       ListItemGroup({ header: this.headerBuilder('对象数组&数组'), space: 10 }) {
         ListItem() {
           Column({ space: 5 }) {
             Text('[ [{⚫ 50×50},{⚫ 50×50}] ]').fontSize(18)
             Column() {
               UISkeleton({
                 options: [[{ size: 50, type: SkeletonType.CIRCLE }, { size: 50, type: SkeletonType.CIRCLE }]]
               })
             }.width('100%').height(50)
           }.alignItems(HorizontalAlign.Start)
         }

         ListItem() {
           Column({ space: 5 }) {
             Text('[ [{□ 180×30},{□ 180×30}] ]').fontSize(18)
             Column() {
               UISkeleton({ options: [[{ width: 180, height: 30 }, { width: 180, height: 30 }]] })
             }.width('100%').height(35)
           }.alignItems(HorizontalAlign.Start)
         }

         ListItem() {
           Column({ space: 5 }) {
             Text('[ [{⚫ 50×50},{□ 180×30}] ,\n  [{□ 180×30},{⚫ 50×50}] ]').fontSize(18)
             Column() {
               UISkeleton({
                 options: [[{ size: 50, type: SkeletonType.CIRCLE }, { width: 180, height: 30 }],
                   [{ width: 180, height: 30 }, { size: 50, type: SkeletonType.CIRCLE }]]
               })
             }.width('100%').height(120)
           }.alignItems(HorizontalAlign.Start)
         }
       }.padding({ left: 10, right: 10 })

       /** 自由组合 **/
       ListItemGroup({ header: this.headerBuilder('组合效果'), space: 10 }) {
         ListItem() {
           Column({ space: 5 }) {
             Text('自由混排').fontSize(18)
             Column() {
               UISkeleton({
                 options: [
                   { type: SkeletonType.CIRCLE, size: 50 },
                   [{ width: '50%', height: 150, radius: 10 }, { width: '50%', height: 150, radius: 10 }],
                   1,
                 ]
               })
             }.width('100%').height(260)
           }.alignItems(HorizontalAlign.Start)
         }
       }.padding({ left: 10, right: 10 })
     }
     .divider({
       strokeWidth: 1,
       color: '#ffeeecec',
       startMargin: 5,
       endMargin: 5
     })
     .sticky(StickyStyle.Header)
     .padding({ top: 20 })
   }
   .title('自定义演示')
   .titleMode(NavigationTitleMode.Mini)
   .width('100%')
   .height('100%')
 }

 @Builder
 headerBuilder(title: string) {
   Text(title).fontColor('#7bddfa').fontSize(20).margin({ bottom: 5 })
 }
}
```

### 示例 3: 常见场景

**示例效果**

**完整代码**

```typescript
import { SkeletonTheme, UISkeleton } from '@hw-agconnect/ui-skeleton'

@Entry
@ComponentV2
struct SkeletonScene {
 // 切换显示 - 骨架屏 or 子组件
 @Local loading: boolean = true

 build() {
   Navigation() {
     List({ space: 15 }) {
       /** 标题 + 段落 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('标题 + 段落').fontColor($r('sys.color.ohos_id_color_text_secondary')).lineHeight(19)
           Column({ space: 16 }) {
             Column() {
               UISkeleton({ options: [{ width: 180, height: 20 }], loading: this.loading }) {
                 Text('骨架屏使用规范须知：')
                   .width('100%')
                   .fontSize($r('sys.float.ohos_id_text_size_headline9'))
                   .fontColor($r('sys.color.ohos_id_color_text_primary'))
                   .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
               }
             }
             .height(20).width('100%')

             Column() {
               UISkeleton({ theme: SkeletonTheme.PARAGRAPH, loading: this.loading }) {
                 Text('为提升组件的统一性，骨架屏的元素构成和排布方式与页面自身保持一致，避免出现元素错位的情况出现。额外填充内容额外填充内容额外填充内容额外填充内容......')
                   .lineHeight(24)
                   .fontSize($r('sys.float.ohos_id_text_size_body1'))
                   .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                   .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
               }
             }.height(90).width('100%')
           }
           .height(140)
           .margin({ bottom: 18 })
           .alignItems(HorizontalAlign.Start)
         }.alignItems(HorizontalAlign.Start)
       }

       /** 头像 + 标题 + 文本 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('头像 + 标题 + 文本').fontColor($r('sys.color.ohos_id_color_text_secondary')).lineHeight(19)
           Row({ space: 16 }) {
             Column() {
               UISkeleton({ theme: SkeletonTheme.AVATAR, loading: this.loading }) {
                 Image($r("app.media.skeleton_avatar")).width(48).aspectRatio(1).borderRadius(24)
               }
             }.width(48).height(48)

             Column() {
               UISkeleton({ options: [{ width: 100, height: 20 }, 1], loading: this.loading }) {
                 Column() {
                   Text('用户昵称')
                     .fontSize($r('sys.float.ohos_id_text_size_headline9'))
                     .fontColor($r('sys.color.ohos_id_color_text_primary'))
                     .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
                   Text('车遥马急，慢慢来，也是一种诚意')
                     .fontSize($r('sys.float.ohos_id_text_size_body1'))
                     .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                     .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
                 }.alignItems(HorizontalAlign.Start).justifyContent(FlexAlign.SpaceBetween).height('100%')
               }
             }.layoutWeight(1).height(48).alignItems(HorizontalAlign.Start)
           }
           .height(48)
           .alignItems(VerticalAlign.Top)
           .margin({ bottom: 18 })
         }.alignItems(HorizontalAlign.Start)
       }

       /** 图片 + 文本 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('图片 + 文本').fontColor($r('sys.color.ohos_id_color_text_secondary')).lineHeight(19)
           Row({ space: 16 }) {
             Column() {
               UISkeleton({ theme: SkeletonTheme.IMAGE, loading: this.loading }) {
                 Image($r("app.media.skeleton_view1")).width(96).aspectRatio(1).borderRadius(12)
               }
             }.width(96).height(96)

             Column() {
               UISkeleton({
                 options: [{ width: '100%', height: 20 }, { width: '100%', height: 20 }, { width: '70%', height: 20 }],
                 loading: this.loading
               }) {
                 Text('阳光轻吻山巅绿翠，天空，如梦似幻，云朵悠然，像极了你温柔的眼眸 ')
                   .lineHeight(26)
                   .fontSize($r('sys.float.ohos_id_text_size_body1'))
                   .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                   .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
                   .position({ y: -5 })
               }
             }.layoutWeight(1).height(96)
           }
           .height(96)
           .alignItems(VerticalAlign.Top)
           .margin({ bottom: 18 })
         }.alignItems(HorizontalAlign.Start)
       }

       /** 图片 + 标题 + 文本 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('图片 + 标题 + 文本').fontColor($r('sys.color.ohos_id_color_text_secondary')).lineHeight(19)
           Row({ space: 20 }) {
             Column() {
               UISkeleton({
                 options: [
                   { size: 146, radius: 12 },
                   { width: '100%', height: 20, margin: { top: 2, bottom: 6 } },
                   1, 1, { width: '70%' }
                 ],
                 loading: this.loading
               }) {
                 Image($r("app.media.skeleton_view2")).width(146).aspectRatio(1).borderRadius(12)
                 Text('日落雪山风光').margin({ top: 12, bottom: 8 })
                   .fontSize($r('sys.float.ohos_id_text_size_headline9'))
                   .fontColor($r('sys.color.ohos_id_color_text_primary'))
                   .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
                 Text('大柴旦镇那里不止有苍茫的落日，更有柔美而醉人的黄昏！')
                   .lineHeight(24)
                   .fontSize($r('sys.float.ohos_id_text_size_body1'))
                   .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                   .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
               }
             }.width(146).alignItems(HorizontalAlign.Start)

             Column() {
               UISkeleton({
                 options: [
                   { size: 146, radius: 12 },
                   { width: '100%', height: 20, margin: { top: 2, bottom: 6 } },
                   1, 1, { width: '70%' }
                 ],
                 loading: this.loading
               }) {
                 Image($r("app.media.skeleton_view3")).width(146).aspectRatio(1).borderRadius(12)
                 Text('云南洱海').margin({ top: 12, bottom: 8 })
                   .fontSize($r('sys.float.ohos_id_text_size_headline9'))
                   .fontColor($r('sys.color.ohos_id_color_text_primary'))
                   .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
                 Text('大理人的“母亲湖”，每一个旅行者心中那片纯净的向往。')
                   .lineHeight(24)
                   .fontSize($r('sys.float.ohos_id_text_size_body1'))
                   .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                   .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
               }
             }.width(146).alignItems(HorizontalAlign.Start)
           }
           .height(260)
           .margin({ bottom: 18 })
         }.alignItems(HorizontalAlign.Start)
       }

       /** 图片 + 标题 + 段落 **/
       ListItem() {
         Column({ space: 12 }) {
           Text('图片 + 标题 + 段落').fontColor($r('sys.color.ohos_id_color_text_secondary')).lineHeight(19)
           Column() {
             UISkeleton({
               options: [
                 { width: 312, height: 146, radius: 12 },
                 { width: '100%', height: 20, margin: { top: 8 } },
                 { width: '100%', height: 20, margin: { bottom: 8 } },
                 1, 1, 1, 1, 1, 1, 1
               ],
               loading: this.loading
             }) {
               Image($r("app.media.skeleton_view4")).width(312).height(146).borderRadius(12)
               Text('是你脑海中的画面吗？晚霞中的罗马尼亚乡村！').margin({ top: 16, bottom: 8 })
                 .fontSize($r('sys.float.ohos_id_text_size_headline9'))
                 .fontColor($r('sys.color.ohos_id_color_text_primary'))
                 .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
               Text('罗马尼亚乡村的自然景观极为壮观。辽阔的田野、连绵起伏的山丘和茂密的森林，共同营造出一种宁静而神秘的美感。在这里，可以欣赏到壮观的日出和日落，感受大自然的宏伟与美丽。\n' +
                 '罗马尼亚乡村还拥有丰富的文化遗产。这里的许多村庄和小镇保留着传统的建筑风格，如木制房屋、石砌教堂和古老的市场广场。')
                 .lineHeight(24)
                 .fontSize($r('sys.float.ohos_id_text_size_body1'))
                 .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                 .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
             }
           }
           .width(312).height(410)
           .margin({ bottom: 18 })
         }.alignItems(HorizontalAlign.Start)
       }
     }
     .layoutWeight(1)
     .divider({ strokeWidth: 1 })
     .padding({ top: 10, left: 24, right: 24 })

     Row({ space: 5 }) {
       Text('切换显示:')
       Text('子组件')
       Toggle({ type: ToggleType.Switch, isOn: $$this.loading })
     }.width('100%').padding({ left: 24 })
   }
   .title('使用场景')
   .titleMode(NavigationTitleMode.Mini)
   .width('100%')
   .height('100%')
 }
}
```

## 更新记录

### 1.0.0 (2025-09-29)

- Created with Pixso.

## 兼容性

| 项目 | 说明 |
| :--- | :--- |
| **HarmonyOS 版本** | 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5 |
| **应用类型** | 应用，元服务 |
| **设备类型** | 手机，平板，PC |
| **DevEco Studio 版本** | DevEco Studio 5.0.0, 5.0.1, 5.0.2, 5.0.3, 5.0.4, 5.0.5, 5.1.0, 5.1.1, 6.0.0 |

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无 | 无 | 无 |

- **隐私政策**: 不涉及
- **SDK 合规使用指南**: 不涉及

## 安装方式

```bash
ohpm install @hw-agconnect/ui-skeleton
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/515346348f5e46e2bf2957d51dc65544/2adce9bbd4cb42d58a87e6add45594b3?origin=template