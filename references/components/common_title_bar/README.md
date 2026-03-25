# CommonTitleBar 通用标题栏组件

## 简介

通用标题栏，沉浸式状态，正常状态左侧返回、居中标题、右侧更多，左中右均可自定义视图。

## 详细介绍

### 简介

一款通用标题栏，支持高度自定义，可设置沉浸式状态，正常状态下为：左侧返回、居中标题，左中右均可自定义视图。

### 效果图

### 使用说明

#### 引入仓库

#### 设置全局属性

设置全局属性：状态栏高度、是否全面屏、标题栏高度、标题栏颜色等（可忽略，使用默认配置）。

### 注意事项

因为默认返回按钮使用的 Navigation 的 NavPathStack.pop 返回方式，所以需要在主页面（MainPage.ets 或其他页面）设置：

```typescript
@Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();
```

而其他的子页面上也可以添加：

```typescript
@Consume('appPathStack') appPathStack: NavPathStack;
```

以此使用 Navigation 导航功能。

### 基础使用

```typescript
import { CommonTitleBar, TitleType } from 'common_title_bar';
import { promptAction } from '@kit.ArkUI';

@Component
export struct TitlePage {
  /**
   * rightType: TitleType.IMAGE 时，设置了 rightMorePopupData: this.rightMorePopup
   * 则会显示气泡菜单弹窗：如微信扫一扫弹窗
   */
  @State rightMorePopup: MenuItemOptions[] = [
    {
      startIcon: $r('app.media.ic_edit'),
      content: "编辑资料",
    }, {
      startIcon: $r('app.media.ic_download'),
      content: "上传信息",
    }, {
      startIcon: $r('app.media.ic_upload'),
      content: "下载信息",
    }, {
      startIcon: $r('app.media.ic_scan'),
      content: "扫一扫",
    }
  ]

  /**
   * 左侧自定义视图
   */
  @Builder
  leftBuilder() {
    Row() {
      Image($r('app.media.ic_arrow_left'))
        .height(20)
      Text('返回')
        .onClick(() => {
          promptAction.showToast({
            message: "点击了左侧自定义视图",
            duration: 1500,
          })
        })
    }
  }

  /**
   * 右侧自定义视图
   */
  @Builder
  rightBuilder() {
    Row() {
      Text('更多')
        .onClick(() => {
          promptAction.showToast({
            message: "点击了右侧自定义视图",
            duration: 1500,
          })
        })
      Image($r('app.media.ic_more'))
        .height(20)
    }
  }

  /**
   * 居中自定义视图
   */
  @Builder
  centerBuilder() {
    Row() {
      Image($r('app.media.ic_arrow_left'))
        .height(20)
      Text('居中')
        .onClick(() => {
          promptAction.showToast({
            message: "点击了居中自定义视图",
            duration: 1500,
          })
        })
      Image($r('app.media.ic_more'))
        .height(20)
    }
  }

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          CommonTitleBar({
            leftType: TitleType.NONE,
            centerType: TitleType.TEXT,
            centerText: "通用标题栏",
          })

          CommonTitleBar({
            isFullScreen: false,
            leftType: TitleType.TEXT,
            leftText: "返回",
            centerType: TitleType.TEXT,
            centerText: "非全面屏 + 左右文字",
            rightType: TitleType.TEXT,
            rightText: "更多",
          })

          /**
           * 左侧返回，右侧更多 + 气泡菜单
           */
          CommonTitleBar({
            isFullScreen: false,
            centerType: TitleType.TEXT,
            centerText: "左侧返回 + 右侧更多",
            rightType: TitleType.IMAGE,
            rightMorePopupData: this.rightMorePopup,
            rightOnClick: (menu, index) => {
              promptAction.showToast({
                message: menu?.content + '---' + index,
                duration: 1500,
              })
            }
          })

          CommonTitleBar({
            isFullScreen: false,
            centerType: TitleType.TEXT,
            centerText: "自定义点击事件",
            centerOnClick: (): void => {
              promptAction.showToast({
                message: "居中自定义事件",
                duration: 1500,
              })
            },
            leftOnClick: () => {
              promptAction.showToast({
                message: "左侧自定义事件",
                duration: 1500,
              })
            },
            rightType: TitleType.TEXT,
            rightText: "更多",
            rightOnClick: () => {
              promptAction.showToast({
                message: "右侧自定义事件",
                duration: 1500,
              })
            }
          })
          /**
           * 自定义视图
           */
          CommonTitleBar({
            isFullScreen: false,
            leftType: TitleType.CUSTOM,
            leftCustomView: this.leftBuilder,
            centerType: TitleType.CUSTOM,
            centerCustomView: this.centerBuilder,
            rightType: TitleType.CUSTOM,
            rightCustomView: this.rightBuilder
          })

          /**
           * 跑马灯效果
           */
          CommonTitleBar({
            isFullScreen: false,
            leftWidth: 80,
            leftType: TitleType.TEXT,
            leftText: "超长文本时开启跑马灯效果",
            centerWidth: 150,
            centerText: "超长文本时开启跑马灯效果，超长文本时开启跑马灯效果，超长文本时开启跑马灯效果",
            rightWidth: 80,
            rightType: TitleType.TEXT,
            rightText: "超长文本时开启跑马灯效果",
            rightTextOverflow: TextOverflow.Ellipsis
          })

          /**
           * 中间搜索框
           */
          CommonTitleBar({
            isFullScreen: false,
            leftType: TitleType.NONE,
            centerType: TitleType.SEARCH,
            searchValue: "关键字",
            searchPlaceholder: "请输入产品名称",
            searchButtonText: "搜索",
            searchButtonOptions: {
              fontSize: 14,
              fontColor: Color.Red
            },
            onChangeSearch: (value) => {
              console.log("Search:" + value)
            },
            onSubmitSearch: (value) => {
              promptAction.showToast({
                message: value,
                duration: 1500,
              })
            }
          })

          /**
           * 中间搜索框 + 左侧返回 + 右侧更多
           */
          CommonTitleBar({
            isFullScreen: false,
            rightType: TitleType.IMAGE,
            rightMorePopupData: this.rightMorePopup,
            rightOnClick: (menu, index) => {
              promptAction.showToast({
                message: menu?.content + '---' + index,
                duration: 1500,
              })
            },
            centerLeftPadding: 50,
            centerRightPadding: 50,
            centerType: TitleType.SEARCH,
            searchPlaceholder: "请输入产品名称",
            searchButtonText: "搜索",
            searchButtonOptions: {
              fontSize: 14,
              fontColor: Color.Red
            },
            onChangeSearch: (value) => {
              console.log("Search:" + value)
            },
            onSubmitSearch: (value) => {
              promptAction.showToast({
                message: value,
                duration: 1500,
              })
            }
          })
          
          /**
           * 左侧返回方式:
           * BackType.
           * POP：使用 NavPathStack.pop() 返回到上一页，默认方式
           * POP_TO_NAME：使用 NavPathStack.popToName("name") 返回到上一个 name 页面
           * POP_TO_INDEX：使用 NavPathStack.popToIndex(1) 返回到索引为 1 的页面
           * CLEAR：使用 NavPathStack.clear() 返回到根首页（清除栈中所有页面）
           * ROUTER：使用 router.back() 返回到上一页
           * 取决页面使用 Router 还是 Navigation（推荐）导航
           */
          CommonTitleBar({
            isFullScreen: false,
            centerText: "左侧返回方式",
            leftBackType: BackType.ROUTER
          })

          /**
           * 基础属性设置
           */
          CommonTitleBar({
            centerText: "基础属性设置",
            isFullScreen: true,
            statusBarHeight: 50,
            statusBarColor: Color.Blue,
            titleBarHeight: 56,
            titleBarColor: Color.Green,
            showBottomLine: true,
            bottomLineColor: Color.Red,
            bottomLineSize: 5,
          })

        }
      }
    }
    .hideTitleBar(true)
  }
}
```

