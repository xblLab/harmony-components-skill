# 翻页时钟和计时器组件

## 简介

Flip Clock 是一款面向 HarmonyOS NEXT 的高质量翻页时钟与计时器组件，采用 ArkTS 实现，通过精细的四层翻页结构与动画控制，还原真实机械翻页时钟的物理运动效果。组件内置 FlipClock（时钟）与 FlipTimer（计时器）两种核心形态，支持 12/24 小时制、正计时与倒计时模式，并可根据容器尺寸自动适配布局、字体与圆角，轻松融入不同应用界面。无论是桌面时钟、工具应用，还是需要时间展示的业务场景，Flip Clock 都能以稳定、优雅的方式呈现时间的流动。

## 详细介绍

```text
视频播放器 is loading.播放视频播放静音当前时间 0:00/时长 0:13 加载完毕：100.00%0:00 媒体流类型 直播 Seek to live, currently behind live 直播剩余时间 -0:13 1x 播放速度 2x1.75x1.5x1.25x1x, 选择 0.5x 节目段落节目段落描述关闭描述，选择字幕字幕设定，开启字幕设置弹窗关闭字幕，选择音轨画中画全屏 This is a modal window.开始对话视窗。离开会取消及关闭视窗文字 Color 白黑红绿蓝黄紫红青 Transparency 不透明半透明背景 Color 黑白红绿蓝黄紫红青 Transparency 不透明半透明透明视窗 Color 黑白红绿蓝黄紫红青 Transparency 透明半透明不透明字体尺寸 50%75%100%125%150%175%200%300%400% 字体边缘样式无浮雕压低均匀下阴影字体库比例无细体单间隔无细体比例细体单间隔细体舒适手写体小型大写字体重启 恢复全部设定至预设值完成关闭弹窗结束对话视窗
```

HarmonyOS Flip Clock Component

一个适用于 HarmonyOS NEXT 的翻页时钟和计时器组件，提供逼真的机械翻页动画效果。

### 特性

*   **逼真的翻页动画**：基于 ArkTS 和 Stack 布局实现的 4 层翻页结构，还原真实机械时钟的物理运动。
*   **响应式设计**：组件能够根据容器大小自动调整数字卡片的宽高、字体大小和圆角。

#### FlipClock (时钟组件)

*   支持 12 小时制和 24 小时制。
*   自动获取系统当前时间并实时更新。

#### FlipTimer (计时器组件)

*   **正计时模式**：从 0 开始累加计时。
*   **倒计时模式**：从指定时长开始倒计时，结束后触发回调。
*   **智能显示**：倒计时不足 1 小时时，自动隐藏小时位，仅显示分秒。

## 安装

使用 ohpm 安装：
深色代码主题复制
```bash
ohpm install flip_clock
```

## 使用指南

### 1. FlipClock (翻页时钟)

用于显示当前时间。
深色代码主题复制
```typescript
import { FlipClock } from 'flip_clock';

@Entry
@Component
struct Index {
  build() {
    Column() {
      // 标题
      Text('HarmonyOS Flip Clock')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 30, bottom: 20 })

      // 示例 1：24 小时制
      Text('24 Hour Mode')
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ bottom: 10 })

      FlipClock({ is24Hour: true })
        .width('90%')
        .height(100)
        .backgroundColor('#F0F0F0')
        .borderRadius(16)
        .margin({ bottom: 30 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}
```

### 属性

| 属性名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| is24Hour | boolean | true | 是否使用 24 小时制。 |
| flipBgColor | ResourceColor | '#333333' | 翻页卡片的背景颜色。 |
| flipTextColor | ResourceColor | '#FFFFFF' | 数字文字颜色。 |

### 2. FlipTimer (翻页计时器)

用于正计时或倒计时。
深色代码主题复制
```typescript
import { FlipTimer } from 'flip_clock';

@Entry
@Component
struct Index {
  @State isTimerRunning: boolean = false
  @State isCountDownRunning: boolean = false

  build() {
    Scroll() {
      Column() {
        // 示例 2：正计时器
        Text('Timer (Count Up)')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 10 })

        FlipTimer({
          isCountDown: false,
          isRunning: $isTimerRunning
        })
          .width('90%')
          .height(100)
          .backgroundColor('#E8F6F3')
          .borderRadius(16)
          .margin({ bottom: 10 })

        Button(this.isTimerRunning ? 'Pause' : 'Start')
          .onClick(() => {
            this.isTimerRunning = !this.isTimerRunning
          })
          .margin({ bottom: 30 })

        // 示例 3：倒计时器 (自动隐藏小时)
        Text('Count Down (< 1h)')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 10 })

        FlipTimer({
          isCountDown: true,
          initialDuration: 65, // 1 分 5 秒
          isRunning: $isCountDownRunning,
          onFinish: () => {
            console.info('Count down finished!')
          }
        })
          .width('90%')
          .height(100)
          .backgroundColor('#FDEDEC')
          .borderRadius(16)
          .margin({ bottom: 10 })

        Button(this.isCountDownRunning ? 'Pause' : 'Start')
          .onClick(() => {
            this.isCountDownRunning = !this.isCountDownRunning
          })
          .margin({ bottom: 30 })

      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
```

### 属性

| 属性名 | 类型 | 默认值 | 描述 |
| :--- | :--- | :--- | :--- |
| isCountDown | boolean | false | true 为倒计时模式，false 为正计时模式。 |
| initialDuration | number | 0 | 倒计时的初始时长（秒）。 |
| isRunning | boolean (Link) | - | 双向绑定属性，控制计时器的开始 (true) 和暂停 (false)。 |
| onFinish | () => void | - | 倒计时结束时的回调函数。 |
| flipBgColor | ResourceColor | '#333333' | 翻页卡片的背景颜色。 |
| flipTextColor | ResourceColor | '#FFFFFF' | 数字文字颜色。 |

## License

本项目基于 Apache License 2.0 开源。
深色代码主题复制
```text
Copyright 2024 [Your Name/Organization]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## 更新记录

*   **1.0.3 (2026-01-14)**：对 HAR 包进行了正式签名，确保分发安全性。
*   **1.0.1 (2026-01-13)**：Flip Clock 是一款面向 HarmonyOS NEXT 的高质量翻页时钟与计时器组件，采用 ArkTS 实现，通过精细的四层翻页结构与动画控制，还原真实机械翻页时钟的物理运动效果。

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 无 | 无 | 无 | 无 |

## 兼容性

| 项目 | 版本/类型 | 备注 |
| :--- | :--- | :--- |
| HarmonyOS 版本 | 5.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.1 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.2 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.3 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.4 | Created with Pixso. |
| HarmonyOS 版本 | 5.0.5 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.0 | Created with Pixso. |
| HarmonyOS 版本 | 5.1.1 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.0 | Created with Pixso. |
| HarmonyOS 版本 | 6.0.1 | Created with Pixso. |
| 应用类型 | 应用 | Created with Pixso. |
| 应用类型 | 元服务 | Created with Pixso. |
| 设备类型 | 手机 | Created with Pixso. |
| 设备类型 | 平板 | Created with Pixso. |
| 设备类型 | PC | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.2 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.3 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.4 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.5 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.1.1 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.0 | Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 6.0.1 | Created with Pixso. |

## SDK 合规

*   不涉及

## 使用指南

*   不涉及

## 隐私政策

*   不涉及

## 安装方式

```bash
ohpm install flip_clock
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/c3455cd2a6f34592a0d3e0aa3ae21314/DEVELOPER?origin=template