# 滚动吸顶组件 UIStickyScroll

## 简介

UIStickyScroll 是基于 open harmony 基础组件开发的滚动吸顶组件，支持滚动吸顶、自定义多种样式风格、滑动切换 tab 栏等功能。

## 详细介绍

### 简介

UIStickyScroll 是基于 open harmony 基础组件开发的滚动吸顶组件，支持滚动吸顶、自定义多种样式风格、滑动切换 tab 栏等功能。
我们提供两种方式：ohpm 快速集成和下载源码包手工集成，您可以根据需要选择合适的方式，下面以 ohpm 快速集成为例，描述完整集成方法。

### 快速开始

#### 安装

深色代码主题复制
```bash
ohpm install @hw-agconnect/ui-sticky-scroll
```

#### 使用

深色代码主题复制
```typescript
// 引入组件
import { UIStickyScroll, TabItem } from '@hw-agconnect/ui-sticky-scroll'
```

### 约束与限制

本示例仅支持标准系统上运行，支持设备：华为手机。

HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。

DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。

HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

### 子组件

无

### 接口

UIStickyScroll(options: UIStickyScrollOptions)

#### UIStickyScrollOptions 对象说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| headerHeight | number | 否 | 单位 vp, 默认值为 48，头部导航栏高度 |
| mainHeight | number | 否 | 单位 vp, 默认值为 154，主要信息区高度 |
| headerTitleResourceStr | ResourceStr | 否 | 头部导航栏标题 |
| iconListResource | [] | 否 | 头部导航栏右侧图标，可缺省，数量由传入图标数量控制 |
| isToggleByPan | boolean | 否 | 默认值为 true,是否根据滑动手势切换 tab |
| tabList | TabItem[] | 是 | tab 栏文字和图标信息 |
| contentBuilderParam | CustomBuilder | 是 | 内容区自定义内容 |
| mainBuilderParam | CustomBuilder | 是 | 主要信息区自定义内容 |
| backgroundBuilderParam | CustomBuilder | 是 | 版头背景自定义内容 |
| tabStyle | TabStyle | 否 | tab 栏样式 |

#### TabItem 数据结构说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| text | string | 是 | tab 文字描述 |
| value | string \| number | 是 | tab 选项值 |
| iconResource | Resource | 否 | 图标资源 |

#### TabStyle 数据结构说明

| 参数 | 类型 | 必填 | 说明 |
| :--- | :--- | :--- | :--- |
| tabIconWidth | number | 是 | 单位 vp, 默认值为 24，tab 栏图标宽度 |
| tabIconHeight | number | 是 | 单位 vp, 默认值为 24，tab 栏图标高度 |
| tabActiveColor | ResourceColor | 是 | tab 选中状态颜色 |
| tabIconColor | ResourceColor | 是 | tab 栏图标未选中状态颜色，仅支持 svg 格式 |
| tabFontColor | ResourceColor | 是 | tab 栏字体颜色 |
| tabFontFamily | ResourceStr | 是 | tab 栏字体字重 |
| tabFontSize | ResourceStr \| number | 是 | tab 栏字体大小 |
| tabHeight | number | 是 | 单位 vp, 默认值为 48，tab 栏高度 |

### 使用限制

无

### 事件