## 枚举类型

### 视图类型

```typescript
export enum TitleType {
  NONE = 'none', // 空白
  TEXT = 'text', // 文字
  IMAGE = 'image', // 图标
  CUSTOM = 'custom', // 自定义
  SEARCH = 'search', // 居中搜索框
}
```

### 左侧返回方式

```typescript
/**
* 返回方式
* 使用 POP、POP_TO_NAME、POP_TO_INDEX、CLEAR，需要在 MainPage 主页面设置：@Provide('appPathStack') appPathStack: NavPathStack = new NavPathStack();
* MainPage 为其他使用 CommonTitleBar 子组件的主组件
* 如果使用以下方式，自定义左侧图图标点击事件（onClickLeftImage）即可
*/
export enum BackType {
  NONE = 'none', // 无点击事件
  ROUTER = 'router', // router.back() 返回到上一页
  POP = 'pop', // NavPathStack.pop() 返回到上一页；默认方式
  POP_TO_NAME = 'popToName', // NavPathStack.popToName("name") 返回到上一个 name 页面
  POP_TO_INDEX = 'popToIndex', // NavPathStack.popToIndex(1) 返回到索引为 1 的页面
  CLEAR = 'clear', // NavPathStack.clear() 返回到根首页（清除栈中所有页面）
}
```

