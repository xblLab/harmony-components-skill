# socketio 通信组件

## 简介

socketio 是一个在客户端和服务器之间实现低延迟、双向和基于事件的通信的库。建立在 WebSocket 协议之上，并提供额外的保证，例如回退到 HTTP 长轮询或自动重新连接。

## 详细介绍

### 简介

socketio 是一个在客户端和服务器之间实现低延迟、双向和基于事件的通信的库。建立在 WebSocket 协议之上，并提供额外的保证，例如回退到 HTTP 长轮询或自动重新连接。

### 注意事项

- socketio 仅支持基于 HTTP 的连接，不支持 HTTPS（TLS）协议；
- 若需通过 HTTPS（TLS）建立加密连接，请使用 `socketio_tls` 版本；
- 两个版本分别适用于 HTTP 与 HTTPS 场景，不可混用。

## 效果展示

![loginchat](loginchat)

## 安装方式

```bash
ohpm install @ohos/socketio
```

## 使用说明

### 导入依赖库

```typescript
import { client_socket } from '@ohos/socketio';
```

### 初始化 socket.io 客户端

```typescript
client: client_socket = new client_socket();
```

### 设置监听事件

```typescript
this.client.set_open_listener(this.on_open.bind(this));
this.client.set_fail_listener(this.on_fail.bind(this));
this.client.set_reconnecting_listener(this.on_reconnecting.bind(this));
this.client.set_reconnect_listener(this.on_reconnect.bind(this));
this.client.set_close_listener(this.on_close.bind(this));
this.client.set_socket_open_listener(this.on_socket_open.bind(this));
this.client.set_socket_close_listener(this.on_socket_close.bind(this));
```

### 连接服务器

```typescript
this.client.connect(uri) // uri: socket.io server address
```

### 设置用户消息监听以及用户加入离开监听

#### 监听事件实现

```typescript
on_user_left_listener(event_json: string): void {
    // Callback data processing
}
```

#### 设置监听

```typescript
this.client.on("new message", this.on_new_message_listener.bind(this));
this.client.on("user joined", this.on_user_joined_listener.bind(this));
this.client.on("user left", this.on_user_left_listener.bind(this));
this.client.on("login", this.on_login_listener.bind(this));
```

### 登录服务器，并设置登录成功回调

```typescript
this.client.emit("add user", username, this.on_emit_callback.bind(this));
```

### 发送消息并设置发送消息监听

```typescript
this.client.emit("new message", message, this.on_emit_callback);
```

### 关闭服务器链接

```typescript
this.client.close();
```

### 补充说明

本示例代码中提供了一个简单的封装，可以作为参考，另外在示例代码中，增加了前后台切换时的处理，具体使用时可以根据自己的需求进行修改。

## 接口说明

### 初始化客户端

```typescript
client: client_socket = new client_socket();
```

### 设置客户端监听器

```typescript
set_open_listener(on_open: () => void)
```

### 设置客户端失败监听器

```typescript
set_fail_listener(on_fail: () => void)
```

### 设置客户端正在重新连接监听器

```typescript
set_reconnecting_listener(on_reconnecting: () => void)
```

### 设置客户端重新连接监听器

```typescript
set_reconnect_listener(on_reconnect: () => void)
```

### 设置客户端关闭监听器

```typescript
set_close_listener(on_close: (reason: string) => void)
```

### 设置 socket 打开监听

```typescript
set_socket_open_listener(on_socket_open: (nsp: string) => void)
```

### 设置 socket 关闭监听

```typescript
set_socket_close_listener(on_socket_close: (nsp: string) => void)
```

### 设置 header

```typescript
set_headers(headers: string)
```

### 连接服务器

```typescript
connect(uri: string)
```

### 清除所有监听器

```typescript
clear_con_listeners()
```

### 清除所有 socket 监听器

```typescript
clear_socket_listeners()
```

### 设置重连次数

```typescript
set_reconnect_attempts(attempts: number)
```

### 设置重新连接尝试的延迟时间

```typescript
set_reconnect_delay(millis: number)
```

### 设置重新连接的最大延迟

```typescript
set_reconnect_delay_max(millis: number)
```

### 关闭连接

```typescript
close()
```

### 同步关闭

```typescript
sync_close()
```

### 判断是否打开

```typescript
opened(): boolean
```

### 获取 sessionID

```typescript
get_sessionid(): string
```

### 注册一个新的响应服务器事件的事件处理器

```typescript
on(event_name: string, on_event_listener: (event_json: string) => void)
```

### 设置 socket 监听关闭

```typescript
socket_close()
```

### 设置错误监听

```typescript
on_error(on_error_listener: (message: string) => void)
```

### 关闭错误监听

```typescript
off_error()
```

### emit 方法

通过提供的 name 事件名称向 socket 标志发送事件。
**说明：** 响应服务器用来确认消息的应答。

```typescript
emit(name: string, message: string, on_emit_callback?: (emit_callback_json: string) => void)
```