| 名称 | 功能描述 |
| :--- | :--- |
| onTabChange | ((currentTab: TabItem) => void）选择 tab 栏改变时触发 |
| onReachTop | (() => void）主要信息区滚动到顶时触发 |
| onProcess | ((ratio: number) => void）主要信息区滚动过程中触发，ratio 为 y 轴的偏移程度，取为 0-1，0 为未向上滚动，1 为滚动到顶部 |
| onBack | (() => void）点击头部导航栏返回图标时触发 |
| onTapIcon | ((index：number) => void）点击头部导航栏右侧图标时触发，需提前传入图标 |

### 示例

#### 示例 1

深色代码主题复制
```typescript
import { UIStickyScroll, TabItem } from '@hw-agconnect/ui-sticky-scroll'


@Entry
@ComponentV2
export struct UIStickyScrollDemo {
  @Local arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8]
  @Local headerHeight: number = 48
  @Local mainHeight: number = 154
  @Local headerTitle: ResourceStr = '标题--ui_sticky_scroll'
  @Local tabList: TabItem[] =
    [{ text: 'Tab 次标题一', value: 1, icon: $r('app.media.icon_star') },
      { text: 'Tab 次标题二', value: 2, icon: $r('app.media.icon_star') },
      { text: 'Tab 次标题三', value: 3, icon: $r('app.media.icon_star') }]
  @Local title: string = '云南洱海'
  //头部导航栏图标资源
  @Local iconList: Resource[] =
    [$r('app.media.icon_collection'), $r('app.media.icon_forward'), $r('app.media.icon_more')]
  scroller: Scroller = new Scroller()

  @Builder
  contentBuilder() {
    List({ space: 12 }) {
      ForEach(this.arr, (item: number, index: number) => {
        ListItem() {
          Flex() {
            Image($r('app.media.icon_avatar')).width(48).height(48).borderRadius(24).flexShrink(0)
            Column() {
              Text('用户昵称')
                .fontSize(16)
                .fontColor('#E6000000')
                .margin({ bottom: 8 })
                .lineHeight(20)
                .fontWeight(500)
                .fontFamily('HarmonyHeiTi')
              Text('喜欢旅游的中国人，一生一定要体验一次的骑行洱海，太美了。阳光，蓝天，白云，碧波，优质空气，一切都太美好，不能忘怀。')
                .fontSize(12)
                .fontColor('#99000000')
                .lineHeight(16)
                .fontWeight(500)
                .fontFamily('HarmonyHeiTi')
              Row() {
                Image($r('app.media.icon_like'))
                  .width(14)
                  .margin({ right: 9 })
                  .fillColor('#191919')
                Image($r('app.media.icon_share')).width(14).fillColor('#191919')
              }.width('100%').margin({ top: 9 }).justifyContent(FlexAlign.End)
            }.alignItems(HorizontalAlign.Start)
            .margin({ left: 16 })
          }
        }.margin({ top: index === 0 ? 19 : 0 }).height(100)
      }, (item: string) => item)
    }
    .backgroundColor('#FFFFFF')
    .padding({ left: 8, right: 8 })
    .edgeEffect(EdgeEffect.Spring)
    .scrollBar(BarState.Off)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
  }

  //主要信息区自定义内容
  @Builder
  mainBuilder() {
    Column() {
      Row() {
        Text('标题--ui_sticky_scroll')
          .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
          .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
          .fontColor('white')
      }.width('100%').height(24).margin({ bottom: 12 })

      Flex() {
        Column() {
          Image($r('app.media.icon_sticky_image')).width(90).height(90).borderRadius(6)
        }.width(90).margin({ left: 8 })

        Column() {
          Text(this.title).margin({ left: 16, top: 6 }).fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
            .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
            .fontColor('white')
          Text('阳光轻吻山巅绿翠，天空，如梦似幻，云朵悠然，像极了你温柔的眼眸')
            .fontSize($r('sys.float.ohos_id_text_size_body2'))
            .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
            .fontColor('white')
            .opacity($r('sys.float.ohos_id_alpha_content_primary'))
            .margin({ top: 10, left: 16, right: 16 })
        }.alignItems(HorizontalAlign.Start)
      }
    }
  }

  //设置版头背景
  @Builder
  backgroundBuilder() {
    Image($r('app.media.icon_bg')).width('100%').height('100%')
  }

  build() {
    Column() {
      UIStickyScroll({
        tabList: this.tabList,
        iconList: this.iconList,
        mainHeight: this.mainHeight,
        headerHeight: this.headerHeight,
        headerTitle: this.headerTitle,
        contentBuilderParam: (): void => {
          this.contentBuilder()
        },
        mainBuilderParam: (): void => {
          this.mainBuilder()
        },
        backgroundBuilderParam: (): void => {
          this.backgroundBuilder()
        },
        onTabChange: (currentTab: TabItem) => {
          console.log('当前选中 tab 为', JSON.stringify(currentTab));
        },
        //main 滚动过程触发，ratio 为 y 轴的偏移程度，取为 0-1，0 为未向上滚动，1 为滚动到顶部
        onProcess: (ratio: number) => {
          console.log('滚动比率', ratio)
        },
        //滚动到达顶部
        onReachTop: () => {
          console.log('滚动到达顶部了')
        },
        //点击返回
        onBack: () => {
          console.log('点击了返回按钮')
        },
        //点击导航栏对应图标，需传入图标才能触发
        onTapIcon: (index) => {
          console.log('点击图标对应的索引为', index)
        }
      })
    }.backgroundColor('#F1F3F5')
  }
}
```

## 更新记录

| 版本 | 日期 | 备注 |
| :--- | :--- | :--- |
| 1.0.0 | 2025-09-29 | Created with Pixso. |

## 权限与隐私基本信息

| 项目 | 内容 |
| :--- | :--- |
| 下载该版本 | 初始版本 |
| 权限名称 | 无 |
| 权限说明 | 无 |
| 使用目的 | 无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

| 兼容性 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 <br> Created with Pixso. |
| 5.0.1 | Created with Pixso. |
| 5.0.2 | Created with Pixso. |
| 5.0.3 | Created with Pixso. |
| 5.0.4 | Created with Pixso. |
| 5.0.5 | Created with Pixso. |
| 应用类型 | 应用 <br> Created with Pixso. |
| 元服务 | Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| 平板 | Created with Pixso. |
| PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 <br> Created with Pixso. |
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
ohpm install @hw-agconnect/ui-sticky-scroll
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c785ae24ab1d4ad782f894b95908ad7c/2adce9bbd4cb42d58a87e6add45594b3?origin=template