## CommonTitleBar 属性介绍

| 属性 | 默认值 | 说明 |
| :--- | :--- | :--- |
| **主体设置** | | |
| `isFullScreen` | `boolean: true` | 是否是全面沉浸式屏 |
| `statusBarHeight` | `Length: 36` | 状态栏高度（全面沉浸式屏生效） |
| `titleBarHeight` | `Length: 56` | 标题栏高度 |
| `titleBarColor` | `ResourceColor: '#f5f5f5'` | 标题栏颜色 |
| `statusBarColor` | `ResourceColor: '#f5f5f5'` | 状态栏颜色 默认 等于标题栏颜色 |
| `showBottomLine` | `boolean: true` | 是否显示标题栏底部的分割线 |
| `bottomLineSize` | `Length: 1` | 标题栏底部的分割线的宽度 |
| `bottomLineColor` | `ResourceColor: "#DDDDDD"` | 标题栏分割线颜色 |
| **左侧设置** | | |
| `leftType` | `string: TitleType.IMAGE` | 左侧视图类型，默认显示返回按钮 |
| `leftWidth` | `Length: -1` | 左侧视图宽度，不设置则自适应内容 |
| `leftLeftPadding` | `Length: 15` | 左侧视图左内间距 |
| `leftRightPadding` | `Length: 5` | 左侧视图右内间距 |
| `leftText` | `ResourceStr: 'Left'` | 左侧文字 `leftType = text` 有效 |
| `leftTextColor` | `ResourceColor: "#000000"` | 左侧文字颜色 |
| `leftTextSize` | `Length: 16` | 左侧文字大小 |
| `leftTextOverflow` | `TextOverflow: TextOverflow.MARQUEE` | 左侧文本，超长时的显示方式，默认跑马灯效果 |
| `leftImageResource` | `ResourceStr/PixelMap` | 返回图标 |
| `leftImageWidth` | `Length: 26` | 左侧图标宽度 |
| `leftImageHeight` | `Length: 26` | 左侧图标高度 |
| `leftImagePadding` | `Length: 5` | 左侧图标 padding 值：图标尺寸 16，内间距各 5，保证点击范围 |
| `leftBackType` | `string: BackType.POP` | 返回方法，不设置 `leftOnClick` 的情况下生效 |
| `leftPopToName` | `string: ''` | `BackType.POP_TO_NAME` 下生效：NavPathStack.popToName("name") 方式的页面名称 |
| `leftPopToIndex` | `number: 0` | `BackType.POP_TO_INDEX` 下生效：NavPathStack.popToIndex(1) 返回到索引为 1 的页面 |
| `leftCustomView` | `@Builder` | 左侧自定义视图 |
| `leftOnClick` | `() => void` | 左侧点击事件 |
| **右侧设置** | | |
| `rightType` | `string: TitleType.NONE` | 右侧视图类型，默认无视图 |
| `rightWidth` | `Length: -1` | 右侧宽度，不设置则自适应内容 |
| `rightLeftPadding` | `Length: 5` | 右侧视图左内间距 |
| `rightRightPadding` | `Length: 15` | 右侧视图右内间距 |
| `rightText` | `ResourceStr: 'Right'` | 右侧文字 `leftType = text` 有效 |
| `rightTextColor` | `ResourceColor: "#000000"` | 右侧文字颜色 |
| `rightTextSize` | `Length: 16` | 右侧文字大小 |
| `rightTextOverflow` | `TextOverflow: TextOverflow.MARQUEE` | 右侧文本，超长时的显示方式，默认跑马灯效果 |
| `rightImageResource` | `ResourceStr/PixelMap` | 更多图标 |
| `rightMorePopupView` | `@Builder` | 更多 - 气泡菜单如果默认使用更多图标，可默认展示气泡菜单 |
| `rightMorePopupData` | `MenuItemOptions[]: []` | 气泡菜单数据列表 |
| `rightImageWidth` | `Length: 26` | 右侧图标宽度 |
| `rightImageHeight` | `Length: 26` | 右侧图标高度 |
| `rightImagePadding` | `Length: 5` | 右侧图标 padding 值：图标尺寸 16，内间距各 5，保证点击范围 |
| `rightCustomView` | `@Builder` | 右侧自定义视图 |
| `rightOnClick` | `(item?: MenuItemOptions, index?: number) => void` | 右侧点击事件 |
| **居中设置** | | |
| `centerType` | `string: TitleType.TEXT` | 居中视图类型，默认文字视图 |
| `centerWidth` | `Length: -1` | 居中宽度，不设置则自适应内容 |
| `centerText` | `ResourceStr: 'Center'` | 居中文字 `leftType= text` 有效 |
| `centerTextColor` | `ResourceColor: "#000000"` | 居中文字颜色 |
| `centerTextSize` | `Length: 16` | 居中文字大小 |
| `centerTextOverflow` | `TextOverflow: TextOverflow.MARQUEE` | 居中文本，超长时的显示方式，默认跑马灯效果 |
| `centerOnClick` | `() => void` | 居中文字点击事件 |
| `centerImageResource` | `ResourceStr/PixelMap` | 无 |
| `centerImageWidth` | `Length: 26` | 居中图标宽度 |
| `centerImageHeight` | `Length: 26` | 居中图标高度 |
| `centerImagePadding` | `Length: 5` | 居中图标 padding 值：图标尺寸 16，内间距各 5，保证点击范围 |
| `centerCustomView` | `@Builder` | 无居中自定义视图 |
| `searchValue` | `string: ''` | `centerType = TitleType.SEARCH` 生效：居中搜索框文本 |
| `searchPlaceholder` | `ResourceStr: '请输入关键字'` | 居中搜索框提示文本 |
| `searchButtonText` | `string: '搜索'` | 设置搜索框末尾搜索按钮文本 |
| `searchButtonOptions` | `SearchButtonOptions` | 设置搜索框末尾搜索按钮文本样式 |
| `onSubmitSearch` | `(value: string) => void` | 点击搜索图标、搜索按钮或者按下软键盘搜索按钮时触发该回调 |
| `onChangeSearch` | `(value: string) => void` | 输入内容发生变化时，触发该回调 |
| `centerLeftPadding` | `Length: 30` | 居中视图左内间距 |
| `centerRightPadding` | `Length: 30` | 居中视图右间距 |

