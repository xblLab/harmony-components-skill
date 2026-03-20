# csp/floating-button 悬浮按钮组件

## 简介

悬浮按钮组件，功能强大，易于使用。支持自动贴边、自动隐藏、拖拽操作、自定义内容等丰富功能。

## 详细介绍

### 简介

HarmonyOS 悬浮按钮组件，功能强大，易于使用。一个基于 HarmonyOS 开发的高度可定制悬浮按钮组件，支持自动贴边、自动隐藏、拖拽操作、自定义内容等丰富功能。

### 特性亮点

- **智能交互** - 支持自动贴边、自动隐藏、拖拽阈值控制
- **高度定制** - 21 个配置参数，6 种事件回调，满足各种场景需求  
- **灵活内容** - 支持自定义组件内容，不仅限于图片
- **用户友好** - 默认右下角位置，符合用户操作习惯
- **性能优化** - 智能定时器管理，低资源占用
- **开箱即用** - 简单配置即可使用，像 ImageView 一样简单

### 快速开始

#### 安装

深色代码主题复制
```bash
ohpm i @csp/floatingbutton
```

#### 基本使用

深色代码主题复制
```typescript
// 在你的组件中使用
FloatingButton({
  content: () => {
    Text('⚙️')
      .fontSize(24)
      .fontColor(Color.White)
  },
  onClickEvent: () => {
    // 点击事件处理
    return true
  }
})
```

## API 文档

### 基础属性

| 属性名 | 类型 | 必需 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| radius | number | ✖️ | 25 | 悬浮按钮半径 |
| opacityWhenVisible | number | ✖️ | 1.0 | 可见状态透明度 |
| opacityWhenHidden | number | ✖️ | 0.5 | 隐藏状态透明度 |
| marginWhenShow | number | ✖️ | 25 | 显示时的边距 |

### 位置配置

| 属性名 | 类型 | 必需 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| initialLeft | number | ✖️ | -1 | 初始 X 坐标（-1 表示自动） |
| initialTop | number | ✖️ | 1 | 初始 Y 坐标（-1 表示自动） |

### 行为控制

| 属性名 | 类型 | 必需 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| enableAutoEdge | boolean | ✖️ | true | 开启自动贴边 |
| enableAutoHide | boolean | ✖️ | rue | 开启自动隐藏 |
| enableDragOutOfBounds | boolean | ✖️ | true | 允许拖拽超出边界 |
| enableDragWhenHidden | boolean | ✖️ | true | 隐藏时允许拖拽 |
| dragThreshold | number | ✖️ | 5 | 拖拽阈值（vp） |

### 时间配置

| 属性名 | 类型 | 必需 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| autoEdgeDelayTime | number | ✖️ | 300 | 贴边延迟时间（ms） |
| autoHideDelayTime | number | ✖️ | 3000 | 隐藏延迟时间（ms） |
| edgeAnimationDuration | number | ✖️ | 300 | 贴边动画时长（ms） |
| showAnimationDuration | number | ✖️ | 500 | 显示动画时长（ms） |
| hideAnimationDuration | number | ✖️ | 1000 | 隐藏动画时长（ms） |

### 内容配置

