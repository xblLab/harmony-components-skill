# duke/websocket-client 通信协议组件

## 简介

三方源 websocket 客户端

## 详细介绍

### 项目简介

WebSocketClient 是一个为 OpenHarmony 开发的 WebSocket 客户端库，提供简单易用的 API 来建立 WebSocket 连接、发送和接收消息。

### 功能特性

- 支持 WebSocket 客户端连接
- 支持文本和二进制数据传输
- 支持事件监听和处理
- C++ 的 WebSocket 实现，提供给 ArkTS 使用，解决 ArkTS 提供的 API12-API17 下 WebSocket 下 buffer 和 string 混合传递，类型错乱的问题
- 解决 on("Message") 下 payload 大小为 0 导致 message 为 undefined 的情况
- 1.x.x 版本为仓颉实现，会持续维护

### 下载安装

```bash
ohpm install @duke/websocket-client
```

### 使用说明

#### 基本用法

导入 WebSocket 库：

```typescript
import { createWebSocket, WebSocketClient, WebSocketClientEvent } from '@duke/websocket-client';
```

创建 WebSocket 客户端实例：

```typescript
const wsClient = createWebSocket();
```

连接到 WebSocket 服务器：

```typescript
wsClient.connect("ws://your-websocket-server-url");
```

#### 事件监听

可以监听以下事件：

连接打开事件：

```typescript
wsClient.on("open", (event: WebSocketClientEvent) => {
 console.log("WebSocket 连接已打开");
})
```

接收到文本消息：

```typescript
wsClient.on("messageText", (data: string) => {
 console.log("收到文本消息：", data);
})
```

接收到二进制数据：

```typescript
wsClient.on("messageBuffer", (data: ArrayBuffer) => {
 console.log("收到二进制消息，长度：" + data.byteLength);
})
```

连接关闭事件：

```typescript
wsClient.on("close", (event: WebSocketClientEvent) => {
 console.log("WebSocket 连接已关闭");
})
```

错误事件：

```typescript
wsClient.on("error", (event: WebSocketClientEvent) => {
 console.log("WebSocket 发生错误" + event.reason);
})
```

#### 发送消息

发送文本消息：

```typescript
wsClient.send("Hello, WebSocket!");
```

发送二进制数据：

```typescript
const buffer = new ArrayBuffer(10);
wsClient.send(buffer);
```

#### 关闭连接

```typescript
wsClient.close();
```

#### 移除事件监听

可以移除特定事件的监听器：

```typescript
// 移除特定回调函数
wsClient.off("messageText", messageHandler)
// 移除所有回调函数
wsClient.off("messageText");
```

### API 参考

#### WebSocketClient 方法

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| connect | url: string \| headers?: Record<string, string> | 创建 WebSocket 实例，返回 WebSocketClient 实例 |
| connect | url: string \| headers: Record<string, string> \| callback: (error: string) => void | 连接到指定 URL 的 WebSocket 服务器，通过回调处理结果 |
| pingInterval | interval: number | 设置心跳间隔，单位毫秒，默认为 40 秒，为 0，表示不发送心跳包，以连接后不能中途修改 |
| send | data: string \| ArrayBuffer | 发送文本或二进制数据，返回 Promise |
| send | data: string \| ArrayBuffer, callback: (error: string) => void | 发送文本或二进制数据，通过回调处理结果 |
| close | 无 | 关闭 WebSocket 连接，返回 Promise |
| close | callback: (error: string) => void | 关闭 WebSocket 连接，通过回调处理结果 |
| on | event: string, callback: Function | 注册事件监听器 |
| off | event: string, callback?: Function | 移除事件监听器 |

#### 事件类型

| 事件名 | 回调参数类型 | 描述 |
| :--- | :--- | :--- |
| open | WebSocketClientEvent | 连接成功打开时触发 |
| messageText | string | 收到文本消息时触发 |
| messageBuffer | ArrayBuffer | 收到二进制消息时触发 |
| close | WebSocketClientEvent | 连接关闭时触发 |
| error | WebSocketClientEvent | 发生错误时触发 |

#### WebSocketClientEvent

| 属性名 | 类型 | 描述 |
| :--- | :--- | :--- |
| code | string | 报错代码 |
| reason | string | 原因描述 |

### 约束与限制

在下述版本验证通过：
DevEco Studio: 5.0.5.315, SDK: HarmonyOS 5.0.1 Release Ohos_sdk_public 5.0.1.115 (API Version 13 Release)

### 目录结构

```text
|---- WebSocket
|     |---- AppScrope  # 示例代码文件夹
|     |---- entry  # 示例代码文件夹
|     |---- examples # 示例代码文件夹  
|     |---- library # WebSocketClient 库仓颉版实现文件夹  
|           |---- build  # WebSocketClient 模块打包后的文件
|           |---- index.ets  # 对外接口    
|     |---- TestServer # Node 测试 websocket 服务端    
|     |---- websocket # WebSocketClient 库 C++ 版实现文件夹  
|           |---- build  # WebSocketClient 模块打包后的文件
|           |---- index.ets  # 对外接口     
|     |---- README.md  # 安装使用方法
|     |---- CHANGELOG.md  # 更新日志
```

### 开源协议

本项目基于 MIT license，请自由地享受和参与开源。

### 更新记录

- **[v2.2.1]** 2026.02
  - 修复：替换 SSL 库从三方编译，替换成自编译，解决空指针问题
- **[v2.2.0]** 2025.11
  - 新增文本和二进制分离回调
  - 修复 message 方法回调方法原型申明错误
- **[v2.1.3]** 2025.09
  - 兼容服务端握手不标准实现，Value 小写的情况
- **[v2.1.2]** 2025.09
  - 兼容服务端握手不标准实现，小写的情况
- **[v2.1.1]** 2025.09
  - 修复 wss 协议握手失败的问题
  - 修复握手失败时重复调用 error 的情况
  - 修复 pong 帧没有回复的问题
- **[v2.1.0]** 2025.09
  - 添加自定义 Header 支持
- **[v2.0.0]** 2025.08
  - 全新升级，主要 API 保持一致
  - 用 C++ 实现 WebSocketClient
  - 添加 openssl 以支持 wss 协议
  - 1.. 会继续独立维护
- **[v1.0.5]** 2025.07.29
  - 修复异常回调导致的中断
- **[v1.0.4]** 2025.07.29
  - 修复异常回调导致的中断
- **[v1.0.3]** 2025.07.28
  - 优化断开连接的逻辑，确保正确处理各种情况
- **[v1.0.2]** 2025.07.28
  - 修复 send 失败时的线程调度问题
  - 添加 close 函数的异步结果
  - 调用 close 时不直接终端 socket 了，改为尝试发送一个 close 包
- **[v1.0.1]** 2025.07.25
  - send 添加 callback 结果
- **[v1.0.0]** 2025.07
  - 第一版正式可用版本

## 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |
| 隐私政策 | 不涉及 | SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 是 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @duke/websocket-client
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5d005b90c1fe415ea1494b9ca0dc040a/PLATFORM?origin=template