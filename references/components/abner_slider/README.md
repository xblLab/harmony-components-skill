# 滑块验证 slider 组件

## 简介

slider 是一个支持简单便捷的滑块验证组件，无论背景还是滑块等样式，均可自定义实现。

## 详细介绍

### 功能介绍

slider 是一个支持简单便捷的滑块验证组件，无论背景还是滑块等样式，均可自定义实现。

### 环境要求

Api 适用版本：>=12

### 示例效果

**动态效果**

**静态效果**

### 快速入门

#### 方式一

在 Terminal 窗口中，执行如下命令安装三方包，DevEco Studio 会自动在工程的 oh-package.json5 中自动添加三方包依赖。

建议：在使用的模块路径下进行执行命令。

```bash
ohpm install @abner/slider
```

#### 方式二

在需要的模块中的 oh-package.json5 中设置三方包依赖，配置示例如下：

```json5
"dependencies": { "@abner/slider": "^1.0.0"}
```

### 使用样例

目前默认的是常规的绿色验证样式，如果符合需求，可以直接使用。

```typescript
SliderDragView({
  onComplete: () => {
    //滑动完成
    console.log("=======滑动完成")
  }
})
```

### 自定义组件形式

目前支持所有的样式自定义，需要自己来逐一实现自己需要的 UI。

```typescript
SliderDragView({
  sText: "拖动滑块滑动",
  sCompleteText: "完成验证",
  defaultView: () => {
    //自定义默认视图
    this.defaultView()
  },
  sliderView: () => {
    //自定义滑动视图
    this.sliderView()
  },
  thumbSlidingView: () => {
    //自定义滑块滑动中视图
    this.thumbSlidingView()
  },
  thumbCompleteView: () => {
    //自定义滑块完成视图
    this.thumbCompleteView()
  },
  onComplete: () => {
    //滑动完成
    console.log("=======滑动完成")
  }
}).margin({ top: 20 })
```

### 完整案例

```typescript
import { SliderControl, SliderDragView } from '@abner/slider'

@Entry
@Component
struct SliderPage {
  sliderControl: SliderControl = new SliderControl()
  sliderControl2: SliderControl = new SliderControl()

  @Builder
  defaultView() {
    Column() {
      Text("拖动滑块滑动")
        .fontSize(14)
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Pink)
    .borderRadius(10)
  }

  @Builder
  sliderView() {
    Column() {

    }.width("100%")
    .height("100%")
    .backgroundColor(Color.Red)
    .borderRadius({ topLeft: 10, bottomLeft: 10 })
  }

  @Builder
  thumbSlidingView() {
    Text("-->")
      .width("100%")
      .height("100%")
      .backgroundColor(Color.White)
      .textAlign(TextAlign.Center)
      .borderRadius({ topRight: 10, bottomRight: 10 })
      .border({ width: 1, color: "#e8e8e8" })
  }

  @Builder
  thumbCompleteView() {
    Column() {
      SymbolGlyph($r('sys.symbol.checkmark_circle_fill'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Red])
    }
    .width("100%")
    .height("100%")
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
    .borderRadius({ topRight: 10, bottomRight: 10 })
    .border({ width: 1, color: "#e8e8e8" })
  }

  build() {
    Column() {
      SliderDragView({
        sliderControl: this.sliderControl,
        onComplete: () => {
          //滑动完成
          console.log("=======滑动完成")
        }
      })

      //全部自定义

      SliderDragView({
        sText: "拖动滑块滑动",
        sCompleteText: "完成验证",
        sliderControl: this.sliderControl2,
        defaultView: () => {
          //自定义默认视图
          this.defaultView()
        },
        sliderView: () => {
          //自定义滑动视图
          this.sliderView()
        },
        thumbSlidingView: () => {
          //自定义滑块滑动中视图
          this.thumbSlidingView()
        },
        thumbCompleteView: () => {
          //自定义滑块完成视图
          this.thumbCompleteView()
        },
        onComplete: () => {
          //滑动完成
          console.log("=======滑动完成")
        }
      }).margin({ top: 20 })

      Button("重置")
        .margin({ top: 20 })
        .onClick(() => {
          this.sliderControl.reset()
          this.sliderControl2.reset()
        })
    }
    .height('100%')
    .width('100%')
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.Center)
  }
}
```

### API 说明

Api 适用版本：>=12

### 配置说明

纯组件，无需配置

### 权限要求

暂无权限要求

### 技术支持

在 Github 中的 Issues 中提问题，定期解答。

### 开源许可协议

该代码经过 Apache 2.0 授权许可。

### 更新记录

- **1.0.0 (2026-01-26)**
  1. 滑块验证组件首次上传
  2. 支持自定义组件

### 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 无权限 | 无权限 | 无权限 |

### SDK 合规使用指南

不涉及

## 兼容性

### HarmonyOS 版本

- 5.0.3
- 5.0.4
- 5.0.5
- 5.1.0
- 5.1.1
- 6.0.0
- 6.0.1

### 应用类型

- 应用
- 元服务

### 设备类型

- 手机
- 平板
- PC

### DevEcoStudio 版本

- DevEco Studio 5.1.0
- DevEco Studio 5.1.1
- DevEco Studio 6.0.0
- DevEco Studio 6.0.1

## 安装方式

```bash
ohpm install @abner/slider
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b85c413f5fc44cfc98605b5e91152d8b/b6a17875746941e0b5606c9b1eb174f8?origin=template