### get_current_state 方法

获取当前连接状态。
**说明：** 0: 未连接，1: 断开连接，2: 正在连接，3: 已连接。

```typescript
get_current_state(): number
```

### 固定事件：disconnect

**说明：** disconnect 事件是在客户端断开连接时触发。

```typescript
// Demo example
this.client.on("disconnect", (data: string) => {
    console.log("disconnect", data);
});
```

### 固定事件：ping_pong

**说明：** ping_pong 事件是在客户端与服务器之间的心跳检测。

```typescript
// Demo example
this.client.on("ping_pong", (data: string) => {
    console.log("ping_pong", data);
});
```

## 源码下载

本项目依赖 `socket.io-client-cpp` 库，通过 git submodule 引入，下载代码时需加上 `--recursive` 参数。

```bash
git clone --recursive https://gitcode.com/openharmony-tpc/openharmony_tpc_samples.git
```

Linux 环境无需执行该步骤，如果是 windows 环境下，代码下载完成后合入 OHOS 适配的代码，cd 进入到 `socketio/library/src/main/cpp/thirdModule` 目录下，执行 `modify.sh` 脚本，将本目录下的 patch 文件合入到 `socket.io-client-cpp` 源码中。

开始编译项目。

## 约束与限制

在下述版本验证通过：

- IDE: DevEco Studio 4.1.3.532, SDK: 4.1.0.67(SP3)
- IDE: DevEco Studio Next, Developer Beta1 (5.0.3.121), SDK: API12 (5.0.0.16)
- IDE: DevEco Studio NEXT Developer Beta2 (5.0.3.500); SDK: API12 (5.0.0.31)
- IDE: DevEco Studio 5.0.1 Release(5.0.5.310); SDK: API13 (5.0.1.115)

## 目录结构

```text
|---- socketio  
|     |---- entry  # Sample code
|     |---- library  # socket.io library
|           |---- ets # External APIs
              |---- client_socket.ets # External APIs
           |---- cpp # Module code
                 |---- src # Core class
                 |---- client_socket.cpp # NAPI layer of the socket.io client
|     |---- README_EN.md  # Readme                    
```

## 开源协议

本项目基于 MIT LICENSE，请自由地享受和参与开源。

## 更新记录

### v2.1.3

- Optimized Shared Library Compilation: O3 and LTO Support

### v2.1.3-rc.2

- Fixed the issue of the number of callback function parameters in the on and emit methods and made improvements

### v2.1.3-rc.1

- Fixed the issue where emit callbacks could be overwritten across same or different event names

### v2.1.3-rc.0

- Fixed the issue where the dependent c++ static library caused conflicts with the dynamic libraries of other modules, leading to program crashes

### v2.1.2

- Fix repository from gitee to gitcode in oh-package.json5
- Release the official version

### v2.1.1

- Optimized the memory problem in the emit message processing process.
- Added fixed events "ping_pong" and "disconnect" to listen for heartbeat and disconnection events.
- Added an interface "get_current_state" to get the current state.
- Simple packaging of demo to match new features and interfaces.
- Modified the readme file to add descriptions of new interfaces and features.

### v2.1.1-rc.1

- Fixed the issue of duplicate emit messages.

### v2.1.1-rc.0

- Fixed the format of incoming parameters in the set_option and set_header interfaces.
- Fixed an issue where received messages contained special escape characters causing the program to crash.

### v2.1.0

- Socketio objects can be created in multiple scenarios.
- Support custom event name.
- Support to receive binary messages.
- Added set_headers for setting request headers.
- Added set_option for setting request parameter.
- Fixed server return json string parsing failure.
- Fixed client crash when server sends empty message.
- Fixed client failed to send array data.
- Fixed server failed to send array data.
- Fixed a data exception caused by the client receiving data buffer being too small.
- Fixed the exception of the client sending callback messages.

### v2.0.1

- 发布正式版本

### v2.0.1-rc.3

- 新增设置请求头 header 功能

### v2.0.1-rc.2

- 支持 x86

### v2.0.1-rc.1

- 修复 Openharmony4.1.0.66 版本上 connect 接口调用 crash 问题，问题原因：由于系统 napi_call_function 接口在该版本上参数定义问题导致 crash。

### v2.0.1-rc.0

- 修复 socket.io 接口 connect 调用 crash 问题

### v2.0.0

- 包管理工具由 npm 切换为 ohpm
- DevEco Studio 版本：4.1 Canary(4.1.3.317)
- OpenHarmony SDK: API11 (4.1.0.36)

### v1.0.1

- 适配 3.1.0.200 IDE

### v1.0.0

- 实现功能：作为与服务端之间建立链接的客户端库，使用 c 代码在 ohos 平台编译成.so 文件，对外暴露 connect、on、open、off、close、emit 等接口。

## 权限与隐私

| 项目 | 内容 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |

## 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | 支持 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/b7dc2051f02c4fdc8b01d16bf71006b5/PLATFORM?origin=template