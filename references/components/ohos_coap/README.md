# coap 通信协议组件

## 简介

ohos_coap 是基于 libcoap，封装 napi 接口，给上层 ts 提供 coap 通信能力的三方库。

## 详细介绍

### 介绍

libcoap 是 Coap 协议的 C 语言实现，它是使用 Coap 协议的工具。
ohos_coap 是基于 libcoap v4.3.1 版本，封装 napi 接口，给上层 ts 提供 coap 通信能力的三方库。

### 目前客户端实现的能力

支持 coap 客户端发起 get, post, put 请求。

### 目前服务端实现的能力

支持 coap 服务端处理 get，post 数据。

### 暂不支持的能力

- coap 服务端除注册 get、post 请求外其余功能不支持。
- coap 客户端发送文件，媒体软件能力。
- 不支持 tls/dtls 的消息。
- 不支持发起 delete 请求。

## 使用本工程

有两种方式可以下载本工程：

开发者如果想要使用本工程，可以使用 git 命令。

```bash
git clone https://gitcode.com/openharmony-tpc/ohos_coap.git --recurse-submodules
```

点击下载按钮，把本工程下到本地，再把 libcoap v4.3.1 版本代码放入 libcoap/src/main/cpp/libcoapSource 目录下，这样才可以编译通过。

漏洞修复，进入到 libcoap\src\main\cpp\thirdModule 目录下，执行 modify.sh 脚本，将本目录下的 patch 文件合入到 libcoap 源码中。

详情查看漏洞修复记录。

## 下载安装

```bash
ohpm install @ohos/coap
```

## X86 模拟器配置

使用模拟器运行应用/服务。

## 使用

### 1、coap get 请求展示

```typescript
// 打开 native log 开关
CoapClient.setNativeLogOpen(true);
// 发起 coap get 请求，注意 this.coapUri 请使用者换成真实的 url
// 每一个 CoapClient 对应一个 COAP 请求任务，不可复用
let coapClient = new CoapClient();
let coapGet = coapClient.request(this.coapUri, CoapRequestMethod.GET, CoapRequestType.COAP_MESSAGE_CON);
console.log("libcoap get test");
//coap get 请求异步回调
coapGet.then((data) => {
 if (data.code == CoapResponseCode.SUCCESS) { //sucess 说明请求成功 
   console.log("libcoap get:" + data.message[0]);
 } else {
   console.log("libcoap get code:" + data.code);
   console.log("libcoap get error message:" + data.message);
 }
})
```

get 请求 CaLLBACK 回调

```typescript
let coapClient = new CoapClient();
coapClient.requestCall(this.coapUri, CoapRequestMethod.GET, CoapRequestType.COAP_MESSAGE_CON, (data: CoapResponse) => {
 if (data.code == CoapResponseCode.SUCCESS) {
   console.log("libcoap requestCall get:" + data.message[0]);
 } else {
   console.log("libcoap requestCall get code:" + data.code);
   console.log("libcoap requestCall get error message:" + data.message[0]);
 }
});
```

### 2、coap put 请求展示

```typescript
// 打开 native log 开关
CoapClient.setNativeLogOpen(true);
let coapClient = new CoapClient();
//设置端口号
coapClient.setPort(5683);
//设置透传数据的格式
coapClient.setFormat(ContentFormat.PLAIN);
//设置透传数据
coapClient.setPayload("this is put test payload");
// 发起 coap put 请求，注意 this.coapUri 请使用者换成真实的 url
// 每一个 CoapClient 对应一个 COAP 请求任务，不可复用
let coapPut = coapClient.request(this.coapUri, CoapRequestMethod.PUT, CoapRequestType.COAP_MESSAGE_CON);
console.log("libcoap put test");
//coap get 请求异步回调
coapPut.then((data) => {
 if (data.code == CoapResponseCode.SUCCESS) { //sucess 说明请求成功 
   console.log("libcoap put:" + data.message[0]);
 } else {
   console.log("libcoap put code:" + data.code);
   console.log("libcoap put error message:" + data.message);
 }
})
```

### 服务端使用

服务器注册 get，post 请求

```typescript
let server = new CoapServer();
let resource = new CoapResource();
let exchange = new CoapExchange();
//服务器本地 IP，端口号目前固定
server.setAddr('125.0.10.5', '0');
// 打开 native log 开关
CoapClient.setNativeLogOpen(true);
//添加 id
let resourceId = this.resource.createResource('test');
//添加资源属性
resource.addAttributes(resourceId, 'title', 'Dynamic');
//处理 get 数据
resource.registerGetHandler(resourceId, (responseId: string) => {
let getQuesOptions = exchange.getRequestOptions(responseId);
exchange.response(responseId, CoapResourceCode.COAP_RESPONSE_CODE_CONTENT, 'hello arkts');
});
//处理 post 数据
resource.registerPostHandler(resourceId, (responseId: string) => {
let postQuesOptions = exchange.getRequestOptions(responseId);
let postQuesText = exchange.getRequestText(responseId); 
exchange.response(responseId, CoapResourceCode.COAP_RESPONSE_CODE_CONTENT, 'hello arkts');
});
//添加资源
server.addResource(resourceId);
//coap server 启动服务器
server.start();
```