## 全局属性枚举类型设置

```typescript
/**
* 全局属性设置
*/
export enum TitleGlobalAttribute {
  STATUS_BAR_HEIGHT = 'statusBarHeight', // 状态栏高度
  IS_FULL_SCREEN = 'isFullScreen', // 是否是全面屏，全面屏的标题栏高度会加上状态栏高度
  TITLE_BAR_HEIGHT = 'titleBarHeight', // 标题栏高度
  TITLE_BAR_COLOR = 'titleBarColor', // 标题栏颜色
  STATUS_BAR_COLOR = 'statusBarColor', // 状态栏颜色 默认 等于标题栏颜色
  SHOW_BOTTOM_LINE = 'showBottomLine', // 否显示标题栏底部的分割线
  BOTTOM_LINE_SIZE = 'bottomLineSize', // 标题栏底部的分割线的宽度
  BOTTOM_LINE_COLOR = 'bottomLineColor', // 标题栏分割线颜色
  LEFT_LEFT_PADDING = 'leftLeftPadding', // 左侧视图左内间距
  LEFT_RIGHT_PADDING = 'leftRightPadding', // 左侧视图右内间距
  LEFT_TEXT_COLOR = 'leftTextColor', // 左侧文字颜色
  LEFT_TEXT_SIZE = 'leftTextSize', // 左侧文字大小
  LEFT_TYPE = 'leftType', // 左侧视图类型
  LEFT_IMAGE_RESOURCE = 'leftImageResource', // 左侧图标
  LEFT_IMAGE_WIDTH = 'leftImageWidth', // 全局设置左侧图标宽度
  LEFT_IMAGE_HEIGHT = 'leftImageHeight', // 全局设置左侧图标高度
  LEFT_IMAGE_PADDING = 'leftImagePadding', // 全局设置左侧图标 padding

  RIGHT_LEFT_PADDING = 'rightLeftPadding', // 右侧视图左内间距
  RIGHT_RIGHT_PADDING = 'rightRightPadding', // 右侧视图右内间距
  RIGHT_TEXT_COLOR = 'rightTextColor', // 右侧文字颜色
  RIGHT_TEXT_SIZE = 'rightTextSize', // 右侧文字大小
  RIGHT_TYPE = 'rightType', // 右侧视图类型
  RIGHT_IMAGE_RESOURCE = 'rightImageResource', // 右侧图标
  RIGHT_IMAGE_WIDTH = 'rightImageWidth', // 右侧图标宽度
  RIGHT_IMAGE_HEIGHT = 'rightImageHeight', // 右侧图标高度
  RIGHT_IMAGE_PADDING = 'rightImagePadding', // 右侧图标 padding

  CENTER_LEFT_PADDING = 'centerLeftPadding', // 居中视图左内间距
  CENTER_RIGHT_PADDING = 'centerRightPadding', // 居中视图右内间距
  CENTER_TEXT_COLOR = 'centerTextColor', // 居中文字颜色
  CENTER_TEXT_SIZE = 'centerTextSize', // 居中文字大小
  CENTER_TYPE = 'centerType', // 居中视图类型
  CENTER_IMAGE_RESOURCE = 'centerImageResource', // 居中图标
  CENTER_IMAGE_WIDTH = 'centerImageWidth', // 居中图标宽度
  CENTER_IMAGE_HEIGHT = 'centerImageHeight', // 居中图标高度
  CENTER_IMAGE_PADDING = 'centerImagePadding', // 居中图标 padding
}
```

