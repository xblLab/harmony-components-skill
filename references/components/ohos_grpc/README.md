# Grpc 远程过程调用框架组件

## 简介

ohos_grpc_node 是一个高性能的远程过程调用（RPC）框架，旨在简化和优化分布式系统中的服务通信。

## 详细介绍

### 简介

ohos_grpc_node 是参考 gRPC 使用 arkTs 语言重构实现的一个高性能的远程过程调用（RPC）框架，旨在简化和优化分布式系统中的服务通信。

### 使用说明

该库有两种编译方式，分别是 ohpm 依赖和源码依赖编译。

#### 1. ohpm 依赖编译

**安装 grpc**

```bash
ohpm install @ohos/grpc
```

注意：安装 ohpm 之后，需要执行替换 protobufjs 的 index.d.ts，把当前工程下的文件 `protobufjs/index.d.ts` 替换所引用的工程的根目录的路径 `oh_modules/.ohpm/@ohos+protobufjs@2.1.0/oh_modules/@ohos/protobufjs/src/main/ets`。

#### 2. 源码依赖编译

**下载源码**

```bash
git clone https://gitcode.com/openharmony-sig/ohos_grpc_node.git --recurse-submodules
```

**编译依赖库 nghttp2、openssl_quic、json**

拷贝生成的文件到 thirdparty 目录。

删除 json 库中此行代码，路径：`include\nlohmann\detail\output\serializer.hpp`：513 行

```cpp
JSON_THROW(type_error::create(316, concat("invalid UTF-8 byte at index ", std::to_string(i), ": 0x", hex_bytes(byte | 0)), nullptr)); 
```

**替换 protobufjs 的 index.d.ts**

把当前工程下的文件 `protobufjs/index.d.ts` 替换路径 `library/oh_modules/@ohos/protobufjs/src/main/ets/index.d.ts`。

#### proto 生成 ts

下载安装配置 protocolbuffers 环境变量：解压之后把 bin 路径添加环境变量 path 中。

```bash
npm install -g protoc-gen-ts
```

生成命令：

```bash
protoc -I=./proto  --ts_out=./out ./proto/hello.proto
```

生成之后需要修改生成文件如下（参考 demo 中的 helloworld.ts）：

```typescript
import * as grpc_1 from "@grpc/grpc-js" 改成 import { grpc as grpc_1 } from "@ohos/grpc"
import buffer from '@ohos.buffer';
```

*   注意在请求接口中的 Buffer 参数需要改成 `ArrayBufferLike | Uint8Array`
*   `Buffer.from` 改成 `buffer.from`

### 接口说明

| 接口名 | 参数 | 返回值 | 说明 |
| :--- | :--- | :--- | :--- |
| makeClientConstructor | methods: ServiceDefinition, serviceName: string, classOptions?: {} | ServiceClientConstructor | 构造客户端 |
| ClientUnaryCall | message: P, metadata: grpc.Metadata, options: grpc.CallOptions, callback: grpc.requestCallback | grpc.ClientUnaryCall | 构造简单 RPC |
| ClientWritableStream | metadata: grpc.Metadata, options: grpc.CallOptions, callback: grpc.requestCallback | grpc.ClientWritableStream | 构造客户端流式 RPC |
| ClientReadableStream | message: P, metadata: grpc.Metadata, options?: grpc.CallOptions | grpc.ClientReadableStream | 构造服务器流式 RPC |
| ClientDuplexStream | metadata: grpc.Metadata, options?: grpc.CallOptions | grpc.ClientDuplexStream<P, R> | 构造双向流式 RPC |
| on | event: string, callback: (...args: any[]) => void | void | 监听 RPC 响应状态（支持的响应状态:'data'、'response'、'close'、'error'） |
| write | chunk: RequestType | void | 向服务端发送 RPC 消息（流式 RPC 支持） |
| close | 无 | void | 关闭流，响应回调在 on 监听 RPC 中回调 close 状态（流式 RPC 支持） |

注意以上接口主要在 proto 生成的 ts 中体现，请结合使用示例使用。

### 使用示例

```typescript
import { grpc } from '@ohos/grpc';
import { helloworld} from '../helloworld/helloworld';

let client = new helloworld.GreeterClient('192.168.25.220:50051',grpc.credentials.createSsl());
let request = new helloworld.HelloRequest(["hello world"]);
client.SayHello(request, (err, response) => {
        console.log('SayHello request:', request);
        if (err) {
          console.log('SayHello err:', err);
        }
        console.log('SayHello response:', response);
})
```

注意：在需要进行双向身份验证的场景中，应配置客户端私钥和证书路径，如下所示：