## 客户端接口说明

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| request(coapUri: string, method: CoapRequestMethod, type: CoapRequestType) | coapUri: string, method: CoapRequestMethod, type: CoapRequestType | 客户端发起请求 |
| requestCall(coapUri: string, method: CoapRequestMethod, type: CoapRequestType, callback: AsyncCallback) | coapUri: string, method: CoapRequestMethod, type: CoapRequestType, callback: AsyncCallback | 客户端发起请求 |
| setFormat(format: ContentFormat) | format: ContentFormat | 客服端发起 post,put 请求时透传参数的格式 |
| setPort(port: number) | port: number | 设置端口号 |
| setWaitSecond(waitSecond: number) | waitSecond: number | 客户端设置请求等待超时时间 |
| setObsSecond(obsSecond: number) | obsSecond: number | 客户端设置连接持续观察等待时间 |
| setRepeatCount(repeatCount: number) | repeatCount: number | 客户端设置重试请求次数 |
| setPayload(payload: string) | payload: string | 设置客服端透传的内容 |
| setToken(token: Uint8Array) | token: Uint8Array | 设置 token |
| setNativeLogOpen(isOpen: boolean) | isOpen: boolean | 是否打开 native 侧的 log |
| addOption(optionNum: number, value: string) | optionNum: number, value: string | 客户端自定义新增一个 option 选项 |
| setMid(mid: number) | mid: number | 客户端自定义报文的 message id |
| setPayloadBinary(payload: Uint8Array) | payload: Uint8Array | 客户端透传的字节内容 |
| setBlockMode(mode: CoapBlockMode) | mode: CoapBlockMode | 客户端的块传输模式 |
| setSessionMtu(mtu: number) | mtu: number | 客户端自定义 mtu 大小 |
| setSessionRecvBufferSize(recvBufferSize: number) | recvBufferSize: number | 客户端自定义 recvBufferSize 大小 |
| addBinaryOption(optionNum: number, value: Uint8Array) | optionNum: number, value: Uint8Array | 客户端设置 option，字节模式 |
| setUriPortOpts(opt: number) | opt: number | 客户端设置是否默认添加 uri-port option |

单元测试用例详情见 TEST.md。

## server 端接口说明

| 方法名 | 入参 | 接口描述 |
| :--- | :--- | :--- |
| start(classId: number) | classId: number | 启动服务器 |
| stop(classId: number) | classId: number | 关闭服务器 |
| addResource(classId: number, resourceID: string) | resourceID: string | 添加资源 |
| setAddr(classId: number, ip: string, port: string) | ip: string, port: string | 设置服务 IP 和端口 (0 表示默认端口) |
| getStatus(classId: number) | classId: number | 判断是否启动状态码 |
| registerGetHandler(resourceID: string, cb: Function) | resourceID: string, cb: Function | 添加 get 请求处理器 |
| registerPostHandler(resourceID: string, cb: Function) | resourceID: string, cb: Function | 添加 post 请求处理器 |
| addAttributes(resourceId: string, attributesOptionOne: string, attributesOptionTwo: string) | resourceId: string, attributesOptionOne: string, attributesOptionTwo: string | 添加资源属性 |
| createResource(resourceId: string) | resourceId: string | 添加 Id |
| destroy() | - | 注销资源 |
| response(responseId: string, code: number, data: string) | responseId: string, code: number, data: string | 发送响应到客户端 |
| getRequestOptions(responseId: string) | responseId: string | 获取请求选项 |
| getRequestText(responseId: string) | responseId: string | 获取请求负载 |
| getSourceAddress(responseId: string) | responseId: string | 对端 IP |

## 约束与限制

在下述版本验证通过：

- DevEco Studio: NEXT Developer Beta1-5.0.3.331, SDK: API12(5.0.0.25(SP6))。
- 在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66) 上验证通过。

## 目录结构

```text
|----ohos_coap
|     |---- entry  # 示例代码文件夹
|     |---- libcoap  # ohos_coap 库文件夹
|           |---- index.ets  # 对外接口
|     |---- README_CN.md  # 使用说明文档
```

## 关于混淆

代码混淆，请查看代码混淆简介。
如果希望 coap 库在代码混淆过程中不会被混淆，需要在混淆规则配置文件 obfuscation-rules.txt 中添加相应的排除规则：

```bash
-keep
./oh_modules/@ohos/coap
```

## 贡献代码

使用过程中发现任何问题都可以提 Issue，当然，也非常欢迎发 PR 共建。

## 开源协议

本项目基于 Apache License 2.0，请自由地享受和参与开源。
依赖 libcoap 基于 BSD 2，请自由地享受和参与开源。

## 更新记录

### 2.0.20

Add a lock for the insertion of g_clientMap.

### 2.0.19

fix CVE-2025-34468

### 2.0.18

Add setup_datapa null variable check, upgrade version to 2.0.18

### 2.0.17