## CommonTitleBar 全局属性设置

统一设置，整个项目均可生效，一般位于 EntryAbility.ets 中设置：

```typescript
/**
      * 设置通用标题栏的全局属性
      * 主体设置
      */
     AppStorage.setOrCreate<boolean>(TitleGlobalAttribute.IS_FULL_SCREEN, true); // 全局设置是否是全面屏
     AppStorage.setOrCreate<number>(TitleGlobalAttribute.STATUS_BAR_HEIGHT, px2vp(area.topRect.height)); // 全局设置状态栏高度
     AppStorage.setOrCreate<number>(TitleGlobalAttribute.TITLE_BAR_HEIGHT, 56); // 全局设置标题栏高度
     AppStorage.setOrCreate<ResourceColor>(TitleGlobalAttribute.TITLE_BAR_COLOR, "#f5f5f5"); // 全局设置标题栏颜色
     AppStorage.setOrCreate<ResourceColor>(TitleGlobalAttribute.STATUS_BAR_COLOR, "#f5f5f5"); // 全局设置状态栏颜色
     AppStorage.setOrCreate<boolean>(TitleGlobalAttribute.SHOW_BOTTOM_LINE, true); // 全局设置是否显示标题栏底部的分割线
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.BOTTOM_LINE_SIZE, 1); // 全局设置标题栏底部的分割线的宽度
     AppStorage.setOrCreate<ResourceColor>(TitleGlobalAttribute.BOTTOM_LINE_COLOR, "#DDDDDD"); // 全局设置标题栏分割线颜色

     /**
      * 左侧设置
      */
     AppStorage.setOrCreate<string>(TitleGlobalAttribute.LEFT_TYPE, TitleType.IMAGE); // 全局设置左侧视图类型
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.LEFT_LEFT_PADDING, 15); // 全局设置左侧视图左内间距
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.LEFT_RIGHT_PADDING, 5); // 全局设置左侧视图右内间距
     AppStorage.setOrCreate<ResourceColor>(TitleGlobalAttribute.LEFT_TEXT_COLOR, "#000000"); // 全局设置左侧文字颜色
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.LEFT_TEXT_SIZE, 16); // 全局设置左侧文字大小
     AppStorage.setOrCreate<ResourceStr | PixelMap>(TitleGlobalAttribute.LEFT_IMAGE_RESOURCE,
       $r('app.media.ic_arrow_left')); // 全局设置左侧图标
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.LEFT_IMAGE_WIDTH, 26); // 全局设置左侧图标宽度
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.LEFT_IMAGE_HEIGHT, 26); // 全局设置左侧图标高度
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.LEFT_IMAGE_PADDING, 5); // 全局设置左侧图标 padding

     /**
      * 右侧设置
      */
     AppStorage.setOrCreate<string>(TitleGlobalAttribute.RIGHT_TYPE, TitleType.NONE); // 全局设置右侧视图类型
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.RIGHT_LEFT_PADDING, 5); // 全局设置右侧视图左内间距
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.RIGHT_RIGHT_PADDING, 15); // 全局设置右侧视图右内间距
     AppStorage.setOrCreate<ResourceColor>(TitleGlobalAttribute.RIGHT_TEXT_COLOR, "#000000"); // 全局设置右侧文字颜色
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.RIGHT_TEXT_SIZE, 16); // 全局设置右侧文字大小
     AppStorage.setOrCreate<ResourceStr | PixelMap>(TitleGlobalAttribute.RIGHT_IMAGE_RESOURCE,
       $r('app.media.ic_more')); // 全局设置左侧图标
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.RIGHT_IMAGE_WIDTH, 26); //  全局设置右侧图标宽度
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.RIGHT_IMAGE_HEIGHT, 26); // 全局设置右侧图标高度
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.RIGHT_IMAGE_PADDING, 5); // 全局设置右侧图标 padding

     /**
      * 居中设置
      */
     AppStorage.setOrCreate<string>(TitleGlobalAttribute.CENTER_TYPE, TitleType.TEXT); // 全局设置居中视图类型
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.CENTER_LEFT_PADDING, 30); // 全局设置居中视图左内间距
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.CENTER_RIGHT_PADDING, 30); // 全局设置居中视图右内间距
     AppStorage.setOrCreate<ResourceColor>(TitleGlobalAttribute.CENTER_TEXT_COLOR, "#000000"); // 全局设置居中文字颜色
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.CENTER_TEXT_SIZE, 16); // 全局设置居中文字大小
     AppStorage.setOrCreate<ResourceStr | PixelMap>(TitleGlobalAttribute.CENTER_IMAGE_RESOURCE,''); // 全局设置居中图标
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.CENTER_IMAGE_WIDTH, 26); //  全局设置居中图标宽度
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.CENTER_IMAGE_HEIGHT, 26); // 全局设置居中图标高度
     AppStorage.setOrCreate<Length>(TitleGlobalAttribute.CENTER_IMAGE_PADDING, 5); // 全局设置居中图标 padding
```

## 更新记录

**1.0.4 (2025-10-14)**

暂无权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

隐私政策：不涉及
SDK 合规使用指南：不涉及

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 支持 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install common_title_bar
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/02c6989ea4fc4508bc10efa77bd7e6bf/PLATFORM?origin=template