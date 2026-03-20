# eventsource 事件驱动框架

## 简介

eventsource 三方库是 EventSource 客户端的纯 JavaScript 实现。它提供了一种在客户端与服务器之间建立单向持续连接的机制，服务器可以使用这个连接向客户端发送事件更新，而客户端能够实时接收并处理这些更新。

## 详细介绍

### 简介

eventsource 三方库是 EventSource 客户端的纯 JavaScript 实现。它提供了一种在客户端与服务器之间建立单向持续连接的机制，服务器可以使用这个连接向客户端发送事件更新，而客户端能够实时接收并处理这些更新。

### 下载安装

```bash
ohpm install @ohos/eventsource
```

### 使用说明

#### 引入依赖

```typescript
import EventSource from '@ohos/eventsource';
```

#### 在 module.json5 中添加权限

```json5
"requestPermissions": [
   {
       "name": "ohos.permission.INTERNET"
   }
]
```

#### 需要 SSE 服务器配合使用

##### 服务端示例代码

创建一个可以传输事件流数据的 node 服务器，具体请看 server 目录。

```javascript
const express = require('express');
const serveStatic = require('serve-static');
const SseStream = require('ssestream');

const app = express()
app.use(serveStatic(__dirname));
app.get('/sse', (req, res) => {
 console.log('new connection');

 const sseStream = new SseStream(req);
 sseStream.pipe(res);
 const pusher = setInterval(() => {
   sseStream.write({
     event: 'server-time',
     data: new Date().toTimeString()
   })
 }, 1000)

 res.on('close', () => {
   console.log('lost connection');
   clearInterval(pusher);
   sseStream.unpipe(res);
 })
})

app.listen(8080, (err) => {
 if (err) throw err;
 console.log('server ready on http://localhost:8080');
})
```

##### 客户端示例代码

```typescript
import promptAction from '@ohos/promptAction';
import EventSource from '@ohos/eventsource'

@State es: null | Eventsource = null;
@State url:string = "http://localhost:8080/sse";

eventListener = (e: Record<"data", string>) => {
 this.simpleList.push(e.data);
}

// Create a connection.
this.es = new EventSource(this.url)

// Enable a listener.
this.es.addEventListener("server-time", this.eventListener);

// Remove the listener.
this.es.removeEventListener("server-time", this.eventListener);

// Disconnect from the server.
this.es.close();

// Error listener.
this.es.onFailure((e: Record<"message", string>) => {
   // Obtain and process the error message.
})
```

##### 错误监听需在创建连接开启的时候同步开启

### 接口说明

| 名称 | 参数 | 类型 | 说明 |
| :--- | :--- | :--- | :--- |
| addEventListener | type:string, callback:()=>{} | - | Adds a listening event. |
| removeEventListener | type:string, callback:()=>{} | - | Removes the listening event. |
| close | No parameter is transferred. | - | Stops a connection. |
| onFailure | (e:object)=>{} | - | Captures an error. e indicates an error object. |

### 单元测试用例详见 TEST.md

### 约束与限制

DevEco Studio: 4.1.3.500; SDK: API11 Release (4.1.0)

## 目录结构

```text
   |---- eventsource 
   |     |---- entry  # Sample code
         |---- library # eventsource library file
           |---- src
   |             |---- main
   |                  |---- ets
   |                       |---- eventsource.js  #eventsource           
   |     |---- README.md  # Readme
   |     |---- README_zh.md  # Readme
```

## 开源协议

本项目基于 MIT License，请自由地享受和参与开源。

## 更新记录

### v2.0.4

Release official version

### v2.0.4-rc.0

Fix the issue where the request for repair does not carry user-defined headers.

### v2.0.3

Release 2.0.3

### v2.0.3-rc.0

Code obfuscation

### v2.0.2

本库是 EventSource 客户端的纯 JavaScript 实现。它提供了一种在客户端与服务器之间建立单向持续连接的机制，服务器可以使用这个连接向客户端发送事件更新，而客户端能够实时接收并处理这些更新。

本库是基于 eventsource 源库 v2.0.2 版本代码进行 OpenHarmony 环境接口适配的三方库。

## 权限与隐私基本信息

| 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 |

## 隐私政策

不涉及 SDK 合规使用指南 不涉及

## 兼容性

| 项目 | 信息 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 设备类型 | 手机、平板、PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/eventsource
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/6434e9e47de54e1987a5aa50fea3be26/PLATFORM?origin=template