Fix vulnerability CVE-2025-65493,CVE-2025-65494,CVE-2025-65495,CVE-2025-65496,CVE-2025-65497,CVE-2025-65498,CVE-2025-65499,CVE-2025-65500,CVE-2025-65501.

### 2.0.16

Fix vulnerability CVE-2025-59391.

### 2.0.16-rc.2

Added support for adding option input as byte.

### 2.0.16-rc.1

Modify the README.md and README_zh.md.
Replace the obsolete interface.
add maintenance logs.

### 2.0.16-rc.0

Modify the README.md and README_zh.md.
Fix the JS code and released the client, but the request of this client has not yet ended.

### 2.0.15

Added the token, mid, ip, options, and payload of the response data returned by the client.
The server response interface supports Uint8Array data and added the getRequestPayload interface
Fix the abort caused by the fd value exceeding the limit

### 2.0.14

add setSessionMtu and setSessionRecvBufferSize API.
add printf VERSION log.

### 2.0.13

Fix the issue where numeric strings (all-digit) are automatically converted to numbers when transmitted during addoption modification.
add coap_io_process_with_fds logs

### 2.0.13-rc.1

Fix the issue where the 'addOption' interface changes when the string data '000000000' is passed in.

### 2.0.13-rc.0

coap_io_process_with_fds add log

### 2.0.12

Fixed the issue of a discrepancy between the set timeout and the actual timeout in multicast scenarios
Roll back libcoap version to 4.3.4
Add patch to fix vulnerability CVE-2024-46304
Fix asan alarms and errors

### 2.0.11

Upgrade the source library version to v4.3.5
Fix the memory leak issue of OhosLogPrint function

### 2.0.10

在 DevEco Studio: NEXT Beta1-5.0.3.806, SDK: API12 Release (5.0.0.66) 上验证通过

### 2.0.9

修复客户端子网地址广播失败问题：开启 HAVE_IFADDRS_H 宏

### 2.0.8

新增 setBlockMode 接口：设置客户端的块传输模式
start 接口返回值修改为 void

### 2.0.8-rc.0

支持 coap 服务端处理 get，post 请求

### 2.0.7

新增 requestCall 接口
SetWaitSecond 接口优化：入参接受浮点数

### 2.0.7-rc.0

新增 requestCall 接口
SetWaitSecond 接口优化：入参接受浮点数

### 2.0.6

修复依赖库 libcoap 漏洞：CVE-2024-0962、CVE-2024-31031

### 2.0.5

支持 x86 编译

### 2.0.5-rc.0

解决 RegisterOption 注册和 AddOption 支持三种类型
修改 libcoap 许可证信息和 Readme 说明文档
修改 C++ 部分函数命名风格

### 2.0.4

客户端自定义新增一个 option 选项
客户端定义报文的 message id
客户端发送字节形式的 payload
通过 Get 方式收到返回消息时，携带对端 Ip
token 长度限制由固定的 8 改为协议标准的 3~8

### 2.0.4-rc.0

libcoap 功能增强：
客户端自定义新增一个 option 选项
客户端定义报文的 message id
客户端发送字节形式的 payload
通过 Get 方式收到返回消息时，携带对端 Ip
token 长度限制由固定的 8 改为协议标准的 3~8

### 2.0.3

修复漏洞 CVE-2023-30362：libcoap 版本由 4.3.1 切换至 4.3.4。

### 2.0.2

ArkTs 新语法适配
解决发送多次请求，回调结果相互影响的问题

### 2.0.1

增加编译选项
适配 DevEco Studio: 4.0 Release (4.0.3.415)
适配 SDK: API10 (4.0.10.5)

### 2.0.0

删除 coap 头文件直接引用，使用 cmakeList configure_file 生成头文件
增加英文 readme
修改 hilog 的头文件引用
适配 DevEco Studio:  4.0 Canary1(4.0.3.212)
适配 SDK: API 10 Release(4.0.8.3)

### 1.0.0

libcoap 是 Coap 协议的 C 语言实现，它是使用 Coap 协议的工具。
ohos_coap 基于 libcoap v4.3.1 版本，封装 napi 接口，给上层 ts 提供 coap 通信能力。
目前实现的能力：

- 支持 coap 客户端发起 get,post,put 请求

暂不支持的能力：

- coap 服务端相关能力
- coap 客户端发送文件，媒体软件能力
- 不支持 tls/dtls 的消息
- 不支持发起 delete 请求

## 权限与隐私基本信息

| 项目 | 值 |
| :--- | :--- |
| 权限名称 | 暂无 |
| 权限说明 | 暂无 |
| 使用目的 | 暂无 |
| 隐私政策 | 不涉及 |
| SDK 合规使用指南 | 不涉及 |
| 兼容性 HarmonyOS 版本 | 5.0.0 |
| 应用类型 | 应用 |
| 元服务 | - |
| 设备类型 | 手机，平板，PC |
| DevEcoStudio 版本 | DevEco Studio 5.0.0 |

## 安装方式

```bash
ohpm install @ohos/coap
```

## 来源

- 原始 URL: https://developer.huawei.com/consumer/cn/market/prod-detail/41ce95972d394069a58e276f2518dbf2/PLATFORM?origin=template