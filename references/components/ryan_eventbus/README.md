# EventBus 事件总线分发组件

## 简介

事件总线分发，支持组件生命周期自动管理，在 ArkTS 组件中使用可自动取消订阅，简化跨组件通信。

## 详细介绍

### 介绍

EventBus 是一个基于 ArkTS 构建的事件总线工具，旨在为 HarmonyOS 应用提供高效、便捷的跨组件 / 跨模块事件通信能力。它支持事件订阅 / 发布、粘性事件、一次性事件等核心功能，并通过装饰器和 Hook 简化 UI 组件与事件总线的交互，自动管理组件生命周期内的事件订阅与取消，避免内存泄漏。

### 核心特性

- **单例设计**：全局唯一实例，确保事件通信的一致性。
- **类型安全**：通过泛型约束事件参数类型，减少运行时错误。
- **生命周期管理**：装饰器与 Hook 自动绑定组件 aboutToAppear/aboutToDisappear，无需手动管理订阅。
- **粘性事件**：新订阅者可接收历史最新事件，适用于“登录后页面立即同步状态”等场景。
- **一次性事件**：事件触发一次后自动取消订阅，简化临时事件逻辑。
- **调试与统计**：支持调试模式与事件统计，便于开发与性能分析。

### 快速开始

#### 安装

1. 将项目中 eventBus 目录下的所有文件（Dispatch.ts、EventBus.ts、EventName.ts、Subscriber.ts 等）复制到你的项目中即可使用。
2. 使用项目中已经 builde 的 EventBus.har 包，并在你的项目中引入。

```json
"dependencies": {
   "@ryan/eventbus": 'file:./src/lib/EventBus.har'
}
```

3. 使用 ohpm 下载安装

```bash
ohpm install @ryan/eventbus
```

#### 使用参考示例

```typescript
import { eventBus, Subscriber, SubscriberOnce } from '@ryan/eventbus';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
    @State message: string = 'Hello World';
    @State listenerId: number = -1

    aboutToAppear(): void {
        // 使用 API 订阅
        eventBus.on('onMessage', this.onMessage)
        // 使用 API 订阅一次
        eventBus.once('onMessageOne', this.onMessageOne)
        // 开启调试模式（输出详细日志）
        eventBus.setDebugMode(true);

        // 使用 API 订阅，并获取 ID 用于后期手动取消订阅
        this.listenerId = eventBus.on('onListenerIdMessage', this.onListenerIdMessage)
    }

    aboutToDisappear(): void {
        // 避免内存泄漏，不使用时取消订阅
        eventBus.off('onMessage', this.onMessage)
        // 避免内存泄漏，不使用时取消订阅
        eventBus.off('onMessageOne', this.onMessageOne)
    }

    // 使用 API 订阅，并获取 ID 用于后期手动取消订阅
    onListenerIdMessage() {
        promptAction.showToast({
            message: '使用 API 订阅，并获取 ID 用于后期手动取消订阅'
        })
    }

    // 使用 API 订阅一次
    onMessage() {
        promptAction.showToast({
            message: '使用 API 订阅'
        })
    }

    // 使用 API 订阅一次
    onMessageOne() {
        promptAction.showToast({
            message: '使用 API 订阅一次'
        })
    }

    // 使用装饰器订阅
    @Subscriber('onSubscriber')
    onSubscriber() {
        promptAction.showToast({
            message: '使用装饰器订阅'
        })
    }

    // 装饰器触发一次
    @SubscriberOnce('onSubscriberOnce')
    onSubscriberOnce() {
        promptAction.showToast({
            message: '装饰器只触发一次'
        })
    }

    // 使用装饰器订阅
    @Subscriber('onSendParams')
    onSendParams(params: ESObject) {
        promptAction.showToast({
            message: '传递过来的参数:' + JSON.stringify(params)
        })
    }

    build() {
        Column({ space: 10 }) {
            Text("EventBus 使用示例")
                .fontSize(20)
                .margin({ bottom: 10 })
            Button("打印日志")
                .width('100%')
                .onClick(() => {
                    eventBus.printStats();
                })

            Button("装饰器订阅")
                .width('100%')
                .onClick(() => {
                    eventBus.emit("onSubscriber")
                })

            Button("装饰器只触发一次")
                .width('100%')
                .onClick(() => {
                    eventBus.emit("onSubscriberOnce")
                })

            Button("使用 API 订阅")
                .width('100%')
                .onClick(() => {
                    eventBus.emit("onMessage")
                })
            Button("使用 API 只触发一次")
                .width('100%')
                .onClick(() => {
                    eventBus.emit("onMessageOne")
                })

            Text("获取指定订阅 ID，手动移除订阅实例")
                .fontSize(20)
                .margin({ bottom: 10 })
            Button(`订阅 ID: ${this.listenerId}, 点击触发`)
                .width('100%')
                .onClick(() => {
                    eventBus.emit("onListenerIdMessage")
                })
            Button(`订阅 ID: ${this.listenerId}, 点击移除`)
                .width('100%')
                .onClick(() => {
                    const bool = eventBus.offById("onListenerIdMessage", this.listenerId)
                    promptAction.showToast({
                        message: bool ? '移除成功' : "移除失败"
                    })
                })

            Text("订阅时传递参数")
                .fontSize(20)
                .margin({ bottom: 10 })
            Button(`传递参数`)
                .width('100%')
                .onClick(() => {
                    eventBus.emit("onSendParams", { name: '小明', age: 18 })
                })

            Text("清除所有订阅事件")
                .fontSize(20)
                .margin({ bottom: 10 })
            Button(`清除所有订阅`)
                .width('100%')
                .onClick(() => {
                    eventBus.clearAll()
                })
        }
        .height('100%')
        .width('100%')
        .padding(10)
    }
}
```

## EventBus 核心方法

### API 参考

| 方法 | 说明 |
| :--- | :--- |
| `getInstance(): EventBus` | 获取全局唯一的 EventBus 实例 |
| `emit(eventName: string, ...args: T[]): Promise` | 同 post |
| `on(eventName: string, callback: (args: T[]) => void, options?: { sticky?: boolean, context?: any }): number` | 订阅事件，返回监听器 ID（用于取消订阅） |
| `off(eventName: string, callback: Function): void` | 通过回调函数引用取消订阅 |
| `offById(eventName: string, listenerId