| 属性名 | 类型 | 必需 | 默认值 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| content | @BuilderParam | ✖️ | undefined | 自定义内容组件 |
| imageResource | string | ✖️ | $r(app.media.app_icon') | 默认图片资源 |

### 事件回调

| 事件名 | 类型 | 说明 |
| :--- | :--- | :--- |
| onClickEvent | () => boolean | 点击事件，返回 false 可阻止后续事件 |
| onEdgeEvent | () => boolean | 贴边事件，返回 false 可阻止后续事件 |
| onHideEvent | () => boolean | 隐藏事件，返回 false 可阻止后续事件 |
| onShowEvent | () => boolean | 显示事件，返回 false 可阻止后续事件 |
| onDragStartEvent | () => void | 拖拽开始事件 |
| onDragEndEvent | () => void | 拖拽结束事件 |

## 使用示例

### 基础使用 - 图片悬浮按钮

深色代码主题复制
```typescript
import { FloatingButton } from '@csp/floatingbutton';
import { promptAction } from '@kit.ArkUI';

FloatingButton({
  image: $r('app.media.startIcon'),          // 图片资源
  radius: 25,                                // 悬浮按钮半径
  marginWhenShow: 25,                        // 显示时的边距
  enableAutoEdge: true,                      // 开启自动贴边
  enableAutoHide: true,                      // 开启自动隐藏
  opacityWhenHidden: 0.5,                    // 隐藏时的透明度
  onClickEvent: (): boolean => {
    promptAction.showToast({ message: '点击了悬浮按钮' });
    return true
  }
})
```

### 高级使用 - 自定义内容悬浮按钮

深色代码主题复制
```typescript
import { FloatingButton } from '@csp/floatingbutton';
import { promptAction } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct Index {
  controller: WebviewController = new webview.WebviewController();

  @Builder
  CustomButton() {
    Column() {
      Text('⚙️')
        .fontSize(24)
        .fontColor(Color.White)
      Text('设置')
        .fontSize(10)
        .fontColor(Color.White)
        .margin({ top: 2 })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('#007AFF')
    .borderRadius(30)
  }

  build() {
    Stack() {
      // 业务内容
      Web({ src: "www.baidu.com", controller: this.controller })
        .width('100%')
        .height('100%')

      // 悬浮按钮
      FloatingButton({
        radius: 30,                                    // 悬浮按钮半径
        marginWhenShow: 25,                            // 显示时的边距
        enableAutoEdge: true,                          // 开启自动贴边
        enableAutoHide: false,                         // 关闭自动隐藏
        opacityWhenHidden: 0.5,                        // 隐藏时的透明度
        dragThreshold: 8,                              // 拖拽阈值
        // 延迟时间配置
        autoEdgeDelayTime: 500,                        // 贴边延迟时间
        autoHideDelayTime: 2000,                       // 隐藏延迟时间
        // 动画时长配置
        edgeAnimationDuration: 250,                    // 贴边动画时长
        showAnimationDuration: 400,                    // 显示动画时长
        hideAnimationDuration: 800,                    // 隐藏动画时长
        // 事件回调
        onClickEvent: (): boolean => {
          promptAction.showToast({ message: '点击了悬浮按钮' });
          if (this.controller.accessStep(-1)) {
            this.controller.backward();
          }
          return true
        },
        onEdgeEvent: (): boolean => {
          promptAction.showToast({ message: '我贴边了' });
          return true
        },
        onHideEvent: (): boolean => {
          promptAction.showToast({ message: '我隐藏了' });
          return true
        },
        onShowEvent: (): boolean => {
          promptAction.showToast({ message: '我显示了' });
          return true
        },
        onDragStartEvent: () => {
          console.info('开始拖拽悬浮按钮')
        },
        onDragEndEvent: () => {
          console.info('结束拖拽悬浮按钮')
        },
        // 自定义内容组件
        content: () => {
          this.CustomButton()
        }
      })
        .hitTestBehavior(HitTestMode.None)             // 点击事件穿透
        .width("100%")
    }
    .height('100%')
    .width('100%')
  }
}
```

## 项目结构

深色代码主题复制
```text
floating-button4-harmony-os/
├── floating-button/             # 核心组件库
│   ├── src/main/ets/pages/      # 组件源码
│   │   └── FloatingButton.ets   # 悬浮按钮组件
│   ├── Index.ets                # 导出文件
│   └── README.md                # 组件说明文档
├── entry/                       # 示例应用
│   └── src/main/ets/pages/     
│       └── Index.ets            # 使用示例
├── README.md                    # 项目主文档
└── oh-package.json5             # 项目配置
```

## 系统要求

- HarmonyOS: API 12+
- DevEco Studio: 4.0+
- ArkTS: 支持
- SDK: OpenHarmony SDK

## 开源协议

MulanPSL2

## 更新记录

1.0.4 (2025-12-02)

## 权限与隐私

### 基本信息

暂无

### 权限名称

暂无

### 权限说明

暂无

### 使用目的

暂无

## SDK 合规

不涉及

## 兼容性

### HarmonyOS 版本

5.0.0 

Created with Pixso.

### 应用类型

应用

Created with Pixso.

### 元服务

Created with Pixso.

### 设备类型

手机

Created with Pixso.

平板

Created with Pixso.

PC

Created with Pixso.

### DevEcoStudio 版本

DevEco Studio 5.0.0 

Created with Pixso.

## 安装方式

```bash
ohpm install @csp/floating-button
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/8d53b065dcf549c8b9fbd1da34df042c/PLATFORM?origin=template