```typescript
const client_key = context.cacheDir +"/client.key";
const client_crt = context.cacheDir +"/client.crt";
const clientCredentials = grpc.credentials.createSsl(
           client_key,
           client_crt
      );
let client = new helloworld.GreeterClient('192.168.25.220:50051', clientCredentials);
let request = new helloworld.HelloRequest(["hello world"]);
client.SayHello(request, (err, response) => {
        console.log('SayHello request:', request);
        if (err) {
          console.log('SayHello err:', err);
        }
        console.log('SayHello response:', response);
})
```

注意：需要获取大数据场景，请添加 Metadata，如下：

```typescript
private getMetadata(): Metadata {
    const metaData = new Metadata();
    metaData.set("recvLargeDataFlags", "true");
    return metaData;
}

let client = new helloworld.GreeterClient('192.168.25.220:50051',grpc.credentials.createSsl());
let request = new helloworld.HelloRequest(["hello world"]);
client.SayHello(request, this.getMetadata(), (err, response) => {
        console.log('SayHello request:', request);
        if (err) {
          console.log('SayHello err:', err);
        }
        console.log('SayHello response:', response);
})
```

```typescript
import { grpc } from '@ohos/grpc';
import buffer from '@ohos.buffer';
import { hello } from '../helloworld/hello';
import { Context } from '@ohos.arkui.UIContext';

export default class StreamSample {

  static request(context: Context) {

    const client = new hello.HelloServiceClient('192.168.25.220:50051', grpc.credentials.createSsl());

    let request = new hello.HelloRequest(["test hello world"]);

    const stream = client.BidiHello();

    stream.on('data', (chunk: hello.HelloResponse) => {
      console.info('===========data=========' + chunk);
    });
    stream.on('response', (headers: string) => {
      console.info("===========response=========" + JSON.stringify(headers));
    });

    stream.on('close', () => {
      console.info('===========close=========');
    });

    stream.on('error', (err) => {
      console.info('=============error============'+JSON.stringify(err));
    });

    stream.write(request);
  }
}
```

### 目录结构

```text
|---- ohos_grpc_node  
|     |---- entry  # 示例代码文件夹
|     |---- library  # grpc 模块
|     |---- README.md  # 安装使用方法                   
```

### 更新记录

*   **1.0.9**
    *   Release official version
*   **1.0.9-rc.0**
    *   Fix the abnormal parsing issue of received audio data in bidirectional streaming scenarios
*   **1.0.8**
    *   Optimized Shared Library Compilation: O3
*   **1.0.8-rc.0**
    *   Fix the issue where deserialization exceptions are caused when receiving 5 bytes of all-zero data
*   **1.0.7**
    *   Fix the issue where deserialization exceptions are caused when receiving 5 bytes of all-zero data
*   **1.0.6**
    *   Fix the issue of abnormal data acquisition when retrieving big data scenarios and Update README
*   **1.0.5**
    *   Fix the abnormal issue of mutual authentication.
    *   Fix security compilation options issue and message when Unary request interface does not callback exceptions.
*   **1.0.4**
    *   Fix occasional crashes and message callback exceptions.
*   **1.0.3**
    *   Add support for bidirectional flow.
*   **1.0.2**
    *   Upgrade the version of nghttp2 to 1.65.0 and solve the crash problem.
*   **1.0.1**
    *   Fix request header not supporting authentication authorization issue
    *   Fix ClientReadableStream and ClientWritableStream Request exception issue
    *   Fix abnormal message forwarding callback issues, unstable long connections, and add support for dynamic header transmission
*   **1.0.1-rc.0**
    *   Fix native callback JS deserialization message format exception and bidirectional stream request exception issues
*   **1.0.0**
    *   Support GRPC communication
    *   Supports HTTP2 protocol

### 权限与隐私

| 基本信息 | 权限名称 | 权限说明 | 使用目的 |
| :--- | :--- | :--- | :--- |
| 暂无 | 暂无 | 暂无 | 暂无 |

| 隐私政策 | SDK 合规使用指南 |
| :--- | :--- |
| 不涉及 | 不涉及 |

### 兼容性

| 项目 | 内容 |
| :--- | :--- |
| HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 <br> Created with Pixso. |
| 元服务 | 元服务 <br> Created with Pixso. |
| 设备类型 | 手机 <br> Created with Pixso. |
| 平板 | 平板 <br> Created with Pixso. |
| PC | PC <br> Created with Pixso. |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 <br> Created with Pixso. |

## 安装方式

```bash
ohpm install @ohos/grpc
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/5072a192741b4e9fb3bb4259d627a44a/PLATFORM?origin=template